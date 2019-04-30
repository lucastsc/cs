import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel extends Model{

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser firebaseUser;

  Map<String,dynamic> userData = Map();//will have name, email, user information...

  bool isLoading = false;

  //current user
  void signUp({@required Map<String,dynamic> userData,@required String password,@required VoidCallback onSuccess,@required VoidCallback onFail}){
    isLoading = true;
    notifyListeners();

    _auth.createUserWithEmailAndPassword(
        email: userData["email"],
        password: password
    ).then((user) async { //if it's ok creating the new user, then...
      firebaseUser = user;

      await _saveUserData(userData);//saving userData on Firebase

      onSuccess(); //VoidCallback function defined
      isLoading = false;
      notifyListeners();

    }).catchError((e){ //if there is a problem creating the new user, then...

      onFail(); //VoidCallback function defined
      isLoading = false;
      notifyListeners();
    });
  }

  void signIn(){

  }

  void recoverPass(){

  }

  void isLoggedIn(){

  }

  Future<Null> _saveUserData(Map<String,dynamic> userData) async {//underscore states that the function can only be called inside the class, i.e, internal function
    this.userData = userData;
    await Firestore.instance.collection("users").document(firebaseUser.uid).setData(userData); //saving userData on Firebase
  }
}