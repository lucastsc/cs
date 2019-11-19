import 'package:college_snacks/Tabs/home_tab.dart';
import 'package:college_snacks/Tabs/my_orders_tab.dart';
import 'package:college_snacks/Widgets/CustomDrawer.dart';
import 'package:college_snacks/screens/cart_screen.dart';
import 'package:college_snacks/screens/user_settings_screen.dart';
import 'package:flutter/material.dart';

PageController pageController = new PageController(); // PageController for PageView

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageView(// Every child of PageView is a screen
      controller: pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          drawer: CustomDrawer(pageController),
          backgroundColor: Colors.black,
          body: HomeTab()
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Carrinho"), backgroundColor: Theme.of(context).primaryColor,
            centerTitle: true,
          ),
          drawer: CustomDrawer(pageController),
          body: CartScreen(pageController),
        ),
        MyOrdersTab(pageController),
        Scaffold(
          appBar: AppBar(
            title: Text("College Snacks"),
            backgroundColor: Theme.of(context).primaryColor,
            centerTitle: true,
          ),
          drawer: CustomDrawer(pageController),
          body: UserSettingsScreen(),
        )
      ],
    );
  }
}





