import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_snacks/Widgets/CustomDrawer.dart';
import 'package:college_snacks/models/user_model.dart';
import 'package:college_snacks/screens/login_screen.dart';
import 'package:college_snacks/tiles/order_tile.dart';
import 'package:flutter/material.dart';

class MyOrdersTab extends StatelessWidget {

  PageController pageController;
  MyOrdersTab(this.pageController);

  @override
  Widget build(BuildContext context) {

    if(UserModel.of(context).isLoggedIn()){
      String uid = UserModel.of(context).firebaseUser.uid;

      return Scaffold(
        appBar: AppBar(
          title: Text("Meus pedidos"), backgroundColor: Theme.of(context).primaryColor,
          centerTitle: true,
        ),
        drawer: CustomDrawer(pageController),
        body: FutureBuilder<QuerySnapshot>(
          future: Firestore.instance.collection("users").document(uid).collection("orders").getDocuments(),
          builder: (context, snapshot){
            if(!snapshot.hasData){
              return Center(
                child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),),
              );
            }
            else{
              return ListView(
                  children: snapshot.data.documents.map((doc) => OrderTile(doc.documentID)).toList()
              );
            }
          },
        )
      );
    }
    else{
     return Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.view_list,
              size: 80.0,
              color: Theme.of(context).primaryColor,
            ),
            SizedBox(
              height: 16.0,
            ),
            Text(
              "Faça o login para acompanhar pedidos!",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 16.0,
            ),
            RaisedButton(
              child: Text(
                "Entrar",
                style: TextStyle(fontSize: 18.0),
              ),
              textColor: Colors.white,
              color: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            )
          ],
        ),
      );
    }
  }
}

/*
FutureBuilder<QuerySnapshot>(
        future: Firestore.instance.collection("users").document(uid).collection("orders").getDocuments(),
        builder: (context, snapshot){
          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),),
            );
          }
          else{
            return ListView(
              children: snapshot.data.documents.map((doc) => OrderTile(doc.documentID)).toList()
            );
          }
        },
      );
 */