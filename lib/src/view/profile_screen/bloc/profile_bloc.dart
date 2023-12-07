import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:traveloi/src/config/global/global.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) {});
    on<ProfileGetUserDetailEvent>(profileGetUserDetailEvent);
  }

  FutureOr<void> profileGetUserDetailEvent(
      ProfileGetUserDetailEvent event, Emitter<ProfileState> emit) async {
    dynamic userExist = checkIfUserExist(event.context);

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
}
