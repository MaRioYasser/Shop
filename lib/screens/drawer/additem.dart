import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:senior/models/mainmodel.dart';
import 'package:senior/widgets/loading.dart';



class AddItem extends StatefulWidget {
  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {

static final _formKey = GlobalKey<FormState>();

static final GlobalKey<FormFieldState<String>> _itemNameKey = GlobalKey<FormFieldState<String>>();
static final GlobalKey<FormFieldState<String>> _itemPriceKey = GlobalKey<FormFieldState<String>>();

final TextEditingController itemNameController = TextEditingController();
final TextEditingController itemPriceController = TextEditingController();

File pickedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black, size: 20.0),
        title: Text(
          'Add item',
          style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Colors.grey[100],
      body: Container(
        margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
        child: Form(
        key: _formKey,
          child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height/4,
                  width: MediaQuery.of(context).size.width/3,
                  margin: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: pickedImage == null ? IconButton(
                    icon: Icon(Icons.add_a_photo),
                    color: Colors.black,
                    iconSize: 30.0,
                    onPressed: () {
                      showDialog(
                        context: context,
                        child: AlertDialog(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                          backgroundColor: Colors.white,
                          title: Text(
                            'Choose Destination',
                            style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                          content: Column(
                            children: [
                              ListTile(
                                title: Text(
                                  'Pick from Camera',
                                  style: TextStyle(color: Colors.grey, fontSize: 15.0, fontWeight: FontWeight.bold),
                                ),
                                trailing: Icon(Icons.camera, color: Colors.grey, size: 20.0),
                                onTap: () {
                                  pickImage(ImageSource.camera);
                                },
                              ),
                              ListTile(
                                title: Text(
                                  'Pick from Gallery',
                                  style: TextStyle(color: Colors.grey, fontSize: 15.0, fontWeight: FontWeight.bold),
                                ),
                                trailing: Icon(Icons.photo_album, color: Colors.grey, size: 20.0),
                                onTap: () {
                                  pickImage(ImageSource.gallery);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  ) : Image.file(pickedImage)
                ),
              ],
            ),
            field(
              'Item Name', Icons.text_fields, TextInputType.text, itemNameController, _itemNameKey
            ),
            field(
              'Item Price', Icons.attach_money, TextInputType.number, itemPriceController, _itemPriceKey
            ),
            Column(
              children: [
                ScopedModelDescendant<MainModel>(
                  builder: (context, child, MainModel model){
                    return FlatButton(
                    child: model.isProductloading == true ? Center(child: Loading()) : Text(
                        'Add item',
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                      color: Colors.black,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                      onPressed: () {
                        if(_formKey.currentState.validate()){
                          model.addproduct(itemNameController.text.toLowerCase(), int.parse(itemPriceController.text), pickedImage);
                          Scaffold.of(context).showSnackBar(
                            snack('item Added Succes')
                          );
                        }else{
                          Scaffold.of(context).showSnackBar(
                            snack('some fields required!')
                          );
                        }
                      }
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
pickImage(ImageSource source) async {
    var _image = await ImagePicker.pickImage(source: source);
    setState(() {
      pickedImage = _image;
    });
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
        ),
        keyboardType: inputType,
        textInputAction: TextInputAction.done,
        controller: controller,
      ),
    );
  }
}