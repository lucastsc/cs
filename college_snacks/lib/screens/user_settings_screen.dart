import 'package:college_snacks/Tabs/about_us_tab.dart';
import 'package:college_snacks/Tabs/card_settings_tab.dart';
import 'package:college_snacks/Tabs/sales_tab.dart';
import 'package:college_snacks/Tabs/user_favorites_tab.dart';
import 'package:college_snacks/Widgets/user_profile_picture.dart';
import 'package:college_snacks/models/user_model.dart';
import 'package:college_snacks/screens/edit_user_screen.dart';
import 'package:college_snacks/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
class UserSettingsScreen extends StatelessWidget {

  final PageController controller;
  UserSettingsScreen(this.controller);

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
              "Faça o login para gerenciar sua conta!",
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
                UserProfilePicture(60.0, 60.0),
                SizedBox(width: 20.0,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(model.userData["name"], style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20.0),),
                    SizedBox(height: 2.5,),
                    InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => UserEditScreen()));
                      },
                      splashColor: Colors.white, // No colors onTap
                      child: Row(
                        children: <Widget>[
                          Text("Editar cadastro", style: TextStyle(fontSize: 16.0),),
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
          SizedBox(height: 15.0,),
          _buildIconTile(Icons.favorite, "Meus favoritos", context, 0, controller: controller),
          SizedBox(height: 15.0,),
          _buildIconTile(MaterialCommunityIcons.getIconData("ticket-percent"), "Promoções", context, 1),
          SizedBox(height: 15.0,),
          _buildIconTile(MaterialCommunityIcons.getIconData("credit-card-multiple"), "Pagamento", context, 2),
          SizedBox(height: 12.0,),
          _buildIconTile(MaterialCommunityIcons.getIconData("information-variant"), "Sobre", context, 3)
        ],
      );
    }
  }
}

Widget _buildIconTile(IconData icon, String text, BuildContext context, int pageNumber, {PageController controller}){
  return InkWell(
    onTap: (){
      if(pageNumber == 0) Navigator.of(context).push(MaterialPageRoute(builder: (context) => UserFavoritesTab(controller)));
      if(pageNumber == 1) Navigator.of(context).push(MaterialPageRoute(builder: (context) => SalesTab()));
      if(pageNumber == 2) Navigator.of(context).push(MaterialPageRoute(builder: (context) => CardSettings()));
      if(pageNumber == 3) Navigator.of(context).push(MaterialPageRoute(builder: (context) => AboutUsTab()));
    },
    child: Container(
      margin: EdgeInsets.only(left: 22.0, top: 20.0),
      child: Row(
        children: <Widget>[
          Icon(icon, size: 33.0,),
          SizedBox(width: 18.0,),
          Text(text, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),),
        ],
      ),
    ),
  );
}