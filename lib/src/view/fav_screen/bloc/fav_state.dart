part of 'fav_bloc.dart';

@immutable
sealed class FavState {}

final class FavInitial extends FavState {}

final class FavProductState extends FavState {
  final List<Map<String, dynamic>> products;
  FavProductState({required this.products});
}

final class FavMsgState extends FavState {
  final bool isError;
  final String msg;
  FavMsgState({required this.isError, required this.msg});
}

final class FavLoadingState extends FavState {}
