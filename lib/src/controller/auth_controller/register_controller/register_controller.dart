import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterController {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future registerAUser(String email, String password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user?.uid != null) {
        //account created successfully
        sharedPreferences.setString("userId", userCredential.user!.uid);
        return true;
      } else {
        return "Something went wrong try again";
      }
    } catch (e) {
      return e;
    }
  }
}
