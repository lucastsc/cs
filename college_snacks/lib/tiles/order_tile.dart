import 'dart:collection';

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
                child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),),
              );
            }
            else{

              int status = snapshot.data["status"];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Código do pedido: ${snapshot.data.documentID}", style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(height: 4.0,),
                  Text(
                    _buildProductsText(snapshot.data)
                  ),
                  SizedBox(height: 4.0,),
                  Text("Status do pedido: \n", style: TextStyle(fontWeight: FontWeight.bold),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _buildCircle("1", "Preparação", status, 1, context),
                      Container(
                        height: 1.0,
                        width: 40.0,
                        color: Colors.grey[500],
                      ),
                      _buildCircle("2", "Pronto!", status, 2, context),
                      Container(
                        height: 1.0,
                        width: 40.0,
                        color: Colors.grey[500],
                      ),
                      _buildCircle("3", "Entregue", status, 3, context)
                    ],
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }

  String _buildProductsText(DocumentSnapshot snapshot){
    String text = "Descrição: \n";
    double finalPrice = snapshot.data["finalPrice"];
    double discount = snapshot.data["discount"];
    
    for(LinkedHashMap map in snapshot.data["products"]){ // LinkedHashMap is a map inside a list of maps
      text += "${map["quantity"]} x ${map["product"]["name"]} (R\$ ${(map["product"]["price"]*map["quantity"]).toStringAsFixed(2)}) \n";
    }
    /*text += "Total: R\$ ${snapshot.data["productsPrice"]}";*/
    text += "Desconto: R\$ ${discount.toStringAsFixed(2)} \n";
    text += "Total: R\$ ${finalPrice.toStringAsFixed(2)}";
    return text;
  }

  Widget _buildCircle(String insideCircle, String title, int status, int thisStatus, BuildContext context){

    // status is the order status and thisStatus is the circles numbers

    Color backColor; // background color for the circle
    Widget child; // Static button, loading button or Finished button

    if(status <  thisStatus){
      backColor = Colors.grey[500];
      child = Text(insideCircle, style: TextStyle(color: Colors.white),);
    }
    else if(status == thisStatus){
      backColor = Colors.blueAccent;
      child = Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Text(insideCircle, style: TextStyle(color: Colors.white),),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
          )
        ],
      );
    }
    else{
      backColor = Colors.green;
      child = Icon(Icons.check, color: Colors.white,);
    }

    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 20.0,
          backgroundColor: backColor,
          child: child,
        ),
        Text(title),
      ],
    );
  }

}
