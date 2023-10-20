import 'package:flutter/material.dart';
import 'package:traveloi/src/view/auth/login/login_screen.dart';
import 'package:traveloi/src/view/auth/register/register_screen.dart';
import 'package:traveloi/src/view/home/home_screen.dart';
import 'package:traveloi/src/view/splash/splash_screen.dart';

Map<String, WidgetBuilder> appRoutes = {
  "/": (context) => LoginScreen(),
  "/login": (context) => LoginScreen(),
  "/register": (context) => RegisterScreen(),
  "/home": (context) => HomeScreen(),
};
