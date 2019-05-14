import 'package:college_snacks/Tabs/home_tab.dart';
import 'package:college_snacks/Widgets/CustomDrawer.dart';
import 'package:college_snacks/screens/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

PageController pageController = new PageController(); // PageController for PageView

class HomeScreen extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return PageView(// Every child of PageView is a screen
      controller: pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          drawer: CustomDrawer(pageController), // Still need to create
          backgroundColor: Colors.black,
          body: HomeTab()
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Carrinho"), backgroundColor: Theme.of(context).primaryColor,
            centerTitle: true,
          ),
          drawer: CustomDrawer(pageController),
          body: CartScreen(),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Carrinho"), backgroundColor: Theme.of(context).primaryColor,
            centerTitle: true,
          ),
          drawer: CustomDrawer(pageController),
          body: Container(color: Colors.black,),
        )
      ],
    );
  }
}





