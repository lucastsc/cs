import 'package:college_snacks/datas/product_data.dart';
import 'package:flutter/material.dart';

class AddRemoveBox extends StatefulWidget {

  final ProductData product;
  final int quantity;

  AddRemoveBox(this.quantity, this.product);

  @override
  _AddRemoveBoxState createState() => _AddRemoveBoxState(quantity, product);
}

class _AddRemoveBoxState extends State<AddRemoveBox> {

  final ProductData product;
  int quantity;

  _AddRemoveBoxState(this.quantity, this.product);

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
            onPressed: (){},
            color: Theme.of(context).primaryColor,
            child: Text("Adicionar R\$ ${(product.price*quantity).toStringAsFixed(2)}", style: TextStyle(color: Colors.white),),
          )
        ],
      ),
    );
  }
}
