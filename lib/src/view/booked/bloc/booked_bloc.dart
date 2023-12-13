import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:traveloi/src/view/bottom_viewer/bottom_viewer.dart';

part 'booked_event.dart';
part 'booked_state.dart';

class BookedBloc extends Bloc<BookedEvent, BookedState> {
  BookedBloc() : super(BookedInitial()) {
    on<BookedEvent>((event, emit) {});

    on<BookedScreenHomeNavigationEvent>(bookedScreenHomeNavigationEvent);
  }

  FutureOr<void> bookedScreenHomeNavigationEvent(
      BookedScreenHomeNavigationEvent event, Emitter<BookedState> emit) {
    Navigator.pushAndRemoveUntil(
        event.context,
        MaterialPageRoute(builder: (context) => const BottomViewer()),
        (route) => false);
  }
}
