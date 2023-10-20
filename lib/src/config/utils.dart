import 'dart:ui';

import 'package:flutter/material.dart';

Color appColorFirst = Color(0xff0172B2);

Color appColorSec = Color(0xff001645);

List popularPlaceList = ["Most Viewed", "Nearby", "Latest"];

ThemeData appTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: appColorFirst),
    useMaterial3: true,
    splashColor: Colors.transparent);

CircularProgressIndicator loadingIndicator = CircularProgressIndicator();

Messenger(BuildContext context, String msg, bool isError) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      msg,
      style: TextStyle(
        color: Colors.white,
      ),
    ),
    backgroundColor: isError ? Colors.redAccent : appColorFirst,
  ));
}
