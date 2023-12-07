part of 'detailed_product_bloc.dart';

@immutable
sealed class DetailedProductEvent {}

class DetailedProductGetAProductEvent extends DetailedProductEvent {
  final String productId;
  final BuildContext context;
  DetailedProductGetAProductEvent(
      {required this.productId, required this.context});
}

class DetailProductBookingEvent extends DetailedProductEvent {
  final BuildContext context;
  final DetailedProductBloc detailedProductBloc;
  final int? currentSelectedPerson;
  final String productId;

  DetailProductBookingEvent(
      {required this.context,
      required this.detailedProductBloc,
      required this.currentSelectedPerson,
      required this.productId});
}

class DetailedProductSelectDateEvent extends DetailedProductEvent {
  final BuildContext context;
  final bool? stateUpdate;
  DetailedProductSelectDateEvent(
      {required this.context, required this.stateUpdate});
}

class DetailedProductSelectPersonEvent extends DetailedProductEvent {
  final int person;
  DetailedProductSelectPersonEvent({required this.person});
}

class DetailedProductBookTravel extends DetailedProductEvent {
  final BuildContext context;
  final String placeId;
  DetailedProductBookTravel({required this.context, required this.placeId});
}

class DetailedProductBackNavigatorEvent extends DetailedProductEvent {
  final BuildContext context;

  DetailedProductBackNavigatorEvent({required this.context});
}
