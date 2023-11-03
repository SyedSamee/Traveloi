part of 'bottom_viewer_bloc.dart';

@immutable
sealed class BottomViewerEvent {}

class BottomViewerChangePageEvent extends BottomViewerEvent {
  final int requestPage;
  BottomViewerChangePageEvent({required this.requestPage});
}
