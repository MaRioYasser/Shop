import 'package:flutter/material.dart';
import 'package:senior/widgets/fav.dart';




class Wishlist extends StatefulWidget {
  @override
  _WishlistState createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {

List<String> itemImage = [
  'assets/pic5', 'assets/pic6', 'assets/pic7', 'assets/pic8', 'assets/pic10', 'assets/pic11', 'assets/pic14',
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black, size: 20.0),
        title: Text(
          'Wishlist',
          style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Colors.grey[100],
      body: Container(
        margin: EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 0.0),
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
                title:  Row(
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
                trailing: Fav('id')
              ),
            );
          },
        ),
      ),
    );
  }
}