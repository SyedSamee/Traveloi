part of 'fav_bloc.dart';

@immutable
sealed class FavEvent {}

class FavGetAllEvent extends FavEvent {
  final BuildContext context;
  FavGetAllEvent({required this.context});
}
