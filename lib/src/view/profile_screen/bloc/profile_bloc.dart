import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:traveloi/src/config/global/global.dart';
import 'package:traveloi/src/controller/profile_controller/profile_controller.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) {});
    on<ProfileGetUserDetailEvent>(profileGetUserDetailEvent);
    on<ProfileLogoutEvent>(profileLogoutEvent);
  }

  FutureOr<void> profileGetUserDetailEvent(
      ProfileGetUserDetailEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoadingState());
    dynamic userExist = await checkIfUserExist(event.context);

    if (userExist == true) {
      dynamic userDetail = await getUserDetail();

      if (userDetail is Map<String, dynamic>) {
        emit(ProfileGetUserDetailState(userData: userDetail));
      } else if (userDetail is String) {
        emit(ProfileMsgState(isError: true, msg: userDetail));
      } else {
        emit(ProfileMsgState(isError: true, msg: "Something went wrong"));
      }
    }
  }

  FutureOr<void> profileLogoutEvent(
      ProfileLogoutEvent event, Emitter<ProfileState> emit) {
    emit(ProfileLoadingState());
    ProfileController().logoutUser(event.context);
  }
}
