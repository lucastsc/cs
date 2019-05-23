import 'package:college_snacks/datas/cart_product.dart';
import 'package:college_snacks/datas/product_data.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CartTile extends StatelessWidget {

  final CartProduct cartProduct;
  CartTile(this.cartProduct);


  @override
  Widget build(BuildContext context) {
    return Card(
        child: cartProduct.productData == null ?
        FutureBuilder<DocumentSnapshot>(
          future: Firestore.instance.collection("restaurants").document("restaurante1").collection("cardapio").document(cartProduct.category).collection("itens").document(cartProduct.pid).get(),
          builder: (context, snapshot){
            if(snapshot.hasData){
              cartProduct.productData = ProductData.fromDocument(snapshot.data);
              return ListTile(
                  leading: Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(cartProduct.productData.url) // url test
                        )
                    ),
                  ),
                  title: Text(cartProduct.productData.name),
                  subtitle: Text(cartProduct.productData.description),
                  trailing: /*Icon(Icons.keyboard_arrow_right),*/Column(
                    children: <Widget>[
                      Text("Quantidade:"),
                      Text("${cartProduct.quantity}")
                    ],
                  )
              );
            }
            else{
              return Center(child: CircularProgressIndicator(),);
            }
          },
        ) :
        ListTile(
            leading: Container(
              width: 50.0,
              height: 50.0,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(cartProduct.productData.url) // url test
                  )
              ),
            ),
            title: Text(cartProduct.productData.name),
            subtitle: Text(cartProduct.productData.description),
            trailing: /*Icon(Icons.keyboard_arrow_right),*/Column(
              children: <Widget>[
                Text("Quantidade:"),
                Text("${cartProduct.quantity}")
              ],
            )
        )
    );
  }
}