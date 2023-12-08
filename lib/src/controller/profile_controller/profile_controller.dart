import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:traveloi/src/config/global/global.dart';

class ProfileController {
  void logoutUser(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    await sharedPreferences.remove("userId");
    await checkIfUserExist(context);
  }
}
