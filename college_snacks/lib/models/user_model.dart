import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel extends Model{

  @override
  void addListener(VoidCallback listener) async{  // function that is called when the object (UserModel variables) changes.
    super.addListener(listener); // Add a listener
    await loadUser(); // refresh current user and user data
  }

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

  Future<Null> signIn({@required String email, @required String pass, VoidCallback onSuccess, VoidCallback onFailed}) async{
    isLoading = true;
    notifyListeners();

    await _auth.signInWithEmailAndPassword(email: email, password: pass).then((user) async{
      firebaseUser = user;

      await loadUser();
      onSuccess();
      isLoading = false;
      notifyListeners();
    }).catchError((e){
      onFailed();
      isLoading = false;
      notifyListeners();
    });
  }

  Future signOut() async {
    await _auth.signOut();

    userData = Map();
    firebaseUser = null;
    notifyListeners();
  }

   Future<Null> loadUser() async{ // Function to recover a logged user from Firebase (when it closes the app, for example)
    if(firebaseUser == null){
      firebaseUser = await  _auth.currentUser();
    }
    if(firebaseUser != null){
      DocumentSnapshot doc = await Firestore.instance.collection("users").document(firebaseUser.uid).get();
      this.userData = doc.data;
    }
  }

  bool isLoggedIn(){
    return firebaseUser != null;
  }

  Future<Null> _saveUserData(Map<String,dynamic> userData) async {//underscore states that the function can only be called inside the class, i.e, internal function
    this.userData = userData;
    await Firestore.instance.collection("users").document(firebaseUser.uid).setData(userData); //saving userData on Firebase
  }

}