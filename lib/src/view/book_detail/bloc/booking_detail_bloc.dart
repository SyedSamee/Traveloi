import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:traveloi/src/config/global/global.dart';
import 'package:traveloi/src/controller/booking_detail_controller/booking_detail_controller.dart';

part 'booking_detail_event.dart';
part 'booking_detail_state.dart';

class BookingDetailBloc extends Bloc<BookingDetailEvent, BookingDetailState> {
  BookingDetailBloc() : super(BookingDetailInitial()) {
    on<BookingDetailEvent>((event, emit) {});
    on<BookingDetailGetAllBooksEvent>(bookingDetailGetAllBooksEvent);
  }

  FutureOr<void> bookingDetailGetAllBooksEvent(
      BookingDetailGetAllBooksEvent event,
      Emitter<BookingDetailState> emit) async {
    emit(BookingDetailLoadingState());
    dynamic response = await checkIfUserExist(event.context);

    if (response == true) {
      dynamic booksResponse = await BookingDetailController().fetchAllBooks();

      if (booksResponse is List<Map<String, dynamic>>) {
        emit(BookingDetailGetAllBooksState(allBooks: booksResponse));
      } else if (booksResponse is String) {
        emit(BookingDetailGetAllBooksState(allBooks: const []));
        emit(BookingDetailMsgState(isError: true, msg: booksResponse));
      } else {
        emit(BookingDetailMsgState(isError: true, msg: "Something went wrong"));
        emit(BookingDetailGetAllBooksState(allBooks: const []));
      }
    }
  }
}
