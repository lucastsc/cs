import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_snacks/datas/cart_product.dart';
import 'package:college_snacks/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model{

  UserModel user;
  List<CartProduct> products =[];
  bool isLoading = false;
  String couponCode;
  int discountPercentage;
  
  double cartFinalPrice;

  CartModel(this.user){
    loadCart();
  }

  static CartModel of(BuildContext context)=>
      ScopedModel.of<CartModel>(context);

  void addCartItem(CartProduct cartProduct){
    products.add(cartProduct);

    Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("cart").add(cartProduct.toMap()).then((doc){
      cartProduct.cid = doc.documentID;
    });

    notifyListeners();
  }

  void removeCartItem(CartProduct cartProduct){
    Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("cart").document(cartProduct.cid).delete();

    products.remove(cartProduct);
    notifyListeners();
  }

  void setCoupon(String couponCode, int discountPercentage){
    this.couponCode = couponCode;
    this.discountPercentage = discountPercentage;
  }

  Future<Null> loadCart() async{ // fetch the data of the user cart and store it on product List.
    Future.delayed(Duration(seconds: 1)).then((v) async{ // delayed to wait the user to get loaded
      if(user.firebaseUser != null){
        QuerySnapshot docs;
        docs = await Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("cart").getDocuments();
        products = docs.documents.map((doc) => CartProduct.fromDocument(doc)).toList();

        notifyListeners();
      }
    });
  }

  double getProductsPrice() { // don't need to access dataBase
    double price = 0.0;
    for(CartProduct c in products){
      if(c.productData != null){
        price += c.quantity * c.productData.price;
        print(price);
      }
    }
    return price;
  }

  double getDiscount(){
    return (getProductsPrice()*discountPercentage/100);
  }

  void updatePrices(){
    notifyListeners();
  }

}