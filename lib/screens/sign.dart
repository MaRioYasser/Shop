import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:senior/models/mainmodel.dart';
import 'package:senior/models/user/googleauth.dart';
import 'package:senior/screens/bottomNavBar/bottomNavBar.dart';
import 'package:senior/widgets/loading.dart';
import 'package:shared_preferences/shared_preferences.dart';



class Sign extends StatefulWidget {
  @override
  _SignState createState() => _SignState();
}

class _SignState extends State<Sign> with TickerProviderStateMixin {

TabController tabController;

@override
void initState() {
  tabController = TabController(length: 2, initialIndex: 0, vsync: this);
  super.initState();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black, size: 20.0),
        title: Text(
          'Welcome!',
          style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        bottom: PreferredSize(
          preferredSize: Size(0.0, 30.0),
          child: TabBar(
            tabs: [
              Text('Sign In'), Text('Register'),
            ],
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(color: Colors.black, width: 0.5),
              color: Colors.transparent
            ),
            labelColor: Colors.black,
            labelStyle: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
            unselectedLabelColor: Colors.grey,
            unselectedLabelStyle: TextStyle(color: Colors.grey, fontSize: 15.0, fontWeight: FontWeight.bold),
            controller: tabController,
          ),
        ),
      ),
      backgroundColor: Colors.grey[100],
      body: Container(
        margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
        child: TabBarView(
          children: [
            SignIn(),
            Register(),
          ],
          controller: tabController,
        ),
      ),
    );
  }
}




class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

static final _formKey = GlobalKey<FormState>();

static final GlobalKey<FormFieldState<String>> _emailKey = GlobalKey<FormFieldState<String>>();
static final GlobalKey<FormFieldState<String>> _resetPasswordKey = GlobalKey<FormFieldState<String>>();
static final GlobalKey<FormFieldState<String>> _passwordKey = GlobalKey<FormFieldState<String>>();

final TextEditingController emailController = TextEditingController();
final TextEditingController resetPasswordController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

bool obsecure = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formKey,
          child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            field(
              'email', Icons.email, TextInputType.emailAddress, emailController, _emailKey
            ),
            field(
              'password', Icons.lock, TextInputType.text, passwordController, _passwordKey
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: InkWell(
                child: Text(
                  'Forgot Password?!',
                  style: TextStyle(color: Colors.black, fontSize: 15.0, decoration: TextDecoration.underline),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context){
                      return AlertDialog(
                        actions: [
                          IconButton(
                            icon: Icon(Icons.cancel),
                            color: Colors.red,
                            iconSize: 20.0,
                            onPressed: () {
                              Navigator.pop(context);
                            }
                          ),
                          IconButton(
                            icon: Icon(Icons.done),
                            color: Colors.black,
                            iconSize: 20.0,
                            onPressed: () {}
                          ),
                        ],
                        title: Text(
                          'Reset Password?!',
                          style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                        content: field(
                          'email', Icons.email, TextInputType.emailAddress, resetPasswordController, _resetPasswordKey
                        ),
                      );
                    }
                  );
                },
              ),
            ),
            Column(
              children: [
                FlatButton(
                  child: Text(
                      'Sign in',
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                  color: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                  onPressed: () async {
                    // return Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {return BottomNavBar();}));
                    if(_formKey.currentState.validate()){
                      SharedPreferences user = await SharedPreferences.getInstance();
                      user.setString('email', emailController.text);
                      return Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {return BottomNavBar();}));
                    }else{
                      return Scaffold.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0))),
                          content: Text(
                            'some fields required',
                            style: TextStyle(color: Colors.white, fontSize: 20.0),
                          ),
                          duration: Duration(seconds: 6),
                        ),
                      );
                    }
                    } 
                ),
                GooAuth()
              ],
            ),
          ],
        ),
      ),
    );
  }
  field(
    String label,
    IconData icon,
    TextInputType inputType,
    TextEditingController controller,
    Key key,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
        key: key,
        validator: (value) {
          if(value.isEmpty){
            return 'this field required';
          }
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(color: Colors.black, width: 0.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(color: Colors.red, width: 0.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(color: Colors.black, width: 0.5),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(color: Colors.grey, width: 0.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(color: Colors.black, width: 0.5),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(color: Colors.red, width: 0.5),
          ),
          enabled: true,
          labelText: label,
          labelStyle: TextStyle(color: Colors.black, fontSize: 15.0),
          prefixIcon: Icon(icon, color: Colors.black, size: 20.0),
          suffixIcon: label == 'password' ? IconButton(
            icon: Icon(Icons.remove_red_eye),
            color: Colors.black,
            iconSize: 15.0,
            onPressed: () {
              setState(() {
                obsecure = !obsecure;
              });
            },
          ) : null
        ),
        keyboardType: inputType,
        textInputAction: TextInputAction.done,
        controller: controller,
        obscureText: label == 'password' ? obsecure : false,
      ),
    );
  }
}





