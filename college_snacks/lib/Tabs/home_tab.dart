import 'package:animated_card/animated_card.dart';
import 'package:college_snacks/Tabs/restaurant_tab.dart';
import 'package:college_snacks/datas/restaurant_data.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {

  RestaurantData selectedRestaurant;//create the object restaurant.It will contain all the fields of a restaurant.See "restaurant_data".

  @override
  Widget build(BuildContext context) {

    Color _color = Theme.of(context).primaryColor;

    return FutureBuilder<QuerySnapshot>(
      future: Firestore.instance.collection("restaurants").getDocuments(),
      builder: (context, snapshot){
        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),),);
        }
        else{
          return CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(// AppBar that expands itself
                actions: <Widget>[
                  IconButton(icon: Icon(Icons.search), onPressed: (){
                    showSearch(context: context, delegate: DataSearch());
                  })
                ],
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
                  return AnimatedCard(
                      direction: AnimatedCardDirection.left, //Initial animation direction
                      initDelay: Duration(milliseconds: 0), //Delay to initial animation
                      duration: Duration(seconds: 2), //Initial animation duration
                      child: Container(
                        margin: index == 0 ? EdgeInsets.only(top: 5.0, bottom: 2.5, right: 5.0, left: 5.0) : EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.5),
                        height: 150,
                        width: 400,
                        child: GestureDetector(
                          child: Card(
                            color: Colors.blue,
                            child: Image.network(snapshot.data.documents[index]["url"], fit: BoxFit.cover,),
                          ),
                          onTap: (){
                            selectedRestaurant = RestaurantData.fromDocument(snapshot.data.documents[index]);//create a restaurant object with all of it's fields
                            Navigator.push(context, MaterialPageRoute(builder: (context) => RestaurantTab(selectedRestaurant)));//sends the restaurant object to the RestaurantTab
                          },
                        ),
                      )
                  );
                  //snapshot.data.documents[index]["url"]
                }, childCount: snapshot.data.documents.length
                ),
              )
            ],
          );
        }
      },
    );
  }
}

class DataSearch extends SearchDelegate<String>{

  final restaurants = [];

  final recentRestaurants = [
    "Jeronimo",
    "Pizza Hut",
    "Dona Lenha"
  ];

  Future<Null> fetchData() async{
    await Firestore.instance.collection("restaurants").getDocuments().then((query){
      if(restaurants.isEmpty){
        for(DocumentSnapshot doc in query.documents){
          restaurants.add(doc["name"]);
        }
      }
    });
  }

  @override
  List<Widget> buildActions(BuildContext context) { // Actions for SearchBar
    return [
      IconButton(icon: Icon(Icons.clear), onPressed: (){query = "";},), // query is what the TextField contains at the moment
    ];
  }

  @override
  Widget buildLeading(BuildContext context) { // Leading Icon on the left of SearchBar
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation
        ), onPressed: (){close(context, null);}
    );
  }

  @override
  Widget buildResults(BuildContext context) { // Show results based on selection
  }

  @override
  Widget buildSuggestions(BuildContext context){ // Shown when someone searches for something

    fetchData();

    final suggestionList = query.isEmpty ? recentRestaurants :  restaurants.where((p) => p.startsWith(query)).toList();

    return ListView.builder(
      itemBuilder: (context, index){
        if(!(restaurants.isEmpty)){
          return ListTile(
            leading: Icon(Icons.location_city),
            title: RichText(text: TextSpan(text: suggestionList[index].substring(0, query.length),
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                children: [
                  TextSpan(text: suggestionList[index].substring(query.length),
                      style: TextStyle(color: Colors.grey)
                  )
                ]
            )),
          );
        }
      },
      itemCount: suggestionList.length,
    );
  }
}

/*
AnimatedCard(
                      direction: AnimatedCardDirection.left, //Initial animation direction
                      initDelay: Duration(milliseconds: 0), //Delay to initial animation
                      duration: Duration(seconds: 2), //Initial animation duration
                      child: Container(
                        margin: index == 0 ? EdgeInsets.only(top: 5.0, bottom: 2.5, right: 5.0, left: 5.0) : EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.5),
                        height: 150,
                        width: 200,
                        child: GestureDetector(
                          child: Card(
                            color: Colors.blue,
                            child: Image.network(snapshot.data.documents[index]["url"], fit: BoxFit.cover,),
                          ),
                          onTap: (){
                            selectedRestaurant = RestaurantData.fromDocument(snapshot.data.documents[index]);//create a restaurant object with all of it's fields
                            Navigator.push(context, MaterialPageRoute(builder: (context) => RestaurantTab(selectedRestaurant)));//sends the restaurant object to the RestaurantTab
                          },
                        ),
                      )
                  );
 */