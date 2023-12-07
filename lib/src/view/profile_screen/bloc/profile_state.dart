part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileMsgState extends ProfileState {
  final String msg;
  final bool isError;
  ProfileMsgState({required this.isError, required this.msg});
}

final class ProfileGetUserDetailState extends ProfileState {
  final Map<String, dynamic> userData;
  ProfileGetUserDetailState({required this.userData});
}
