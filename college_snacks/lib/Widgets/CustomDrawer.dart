import 'package:college_snacks/models/user_model.dart';
import 'package:college_snacks/screens/login_screen.dart';
import 'package:college_snacks/tiles/drawer_tile.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CustomDrawer extends StatelessWidget {

  final PageController pageController;
  CustomDrawer(this.pageController);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: <Widget>[
          ListView(
            padding: EdgeInsets.only(left: 24.0,top: 16.0),
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 8.0),
                padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                height: 170.0,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 8.0,
                      left: 0.0,
                      child: /*Text(
                        "College\nSnacks",
                        style: TextStyle(fontSize: 34.0,fontWeight: FontWeight.bold),),*/
                        Container(
                          height: 90,
                          width: 160,
                          child: Image.asset("assets/LogoCSapp2.png", fit: BoxFit.contain),
                        )
                    ),
                    Positioned(
                      left: 0.0,
                      bottom: 0.0,
                      child: ScopedModelDescendant<UserModel>(
                        builder: (context,child,model){
                          print(model.isLoggedIn());
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Olá, ${!model.isLoggedIn() ? "" : model.userData["name"]}",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              GestureDetector(
                                child: Text(
                                  !model.isLoggedIn()?
                                  "Entre ou cadastre-se"
                                  : "Sair",
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onTap: (){
                                  if(!model.isLoggedIn()){
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginScreen()));
                                  }else{
                                    model.signOut();
                                  }
                                },
                              )
                            ],
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
              Divider(),
              DrawerTile(Icons.home,"Início", pageController, 0),
              DrawerTile(Icons.shopping_cart,"Carrinho", pageController, 1),
              DrawerTile(Icons.playlist_add_check,"Meus Pedidos", pageController, 2),
              DrawerTile(Icons.settings, "Preferências", pageController, 3)
            ],
          )
        ],
      ),
    );
  }
}
