import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:traveloi/src/config/global/global.dart';
import 'package:traveloi/src/controller/detailed_controller/detailed_controller.dart';
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
}
