part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class HomeSearchPlacesEvent extends HomeEvent {
  final String query;
  final String name;
  final String profileImg;
  final List<Map<String, dynamic>> products;
  HomeSearchPlacesEvent(
      {required this.query,
      required this.name,
      required this.products,
      required this.profileImg});
}

class HomeAddOrRemoveFavEvent extends HomeEvent {
  final String productId;
  final HomeBloc homeBloc;

  HomeAddOrRemoveFavEvent({
    required this.productId,
    required this.homeBloc,
  });
}
