part of 'booking_detail_bloc.dart';

@immutable
sealed class BookingDetailEvent {}

class BookingDetailGetAllBooksEvent extends BookingDetailEvent {
  final BuildContext context;
  BookingDetailGetAllBooksEvent({required this.context});
}
