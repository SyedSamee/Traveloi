part of 'detailed_product_bloc.dart';

@immutable
sealed class DetailedProductState {}

final class DetailedProductInitial extends DetailedProductState {}

final class DetailedProductMsgState extends DetailedProductState {
  final String msg;
  final bool isError;
  DetailedProductMsgState({required this.msg, required this.isError});
}

final class DetailedProductLoadingState extends DetailedProductState {}

final class DetailedProductGetAProductState extends DetailedProductState {
  final Map<String, dynamic> productDetail;

  DetailedProductGetAProductState({required this.productDetail});
}

final class DetailedProductSelectPersonState extends DetailedProductState {
  final int person;
  DetailedProductSelectPersonState({required this.person});
}

final class DetailedProductSelectDateState extends DetailedProductState {
  final DateTime? dateTime;
  DetailedProductSelectDateState({required this.dateTime});
}
