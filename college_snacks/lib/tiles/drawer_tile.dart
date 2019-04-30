import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {

  final IconData icon;
  final String text;

  DrawerTile(this.icon,this.text);//constructor

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: (){

        },
        child: Container(
          height: 60.0,
          child: Row(
            children: <Widget>[
              Icon(
                icon,
                size: 32.0,
                color: Colors.black,
              ),
              SizedBox(width: 32.0,),//it puts a space between the icon and the text, in the NavigationDrawer,
              Text(
                text,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
