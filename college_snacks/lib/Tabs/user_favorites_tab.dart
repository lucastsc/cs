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
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
            height: 25.0,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[400], width: 1.0)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CircleAvatar(child: Icon(Icons.person),),
                SizedBox(height: 25.0, width: 1.0,),
                Text(value)
              ],
            ),
          );
        }).toList()
      ),
    );
  }
}
