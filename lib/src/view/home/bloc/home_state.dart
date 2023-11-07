part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeInitState extends HomeState {
  final String name;
  final String profileImg;

  HomeInitState({
    required this.name,
    required this.profileImg,
  });
}

final class HomeGetAllProducts extends HomeState {
  final List<Map<String, dynamic>> products;
  HomeGetAllProducts({required this.products});
}

final class HomeLoadingState extends HomeState {
  final String? msg;
  HomeLoadingState({required this.msg});
}

final class HomeSearchPlaceLoadingState extends HomeState {}

final class HomeMsgState extends HomeState {
  final String msg;
  final bool isError;
  HomeMsgState({required this.msg, required this.isError});
}

final class HomeSearchPlaceState extends HomeState {
  final List<Map<String, dynamic>> products;
  HomeSearchPlaceState({required this.products});
}

final class HomeFavLoadingState extends HomeState {}
