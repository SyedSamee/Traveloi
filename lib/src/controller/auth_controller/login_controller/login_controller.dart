import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future loginAUser(String email, String password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user?.uid != null) {
        //Login successfull

        sharedPreferences.setString("userId", userCredential.user!.uid);
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
