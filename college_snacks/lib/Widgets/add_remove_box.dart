import 'package:college_snacks/Widgets/build_options.dart';
import 'package:college_snacks/datas/cart_product.dart';
import 'package:college_snacks/datas/category_data.dart';
import 'package:college_snacks/datas/product_data.dart';
import 'package:college_snacks/models/cart_model.dart';
import 'package:college_snacks/models/user_model.dart';
import 'package:college_snacks/screens/login_screen.dart';
import 'package:flutter/material.dart';

class AddRemoveBox extends StatefulWidget {

  final ProductData product;
  final CategoryData category;
  final int quantity;
  final List<String> options;
  final TextEditingController observation;

  AddRemoveBox(this.quantity, this.product, this.category, this.options, this.observation);

  @override
  _AddRemoveBoxState createState() => _AddRemoveBoxState(quantity, product, category, options, observation);
}

class _AddRemoveBoxState extends State<AddRemoveBox> {

  final ProductData product;
  final CategoryData category;
  final List<String> options;
  final TextEditingController observation;
  String obsFinal;
  int quantity;

  _AddRemoveBoxState(this.quantity, this.product, this.category, this.options, this.observation);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(0))
            ),
            child: Row(
              children: <Widget>[
                Container(//container containing the remove button
                  height: 40.0,
                  width: 30.0,
                  child: FlatButton(
                    padding: EdgeInsets.all(0),
                    child: quantity == 0 ? null : Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        quantity == 0 ? quantity = 0 : quantity-=1;
                      });
                    },
                  ),
                ),
                SizedBox(//to give some space between buttons
                  width: 10.0,
                ),
                Text(quantity.toString()),
                SizedBox(//to give some space between buttons
                  width: 10.0,
                ),
                Container(//container containing the remove button
                  height: 40.0,
                  width: 30.0,
                  child: FlatButton(
                    padding: EdgeInsets.all(0),
                    child: Icon(Icons.add, color: Theme.of(context).primaryColor,),
                    onPressed: () {
                      setState(() {
                        quantity = quantity + 1;
                      });
                    },
                  ),
                )
              ],
            ),
          ),
          SizedBox(width: 20.0,),
          RaisedButton(
            onPressed: (){
              if(UserModel.of(context).isLoggedIn() && quantity > 0){
                setState(() {
                  obsFinal = observation.text;
                });
                //add to the cart
                CartProduct cartProduct = CartProduct();
                cartProduct.quantity = quantity;
                cartProduct.pid = product.id;
                cartProduct.category = category.id; // product category id
                cartProduct.productData = product;
                cartProduct.options = this.options;
                cartProduct.observation = obsFinal;

                Scaffold.of(context).showSnackBar(//modified this line to use the SnackBar without the Scaffold.We could delete the GlobalKey in the beggining of the file
                    SnackBar(content: Text("Item adicionado com sucesso!"), duration: Duration(seconds: 2),backgroundColor: Theme.of(context).primaryColor,)
                );
                CartModel.of(context).addCartItem(cartProduct);
              }
              else if(!UserModel.of(context).isLoggedIn()){
                Navigator.of(context).push(MaterialPageRoute(builder:(context)=>LoginScreen()));
              }
            },
            color: quantity > 0 ?  Theme.of(context).primaryColor : Colors.grey,
            child: Text("Adicionar R\$ ${(product.price*quantity).toStringAsFixed(2)}", style: TextStyle(color: Colors.white),),
          )
        ],
      ),
    );
  }
}
