import 'package:college_snacks/Widgets/CustomDrawer.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(), // Still need to create
      backgroundColor: Colors.black,
      body: FutureBuilder<QuerySnapshot>(
        future: Firestore.instance.collection("images").getDocuments(),
        builder: (context, snapshot){
          if(!snapshot.hasData){
            return Center(child: CircularProgressIndicator(),);
          }
          else{
            return CustomScrollView(
              slivers: <Widget>[
                SliverAppBar( // AppBar that expands itself
                  floating: false,
                  pinned: true,
                  snap: false,
                  expandedHeight: 80, // The height of the bar when expanded
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text("Restaurantes", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),),
                    centerTitle: true,
                    background: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [ // Colors for the gradient
                                Color.fromRGBO(181, 1, 97, 1),
                                Color.fromRGBO(164, 1, 153, 1)
                              ],
                              begin: Alignment.topLeft, // Where the gradient begins
                              end: Alignment.bottomRight // Where the gradient ends
                          )
                      ),
                    ),
                  ),
                    backgroundColor: Color.fromRGBO(181, 1, 97, 1)
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index){
                    return Container(
                      margin: index == 0 ? EdgeInsets.only(top: 5.0, bottom: 2.5, right: 5.0, left: 5.0) : EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.5),
                      height: 150,
                      width: 200,
                      child: Card(
                        child: Image.network(snapshot.data.documents[index]["url"], fit: BoxFit.cover,),
                      ),
                    );
                  }, childCount: snapshot.data.documents.length
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }
}




