import 'package:college_snacks/Widgets/user_profile_picture.dart';
import 'package:college_snacks/models/user_model.dart';
import 'package:college_snacks/screens/edit_user_screen.dart';
import 'package:college_snacks/screens/login_screen.dart';
import 'package:flutter/material.dart';
class UserSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final UserModel model = UserModel.of(context);
    if(model.isLoading) return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),),);
    else if (!model.isLoggedIn()) {
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
          Container(
            padding: EdgeInsets.only(top: 15.0, left: 15.0),
            child: Row(
              children: <Widget>[
                UserProfilePicture(50.0, 50.0),
                SizedBox(width: 20.0,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(model.userData["name"], style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16.0),),
                    InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => UserEditScreen()));
                      },
                      splashColor: Colors.white, // No colors onTap
                      child: Row(
                        children: <Widget>[
                          Text("Editar cadastro"),
                          SizedBox(width: 8.0,),
                          Icon(Icons.settings, color: Color.fromRGBO(133, 137, 138, 1), size: 20.0,)
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 10.0,),
          Card(
            margin: EdgeInsets.symmetric(horizontal: 15.0),
            elevation: 3.0,
            child: Row(
              children: <Widget>[
                Icon(Icons.donut_large)
              ],
            ),
          )
        ],
      );
    }
  }
}
/*ListTile(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CardSettings()));
            },
            leading: Icon(
              Icons.credit_card, color: Colors.blueAccent,),
            title: Text("Gerenciar pagamentos"),
            trailing: Icon(Icons.arrow_forward_ios),
          ),*/