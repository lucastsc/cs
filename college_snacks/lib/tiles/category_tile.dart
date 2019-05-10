import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryTile extends StatelessWidget {

  final DocumentSnapshot snapshot;
  CategoryTile(this.snapshot);

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
