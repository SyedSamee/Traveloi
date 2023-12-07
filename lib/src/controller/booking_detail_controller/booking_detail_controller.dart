import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookingDetailController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Future fetchAllBooks() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> booksProductList = [];
    try {
      var booksResponse = await firebaseFirestore
          .collection("users")
          .doc(sharedPreferences.getString("userId"))
          .collection("Booking_requests")
          .get();

      if (booksResponse.docs.isNotEmpty) {
        for (var e = 0; e < booksResponse.size; e++) {
          var productResponse = await firebaseFirestore
              .collection("products")
              .doc(booksResponse.docs[e].data()["place_id"])
              .get();

          booksProductList.add(productResponse.data()!);
        }

        return booksProductList;
      } else {
        return booksProductList;
      }
    } catch (e) {
      return e is FirebaseException ? e.message : e;
    }
  }
}
