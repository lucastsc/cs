import 'package:college_snacks/datas/cart_product.dart';
import 'package:college_snacks/datas/product_data.dart';
import 'package:college_snacks/models/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CartTile extends StatefulWidget {

  final CartProduct cartProduct;
  CartTile(this.cartProduct);

  @override
  _CartTileState createState() => _CartTileState(cartProduct);
}

class _CartTileState extends State<CartTile> {

  final CartProduct cartProduct;
  _CartTileState(this.cartProduct);


  @override
  Widget build(BuildContext context) {

    final key = cartProduct.pid; // Unique identifier to each product. We don't have products with the same name

    return Dismissible(
        key: Key(key), // Unique key to the Widget
        direction: DismissDirection.endToStart,
        onDismissed: (direction){
          setState(() {
            CartModel.of(context).removeProduct(cartProduct);
          });
          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text("Item removido!"), duration: Duration(seconds: 3),));
        },
        background: Container(color: Colors.red,),
        child: Card(
            margin: EdgeInsets.symmetric(
                horizontal: 8.0, vertical: 4.0
            ),
            child: cartProduct.productData == null ?
            FutureBuilder<DocumentSnapshot>(
              future: Firestore.instance.collection("restaurants").document("restaurante1").collection("cardapio").document(cartProduct.category).collection("itens").document(cartProduct.pid).get(),
              builder: (context, snapshot){
                if(snapshot.hasData){
                  cartProduct.productData = ProductData.fromDocument(snapshot.data);
                  CartModel.of(context).updatePrices();
                  return Container(
                    padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          height: 60.0,
                          width: 60.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(image: NetworkImage(cartProduct.productData.url)),
                          ),
                        ),
                        Text(cartProduct.productData.name, maxLines: 2,),
                        Column(
                          children: <Widget>[
                            Text("Quantidade:"),
                            Text("${cartProduct.quantity}")
                          ],
                        )
                      ],
                    ),
                  );
                }
                else{
                  return Center(child: CircularProgressIndicator(),);
                }
              },
            ) :
            Container(
                padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 5.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          height: 60.0,
                          width: 60.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(image: NetworkImage(cartProduct.productData.url)),
                          ),
                        ),
                        Text(cartProduct.productData.name, maxLines: 2,),
                        Column(
                          children: <Widget>[
                            Text("Quantidade:"),
                            Text("${cartProduct.quantity}")
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Container(//container containing the remove button
                          height: 20.0,
                          //width: 20.0,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.green),
                              borderRadius: BorderRadius.all(Radius.circular(5.0))
                          ),
                          child: FlatButton(
                            padding: EdgeInsets.all(0),
                            child: Text("Adicionar", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),),
                            onPressed: () {
                              setState(() {
                                CartModel.of(context).increaseProductQuantity(cartProduct);
                              });
                            },
                          ),
                        ),
                        SizedBox(//to give some space between buttons
                          width: 10.0,
                        ),
                        Container(//container containing the remove button
                          height: 20.0,
                          //width: 20.0,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.green),
                              borderRadius: BorderRadius.all(Radius.circular(5.0))
                          ),
                          child: FlatButton(
                            padding: EdgeInsets.all(0),
                            child: Text("Remover", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),),
                            onPressed: () {
                              setState(() {
                                if(cartProduct.quantity>1){
                                  CartModel.of(context).decreaseProductQuantity(cartProduct);
                                }
                              });
                            },
                          ),
                        ),
                        SizedBox(//to give some space between buttons
                          width: 20.0,
                        ),
                        Text("R\$: ${(cartProduct.productData.price*cartProduct.quantity).toStringAsFixed(2)}")
                      ],
                    )
                  ],
                )
            )
        )
    );
  }
}
