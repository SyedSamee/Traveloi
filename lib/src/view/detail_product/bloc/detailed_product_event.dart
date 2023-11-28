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

  DetailProductBookingEvent(
      {required this.context,
      required this.detailedProductBloc,
      required this.currentSelectedPerson});
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
