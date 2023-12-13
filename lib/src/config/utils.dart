
import 'package:flutter/material.dart';

Color appColorFirst = const Color(0xff0172B2);

Color appColorSec = const Color(0xff001645);
Color appColorThird = const Color(0xffFF0000);

String popularPlaceList = "All Places";

String noProfileImage =
    "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png";

ThemeData appTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: appColorFirst),
    useMaterial3: true,
    splashColor: Colors.transparent);

CircularProgressIndicator loadingIndicator = const CircularProgressIndicator();

messenger(BuildContext context, String msg, bool isError) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      msg,
      style: const TextStyle(
        color: Colors.white,
      ),
    ),
    backgroundColor: isError ? Colors.redAccent : appColorFirst,
  ));
}

defaultIndicator(String? msg) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircularProgressIndicator(),
        msg != null
            ? Text(
                msg,
                style: const TextStyle(fontWeight: FontWeight.w500),
              )
            : const SizedBox()
      ],
    ),
  );
}
