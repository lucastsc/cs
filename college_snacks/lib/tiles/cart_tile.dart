import 'package:college_snacks/datas/cart_product.dart';
import 'package:flutter/material.dart';

class CartTile extends StatelessWidget {

  final CartProduct cartProduct;
  CartTile(this.cartProduct);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Text(cartProduct.productData.name)
    );
  }
}
