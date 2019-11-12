import 'package:cloud_firestore/cloud_firestore.dart';

class RestaurantData{

  String cnpj;
  String id;
  String name;
  String searchKey;
  String url;
  String description;
  int time;
  int cost;

  RestaurantData.fromDocument(DocumentSnapshot snapshot){
    id = snapshot.documentID;
    cnpj = snapshot.data["cnpj"];
    name = snapshot.data["name"];
    searchKey = snapshot.data["searchKey"];
    url = snapshot.data["url"];
    description = snapshot.data["description"];
    time = snapshot.data["time"];
    cost = snapshot.data["cost"];
  }
}