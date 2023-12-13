import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:traveloi/src/view/auth/login/login_screen.dart';

Future getUserDetail() async {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  try {
    var response = await firebaseFirestore
        .collection("users")
        .doc(sharedPreferences.getString("userId"))
        .get();
    return response.data();
  } catch (e) {
    if (e is FirebaseException) {
      return e.message;
    } else {
      return e;
    }
  }
}

Future checkIfUserExist(BuildContext context) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  if (sharedPreferences.getString("userId") == null) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false);
  } else {
    return true;
  }
}

Future getAProductDetail(String productId) async {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  try {
    var productResponse =
        await firebaseFirestore.collection("products").doc(productId).get();
    if (productResponse.exists) {
      return productResponse.data() as Map<String, dynamic>;
    } else {
      return "Id is'nt valid";
    }
  } catch (e) {
    if (e is FirebaseException) {
      return e.message;
    } else {
      return e;
    }
  }
}
