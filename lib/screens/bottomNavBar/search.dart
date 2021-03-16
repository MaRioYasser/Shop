import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:senior/models/mainmodel.dart';
import 'package:senior/widgets/item.dart';
import 'package:senior/widgets/loading.dart';




class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

final TextEditingController searchController = TextEditingController();

bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (context, child, MainModel model){
        return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.black, size: 20.0),
          title: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0)
            ),
            height: 40.0,
                margin: EdgeInsets.all(5.0),
                child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      labelText: 'ex: Apple',
                      labelStyle: TextStyle(color: Colors.grey, fontSize: 15.0),
                    ),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.search,
                    controller: searchController,
                    onSubmitted: (value) {
                      setState(() {
                        pressed = true;
                        model.fetchProduct(searchController.text.toLowerCase());
                      });
                    },
                  ),
              ),
          actions:[
             IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              searchController.clear();
              model.allProducts.clear();
              setState(() {
                pressed = false;
              });
            }
          ),
          ]
        ),
        backgroundColor: Colors.grey[100],
        body: body()
        );
      }
    );
  }
  body() {
    return Container(
        margin: EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 0.0),
        child: pressed == false ? Center(child: Icon(Icons.search, color: Colors.grey, size: 50.0)) : 
        ScopedModelDescendant<MainModel>(
          builder: (context, child, MainModel model){
            if(model.isProductloading){
              return Center(child: Loading());
            }else if(model.allProducts.length < 1){
              return Center(child: Text('No Item Found!'));
            }else{
              return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: model.allProducts.length,
                itemBuilder: (context, index){
                  return Item(model.allProducts[index].name, model.allProducts[index].price, model.allProducts[index].image, index);
                }
              );
            }
          }
        )
      );
  }
}