import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:traveloi/src/config/extention/string_extentions.dart';

class HomeController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future getAllItems() async {
    List<Map<String, dynamic>> products = [];
    try {
      var response = await firebaseFirestore.collection("products").get();
      if (response.docs.isNotEmpty) {
        for (var i = 0; i < response.size; i++) {
          products.add(response.docs[i].data());
        }

        return products;
      } else {
        return products;
      }
    } catch (e) {
      if (e is FirebaseException) {
        return e.message;
      } else {
        return e;
      }
    }
  }

  Future searchPlace(String query) async {
    List<Map<String, dynamic>> searchResult = [];
    String filteredQuery = query.firstLetterCapital;

    try {
      var searchResponse = await firebaseFirestore
          .collection("products")
          .orderBy("name")
          .startAt([filteredQuery]).endAt(["$filteredQuery\uf8ff"]).get();

      if (searchResponse.docs.isNotEmpty) {
        for (var o = 0; o < searchResponse.size; o++) {
          searchResult.add(searchResponse.docs[o].data());
        }

        return searchResult;
      } else {
        return searchResult;
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
