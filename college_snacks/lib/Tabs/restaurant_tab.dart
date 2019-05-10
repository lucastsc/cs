import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_snacks/Tabs/products_tab.dart';
import 'package:college_snacks/datas/restaurant_data.dart';
import 'package:college_snacks/tiles/category_tile.dart';
import 'package:flutter/material.dart';

class RestaurantTab extends StatelessWidget {
  int index; //each restaurant card(tile) has an index (0,1,...,8)
  String categoryName; //bebidas,refeicoes,sanduiches...
  String restaurantName;

  List<String> restaurants = [
    //they are documents in firebase
    "restaurante1", "restaurante2", "restaurante3",
    "restaurante4", "restaurante5", "restaurante6",
    "restaurante7", "restaurante8", "restaurante9"
  ]; //index 0,1,2,3,4,5,6,7,8

  RestaurantTab(this.index); //constructor receives the index of the restaurant

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(restaurants[index]),//todo:MUST TRY TO FETCH DATA FROM FIREBASE
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: Firestore.instance
            .collection("restaurants")
            .document(restaurants[index])
            .collection("cardapio")
            .getDocuments(),
        //it contains the categories (ex:bebidas,refeicoes,sanduiches)
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView(
              children: snapshot.data.documents.map((doc) {
                return GestureDetector(
                  child: CategoryTile(doc),
                  onTap: () {
                    categoryName = doc.documentID;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ProductsTab(index, categoryName, restaurants)));
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
