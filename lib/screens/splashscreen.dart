import 'package:flutter/material.dart';
import 'package:senior/screens/bottomNavBar/bottomNavBar.dart';
import 'package:senior/screens/sign.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';



class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

String users;

checkUser() async {
  SharedPreferences user = await SharedPreferences.getInstance();
  setState(() {
    users = user.getString('userId');
  });
}

@override
void initState(){
  checkUser();
  super.initState();
}

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 5,
      backgroundColor: Colors.white,
      loaderColor: Colors.black,
      loadingText: Text(
        'Welcome!',
        style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold)
      ),
      navigateAfterSeconds: users == null ? Sign() : BottomNavBar()
    );
  }
}