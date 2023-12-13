import 'package:flutter/material.dart';
import 'package:traveloi/src/view/auth/login/login_screen.dart';
import 'package:traveloi/src/view/auth/register/register_screen.dart';

import 'package:traveloi/src/view/bottom_viewer/bottom_viewer.dart';

Map<String, WidgetBuilder> appRoutes = {
  "/": (context) => const BottomViewer(),
  "/login": (context) => const LoginScreen(),
  "/register": (context) => const RegisterScreen(),
};
