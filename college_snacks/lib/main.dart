import 'package:college_snacks/models/user_model.dart';
import 'package:college_snacks/screens/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

void main(){

  runApp(
    ScopedModel<UserModel>(
        model: UserModel(),
        child: MaterialApp(
          home: HomeScreen(),
          debugShowCheckedModeBanner: false,
        ))
  );
}