import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:senior/models/mainmodel.dart';
import 'package:senior/screens/bottomNavBar/search.dart';
import 'package:senior/screens/bottomNavBar/shoppingcart.dart';
import 'package:senior/screens/bottomNavBar/wishlist.dart';
import 'package:senior/screens/drawer/about.dart';
import 'package:senior/screens/drawer/additem.dart';
import 'package:senior/screens/drawer/contact.dart';
import 'package:senior/screens/drawer/myaccount.dart';
import 'package:senior/screens/drawer/setting.dart';
import 'package:senior/screens/splashscreen.dart';


void main() => runApp(MyApp());



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: MainModel(),
        child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Splash(),
        routes: {
          'account' : (context) => MyAccount(),
          'setting' : (context) => Setting(),
          'about' : (context) => About(),
          'contact' : (context) => Contact(),
          'favorite' : (context) => Wishlist(),
          'shoppingCart' : (context) => ShoppingCart(),
          'search' : (context) => Search(),
          'addItem' : (context) => AddItem()
        },
      ),
    );
  }
}