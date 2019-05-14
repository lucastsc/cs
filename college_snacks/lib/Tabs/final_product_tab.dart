import 'package:college_snacks/datas/cart_product.dart';
import 'package:college_snacks/datas/product_data.dart';
import 'package:college_snacks/models/cart_model.dart';
import 'package:college_snacks/models/user_model.dart';
import 'package:college_snacks/screens/login_screen.dart';
import 'package:flutter/material.dart';

class FinalProductTab extends StatefulWidget {
  ProductData productData;

  FinalProductTab(this.productData);

  @override
  _FinalProductTabState createState() => _FinalProductTabState();
}

class _FinalProductTabState extends State<FinalProductTab> {

  int quantity = 1;
  String productPriceShown;
  double totalPrice;
  String totalPriceShown;

  @override
  Widget build(BuildContext context) {

    double productPrice = widget.productData.price;//price of the product


    if(productPrice == null){
      productPriceShown = "Preço não cadastrado";
      totalPriceShown = "Preço não cadastrado";
    }else{
      productPriceShown = productPrice.toStringAsFixed(2);
      totalPrice = productPrice*quantity;
      totalPriceShown = totalPrice.toStringAsFixed(2);
    }

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: <Widget>[
            Row(//row containing the image of the product
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 200.0,
                  height: 200.0,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(widget.productData.url))),
                )
              ],
            ),
            Row(//row containing the description of the product
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[Text(widget.productData.description,style: TextStyle(fontSize: 18.0),)],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[Text("R\$:$productPriceShown" ,style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),)],
            ),
            SizedBox(//vertical space
              height: 10.0,
            ),
            Row(//containing the container with borders with the add and remove buttons
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(//container with borders, with add and remove buttons
                  height: 40.0,
                  margin: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(10.0))
                  ),
                  child: Row(//row with [-button][value][+button]
                    children: <Widget>[
                      Container(//container containing the remove button
                        height: 40.0,
                        width: 30.0,
                        child: FlatButton(
                          padding: EdgeInsets.all(0),
                          child: Icon(Icons.remove),
                          onPressed: () {
                            setState(() {
                              quantity <= 1 ? quantity = 1 : quantity-=1;
                            });
                          },
                        ),
                      ),
                      SizedBox(//to give some space between buttons
                        width: 10.0,
                      ),
                      Text("$quantity"),
                      SizedBox(//to give some space between buttons
                        width: 10.0,
                      ),
                      Container(//container containing the remove button
                        height: 40.0,
                        width: 30.0,
                        child: FlatButton(
                          padding: EdgeInsets.all(0),
                          child: Icon(Icons.add),
                          onPressed: () {
                            setState(() {
                              quantity+=1;
                            });
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    RaisedButton(
                      child: Text("Adicionar ao carrinho"),
                      onPressed: () {
                        if(UserModel.of(context).isLoggedIn()){
                          //adicionar ao carrinho
                          CartProduct cartProduct = CartProduct();
                          cartProduct.quantity = 1;
                          cartProduct.pid = widget.productData.id;

                          CartModel.of(context).addCartItem(cartProduct);
                        }else{
                          Navigator.of(context).push(MaterialPageRoute(builder:(context)=>LoginScreen()));
                        }
                      },
                    ),
                    Text("Total: R\$: $totalPriceShown",style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),)
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
