import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_snacks/Widgets/add_remove_box.dart';
import 'package:college_snacks/Widgets/build_options.dart';
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
  int quantity = 1;
  TextEditingController controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: AddRemoveBox(quantity, product, category)
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 130.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                  title:  Text("Detalhes do item", style: TextStyle(fontSize: 16.0, fontStyle: FontStyle.italic),),
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
            SizedBox(height: 10.0,),
            FutureBuilder<DocumentSnapshot>(
              future: Firestore.instance.collection("restaurants").document(restaurantData.id).collection("cardapio").document(category.id).collection("itens").document(product.id).get(),
              builder: (context, snapshot){
                if(!snapshot.hasData){
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                else{

                  List<dynamic> optionalList = snapshot.data["optional"];

                  if(optionalList != null){
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: optionalList.map((option){
                          return BuildOptions(option);
                        }).toList(),
                      ),
                    );
                  }
                  else{
                    return Text("Don't know what to do here");
                  }
                }
              },
            ),
            SizedBox(height: 22.0,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: <Widget>[
                  Icon(Icons.chat),
                  SizedBox(width: 12.0,),
                  Text("Observações para a cozinha?")
                ],
              ),
            ),
            SizedBox(height: 12.0,),
            Container(
              height: 50.0,
              padding: EdgeInsets.only(right: 16.0, left: 16.0),
              child: TextField(
                cursorColor: Colors.black,
                controller: controller,
                decoration: InputDecoration(

                    hintText: "Ex; Tirar queijo, molho à parte, etc.",
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(0)))
                ),
                onSubmitted: (text){},
              ),
            ),
            SizedBox(height: 20.0,)
          ],
        )
      ),
    );
  }
}

