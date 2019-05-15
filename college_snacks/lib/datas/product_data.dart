import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData{

  String id;
  String name;
  String url;
  String description;
  String quantity;
  double price;

  ProductData.fromDocument(DocumentSnapshot snapshot){
    id = snapshot.documentID;
    name = snapshot.data["name"];
    url = snapshot.data["url"];
    description = snapshot.data["description"];
    quantity = snapshot.data["quantity"];
    price = snapshot.data["price"];

  }

  Map<String,dynamic> toResumedMap(){
    return{
      "name":name,
      "description":description,
      "price":price
    };
  }
}