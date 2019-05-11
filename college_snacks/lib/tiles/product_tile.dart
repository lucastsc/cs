import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductTile extends StatelessWidget {

  final DocumentSnapshot product;
  ProductTile(this.product);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Container(
          width: 50.0,
          height: 50.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(product.data["url"])
            )
          ),
        ),
        title: Text(product.data["name"]),
        trailing: Icon(Icons.keyboard_arrow_right),
      ),
    );
  }
}
