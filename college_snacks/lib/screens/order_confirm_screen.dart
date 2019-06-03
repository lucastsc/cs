import 'package:flutter/material.dart';

class OrderConfirmScreen extends StatelessWidget {

  String orderID;
  OrderConfirmScreen(this.orderID);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pedido realizado"),
        centerTitle: true,
      ),
      body: Align(
        alignment: Alignment.center,
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.check, color: Theme.of(context).primaryColor, size: 80.0,),
              Text("Pedido realizado com sucesso!", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
              Text("Identificação: $orderID", style: TextStyle(fontSize: 16.0))
            ],
          ),
        ),
      )
    );
  }
}
