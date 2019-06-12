import 'package:college_snacks/datas/product_data.dart';
import 'package:flutter/material.dart';

class AddOrderScreen extends StatefulWidget {

  ProductData product;
  AddOrderScreen(this.product);

  @override
  _AddOrderScreenState createState() => _AddOrderScreenState(product);
}

class _AddOrderScreenState extends State<AddOrderScreen> {

  ProductData product;
  _AddOrderScreenState(this.product);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhes do item"),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.pop(context); // Return to previous screen
            }
        ),
      ),
      body: ListView(
        children: <Widget>[
          Text(product.name),
          SizedBox(height: 10,),
          Text(product.description),
        ],
      ),
    );
  }
}
