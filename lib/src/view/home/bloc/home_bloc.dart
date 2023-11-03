import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:traveloi/src/config/global/global.dart';
import 'package:traveloi/src/config/utils.dart';
import 'package:traveloi/src/controller/home_controller/home_controller.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>((event, emit) {});
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeSearchPlacesEvent>(homeSearchPlacesEvent);
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState(msg: "Fetching profile info please wait"));

    var globalResponse = await getUserDetail();

    if (globalResponse is Map<String, dynamic>) {
      emit(HomeLoadingState(msg: "Fetching data please wait"));
      var homeProductResponse = await HomeController().getAllItems();
      if (homeProductResponse is List<Map<String, dynamic>>) {
        return emit(HomeInitState(
            name: globalResponse["name"],
            profileImg: globalResponse["profile"] == null
                ? noProfileImage
                : globalResponse["profile"],
            products: homeProductResponse));
      } else if (homeProductResponse is String) {
        emit(HomeMsgState(msg: homeProductResponse));
      } else {
        emit(HomeMsgState(msg: "Something went wrong"));
      }
    } else if (globalResponse is String) {
      //emit msg state
      emit(HomeMsgState(msg: globalResponse));
    } else {
      emit(HomeMsgState(msg: "Something went wrong"));
    }
  }

  FutureOr<void> homeSearchPlacesEvent(
      HomeSearchPlacesEvent event, Emitter<HomeState> emit) async {
    emit(HomeSearchPlaceLoadingState());
    var searchResponse = await HomeController().searchPlace(event.query);
    if (searchResponse is List<Map<String, dynamic>> &&
        searchResponse.isNotEmpty) {
      emit(HomeSearchPlaceState(products: searchResponse));
    } else if (searchResponse is List<Map<String, dynamic>> &&
        searchResponse.isEmpty) {
      emit(HomeMsgState(msg: "No product found"));
      emit(HomeInitState(
          name: event.name,
          profileImg: event.profileImg,
          products: event.products));
    } else if (searchResponse is String) {
      emit(HomeMsgState(msg: searchResponse));
    } else {
      emit(HomeMsgState(msg: "Something went wrong"));
    }
  }
}
