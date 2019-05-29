import 'package:college_snacks/Widgets/discount_card.dart';
import 'package:college_snacks/models/cart_model.dart';
import 'package:college_snacks/models/user_model.dart';
import 'package:college_snacks/screens/login_screen.dart';
import 'package:college_snacks/tiles/cart_tile.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meu Carrinho"),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 8.0),
            alignment: Alignment.center,
            child: ScopedModelDescendant<CartModel>(
              builder: (context, child, model) {
                int p = model.products.length;
                return Text(
                  "${p ?? 0} ${p == 1 ? "ITEM" : "ITENS"}",
                  style: TextStyle(fontSize: 17.0),
                );
              },
            ),
          )
        ],
      ),
      body: ScopedModelDescendant<CartModel>(builder: (context, child, model) {
        if (model.isLoading && UserModel.of(context).isLoggedIn()) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (!UserModel.of(context).isLoggedIn()) {
          return Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.remove_shopping_cart,
                  size: 80.0,
                  color: Theme.of(context).primaryColor,
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  "Faça o login para adicionar produtos!",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 16.0,
                ),
                RaisedButton(
                  child: Text(
                    "Entrar",
                    style: TextStyle(fontSize: 18.0),
                  ),
                  textColor: Colors.white,
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                )
              ],
            ),
          );
        } else if (model.products == null || model.products.length == 0) {
          return Center(
            child: Text(
              "Nenhum produto no carrinho!",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          );
        } else {
          return ListView(
            children: <Widget>[
              Column(
                children: model.products.map((product) {
                  return CartTile(product);
                }).toList(),
              ),
              DiscountCard(),
              SizedBox(height: 4.0,),
              orderResume(context),
              SizedBox(height: 4.0,),
            ],
          );
        }
      }),
    );
  }
}

Widget orderResume(BuildContext context){
  return Card(
    elevation: 10.0,
    margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    child: Container(
      padding: EdgeInsets.all(12.0),
      child: ScopedModelDescendant<CartModel>(
        builder: (context, child, model){

          double price = model.getProductsPrice();
          //double discount = model.getDiscount();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                "Resumo do pedido",
                textAlign: TextAlign.start,
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              Divider(),
              SizedBox(height: 4,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Subtotal"),
                  Text("R\$: ${price.toStringAsFixed(2)}"),
                ],
              ),
              Divider(),
              SizedBox(height: 4,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Desconto"),
                  Text("R\$: 0.00"),
                ],
              ),
              Divider(),
              SizedBox(height: 4,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Total", style: TextStyle(fontWeight: FontWeight.bold),),
                  Text("R\$: 0.00", style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 16.0),),
                ],
              ),
              SizedBox(height: 8,),
              RaisedButton(
                padding: EdgeInsets.zero,
                child: Text("Finalizar pedido"),
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                onPressed: (){},
              )
            ],
          );
        },
      ),
    ),
  );
}
