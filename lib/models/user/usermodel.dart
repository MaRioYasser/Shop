import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';



mixin UserModel on Model{

  bool _isUserLoading;
  bool get isUserLoading => _isUserLoading;

  FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isUserVerified;
  bool get isUserVerified => _isUserVerified;


 Future registerUser(String email, String password, String gender, String dateOfBirth) async {

   _isUserLoading = true;
   notifyListeners();


   AuthResult _register = await _auth.createUserWithEmailAndPassword(
     email: email,
     password: password
    );

    var _userData = _register.user.uid;

    if(_userData != null){
        Map<String, String> _user = {
          'userId' : _userData,
          'userEmail' : email,
          'userPassword' : password,
          'gender' : gender,
          'dateOfBirth' : dateOfBirth
        };
        Firestore.instance.collection('users').add(_user);
        SharedPreferences user = await SharedPreferences.getInstance();
        user.setString('userId', _userData);
        _isUserVerified = true;
        _isUserLoading = false;
        notifyListeners();
    }else{
        _isUserVerified = false;
        _isUserLoading = false;
        notifyListeners();
      }

 }

}
