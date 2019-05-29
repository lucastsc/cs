import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_snacks/models/cart_model.dart';
import 'package:flutter/material.dart';

class DiscountCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: ExpansionTile(
        leading: Icon(Icons.card_giftcard, color: Colors.grey[700],),
        title: Text("Cupom de desconto", style: TextStyle(color: Colors.grey[700]),),
        trailing: Icon(Icons.add, color: Colors.grey[700],),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  hintText: "Digite seu cupom"
              ),
              initialValue: CartModel.of(context).couponCode ?? "", // If exists, initial value will be the coupon code, otherwise will be null
              onFieldSubmitted: (c){ // The coupon must be validated
                Firestore.instance.collection("coupons").document(c).get().then((docSnap){
                    if(docSnap.data != null){
                      CartModel.of(context).setCoupon(c, docSnap.data["percentage"]);
                      Scaffold.of(context).showSnackBar(SnackBar( duration: Duration(seconds: 2),
                        content: Text("Desconto de ${docSnap.data["percentage"]}% aplicado!"), backgroundColor: Theme.of(context).primaryColor,)
                      );
                    }
                    else{
                      CartModel.of(context).setCoupon(null, 0);
                      Scaffold.of(context).showSnackBar(SnackBar(
                        duration: Duration(seconds: 2), content: Text("Cupom inválido!"), backgroundColor: Colors.redAccent,)
                      );
                    }
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
