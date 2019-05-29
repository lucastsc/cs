import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_snacks/Tabs/products_tab.dart';
import 'package:college_snacks/Widgets/custom_button.dart';
import 'package:college_snacks/datas/category_data.dart';
import 'package:college_snacks/datas/restaurant_data.dart';
import 'package:college_snacks/tiles/category_tile.dart';
import 'package:flutter/material.dart';

class RestaurantTab extends StatelessWidget {
  //String categoryName; //bebidas,refeicoes,sanduiches...
  //String restaurantName;
  CategoryData categoryData;

  RestaurantData selectedRestaurant;
  RestaurantTab(this.selectedRestaurant);//receives the restaurant object clicked from the home_tab

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedRestaurant.name),
      ),
      floatingActionButton: CustomButton(),
      body: FutureBuilder<QuerySnapshot>(
        future: Firestore.instance
            .collection("restaurants")
            .document(selectedRestaurant.id)//restaurante1,restaurante2,restaurante3...
            .collection("cardapio")
            .getDocuments(),//it contains the categories (ex:bebidas,refeicoes,sanduiches)
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView(
              children: snapshot.data.documents.map((doc) {
                return GestureDetector(
                  child: CategoryTile(doc),//categoryTile has the way the doc will be displayed in the ListView
                  onTap: () {
                    categoryData = CategoryData.fromDocument(doc);
                    //categoryName = doc.documentID;//bebidas,refeicoes,sanduiches...
                    Navigator.push(context,MaterialPageRoute(builder: (context) => ProductsTab(selectedRestaurant, categoryData)));////sends the restaurant object and the categoryName to the ProductsTab
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
