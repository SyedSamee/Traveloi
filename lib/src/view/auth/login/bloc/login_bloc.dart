import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:traveloi/src/controller/auth_controller/login_controller/login_controller.dart';
import 'package:traveloi/src/view/bottom_viewer/bottom_viewer.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) {});
    on<LoginAUserEvent>(loginAUserEvent);
  }

  FutureOr<void> loginAUserEvent(
      LoginAUserEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());
    if (event.email.isNotEmpty && event.password.isNotEmpty) {
      if (event.email.contains("@") && event.email.contains(".com")) {
        var loginResponse =
            await LoginController().loginAUser(event.email, event.password);

        if (loginResponse is String || loginResponse is FirebaseException) {
          emit(LoginInitial());
          // same sort of error occured showing the error
          emit(LoginMsgState(isError: true, msg: loginResponse.toString()));
        } else if (loginResponse == true) {
          emit(LoginMsgState(
              isError: false,
              msg: "Log in successful, redirecting to homepage"));
          await Future.delayed(const Duration(seconds: 2));
          Navigator.pushAndRemoveUntil(
              event.context,
              MaterialPageRoute(builder: (context) => const BottomViewer()),
              (route) => false);
        } else {
          emit(LoginInitial());
          emit(LoginMsgState(
              isError: true, msg: "Something went wrong try again later"));
        }
      } else {
        emit(LoginInitial());
        emit(LoginMsgState(isError: true, msg: "email is'nt formated"));
      }
    } else {
      emit(LoginInitial());
      emit(LoginMsgState(isError: true, msg: "one or more field is empty"));
    }
  }
}
