import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:traveloi/src/config/global/global.dart';
import 'package:traveloi/src/controller/fav_controller/fav_controller.dart';

part 'fav_event.dart';
part 'fav_state.dart';

class FavBloc extends Bloc<FavEvent, FavState> {
  FavBloc() : super(FavInitial()) {
    on<FavEvent>((event, emit) {});
    on<FavGetAllEvent>(favGetAll);
  }

  FutureOr<void> favGetAll(FavGetAllEvent event, Emitter<FavState> emit) async {
    emit(FavLoadingState());
    dynamic response = await checkIfUserExist(event.context);

    if (response == true) {
      dynamic favResponse = await FavController().fetchAllFav();

      if (favResponse is List<Map<String, dynamic>>) {
        emit(FavProductState(products: favResponse));
      } else if (favResponse is String) {
        emit(FavProductState(products: const []));
        emit(FavMsgState(isError: true, msg: favResponse));
      } else {
        emit(FavMsgState(isError: true, msg: "Something went wrong"));
        emit(FavProductState(products: const []));
      }
    }
  }
}
