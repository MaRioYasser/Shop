import 'package:scoped_model/scoped_model.dart';
import 'package:senior/models/products/productmodel.dart';
import 'package:senior/models/user/usermodel.dart';



class MainModel extends Model with UserModel, ProductModel{}