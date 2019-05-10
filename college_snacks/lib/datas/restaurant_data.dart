import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RestaurantData{

  String cnpj;
  String name;
  String searchKey;
  String url;

  RestaurantData.fromDocument(AsyncSnapshot snapshot){
    cnpj = snapshot.data["cnpj"];
    name = snapshot.data["name"];
    searchKey = snapshot.data["searchKey"];
    cnpj = snapshot.data["url"];
  }
}