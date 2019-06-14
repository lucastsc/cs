import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_snacks/datas/category_data.dart';
import 'package:college_snacks/datas/product_data.dart';
import 'package:college_snacks/datas/restaurant_data.dart';
import 'package:flutter/material.dart';

class AddOrderScreen extends StatefulWidget {

  ProductData product;
  CategoryData category;
  RestaurantData restaurantData;
  AddOrderScreen(this.product, this.category, this.restaurantData);

  @override
  _AddOrderScreenState createState() => _AddOrderScreenState(product, category, restaurantData);
}

class _AddOrderScreenState extends State<AddOrderScreen> {

  ProductData product;
  CategoryData category;
  RestaurantData restaurantData;
  _AddOrderScreenState(this.product, this.category, this.restaurantData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 130.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  background: Image.network(
                    product.url, fit: BoxFit.cover,
                  )),
            ),
          ];
        },
        body: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 16.0),
              height: 30.0,
              child: Text(product.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),),
            ),
            SizedBox(height: 4.0,),
            Container(
              //padding: EdgeInsets.all(5.0),
              /*decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).primaryColor),
              ),*/
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              //height: 60.0,
              child: Text(product.description, style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.0),),
            ),
            SizedBox(height: 10.0,),
            Container(
              margin: EdgeInsets.only(left: 16.0),
              //height: 30.0,
              child: Text("R\$: ${product.price.toStringAsFixed(2)}", style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 17.0),),
            ),
            SizedBox(height: 10.0,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              //height: 70.0,
              color: Colors.grey[300],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Deseja algum adicional?", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),),
                  SizedBox(height: 2.0,),
                  Text("Opções disponíveis:")
                ],
              )
            ),
            FutureBuilder<QuerySnapshot>(
              future: Firestore.instance.collection("restaurants").document(restaurantData.id).collection("cardapio").document(category.id).collection("itens").getDocuments(),
              builder: (context, snapshot){
                return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index){

                    List<String> optionalList = snapshot.data.documents[index]["optional"];

                    return ListView(
                      children: optionalList.map((listItem){
                        return ListTile(
                          title: Text(listItem),
                        );
                      }).toList(),
                    );
                  }
                );
              },
            )
          ],
        )
      ),
    );
  }
}
