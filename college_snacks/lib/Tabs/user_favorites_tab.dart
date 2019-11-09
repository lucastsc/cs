import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_snacks/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class UserFavoritesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final UserModel model = UserModel.of(context);

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
              return _buildTile(value, EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0, bottom: 2.5));
            }
            else{
              return _buildTile(value, EdgeInsets.symmetric(horizontal: 15.0, vertical: 2.5));
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
        
      ]
    )
  );
}

Widget _buildTile(String value, EdgeInsets margin){
  return FutureBuilder<DocumentSnapshot>(
    future: Firestore.instance.collection("restaurants").document(value).get(),
    builder: (context, snapshot){
      if(!snapshot.hasData) return Center();
      else return Container(
        margin: margin,
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0),
              child: Container(
                  child: CircleAvatar(child: Icon(Icons.person), ),
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
                          child:
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
      );
    },
  );
}
