import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_snacks/Tabs/card_settings_tab.dart';
import 'package:college_snacks/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_cielo/flutter_cielo.dart';

class UserSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(
      builder: (context, child, model) {
        if (!model.isLoggedIn()) {
          return CircularProgressIndicator();
        }
        else {
          return ListView(
            children: <Widget>[
              ListTile(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CardSettings()));
                },
                leading: Icon(
                  Icons.credit_card, color: Colors.blueAccent,),
                title: Text("Gerenciar pagamentos"),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ],
          );
        }
      },
    );
  }
}