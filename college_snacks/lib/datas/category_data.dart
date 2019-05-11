import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryData{

  String name;
  String id;

  CategoryData.fromDocument(DocumentSnapshot snapshot){
    name = snapshot.data["name"];
    id = snapshot.documentID;
  }
}