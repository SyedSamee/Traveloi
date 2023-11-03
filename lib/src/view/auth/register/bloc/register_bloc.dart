import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:traveloi/src/controller/auth_controller/register_controller/register_controller.dart';
import 'package:traveloi/src/view/bottom_viewer/bottom_viewer.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterEvent>((event, emit) {});
    on<RegisterAUserEvent>(registerAUserEvent);
  }

  FutureOr<void> registerAUserEvent(
      RegisterAUserEvent event, Emitter<RegisterState> emit) async {
    emit(RegisterLoadingState());
    if (event.fullName.isNotEmpty &&
        event.email.isNotEmpty &&
        event.password.isNotEmpty) {
      if (event.email.contains("@") && event.email.contains(".com")) {
        var registerResponse = await RegisterController()
            .registerAUser(event.fullName, event.email, event.password);

        if (registerResponse is String) {
          emit(RegisterInitial());
          // same sort of error occured showing the error
          emit(RegisterMsgState(isError: true, msg: registerResponse));
        } else if (registerResponse == true) {
          emit(RegisterMsgState(
              isError: false, msg: "Account created, redirecting to homepage"));
          await Future.delayed(Duration(seconds: 2));
          Navigator.pushAndRemoveUntil(
              event.context,
              MaterialPageRoute(builder: (context) => BottomViewer()),
              (route) => false);
        } else {
          emit(RegisterInitial());
          emit(RegisterMsgState(
              isError: true, msg: "Something went wrong try again later"));
        }
      } else {
        emit(RegisterInitial());
        emit(RegisterMsgState(isError: true, msg: "email is'nt formated"));
      }
    } else {
      emit(RegisterInitial());
      emit(RegisterMsgState(isError: true, msg: "one or more field is empty"));
    }
  }
}
