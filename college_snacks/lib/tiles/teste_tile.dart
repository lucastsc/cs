import 'package:college_snacks/datas/category_data.dart';
import 'package:college_snacks/datas/product_data.dart';
import 'package:college_snacks/datas/restaurant_data.dart';
import 'package:college_snacks/screens/add_order_screen.dart';
import 'package:flutter/material.dart';

class Teste extends StatefulWidget {

  final ProductData product;
  final CategoryData category;
  final RestaurantData restaurantData;

  Teste(this.product, this.category, this.restaurantData);
  
  @override
  _TesteState createState() => _TesteState(product,category, restaurantData);
}

class _TesteState extends State<Teste> {

  final ProductData product;
  final CategoryData  category;
  final RestaurantData restaurantData;
  _TesteState(this.product, this.category, this.restaurantData);

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
        child: Column(
          children: <Widget>[
            ListTile(
              leading:  CircleAvatar(
                backgroundImage: NetworkImage(product.url),
              ),
              title: Text(product.name),
              trailing: Text("R\$: ${productPrice.toStringAsFixed(2)}"),
            ),
          ],
        ),
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddOrderScreen(product, category, restaurantData)));
        },
      ),
    );
  }
}

/*Padding(
padding: EdgeInsets.only(left: 72.5),
child: Row(
children: <Widget>[
Container(
padding: EdgeInsets.all(3.0),
decoration: BoxDecoration(
border: Border.all(color: Colors.green),
borderRadius: BorderRadius.all(Radius.circular(6.0))
),
child: Text("Adicionar", style: TextStyle(color: Colors.green),),
),
SizedBox(width: 10.0,),
Container(
padding: EdgeInsets.all(3.0),
decoration: BoxDecoration(
border: Border.all(color: Colors.green),
borderRadius: BorderRadius.all(Radius.circular(6.0))
),
child: Text("Personalizar", style: TextStyle(color: Colors.green),),
),
],
),
)*/