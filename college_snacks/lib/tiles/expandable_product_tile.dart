import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_snacks/datas/category_data.dart';
import 'package:college_snacks/datas/product_data.dart';
import 'package:college_snacks/datas/restaurant_data.dart';
import 'package:college_snacks/tiles/teste_tile.dart';
import 'package:flutter/material.dart';
class ExpandableProductTile extends StatelessWidget {

  final CategoryData categoryData;
  final RestaurantData selectedRestaurant;

  ProductData productData;

  ExpandableProductTile(this.selectedRestaurant,this.categoryData);//constructor

  @override
  Widget build(BuildContext context) {
    return Card(
      child: FutureBuilder<QuerySnapshot>(
        future: Firestore.instance.collection("restaurants").document(selectedRestaurant.id).collection("cardapio").document(categoryData.id).collection("itens").getDocuments(),//products(ex:coca-cola,guaraná,...,
        builder: (context,snapshot){
          if(!snapshot.hasData){
            return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),),);
          }else{
            return Column(
              children: snapshot.data.documents.map((product){
                productData = ProductData.fromDocument(product);
                return Teste(productData, categoryData, selectedRestaurant);
              }).toList(),
            );
          }
        },
      ),
    );
  }
}
