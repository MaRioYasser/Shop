import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:senior/widgets/fav.dart';
import 'package:senior/widgets/loading.dart';



class ShoppingCart extends StatefulWidget {
  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> with TickerProviderStateMixin {

List<String> itemImage = [
  'assets/pic5', 'assets/pic6', 'assets/pic7', 'assets/pic8', 'assets/pic10', 'assets/pic11', 'assets/pic14',
];

double amount = 200.0;

int items = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black, size: 20.0),
        title: Text(
          'Shopping Cart',
          style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Colors.grey[100],
      body: Container(
        margin: EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 0.0),
        child: Column(
          children: [
            Flexible(
              child: ListView.separated(
                scrollDirection: Axis.vertical,
                separatorBuilder: (context, index){
                  return Divider(
                    color: Colors.grey,
                    endIndent: 20.0,
                    indent: 20.0,
                  );
                },
                itemCount: itemImage.length,
                itemBuilder: (context, index){
                  return Container(
                    child: ListTile(
                      leading: Image.asset(itemImage[index]),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tomato',
                            style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '20\$',
                            style: TextStyle(color: Colors.grey, fontSize: 15.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      trailing: Fav('false')
                    ),
                  );
                },
              ),
            ),
            SafeArea(
              bottom: true,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black87,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(15.0)
                ),
                child: ListTile(
                  title: Text(
                      'Total Amount is $amount \$',
                      style: TextStyle(color: Colors.white, fontSize: 15.0, fontWeight: FontWeight.bold),
                    ),
                  subtitle: Text(
                      '$items items',
                      style: TextStyle(color: Colors.white, fontSize: 15.0, fontWeight: FontWeight.bold),
                    ),
                  trailing: Icon(
                    Icons.shopping_basket,
                    color: Colors.white,
                    size: 20.0
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(fullscreenDialog: true, builder: (_) {return CheckOut();}));
                  },
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class CheckOut extends StatefulWidget {
  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {

final TextEditingController lcoationCotnroller = TextEditingController();


Position position = Position();

bool isMapLoading;

bool isDistanceLoading;

List<Marker> markers = [];

double distance = 0.0;

bool enabled = true;

@override
void initState() {
  getLocation();
  super.initState();
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black, size: 20.0),
        title: Text(
          'Check Out',
          style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Colors.grey[100],
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            item('Total Amount', '200\$', Icons.attach_money),
            item('Delivery Fee', '20\$\n${distance.toString()}KM', Icons.motorcycle),
            Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0)
          ),
          height: 50.0,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(color: Colors.black, width: 0.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(color: Colors.black, width: 0.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(color: Colors.black, width: 0.5),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(color: Colors.grey, width: 0.5),
                  ),
                  labelText: 'ex: Cairo',
                  labelStyle: TextStyle(color: Colors.grey, fontSize: 15.0),
                ),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.search,
                controller: lcoationCotnroller,
                onSubmitted: (value) {
                  getLocation();
                  setState(() {
                    if(markers.length == 2){
                      markers.removeAt(1);
                    }
                    enabled = false;
                  });
                },
                enabled: enabled
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: InkWell(
                onTap: () {
                  if(enabled == false){
                    calcualteDistance();
                    setState(() {
                      enabled = true;
                    });
                  }else{
                    setState(() {
                      enabled = false;
                    });
                  }
                },
                child: Text(
                  enabled == false ? 
                  'Calculate Distance' : 'Choose Delivery Location',
                  style: TextStyle(color: enabled == false ? Colors.black : Colors.grey, fontSize: 15.0, fontWeight: enabled == false ? FontWeight.bold : FontWeight.normal, height: 3.0),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height/2.5,
              margin: EdgeInsets.only(bottom: 10.0, top: 10.0),
              child: isMapLoading == true ? 
              Center(child: Loading()) :
               buildMap()
            ),
            FlatButton(
              child: Text(
                  'Place Order',
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
              color: Colors.black,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
              onPressed: () {}
            ),
          ],
        ),
      ),
    );
  }
  item(String title, String subtitle, IconData icon) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
      trailing: Text(
        subtitle,
        style: TextStyle(color: Colors.grey, fontSize: 15.0, fontWeight: FontWeight.bold),
      ),
      leading: Icon(icon, color: Colors.black, size: 20.0),
    );
  }
  getLocation() async {

    setState(() {
      isMapLoading = true;
    });

    bool service = await Geolocator().isLocationServiceEnabled();

    if(service == false){
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context){
          return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
            content: Text(
              'Location Service not enabled\n Please Enable it',
              style: TextStyle(color: Colors.black, fontSize: 20.0),
            ),
            title: Text(
              'Attention',
              style: TextStyle(color: Colors.red, fontSize: 20.0),
            ),
          );
        }
      );
    }else if(lcoationCotnroller.text.isEmpty){
      var _current = await Geolocator().getCurrentPosition();
      Marker _markers = Marker(
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(
          title: 'your location',
        ),
        position: LatLng(_current.latitude, _current.longitude),
        visible: true,
        markerId: MarkerId('location')
      );
      setState(() {
        position = _current;
        markers.add(_markers);
        isMapLoading = false;
      });
    }else{
      List<Placemark> _search = await Geolocator().placemarkFromAddress(lcoationCotnroller.text);
      Marker _markers = Marker(
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(
          title: _search[0].name,
          snippet: _search[0].postalCode,
        ),
        position: LatLng(_search[0].position.latitude, _search[0].position.longitude),
        visible: true,
        markerId: MarkerId(_search[0].name)
      );
      setState(() {
        markers.add(_markers);
        position = _search[0].position;
        isMapLoading = false;
      });
    }
  }

  buildMap() {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 12.0
      ),
      myLocationButtonEnabled: true,
      myLocationEnabled: true,
      mapType: MapType.normal,
      markers: Set.from(markers),
    );
  }

  calcualteDistance() async {

    setState(() {
      isDistanceLoading = true;
    });

    if(markers.length < 2){
      return null;
    }else{
      var _distance = await Geolocator().distanceBetween(markers[0].position.latitude, markers[0].position.longitude, markers[1].position.latitude, markers[1].position.longitude);
      setState(() {
        distance = _distance;
        isDistanceLoading = false;
      });
    }
  }

}







// 1- Add marker on the map for current location //
// 2- make user able to search for delivery location //
// 3- calculate distance between 1 & 2 //
// 4- make user not able to search for more locations except if cleaned pervious //
// 5- calculte distance again //