import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:senior/models/products/product.dart';
import 'dart:convert';



mixin ProductModel on Model{

  bool _isProductLoading;
  bool get isProductloading => _isProductLoading;

  bool _fav = false;
  bool get fav => _fav;

  List<Product> _allProducts = [];
  List<Product> get allProducts => _allProducts;


  String _selectedItemId;
  String get selectedItemId => _selectedItemId;

  Product get selectedProduct{
    return _allProducts.firstWhere((Product product){
      return product.id == _selectedItemId;
    });
  }

  getSelectedItem(String id){
    _selectedItemId = id;
  }


  favo() {
    _fav = !_fav;
    notifyListeners();
  }



  final FirebaseStorage _storage = FirebaseStorage(storageBucket: 'gs://senior-bc1b6.appspot.com');

  addproduct(String name, int price, File image) async {

    _isProductLoading = true;
    notifyListeners();

    String _imageName = 'itemImage/${DateTime.now().toString()}';

    StorageTaskSnapshot _uploadTask = await _storage.ref().child(_imageName).putFile(image).onComplete;
    String _imageUrl = await _uploadTask.ref.getDownloadURL();

    Map<String, dynamic> _newProduct ={
      'itemName' : name,
      'itemPrice' : price,
      'itemImage' : _imageUrl
    };

    Firestore.instance.collection('product').add(_newProduct);

    // http.Response _request = await http.post(
    //   'https://senior-bc1b6.firebaseio.com/prodducts.json',
    //   body: json.encode(_newProduct)
    //   );

    _isProductLoading = false;
    notifyListeners();

  }

  

  fetchProduct(String search) async {

    _isProductLoading = true;
    notifyListeners();

    Firestore.instance.collection('product').where('itemName', isEqualTo: search).getDocuments().then((QuerySnapshot snapShot) {
      snapShot.documents.forEach((i) {
        final Product _newProduct = Product(
          id: i.documentID,
          name: i['itemName'],
          price: i['itemPrice'],
          image: i['itemImage']
        );
        _allProducts.add(_newProduct);
        _isProductLoading = false;
        notifyListeners();
      });
    });

  //   http.Response _request = await http.get('https://senior-bc1b6.firebaseio.com/prodducts.json');
  //   var _response = json.decode(_request.body);
  //   _response.forEach((x, i){
  //     final Product _newProduct = Product(
  //       name: i['itemName'],
  //       price: i['itemPrice'],
  //       image: i['itemImage']
  //     );
  //     _allProducts.add(_newProduct);
  //     _isProductLoading = false;
  //     notifyListeners();
  //   });
  // }
  
  }

}




// 1- get which object selected
// 2- get object ID
// 3- get user Id
// 4- add theses data to fav 