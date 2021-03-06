import 'package:college_snacks/Tabs/my_orders_tab.dart';
import 'package:college_snacks/Widgets/discount_card.dart';
import 'package:college_snacks/Widgets/order_resume_card.dart';
import 'package:college_snacks/models/cart_model.dart';
import 'package:college_snacks/models/user_model.dart';
import 'package:college_snacks/screens/login_screen.dart';
import 'package:college_snacks/tiles/cart_tile.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CartScreen extends StatefulWidget {

  PageController pageController;
  CartScreen(this.pageController);

  @override
  _CartScreenState createState() => _CartScreenState(pageController);
}

class _CartScreenState extends State<CartScreen> with SingleTickerProviderStateMixin{

  PageController pageController;
  _CartScreenState(this.pageController);
  bool finished = false;

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
            child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),),
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
        }else if (finished == true) {
          return Column(
            children: <Widget>[
              Center(
                child: FlareActor(
                  "assets/successCheck.flr",
                  animation: "successCheck",
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.0),
                child: Text("Pedido realizado com sucesso!"),
              )
            ],
          );
        } else if ((model.products == null || model.products.length == 0)) {
          return Center(
            child: Text(
              "Nenhum produto no carrinho!",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          );
        }  else {
          return ListView(
            children: <Widget>[
              Column(
                children: model.products.map((product) {
                  return CartTile(product);
                }).toList(),
              ),
              DiscountCard(notifyParent: refresh,),
              SizedBox(height: 4.0,),
              OrderResumeCard(() async{
                String orderID = await model.finishOrder();
                if(orderID != null){
                  setState(() {
                    finished = true;
                    Future.delayed(Duration(milliseconds: 3500)).then((T){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MyOrdersTab(pageController)));
                    });
                  });
                }
              }),
              SizedBox(height: 4.0,),
            ],
          );
        }
      }),
    );
  }

  void refresh(){ //method created to force setState of this widget in the discount_card.dart
    setState(() {});
  }
}

