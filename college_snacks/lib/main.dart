import 'package:college_snacks/models/cart_model.dart';
import 'package:college_snacks/models/user_model.dart';
import 'package:college_snacks/screens/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
        model: UserModel(),
        child: ScopedModelDescendant<UserModel>(
            builder:(context,child,model){
              return ScopedModel<CartModel>(
                  model:CartModel(model),
                  child:MaterialApp(
                    theme: ThemeData(
                        primaryColor: Color.fromRGBO(181, 1, 97, 1)
                    ),
                    home: HomeScreen(),
                    debugShowCheckedModeBanner: false,
                  )//MaterialApp
              );//ScopedModel<CartModel>
            }//builder
        )

    );
  }
}


