import 'package:college_snacks/datas/cart_product.dart';
import 'package:college_snacks/datas/category_data.dart';
import 'package:college_snacks/datas/product_data.dart';
import 'package:college_snacks/models/cart_model.dart';
import 'package:college_snacks/models/user_model.dart';
import 'package:college_snacks/screens/login_screen.dart';
import 'package:flutter/material.dart';
class ExpandableFinalProduct extends StatefulWidget {

  final ProductData product;
  final CategoryData category;

  ExpandableFinalProduct(this.product, this.category);

  @override
  _ExpandableFinalProductState createState() => _ExpandableFinalProductState(product,category);
}

class _ExpandableFinalProductState extends State<ExpandableFinalProduct> {

  final ProductData product;
  final CategoryData  category;
  _ExpandableFinalProductState(this.product, this.category);


  int quantity = 1;
  String productPriceShown;
  num totalPrice;
  String totalPriceShown;

  @override
  Widget build(BuildContext context) {

    num productPrice = product.price;//price of the product


    if(productPrice == null){
      productPriceShown = "Preço não cadastrado";
      totalPriceShown = "Preço não cadastrado";
    }else{
      productPriceShown = productPrice.toStringAsFixed(2);
      totalPrice = productPrice*quantity;
      totalPriceShown = totalPrice.toStringAsFixed(2);
    }

    return Container(
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
                        image: NetworkImage(product.url))),
              )
            ],
          ),
          Row(//row containing the description of the product
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[Expanded(child: Container(alignment:Alignment.center,margin:EdgeInsets.all(20.0),child: Text(product.description,style: TextStyle(fontSize: 18.0),),),)],
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
                        //add to the cart
                        CartProduct cartProduct = CartProduct();
                        cartProduct.quantity = quantity;
                        cartProduct.pid = product.id;
                        cartProduct.category = category.id; // product category id
                        cartProduct.productData = product;


                        Scaffold.of(context).showSnackBar(//modified this line to use the SnackBar without the Scaffold.We could delete the GlobalKey in the beggining of the file
                            SnackBar(content: Text("Item adicionado com sucesso!"), duration: Duration(seconds: 2),backgroundColor: Theme.of(context).primaryColor,)
                        );
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
    );

  }
}
