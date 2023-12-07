part of 'booking_detail_bloc.dart';

@immutable
sealed class BookingDetailState {}

final class BookingDetailInitial extends BookingDetailState {}

final class BookingDetailMsgState extends BookingDetailState {
  final String msg;
  final bool isError;
  BookingDetailMsgState({required this.msg, required this.isError});
}

final class BookingDetailLoadingState extends BookingDetailState {}

final class BookingDetailGetAllBooksState extends BookingDetailState {
  final List<Map<String, dynamic>> allBooks;

  BookingDetailGetAllBooksState({required this.allBooks});
}
