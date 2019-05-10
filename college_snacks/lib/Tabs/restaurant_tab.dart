import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_snacks/Tabs/products_tab.dart';
import 'package:college_snacks/tiles/category_tile.dart';
import 'package:flutter/material.dart';

class RestaurantTab extends StatelessWidget {

  int index;
  String categoryName;

  List<String> restaurants = ["restaurante1","restaurante2","restaurante3"];//index 0,1,2
  RestaurantTab(this.index);


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: Firestore.instance.collection("restaurants").document(restaurants[index]).collection("cardapio").getDocuments(),//bebidas,refeicoes,sanduiches
      builder: (context,snapshot){
        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator(),);
        }else{
          return ListView(
            children: snapshot.data.documents.map((doc){
              return GestureDetector(
                child: CategoryTile(doc),
                onTap: (){
                  categoryName = doc.documentID;
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProductsTab(index,categoryName,restaurants)));
                },
              );
            }).toList(),
          );
        }
      },
    );
  }
}
