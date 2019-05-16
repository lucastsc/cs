import 'package:college_snacks/datas/cart_product.dart';
import 'package:flutter/material.dart';

class CartTile extends StatelessWidget {

  final CartProduct cartProduct;
  CartTile(this.cartProduct);


  @override
  Widget build(BuildContext context) {

    print(cartProduct.productData.quantity);
    return Card(
      child: ListTile(
        leading: Container(
          width: 50.0,
          height: 50.0,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(cartProduct.productData.url)
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
      ),
    );
  }
}
