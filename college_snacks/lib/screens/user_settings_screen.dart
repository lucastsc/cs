import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_snacks/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class UserSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(
      builder: (context,child,model){
        if(!model.isLoggedIn()){
          return CircularProgressIndicator();
        }
        else{
          return FutureBuilder<QuerySnapshot>(
            future: Firestore.instance.collection("userIcons").getDocuments(),
            builder: (context, snapshot){
              if(!snapshot.hasData){
                return Center(child: CircularProgressIndicator(),);
              }
              else{
                return ListView(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10.0),
                      //height: 50.0,
                      child: Row(
                        children: <Widget>[
                          CircleAvatar(
                            backgroundImage: model.userData["stage"] == 0 ? NetworkImage(snapshot.data.documents[0]["icon"]) : NetworkImage(snapshot.data.documents[1]["icon"])
                          ),
                          SizedBox(width: 30,),
                          Text(model.userData["name"], style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),)
                        ],
                      ),
                    ),
                  ],
                );
              }
            },
          );
        }
      },
    );
  }
}
