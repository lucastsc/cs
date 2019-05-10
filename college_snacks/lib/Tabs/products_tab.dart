import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_snacks/tiles/product_tile.dart';
import 'package:flutter/material.dart';

class ProductsTab extends StatelessWidget {

  final int index;//index of the restaurant
  final String categoryName;
  final List<String> restaurants;

  ProductsTab(this.index,this.categoryName,this.restaurants);


  @override
  Widget build(BuildContext context) {

    return FutureBuilder<QuerySnapshot>(
      future: Firestore.instance.collection("restaurants").document(restaurants[index]).collection("cardapio").document(categoryName).collection("itens").getDocuments(),//products
      builder: (context,snapshot){
        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator(),);
        }else{
          print(snapshot.data.documents);
          return ListView(
            children: snapshot.data.documents.map((doc){
              //print(doc.documentID);
              return GestureDetector(
                child: ProductTile(doc),
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
