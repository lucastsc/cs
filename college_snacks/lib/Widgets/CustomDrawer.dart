import 'package:college_snacks/screens/signup_screen.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          
          ListTile(
            title: Text("Cadastre-se"),
            onTap: (){
              Navigator.of(context).pop();//before going to SignUpScreen, it backs off the Navigation Drawer
              Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
            },
          )

        ],
      ),
    );
  }
}
