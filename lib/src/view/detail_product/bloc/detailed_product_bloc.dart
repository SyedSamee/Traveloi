import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:traveloi/src/config/global/global.dart';

import 'package:traveloi/src/controller/detailed_product_controller/detailed_product_controller.dart';
import 'package:traveloi/src/view/booked/booked_scree.dart';
import 'package:traveloi/src/view/detail_product/widget/dialog/booking_dialog.dart';

part 'detailed_product_event.dart';
part 'detailed_product_state.dart';

class DetailedProductBloc
    extends Bloc<DetailedProductEvent, DetailedProductState> {
  DetailedProductBloc() : super(DetailedProductInitial()) {
    on<DetailedProductEvent>((event, emit) {});
    on<DetailedProductGetAProductEvent>(detailedProductGetAProductEvent);
    on<DetailProductBookingEvent>(detailProductBookingEvent);
    on<DetailedProductSelectDateEvent>(detailedProductSelectDateEvent);
    on<DetailedProductSelectPersonEvent>(detailedProductSelectPersonEvent);
    on<DetailedProductBookTravel>(detailedProductBookTravel);
    on<DetailedProductBackNavigatorEvent>(detailedProductBackNavigatorEvent);
  }

  FutureOr<void> detailedProductGetAProductEvent(
      DetailedProductGetAProductEvent event,
      Emitter<DetailedProductState> emit) async {
    emit(DetailedProductLoadingState());
    var productResponse = await getAProductDetail(event.productId);
    var userChecker = await checkIfUserExist(event.context);
    if (userChecker == true) {
      if (productResponse is Map<String, dynamic>) {
        emit(DetailedProductGetAProductState(productDetail: productResponse));
      } else if (productResponse is String) {
        emit(DetailedProductMsgState(msg: productResponse, isError: true));
      } else {
        emit(DetailedProductMsgState(
            msg: "Something went wrong", isError: true));
      }
    }
  }

  FutureOr<void> detailProductBookingEvent(
      DetailProductBookingEvent event, Emitter<DetailedProductState> emit) {
    showDialog(
        context: event.context,
        builder: (context) => AlertDialog(
              content: BookingDialog(
                detailedProductBloc: event.detailedProductBloc,
                placeId: event.productId,
              ),
            ));
  }

  FutureOr<void> detailedProductSelectDateEvent(
      DetailedProductSelectDateEvent event,
      Emitter<DetailedProductState> emit) async {
    event.stateUpdate != true
        ? DetailedProductController.datetime = await showDatePicker(
            context: event.context,
            initialDate: DateTime.now(),
            firstDate: DateTime(DateTime.now().year),
            lastDate: DateTime(DateTime.now().year + 1),
          )
        : null;
    emit(DetailedProductSelectDateState(
        dateTime: DetailedProductController.datetime));
  }

  FutureOr<void> detailedProductSelectPersonEvent(
      DetailedProductSelectPersonEvent event,
      Emitter<DetailedProductState> emit) {
    DetailedProductController.person = event.person;
    emit(DetailedProductSelectPersonState(person: event.person));
  }

  FutureOr<void> detailedProductBookTravel(DetailedProductBookTravel event,
      Emitter<DetailedProductState> emit) async {
    if (DetailedProductController.datetime != null &&
        DetailedProductController.person != null) {
      emit(DetailedProductLoadingState());
      var travelResponse =
          await DetailedProductController().bookATravel(event.placeId);
      if (travelResponse == true) {
        Navigator.pushAndRemoveUntil(
            event.context,
            MaterialPageRoute(builder: (context) => const BookedScreen()),
            (route) => false);
      } else if (travelResponse is String) {
        Navigator.pop(event.context);
        emit(DetailedProductMsgState(msg: travelResponse, isError: true));
      } else {
        Navigator.pop(event.context);
        emit(DetailedProductMsgState(
            msg: "Something went wrong", isError: true));
      }
    } else {
      Navigator.pop(event.context);
      emit(DetailedProductMsgState(
          msg: "Date or person cannot be empty", isError: true));
    }
  }

  FutureOr<void> detailedProductBackNavigatorEvent(
      DetailedProductBackNavigatorEvent event,
      Emitter<DetailedProductState> emit) {
    Navigator.pop(event.context);
  }
}
