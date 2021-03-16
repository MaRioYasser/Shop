import 'package:flutter/material.dart';
import 'package:senior/widgets/item.dart';



class Result extends StatefulWidget {

final String classNamme;

Result(this.classNamme);

  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {

String filter = 'Default';

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
          widget.classNamme,
          style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        bottom: PreferredSize(
          preferredSize: Size(0.0, 50.0),
          child: ListTile(
            leading: Text(
              '${itemImage.length.toString()} items - $filter',
              style: TextStyle(color: Colors.grey, fontSize: 15.0, fontWeight: FontWeight.bold),
            ),
            trailing: PopupMenuButton(
              icon: Icon(Icons.filter_list),
              itemBuilder: (BuildContext context){
                return <PopupMenuEntry<String>>[
                  PopupMenuItem(
                    child: Text(
                        'Best Rated',
                        style: TextStyle(color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.bold),
                      ),
                    value: 'Best Rated',
                  ),
                  PopupMenuItem(
                    child: Text(
                        'New Arrival',
                        style: TextStyle(color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.bold),
                      ),
                    value: 'New Arrival',
                  ),
                ];
              },
              onSelected: (value) {
                setState(() {
                  filter = value;
                });
              },
            ),
          ),
        ),
      ),
      backgroundColor: Colors.grey[100],
      body: Container(
        margin: EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 0.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            childAspectRatio: 0.6
          ),
          itemCount: itemImage.length,
          itemBuilder: (context, index){
            return Item('apple', 20, 'https://firebasestorage.googleapis.com/v0/b/senior-bc1b6.appspot.com/o/itemImage%2F2020-09-14%2011%3A44%3A32.490227?alt=media&token=fd6b07ce-2eda-438c-ba5c-14c4a4bf4b59', index);
          },
        ),
      ),
    );
  }
}