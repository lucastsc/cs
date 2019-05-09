import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {

  final IconData icon;
  final String text;
  final PageController pageController;
  final int pageNumber;

  DrawerTile(this.icon,this.text, this.pageController, this.pageNumber);//constructor

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: (){
          Navigator.of(context).pop(); //Closes the Navigation Drawer
          pageController.jumpToPage(pageNumber); // Jump to page from that correspond to the DrawerTile
        },
        child: Container(
          height: 50.0,
          child: Row(
            children: <Widget>[
              Icon(
                icon,
                size: 32.0,
                color: pageController.page.round() == pageNumber ? Theme.of(context).primaryColor : Colors.black,
              ),
              SizedBox(width: 32.0,),//it puts a space between the icon and the text, in the NavigationDrawer,
              Text(
                text,
                style: TextStyle(
                  fontSize: 16.0,
                  color: pageController.page.round() == pageNumber ? Theme.of(context).primaryColor : Colors.black
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
