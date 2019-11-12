import 'package:animated_card/animated_card.dart';
import 'package:college_snacks/datas/cart_product.dart';
import 'package:college_snacks/datas/category_data.dart';
import 'package:college_snacks/datas/product_data.dart';
import 'package:college_snacks/datas/restaurant_data.dart';
import 'package:college_snacks/models/cart_model.dart';
import 'package:college_snacks/models/user_model.dart';
import 'package:college_snacks/screens/add_order_screen.dart';
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
  CategoryData categoryData;
  RestaurantData restaurantData;
  _CartTileState(this.cartProduct);

  @override
  Widget build(BuildContext context) {

    CartModel model = CartModel.of(context);

    return AnimatedCard(
        direction: AnimatedCardDirection.left, //Initial animation direction
        initDelay: Duration(milliseconds: 0), //Delay to initial animation
        duration: Duration(milliseconds: 0), //Initial animation duration
        onRemove: () => model.removeCartItem(this.cartProduct), //Implement this action to active dismiss
        child: Card(
          elevation: 8.0,
            margin: EdgeInsets.symmetric(
                horizontal: 8.0, vertical: 10.0
            ),
            child: cartProduct.productData == null ?
            FutureBuilder<DocumentSnapshot>(
              future: Firestore.instance.collection("restaurants").document("restaurante1").collection("cardapio").document(cartProduct.category).collection("itens").document(cartProduct.pid).get(),
              builder: (context, snapshot){
                if(snapshot.hasData){
                  cartProduct.productData = ProductData.fromDocument(snapshot.data);
                  categoryData = CategoryData.fromDocument(snapshot.data);
                  restaurantData = RestaurantData.fromDocument(snapshot.data);

                  categoryData.id = cartProduct.category;
                  restaurantData.id = cartProduct.restaurantID;

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
                  return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),));
                }
              },
            ) :
            Container(
                padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 5.0),
                child: Column(
                  children: <Widget>[
                    Material(
                      child: InkWell(
                        onTap: (){
                          print("estou vindo daqui doutor");
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> AddOrderScreen(cartProduct.productData, categoryData, restaurantData)));
                        },
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
                            ),
                          ],
                        ),
                      ),
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

  Future<String> fetchRestaurantID() async{
    DocumentSnapshot documentSnapshot;
    documentSnapshot = await Firestore.instance.collection("users").document(UserModel.of(context).firebaseUser.uid).collection("cart").document(cartProduct.cid).get();
    print(documentSnapshot.data);
    return documentSnapshot.data["restaurantID"];
  }

}

/*
Dismissible(
        key: Key(UniqueKey().toString()), // Unique key to the Widget
        direction: DismissDirection.endToStart,
        onDismissed: (direction){
          setState(() {
            CartModel.of(context).removeProduct(cartProduct);
          });
          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text("Item removido!"), duration: Duration(seconds: 3),));
        },
        background: Container(
          color: Colors.red,
          child: Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: EdgeInsets.only(right: 10.0),
              child: Icon(Icons.delete, color: Colors.white, size: 28.0,),
            ),
          )
        ),
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
                  categoryData = CategoryData.fromDocument(snapshot.data);
                  restaurantData = RestaurantData.fromDocument(snapshot.data);

                  categoryData.id = cartProduct.category;
                  restaurantData.id = cartProduct.restaurantID;

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
                    Material(
                      child: InkWell(
                        onTap: (){
                          print("estou vindo daqui doutor");
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> AddOrderScreen(cartProduct.productData, categoryData, restaurantData)));
                        },
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
                            ),
                          ],
                        ),
                      ),
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
*/
