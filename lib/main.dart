import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:traveloi/src/config/routes.dart';
import 'package:traveloi/src/config/utils.dart';
import 'package:traveloi/src/controller/firebase/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: appTheme,
      debugShowCheckedModeBanner: false,
      routes: appRoutes,
    );
  }
}
