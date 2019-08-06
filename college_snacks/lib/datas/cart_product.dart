import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_snacks/datas/product_data.dart';

class CartProduct{
  String cid;
  String category;
  String pid;//productID
  int quantity;
  List<String> options = new List(); // Will hold the possible optionals the user will add to its order
  String observation; // observation to the kitchen about the order
  String restaurantID;


  ProductData productData;

  CartProduct();//constructor

  CartProduct.fromDocument(DocumentSnapshot document){
    cid = document.documentID;
    category = document.data["category"];
    pid = document.data["pid"];
    quantity = document.data["quantity"];
    restaurantID = document.data["restaurantID"];
  }

  Map<String,dynamic> toMap(){
    return{
      "category":category,
      "pid":pid,
      "quantity":quantity,
      "product":productData.toResumedMap(),
      "options": options,
      "observation": observation,
      "restaurantID": restaurantID,
    };
  }
}