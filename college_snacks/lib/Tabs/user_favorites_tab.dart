import 'package:college_snacks/models/user_model.dart';
import 'package:flutter/material.dart';

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
            print("true");
            return _buildTile(value, EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0, bottom: 5.0));
          }
          else{
            return _buildTile(value, EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0));
          }
        }).toList()
      ),
    );
  }
}

Widget _buildTile(String value, EdgeInsets margin){
  return Container(
    margin: margin,
    height: 65.0,
    decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[400], width: 1.0)
    ),
    child: Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10.0),
          child: CircleAvatar(child: Icon(Icons.person),),
        ),
        VerticalDivider(width: 3.0, color: Colors.grey[400],),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(value),
            Row(
              children: <Widget>[
                Icon(Icons.star, color: Colors.yellow[800], size: 15.0,),
                SizedBox(width: 4.0,),
                Text("4.7", style: TextStyle(color: Colors.yellow[800], fontSize: 12.0),),
                SizedBox(width: 3.0,),
                Container(
                  height: 3.0,
                  width: 3.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[800]
                  ),
                )
              ],
            )
          ],
        )
      ],
    ),
  );
}
