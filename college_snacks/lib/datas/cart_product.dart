import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_snacks/datas/product_data.dart';

class CartProduct{
  String cid;
  String category;
  String pid;//productID
  int quantity;

  ProductData productData;

  CartProduct();//constructor

  CartProduct.fromDocument(DocumentSnapshot document){
    cid = document.documentID;
    category = document.data["category"];
    pid = document.data["pid"];
    quantity = document.data["quantity"];
  }

  Map<String,dynamic> toMap(){
    return{
      "category":category,
      "pid":pid,
      "quantity":quantity,
      "product":productData.toResumedMap() //todo: need to verify this line.toResumedMap 'was called on null'
    };
  }
}