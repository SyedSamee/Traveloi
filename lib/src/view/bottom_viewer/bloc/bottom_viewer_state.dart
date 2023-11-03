part of 'bottom_viewer_bloc.dart';

@immutable
sealed class BottomViewerState {}

final class BottomViewerInitial extends BottomViewerState {
  final int currentPage;

  BottomViewerInitial({required this.currentPage});
}
