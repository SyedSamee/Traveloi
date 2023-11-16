import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:traveloi/src/view/auth/login/login_screen.dart';

List<Map<String, dynamic>> favProducts = [];
//you can find favProducts controller at homecontroller
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
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (route) => false);
  } else {
    return true;
  }
}
