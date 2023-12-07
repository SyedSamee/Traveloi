part of 'booked_bloc.dart';

@immutable
sealed class BookedEvent {}

class BookedScreenHomeNavigationEvent extends BookedEvent {
  final BuildContext context;
  BookedScreenHomeNavigationEvent({required this.context});
}
