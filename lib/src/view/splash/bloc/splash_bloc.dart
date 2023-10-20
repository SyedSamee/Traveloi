import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

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

    //if user is login send him/her to home
    // this will mimic the checking function
    await Future.delayed(Duration(seconds: 2));
    //else show him/her login screen

    Navigator.pushNamedAndRemoveUntil(
        event.context, "/login", (route) => false);
  }
}
