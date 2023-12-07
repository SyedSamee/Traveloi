part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeInitialEvent extends HomeEvent {
  final HomeBloc homeBloc;
  final BuildContext context;
  HomeInitialEvent({required this.homeBloc, required this.context});
}

class HomeGetAllProductsEvent extends HomeEvent {
  final BuildContext context;
  HomeGetAllProductsEvent({required this.context});
}

class HomeSearchPlacesEvent extends HomeEvent {
  final String query;
  final HomeBloc homeBloc;
  final dynamic state;
  final BuildContext context;
  HomeSearchPlacesEvent(
      {required this.query,
      required this.homeBloc,
      required this.state,
      required this.context});
}

class HomeAddOrRemoveFavEvent extends HomeEvent {
  final String productId;
  final HomeBloc homeBloc;
  final int loadingIndex;
  final BuildContext context;
  final List<Map<String, dynamic>> productList;
  final bool isSearchState;

  HomeAddOrRemoveFavEvent(
      {required this.productId,
      required this.homeBloc,
      required this.loadingIndex,
      required this.context,
      required this.productList,
      required this.isSearchState});
}

class HomeToProductEvent extends HomeEvent {
  final BuildContext context;
  final String productId;
  HomeToProductEvent({required this.context, required this.productId});
}
