import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:senior/models/mainmodel.dart';



class Fav extends StatefulWidget {

final String id;

Fav(this.id);

  @override
  _FavState createState() => _FavState();
}

class _FavState extends State<Fav> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (context, child, MainModel model){
        return IconButton(
        icon: Icon(model.fav == false ? Icons.favorite_border : Icons.favorite),
        color: Colors.red,
        iconSize: 20.0,
        onPressed: () {
          model.getSelectedItem(widget.id);
          model.favo();
        }
      );
      },
    );
  }
}