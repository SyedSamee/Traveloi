import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
