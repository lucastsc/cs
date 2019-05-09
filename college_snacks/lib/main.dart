import 'package:college_snacks/models/user_model.dart';
import 'package:college_snacks/screens/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

void main(){

  runApp(
    ScopedModel<UserModel>(
        model: UserModel(),
        child: MaterialApp(
          theme: ThemeData(
            primaryColor: Color.fromRGBO(181, 1, 97, 1)
          ),
          home: HomeScreen(),
          debugShowCheckedModeBanner: false,
        ))
  );
}