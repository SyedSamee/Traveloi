import 'package:flutter/material.dart';
import 'package:traveloi/src/config/utils.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:traveloi/src/view/splash/bloc/splash_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashBloc splashBloc = SplashBloc();

  @override
  void initState() {
    splashBloc.add(SplashInitialEvent(context: context));
    super.initState();
  }

  @override
  void dispose() {
    splashBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
          child: Container(
        width: screenWidth,
        height: screenHeight,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              appColorFirst,
              appColorSec,
            ])),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Travel',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 44,
                  fontFamily: 'Lobster',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
              SizedBox(
                width: screenWidth * .03,
              ),
              SvgPicture.asset(
                "assets/images/main_logo.svg",
                width: screenWidth * .085,
              )
            ],
          ),
          SizedBox(
            height: screenHeight * .07,
          ),
          const Text(
            "Find Your Dream",
            style: TextStyle(
              color: Color(0xFFE7E7E7),
              fontSize: 20,
              fontWeight: FontWeight.w400,
              height: 0.08,
              fontFamily: "",
            ),
          ),
          SizedBox(
            height: screenHeight * .04,
          ),
          const Text(
            "Destination With Us  ",
            style: TextStyle(
              color: Color(0xFFE7E7E7),
              fontSize: 20,
              fontFamily: "",
              fontWeight: FontWeight.w400,
              height: 0.08,
            ),
          ),
        ]),
      )),
    );
  }
}
