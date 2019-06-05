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
  int discountPercentage = 0;

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

        print("carreguei os produtos");

        notifyListeners();
      }
    });
  }

  double getProductsPrice() { // don't need to access dataBase
    double price = 0.0;
    for(CartProduct c in products){
      if(c.productData != null){
        price += c.quantity * c.productData.price;
      }
    }
    return price;
  }

  double getDiscount(){
    return getProductsPrice() * discountPercentage / 100;
  }

  void updatePrices(){ // function to fix the loading prices problem
    notifyListeners();
  }

  Future<String> finishOrder() async{ // function to finish the order and add it to dataBase
    if(products.length == 0) return null;

    isLoading = true;
    notifyListeners();

    double productsPrice = getProductsPrice();
    double discount = getDiscount();

    DocumentReference refOrder = await Firestore.instance.collection("orders").add({ // refOrder holds the new document created id
      "clientID" : user.firebaseUser.uid,
      "products" : products.map((cartProduct)=>cartProduct.toMap()).toList(),
      "productsPrice" : productsPrice,
      "discount" : discount,
      "finalPrice" : productsPrice - discount,
      "status" : 1 // the initial status of an order is '1'. It is waiting for restaurant confirmation... There will be 4 steps.

    });

   await Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("orders").document(refOrder.documentID).
      setData({
        "orderID" : refOrder.documentID
      });

   QuerySnapshot query = await Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("cart").getDocuments();

   for(DocumentSnapshot doc in query.documents){
     doc.reference.delete(); // Delete each order document from user cart
   }

   products.clear();

   couponCode = null;
   discountPercentage = 0;

   isLoading = false;
   notifyListeners();

   return refOrder.documentID; // returns the ID of the document created for this order
  }

}