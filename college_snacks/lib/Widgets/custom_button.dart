import 'package:college_snacks/screens/cart_screen.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: (){
        //Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => CartScreen()));
      },
      child: Icon(Icons.shopping_cart),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}
