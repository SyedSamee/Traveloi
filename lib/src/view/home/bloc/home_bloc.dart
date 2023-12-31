import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:traveloi/src/config/global/global.dart';
import 'package:traveloi/src/config/utils.dart';
import 'package:traveloi/src/controller/home_controller/home_controller.dart';
import 'package:traveloi/src/view/detail_product/detail_product._screen.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>((event, emit) {});
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeGetAllProductsEvent>(homeGetAllProductsEvent);
    on<HomeSearchPlacesEvent>(homeSearchPlacesEvent);
    on<HomeAddOrRemoveFavEvent>(homeAddOrRemoveFavEvent);
    on<HomeToProductEvent>(homeToProductEvent);
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState(msg: "Fetching profile info please wait"));

    var globalResponse = await getUserDetail();
    var userChecker = await checkIfUserExist(event.context);
    if (userChecker == true) {
      if (globalResponse is Map<String, dynamic>) {
        emit(HomeInitState(
            name: globalResponse["name"],
            profileImg: globalResponse["profileImage"] == null
                ? noProfileImage
                : globalResponse["profileImage"]));
        event.homeBloc.add(HomeGetAllProductsEvent(context: event.context));
      } else if (globalResponse is String) {
        //emit msg state
        emit(HomeMsgState(msg: globalResponse, isError: true));
      } else {
        emit(HomeMsgState(msg: "Something went wrong", isError: true));
      }
    }
  }

  FutureOr<void> homeGetAllProductsEvent(
      HomeGetAllProductsEvent event, Emitter<HomeState> emit) async {
    emit(HomeProductLoadingState());
    var allItemResponse = await HomeController().getAllItems();
    var userChecker = await checkIfUserExist(event.context);
    if (userChecker == true) {
      if (allItemResponse is List<Map<String, dynamic>>) {
        emit(HomeGetAllProductsState(products: allItemResponse));
      } else if (allItemResponse is String) {
        emit(HomeMsgState(msg: allItemResponse, isError: true));
      } else {
        emit(HomeMsgState(msg: "Something went wrong ", isError: true));
      }
    }
  }

  FutureOr<void> homeSearchPlacesEvent(
      HomeSearchPlacesEvent event, Emitter<HomeState> emit) async {
    if (event.query.isNotEmpty) {
      emit(HomeProductLoadingState());
      var userChecker = await checkIfUserExist(event.context);
      var searchResponse = await HomeController().searchPlace(event.query);

      if (userChecker == true) {
        if (searchResponse is List<Map<String, dynamic>> &&
            searchResponse.isNotEmpty) {
          emit(HomeSearchPlaceState(products: searchResponse));
        } else if (searchResponse is List<Map<String, dynamic>> &&
            searchResponse.isEmpty) {
          emit(HomeSearchPlaceState(products: null));
        } else if (searchResponse is String) {
          emit(HomeMsgState(msg: searchResponse, isError: true));
        } else {
          emit(HomeMsgState(msg: "Something went wrong", isError: true));
        }
      } else if (event.query.isEmpty && event.state is HomeSearchPlaceState) {
        event.homeBloc.add(HomeGetAllProductsEvent(context: event.context));
      }
    }
  }

  FutureOr<void> homeAddOrRemoveFavEvent(
      HomeAddOrRemoveFavEvent event, Emitter<HomeState> emit) async {
    emit(HomeFavLoadingState());

    var favResponse = await HomeController().addOrRemoveToFav(event.productId);

    if (favResponse is int) {
      for (var i = 0; i < event.productList.length; i++) {
        if (event.productList[i]["product_id"] == event.productId) {
          Map<String, dynamic> replacement = event.productList[i];

          replacement.update("isFavByUser", (value) => favResponse);

          event.productList[i] = replacement;

          event.isSearchState
              ? emit(HomeSearchPlaceState(products: event.productList))
              : emit(HomeGetAllProductsState(products: event.productList));
        }
      }
    } else if (favResponse is String) {
      emit(HomeMsgState(msg: favResponse, isError: true));
    } else {
      emit(HomeMsgState(msg: "Something went wrong", isError: true));
    }
  }

  FutureOr<void> homeToProductEvent(
      HomeToProductEvent event, Emitter<HomeState> emit) {
    Navigator.push(
        event.context,
        MaterialPageRoute(
            builder: (context) =>
                DetailProductScreen(productId: event.productId)));
  }
}
