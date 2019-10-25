import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_snacks/models/cart_model.dart';
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

  static UserModel of(BuildContext context)=>
      ScopedModel.of<UserModel>(context);

  //current user
  void signUp({@required Map<String,dynamic> userData,@required String password,@required VoidCallback onSuccess,@required VoidCallback onFail}){
    isLoading = true;
    notifyListeners();

    _auth.createUserWithEmailAndPassword(
        email: userData["email"],
        password: password
    ).then((user) async { //if it's ok creating the new user, then...
      firebaseUser = user.user;

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
      firebaseUser = user.user;

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
      isLoading = true;
      notifyListeners();
      firebaseUser = await  _auth.currentUser();
      isLoading = false;
      notifyListeners();
    }
    if(firebaseUser != null){
      isLoading = true;
      notifyListeners();
      DocumentSnapshot doc = await Firestore.instance.collection("users").document(firebaseUser.uid).get();
      this.userData = doc.data;
      isLoading = false;
      notifyListeners();
    }
  }

  bool isLoggedIn(){
    return firebaseUser != null;
  }

  Future<Null> updateUser(Map<String, dynamic> newData, VoidCallback onSuccess) async{  // Updates user data when its changed by the user
    isLoading = true;
    notifyListeners();
    this.userData = newData;
    await Firestore.instance.collection("users").document(firebaseUser.uid).setData(userData);
    onSuccess();
    isLoading = false;
    notifyListeners();
  }

  Future<Null> _saveUserData(Map<String,dynamic> userData) async {
    this.userData = userData;
    await Firestore.instance.collection("users").document(firebaseUser.uid).setData(userData); //saving userData on Firebase
  }

}