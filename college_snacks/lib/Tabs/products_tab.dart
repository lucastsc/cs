import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_snacks/datas/restaurant_data.dart';
import 'package:college_snacks/tiles/product_tile.dart';
import 'package:flutter/material.dart';

class ProductsTab extends StatelessWidget {

  final String categoryName;
  final RestaurantData selectedRestaurant;

  ProductsTab(this.selectedRestaurant,this.categoryName);

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<QuerySnapshot>(
      future: Firestore.instance.collection("restaurants").document(selectedRestaurant.id).collection("cardapio").document(categoryName).collection("itens").getDocuments(),//products(ex:coca-cola,guaraná,...
      builder: (context,snapshot){
        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator(),);
        }else{
          return ListView(
            children: snapshot.data.documents.map((doc){
              return GestureDetector(
                child: ProductTile(doc),//ProductTile contains the way the doc info will be displayed on the ListView
                onTap: (){

                },
              );
            }).toList(),
          );
        }
      },
    );
  }
}
