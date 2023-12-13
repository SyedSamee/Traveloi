import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:traveloi/src/view/bottom_viewer/bottom_viewer.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<SplashEvent>((event, emit) {});
    on<SplashInitialEvent>(splashInitialEvent);
  }

  FutureOr<void> splashInitialEvent(
      SplashInitialEvent event, Emitter<SplashState> emit) async {
    //checking if user is login or not.
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if (sharedPreferences.getString("userId") != null) {
      Navigator.pushAndRemoveUntil(
          event.context,
          MaterialPageRoute(builder: (context) => const BottomViewer()),
          (route) => false);
      //user is logged in
    } else {
      Navigator.pushNamedAndRemoveUntil(
          event.context, "/login", (route) => false);
    }
  }
}
