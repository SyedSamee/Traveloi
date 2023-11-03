import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterController {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Future registerAUser(String name, String email, String password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user?.uid != null) {
        //account created successfully
        sharedPreferences.setString("userId", userCredential.user!.uid);

        await firebaseFirestore
            .collection("users")
            .doc(sharedPreferences.getString("userId"))
            .set({"name": name, "email": email});
        return true;
      } else {
        return "Something went wrong try again";
      }
    } catch (e) {
      if (e is FirebaseException) {
        return e.message;
      } else {
        return e;
      }
    }
  }
}
