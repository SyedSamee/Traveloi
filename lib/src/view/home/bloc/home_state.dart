part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeInitState extends HomeState {
  final String name;
  final String profileImg;
  final List<Map<String, dynamic>> products;
  HomeInitState(
      {required this.name, required this.profileImg, required this.products});
}

final class HomeLoadingState extends HomeState {
  final String? msg;
  HomeLoadingState({required this.msg});
}

final class HomeSearchPlaceLoadingState extends HomeState {}

final class HomeMsgState extends HomeState {
  final String msg;
  HomeMsgState({required this.msg});
}

final class HomeSearchPlaceState extends HomeState {
  final List<Map<String, dynamic>> products;
  HomeSearchPlaceState({required this.products});
}
