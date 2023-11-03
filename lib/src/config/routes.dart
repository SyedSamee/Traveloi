import 'package:flutter/material.dart';
import 'package:traveloi/src/view/auth/login/login_screen.dart';
import 'package:traveloi/src/view/auth/register/register_screen.dart';
import 'package:traveloi/src/view/book_detail/book_detail_screen.dart';
import 'package:traveloi/src/view/bottom_viewer/bottom_viewer.dart';
import 'package:traveloi/src/view/fav_screen/fav_screen.dart';
import 'package:traveloi/src/view/home/home_screen.dart';
import 'package:traveloi/src/view/profile_screen/profile_screen.dart';
import 'package:traveloi/src/view/splash/splash_screen.dart';

Map<String, WidgetBuilder> appRoutes = {
  "/": (context) => BottomViewer(),
  "/login": (context) => LoginScreen(),
  "/register": (context) => RegisterScreen(),
};
