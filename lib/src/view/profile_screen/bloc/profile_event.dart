part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

class ProfileGetUserDetailEvent extends ProfileEvent {
  final BuildContext context;
  ProfileGetUserDetailEvent({required this.context});
}

class ProfileLogoutEvent extends ProfileEvent {
  final BuildContext context;
  ProfileLogoutEvent({required this.context});
}
