import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailedProductController {
  static int? person;
  static DateTime? datetime;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Future bookATravel() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    await firebaseFirestore
        .collection("users")
        .doc(sharedPreferences.getString("userId"))
        .collection("book_travel")
        .add({
      //place id
      //booking detail date and person
      //good to go
    });
  }
}
