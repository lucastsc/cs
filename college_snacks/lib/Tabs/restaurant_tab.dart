import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_snacks/Widgets/custom_button.dart';
import 'package:college_snacks/datas/category_data.dart';
import 'package:college_snacks/datas/restaurant_data.dart';
import 'package:college_snacks/models/user_model.dart';
import 'package:college_snacks/tiles/expandable_product_tile.dart';
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RestaurantTab extends StatefulWidget {

  final RestaurantData restaurantData;
  RestaurantTab(this.restaurantData);

  @override
  _RestaurantTabState createState() => _RestaurantTabState(restaurantData);
}

class _RestaurantTabState extends State<RestaurantTab> with SingleTickerProviderStateMixin{
  //String categoryName; //bebidas,refeicoes,sanduiches...
  //String restaurantName;
  CategoryData categoryData;
  RestaurantData selectedRestaurant;
  PageController pageController;

  _RestaurantTabState(this.selectedRestaurant);//receives the restaurant object clicked from the home_tab

  bool expanded = false; // if true is ExpansionTile is expanded, if false is collapsed
  AnimationController animationController;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250)
    );

    animation = Tween(begin: 24.0, end: 32.0).animate(CurvedAnimation(parent: animationController, curve: Curves.linear));

    animationController.addStatusListener((status){
      if(status == AnimationStatus.completed){
        animationController.reverse();
      }
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    final model = UserModel.of(context);

    void _saveFavs() async{
      final prefs = await SharedPreferences.getInstance();
      for(var id in model.userFavorites){
        prefs.setString(id, "true");
      }
    }


    return Scaffold(
      appBar: AppBar(
        title: Text(selectedRestaurant.name),
        actions: <Widget>[
            Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: AnimatedBuilder(
              animation: animation,
              builder: (context, child){
                return IconButton(
                    icon: model.userFavorites.contains(selectedRestaurant.id) ? Icon(Icons.favorite, size: animation.value,) :
                    Icon(Icons.favorite_border, size: animation.value,),
                    onPressed: (){
                      animationController.forward();
                      setState(() { // First check if the restaurant if fav or not
                        model.userFavorites.contains(selectedRestaurant.id) ? model.userFavorites.remove(selectedRestaurant.id) :
                        model.userFavorites.add(selectedRestaurant.id);
                      });
                      // Then save it locally with Shared_Preferences
                      // todo: need to make a hash of the restaurant id's
                      _saveFavs();
                    }
                );
              },
            )
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            //Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => CartScreen()));
          },
          child: Icon(Icons.shopping_cart),
          backgroundColor: Theme.of(context).primaryColor,
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: Firestore.instance
            .collection("restaurants")
            .document(selectedRestaurant.id)//restaurante1,restaurante2,restaurante3...
            .collection("cardapio")
            .getDocuments(),//it contains the categories (ex:bebidas,refeicoes,sanduiches)
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),),
            );
          } else {
            return ListView(
              children: snapshot.data.documents.map((doc) {
                categoryData = CategoryData.fromDocument(doc);
                return ExpansionTile(
                  onExpansionChanged: (value){ // Called when expanded
                    setState(() {
                      if(expanded == false){
                        expanded = true;
                      }
                      else{
                        expanded = false;
                      }
                    });
                  },
                  title: Text(doc.data["name"]),
                  trailing: expanded == false ? Icon(Icons.keyboard_arrow_right,color: Colors.grey[700],) : Icon(Icons.keyboard_arrow_down),
                  children: <Widget>[
                    ExpandableProductTile(selectedRestaurant,categoryData)
                  ],
                );
              }).toList(),
            );
          }
        },
      ),
    );
  }
}

