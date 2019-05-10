import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductTile extends StatelessWidget {

  final DocumentSnapshot snapshot;
  ProductTile(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(snapshot.data["name"]),
        trailing: Icon(Icons.keyboard_arrow_right),
      ),
    );
  }
}
