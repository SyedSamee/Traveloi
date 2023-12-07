import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future fetchAllFav() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> favProductList = [];
    try {
      var favResponse = await firebaseFirestore
          .collection("users")
          .doc(sharedPreferences.getString("userId"))
          .collection("favourite")
          .get();

      if (favResponse.docs.isNotEmpty) {
        for (var e = 0; e < favResponse.size; e++) {
          var productResponse = await firebaseFirestore
              .collection("products")
              .doc(favResponse.docs[e].data()["placeId"])
              .get();

          favProductList.add(productResponse.data()!);
        }

        return favProductList;
      } else {
        return favProductList;
      }
    } catch (e) {
      return e is FirebaseException ? e.message : e;
    }
  }
}
