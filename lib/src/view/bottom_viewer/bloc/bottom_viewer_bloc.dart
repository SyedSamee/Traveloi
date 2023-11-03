import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'bottom_viewer_event.dart';
part 'bottom_viewer_state.dart';

class BottomViewerBloc extends Bloc<BottomViewerEvent, BottomViewerState> {
  BottomViewerBloc() : super(BottomViewerInitial(currentPage: 0)) {
    on<BottomViewerEvent>((event, emit) {});
    on<BottomViewerChangePageEvent>(bottomViewerChangePageEvent);
  }

  FutureOr<void> bottomViewerChangePageEvent(
      BottomViewerChangePageEvent event, Emitter<BottomViewerState> emit) {
    emit(BottomViewerInitial(currentPage: event.requestPage));
  }
}
