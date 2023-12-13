import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traveloi/src/config/utils.dart';
import 'package:traveloi/src/view/detail_product/bloc/detailed_product_bloc.dart';
import 'package:traveloi/src/view/detail_product/widget/detail_product_widget.dart';

class DetailProductScreen extends StatefulWidget {
  final String productId;
  const DetailProductScreen({super.key, required this.productId});

  @override
  State<DetailProductScreen> createState() => _DetailProductScreenState();
}

class _DetailProductScreenState extends State<DetailProductScreen> {
  DetailedProductBloc detailedProductBloc = DetailedProductBloc();
  @override
  void initState() {
    detailedProductBloc.add(DetailedProductGetAProductEvent(
        productId: widget.productId, context: context));
    super.initState();
  }

  @override
  void dispose() {
    detailedProductBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Center(
          child: BlocConsumer<DetailedProductBloc, DetailedProductState>(
            bloc: detailedProductBloc,
            buildWhen: (previous, current) =>
                current is DetailedProductGetAProductState ||
                current is DetailedProductLoadingState,
            listenWhen: (previous, current) =>
                current is DetailedProductMsgState,
            listener: (context, state) {
              state as DetailedProductMsgState;
              messenger(context, state.msg, state.isError);
            },
            builder: (context, state) {
              switch (state.runtimeType) {
                case DetailedProductLoadingState:
                  {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: SizedBox(
                        child: defaultIndicator(null),
                      ),
                    );
                  }
                case DetailedProductGetAProductState:
                  {
                    state as DetailedProductGetAProductState;
                    return DetailProductWidget(
                      state: state,
                      detailedProductBloc: detailedProductBloc,
                      placeId: widget.productId,
                    );
                  }

                default:
                  {
                    return SizedBox(
                      height: height * .05,
                    );
                  }
              }
            },
          ),
        ),
      )),
    );
  }
}
