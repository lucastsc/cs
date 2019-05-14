import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_snacks/Tabs/final_product_tab.dart';
import 'package:college_snacks/datas/category_data.dart';
import 'package:college_snacks/datas/product_data.dart';
import 'package:college_snacks/datas/restaurant_data.dart';
import 'package:college_snacks/tiles/product_tile.dart';
import 'package:flutter/material.dart';

class ProductsTab extends StatelessWidget {

  //final String categoryName;
  CategoryData categoryData;
  final RestaurantData selectedRestaurant;
  ProductData productData;

  ProductsTab(this.selectedRestaurant,this.categoryData);//receives the selectedRestaurant and the categoryData from the restaurant_tab

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryData.name),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: Firestore.instance.collection("restaurants").document(selectedRestaurant.id).collection("cardapio").document(categoryData.id).collection("itens").getDocuments(),//products(ex:coca-cola,guaraná,...
        builder: (context,snapshot){
          if(!snapshot.hasData){
            return Center(child: CircularProgressIndicator(),);
          }else{
            return ListView(
              children: snapshot.data.documents.map((product){
                return GestureDetector(
                  child: ProductTile(product),//ProductTile contains the way the doc info will be displayed on the ListView
                  onTap: (){
                    productData = ProductData.fromDocument(product);
                    Navigator.push(context,MaterialPageRoute(builder: (context) => FinalProductTab(productData)));
                  },
                );
              }).toList(),
            );
          }
        },
      ),
    );
  }
}
