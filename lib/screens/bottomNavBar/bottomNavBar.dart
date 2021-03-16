import 'package:flutter/material.dart';
import 'package:senior/screens/bottomNavBar/homepage.dart';
import 'package:senior/screens/bottomNavBar/search.dart';
import 'package:senior/screens/bottomNavBar/shoppingcart.dart';
import 'package:senior/screens/bottomNavBar/wishlist.dart';




class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

List screens = [
  HomePage(), Wishlist(), Search(), ShoppingCart()
];

int current = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            title: Text('Wishlist'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('Search'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket),
            title: Text('Basket'),
          ),
        ],
        selectedLabelStyle: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.normal),
        unselectedLabelStyle: TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.normal),
        selectedIconTheme: IconThemeData(color: Colors.black, size: 20.0),
        unselectedIconTheme: IconThemeData(color: Colors.grey, size: 20.0),
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        currentIndex: current,
        onTap: (index) {
          setState(() {
            current = index;
          });
        },
      ),
      body: screens[current],
    );
  }
}