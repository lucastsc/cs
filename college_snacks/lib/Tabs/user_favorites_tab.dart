import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_snacks/Tabs/restaurant_tab.dart';
import 'package:college_snacks/datas/restaurant_data.dart';
import 'package:college_snacks/models/user_model.dart';
import 'package:college_snacks/screens/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class UserFavoritesTab extends StatelessWidget {

  final PageController controller;
  UserFavoritesTab(this.controller);

  @override
  Widget build(BuildContext context) {

    final UserModel model = UserModel.of(context);
    RestaurantData selectedRestaurant;

    return Scaffold(
      appBar: AppBar(
        title: Text("Favoritos"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.of(context).pop();
          }
        ),
      ),
      body: ListView(
          children: model.userFavorites.map((value){
            if(value == model.userFavorites[0]){
              return _buildTile(value, EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0, bottom: 2.5), selectedRestaurant);
            }
            else{
              return _buildTile(value, EdgeInsets.symmetric(horizontal: 15.0, vertical: 2.5), selectedRestaurant);
            }
          }).toList()
      )
    );
  }
}

Widget _buildCost(int cost){ // Cost varies from 1 to 5
  String text = "\$\$\$\$\$";
  return RichText(
    text: TextSpan(
      children: <TextSpan>[
        TextSpan(text: text.substring(0,cost), style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w900, color: Colors.grey[700]),),
        TextSpan(text: text.substring(cost, text.length), style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w700, color: Colors.grey[500]),)
      ]
    )
  );
}

Widget _buildTile(String value, EdgeInsets margin, RestaurantData selectedRestaurant){
  return FutureBuilder<DocumentSnapshot>(
    future: Firestore.instance.collection("restaurants").document(value).get(),
    builder: (context, snapshot){
      if(!snapshot.hasData) return Center();
      else return InkWell(
        onTap: (){
          selectedRestaurant = RestaurantData.fromDocument(snapshot.data);
          Navigator.push(context, MaterialPageRoute(builder: (context) => RestaurantTab(selectedRestaurant, pageController)));
        },
        child: Container(
          margin: margin,
          child: Row(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0),
                  child: Container(
                    child: CircleAvatar(backgroundImage: NetworkImage(snapshot.data["url"]),),
                    height: 50.0,
                    width: 50.0,
                  )
              ),
              VerticalDivider(width: 3.0, color: Colors.grey[400],),
              SizedBox(width: 10.0,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(snapshot.data["name"], style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 16.5),),
                        Container(
                          margin: EdgeInsets.only(right: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Icon(Icons.star, color: Colors.yellow[800], size: 15.0,),
                              SizedBox(width: 4.0,),
                              Text("4.7", style: TextStyle(color: Colors.yellow[800], fontSize: 12.0),),
                              SizedBox(width: 3.0,),
                            ],
                          ),
                        )
                      ],
                    ),
                    Text(snapshot.data["description"], style: TextStyle(color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.w500),),
                    Row(
                      children: <Widget>[
                        Icon(MaterialCommunityIcons.getIconData("clock-outline"), color: Colors.black54, size: 20.0,),
                        SizedBox(width: 5.0,),
                        Text(snapshot.data["timeMin"] + " - " + snapshot.data["timeMax"] + " min", style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w400),),
                        Expanded(
                            child: Container(
                                padding: EdgeInsets.only(right: 10.0),
                                alignment: Alignment.centerRight,
                                child: _buildCost(snapshot.data["cost"])
                            )
                        )
                      ],
                    ),
                    Divider(color: Colors.grey[700])
                  ],
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}
