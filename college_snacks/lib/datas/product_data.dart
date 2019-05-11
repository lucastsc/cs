import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData{

  String id;
  String name;
  String url;
  String description;
  String quantity;

  ProductData.fromDocument(DocumentSnapshot snapshot){
    id = snapshot.documentID;
    name = snapshot.data["name"];
    url = snapshot.data["url"];
    description = snapshot.data["description"];
    quantity = snapshot.data["quantity"];

  }
}