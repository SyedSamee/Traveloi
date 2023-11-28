import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:traveloi/src/config/extention/string_extentions.dart';
import 'package:traveloi/src/config/global/global.dart';

class HomeController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future getAllItems() async {
    List<Map<String, dynamic>> products = [];

    List favProductIds = [];

    try {
      var productsResponse =
          await firebaseFirestore.collection("products").get();

      if (productsResponse.docs.isNotEmpty) {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();

        //getting user's fav restaurant
        var userFavResponse = await firebaseFirestore
            .collection("users")
            .doc(sharedPreferences.getString("userId"))
            .collection("favourite")
            .get();
        //adding user fav restaurant into a list
        for (var e = 0; e < userFavResponse.size; e++) {
          favProductIds.add(userFavResponse.docs[e].data()["placeId"]);
        }
        //add all the product to list

        for (var i = 0; i < productsResponse.size; i++) {
          //checking if product id is present in user fav list if it does then we will add an variable called isFavByUser otherwise will just add the product details
          products.add({
            "product_id": productsResponse.docs[i].id,
            "product_detail": productsResponse.docs[i].data(),
            "isFavByUser":
                favProductIds.contains(productsResponse.docs[i].id) ? 1 : 0
          });
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
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List favProductIds = [];
    try {
      //searching a product with custom method for more accuracy
      var searchResponse = await firebaseFirestore
          .collection("products")
          .orderBy("name")
          .startAt([filteredQuery]).endAt(["$filteredQuery\uf8ff"]).get();

      if (searchResponse.docs.isNotEmpty) {
        //adding response into a list

        //getting user's fav restaurant
        var userFavResponse = await firebaseFirestore
            .collection("users")
            .doc(sharedPreferences.getString("userId"))
            .collection("favourite")
            .get();
        //adding user fav restaurant into a list
        for (var e = 0; e < userFavResponse.size; e++) {
          favProductIds.add(userFavResponse.docs[e].data()["placeId"]);
        }
        //add all the product to list

        for (var i = 0; i < searchResponse.size; i++) {
          //checking if product id is present in user fav list if it does then we will add an variable called isFavByUser otherwise will just add the product details

          searchResult.add({
            "product_id": searchResponse.docs[i].id,
            "product_detail": searchResponse.docs[i].data(),
            "isFavByUser":
                favProductIds.contains(searchResponse.docs[i].id) ? 1 : 0
          });
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

  Future addOrRemoveToFav(String id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List allFavs = [];
    try {
      var favResponse = await firebaseFirestore
          .collection("users")
          .doc(sharedPreferences.getString("userId"))
          .collection("favourite")
          .get();
      if (favResponse.docs.isNotEmpty) {
        for (var e = 0; e < favResponse.size; e++) {
          //checking if product id is'nt present in user's fav if it does'nt add it else delete

          allFavs.add(favResponse.docs[e].data()["placeId"]);
        }
        if (allFavs.contains(id)) {
          //  deleting product id from user's fav
          for (var w = 0; w < favResponse.size; w++) {
            if (id == favResponse.docs[w].data()["placeId"]) {
              await firebaseFirestore
                  .collection("users")
                  .doc(sharedPreferences.getString("userId"))
                  .collection("favourite")
                  .doc(favResponse.docs[w].id)
                  .delete();
              return 0;
            }
          }
        } else {
          var response = await firebaseFirestore
              .collection("users")
              .doc(sharedPreferences.getString("userId"))
              .collection("favourite")
              .add({"placeId": id});
          if (response.id.isNotEmpty) {
            return 1;
          } else {
            return "Something went wrong try again";
          }
        }
      } else {
        //if user fav is empty then this will run as the loop will not run if the user fav collection is empty

        var response = await firebaseFirestore
            .collection("users")
            .doc(sharedPreferences.getString("userId"))
            .collection("favourite")
            .add({"placeId": id});
        if (response.id.isNotEmpty) {
          return 1;
        } else {
          return "Something went wrong try again";
        }
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
