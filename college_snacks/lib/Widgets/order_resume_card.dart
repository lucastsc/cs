import 'package:college_snacks/models/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class OrderResumeCard extends StatelessWidget {

  final VoidCallback buy;
  OrderResumeCard(this.buy);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0,
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Container(
        padding: EdgeInsets.all(12.0),
        child: ScopedModelDescendant<CartModel>(
          builder: (context, child, model){

            double price = model.getProductsPrice();
            double discount = model.getDiscount();

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
                    Text("R\$: ${discount.toStringAsFixed(2)}"),
                  ],
                ),
                Divider(),
                SizedBox(height: 4,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Total", style: TextStyle(fontWeight: FontWeight.bold),),
                    Text("R\$: ${(price-discount).toStringAsFixed(2)}", style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 16.0),),
                  ],
                ),
                SizedBox(height: 8,),
                RaisedButton(
                  padding: EdgeInsets.zero,
                  child: Text("Finalizar pedido"),
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  onPressed: buy,
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

