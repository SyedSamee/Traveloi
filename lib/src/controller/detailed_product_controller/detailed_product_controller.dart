import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailedProductController {
  static int? person;
  static DateTime? datetime;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Future bookATravel(String placeId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    try {
      var booking_request_response = await firebaseFirestore
          .collection("users")
          .doc(sharedPreferences.getString("userId"))
          .collection("Booking_requests")
          .add({
        "place_id": placeId,
        "date": datetime,
        "person": person,
      });

      if (booking_request_response.id != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return e is FirebaseException ? e.message : e;
    }
  }
}
