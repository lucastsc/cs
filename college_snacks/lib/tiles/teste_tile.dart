import 'package:college_snacks/datas/category_data.dart';
import 'package:college_snacks/datas/product_data.dart';
import 'package:college_snacks/screens/add_order_screen.dart';
import 'package:flutter/material.dart';

class Teste extends StatefulWidget {

  final ProductData product;
  final CategoryData category;

  Teste(this.product, this.category);
  
  @override
  _TesteState createState() => _TesteState(product,category);
}

class _TesteState extends State<Teste> {

  final ProductData product;
  final CategoryData  category;
  _TesteState(this.product, this.category);

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
    
    return Material(
      child: InkWell(
        child: ListTile(
          leading: Container(
            width: 50.0,
            height: 50.0,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(product.url))),
          ),
          title: Text(product.name),
          trailing: Text("R\$: ${productPrice.toStringAsFixed(2)}"),
        ),
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddOrderScreen(product)));
        },
      ),
    );
  }
}
