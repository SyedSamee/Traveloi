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
    on<HomeAddOrRemoveFavEvent>(homeFavARestaurant);
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState(msg: "Fetching profile info please wait"));

    var globalResponse = await getUserDetail();

    if (globalResponse is Map<String, dynamic>) {
      emit(HomeInitState(
          name: globalResponse["name"],
          profileImg: globalResponse["profileImage"] == null
              ? ""
              : globalResponse["profileImage"]));
    } else if (globalResponse is String) {
      //emit msg state
      emit(HomeMsgState(msg: globalResponse, isError: true));
    } else {
      emit(HomeMsgState(msg: "Something went wrong", isError: true));
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
      emit(HomeMsgState(msg: "No product found", isError: true));
      emit(HomeInitState(
        name: event.name,
        profileImg: event.profileImg,
      ));
    } else if (searchResponse is String) {
      emit(HomeMsgState(msg: searchResponse, isError: true));
    } else {
      emit(HomeMsgState(msg: "Something went wrong", isError: true));
    }
  }

  FutureOr<void> homeFavARestaurant(
      HomeAddOrRemoveFavEvent event, Emitter<HomeState> emit) async {
    emit(HomeFavLoadingState());
    var favResponse = await HomeController().addOrRemoveToFav(event.productId);

    if (favResponse == true) {
      //sucess
      event.homeBloc.add(HomeInitialEvent());
    } else if (favResponse is String) {
      emit(HomeMsgState(msg: favResponse, isError: true));
    } else {
      emit(HomeMsgState(msg: "Something went wrong", isError: true));
    }
  }
}