class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {


static final _registerFormKey = GlobalKey<FormState>();

static final GlobalKey<FormFieldState<String>> registerEmailKey = GlobalKey<FormFieldState<String>>();
static final GlobalKey<FormFieldState<String>> registerPasswordKey = GlobalKey<FormFieldState<String>>();

final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

String gender = 'Select';

bool check = false;

bool obsecure = true;

String pickedDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _registerFormKey,
          child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            field(
              'email', Icons.email, TextInputType.emailAddress, emailController, registerEmailKey
            ),
            field(
              'password', Icons.lock, TextInputType.text, passwordController, registerPasswordKey
            ),
            ListTile(
              title: Text(
                  'Gender',
                  style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              subtitle: Text(
                  gender,
                  style: TextStyle(color: Colors.grey, fontSize: 15.0, fontWeight: FontWeight.bold),
                ),
              trailing: PopupMenuButton(
                icon: Icon(Icons.arrow_downward),
                itemBuilder: (BuildContext context){
                  return <PopupMenuEntry<String>>[
                    PopupMenuItem(
                      child: Text(
                          'Male',
                          style: TextStyle(color: Colors.grey, fontSize: 15.0, fontWeight: FontWeight.bold),
                        ),
                      value: 'Male',
                    ),
                    PopupMenuItem(
                      child: Text(
                          'Female',
                          style: TextStyle(color: Colors.grey, fontSize: 15.0, fontWeight: FontWeight.bold),
                        ),
                      value: 'Female',
                    ),
                  ];
                },
                onSelected: (value) {
                  setState(() {
                    gender = value;
                  });
                },
              ),
            ),
            ListTile(
              title: Text(
                  'Accept Conditions',
                  style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              subtitle: Text(
                  'Read our Terms & Conditions',
                  style: TextStyle(color: Colors.grey, fontSize: 15.0, fontWeight: FontWeight.bold),
                ),
              trailing: Checkbox(
                activeColor: Colors.black,
                checkColor: Colors.white,
                hoverColor: Colors.black,
                onChanged: (value){
                  setState(() {
                    check = value;
                  });
                },
                value: check,
              ),
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0))),
                  builder: (BuildContext context){
                    return ListTile(
                      title: Text(
                        'Read Carfeuly!',
                        style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        '''
                        1- Conditons is equal second condition 
                        2- we will secure your data
                        3- our permissions is for\n
                        A) Device Camera\n
                        B) Access Location\n
                        C) Access Speaker\n
                        4- Theese conditions is up to for accept or reject
                        ''',
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.grey, fontSize: 15.0, fontWeight: FontWeight.bold),
                      ),
                    );
                  }
                );
              },
            ),
            ListTile(
              title: Text(
                  'Date of Birth',
                  style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              subtitle: Text(
                  '$pickedDate',
                  style: TextStyle(color: Colors.grey, fontSize: 15.0, fontWeight: FontWeight.bold),
                ),
              trailing: Icon(Icons.date_range, color: Colors.grey, size: 20.0),
              onTap: () async {
                var picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1980),
                  lastDate: DateTime.now(),
                  currentDate: DateTime.now(),
                );
                setState(() {
                  pickedDate = picked.toString().substring(0,11);
                });
              },
            ),
            Column(
              children: [
                ScopedModelDescendant<MainModel>(
                  builder: (context, child, MainModel model){
                    return FlatButton(
                      child: model.isUserLoading == true ? Center(child: Loading()) : Text(
                          'Sign Up',
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                      color: Colors.black,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                      onPressed: () {
                        if(!_registerFormKey.currentState.validate()){
                          return Scaffold.of(context).showSnackBar(
                            snack('some fields required!')
                          );
                        }else if(passwordController.text.isNotEmpty){
                          if(passwordController.text.length < 7){
                            return Scaffold.of(context).showSnackBar(
                              snack('password should be atleast 7 characters!')
                            ); 
                          }else{
                            model.registerUser(emailController.text, passwordController.text, gender, pickedDate).whenComplete(() {
                              if(model.isUserVerified == true){
                              return Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {return BottomNavBar();}));
                                }else{
                                return Scaffold.of(context).showSnackBar(
                                  snack('register failed correct data')
                                ); 
                              }
                          });
                        }
                      }
                    }
                    );
                  },
                ),
                GooAuth()
              ],
            ),
          ],
        ),
      ),
    );
  }
  snack(String content) {
    return SnackBar(
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0))),
      content: Text(
        content,
        style: TextStyle(color: Colors.white, fontSize: 20.0),
      ),
      duration: Duration(seconds: 6),
    );
  }
  field(
    String label,
    IconData icon,
    TextInputType inputType,
    TextEditingController controller,
    Key key,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
        key: key,
        validator: (value) {
          if(value.isEmpty){
            return 'this field required';
          }
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(color: Colors.black, width: 0.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(color: Colors.red, width: 0.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(color: Colors.black, width: 0.5),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(color: Colors.grey, width: 0.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(color: Colors.black, width: 0.5),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(color: Colors.red, width: 0.5),
          ),
          enabled: true,
          labelText: label,
          labelStyle: TextStyle(color: Colors.black, fontSize: 15.0),
          prefixIcon: Icon(icon, color: Colors.black, size: 20.0),
          suffixIcon: label == 'password' ? IconButton(
            icon: Icon(Icons.remove_red_eye),
            color: Colors.black,
            iconSize: 15.0,
            onPressed: () {
              setState(() {
                obsecure = !obsecure;
              });
            },
          ) : null
        ),
        keyboardType: inputType,
        textInputAction: TextInputAction.done,
        controller: controller,
        obscureText: label == 'password' ? obsecure : false,
      ),
    );
  }
}



class GooAuth extends StatefulWidget {
  @override
  _GooAuthState createState() => _GooAuthState();
}

class _GooAuthState extends State<GooAuth> {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(
          'Google',
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
      color: Colors.red,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      onPressed: () {
        googleAuth().whenComplete(() => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {return BottomNavBar();})));
      },
    );
  }
}