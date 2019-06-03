import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderTile extends StatelessWidget {

  final String documentID;
  OrderTile(this.documentID);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Padding(
        padding: EdgeInsets.all(6.0),
        child: StreamBuilder<DocumentSnapshot>(
          stream: Firestore.instance.collection("orders").document(documentID).snapshots(),
          builder: (context, snapshot){
            if(!snapshot.hasData){
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            else{
              return Column(
                children: <Widget>[
                  Text("Código do pedido: ${snapshot.data.documentID}", style: TextStyle(fontWeight: FontWeight.bold),),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
