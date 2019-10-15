import 'package:college_snacks/Tabs/card_settings_tab.dart';
import 'package:college_snacks/models/user_model.dart';
import 'package:college_snacks/screens/login_screen.dart';
import 'package:flutter/material.dart';
class UserSettingsScreen extends StatelessWidget {



  @override
  Widget build(BuildContext context) {

    final UserModel model = UserModel.of(context);

    if (!model.isLoggedIn()) {
      return Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.supervised_user_circle,
              size: 80.0,
              color: Theme.of(context).primaryColor,
            ),
            SizedBox(
              height: 16.0,
            ),
            Text(
              "Faça o login para gerenciar pagamentos!",
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
  }
}
