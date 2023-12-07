import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traveloi/src/config/global/global.dart';
import 'package:traveloi/src/config/utils.dart';
import 'package:traveloi/src/controller/detailed_product_controller/detailed_product_controller.dart';
import 'package:traveloi/src/view/detail_product/bloc/detailed_product_bloc.dart';

class BookingDialog extends StatefulWidget {
  final DetailedProductBloc detailedProductBloc;
  final String placeId;
  const BookingDialog(
      {super.key, required this.detailedProductBloc, required this.placeId});

  @override
  State<BookingDialog> createState() => _BookingDialogState();
}

class _BookingDialogState extends State<BookingDialog> {
  @override
  void initState() {
    DetailedProductController.person != null
        ? widget.detailedProductBloc.add(DetailedProductSelectPersonEvent(
            person: DetailedProductController.person!))
        : null;
    DetailedProductController.datetime != null
        ? widget.detailedProductBloc.add(
            DetailedProductSelectDateEvent(context: context, stateUpdate: true))
        : null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: width * .9,
      height: height * .3,
      alignment: Alignment.center,
      decoration: BoxDecoration(),
      child: BlocBuilder<DetailedProductBloc, DetailedProductState>(
        bloc: widget.detailedProductBloc,
        buildWhen: (previous, current) =>
            current is DetailedProductLoadingState,
        builder: (context, state) {
          return state is DetailedProductLoadingState
              ? defaultIndicator(null)
              : Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  BlocBuilder<DetailedProductBloc, DetailedProductState>(
                    bloc: widget.detailedProductBloc,
                    buildWhen: (previous, current) =>
                        current is DetailedProductSelectPersonState ||
                        current is DetailedProductLoadingState,
                    builder: (context, state) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                            5,
                            (index) => Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: GestureDetector(
                                    onTap: () {
                                      widget.detailedProductBloc.add(
                                          DetailedProductSelectPersonEvent(
                                              person: index + 1));
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: appColorFirst,
                                      child: Text(
                                        "${index + 1}",
                                        style: TextStyle(
                                          color: state
                                                  is DetailedProductSelectPersonState
                                              ? state.person == index + 1
                                                  ? Colors.black
                                                  : Colors.white
                                              : Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                )),
                      );
                    },
                  ),
                  SizedBox(
                    height: height * .05,
                  ),
                  BlocBuilder<DetailedProductBloc, DetailedProductState>(
                    buildWhen: (previous, current) =>
                        current is DetailedProductSelectDateState,
                    bloc: widget.detailedProductBloc,
                    builder: (context, state) {
                      return GestureDetector(
                          onTap: () {
                            widget.detailedProductBloc.add(
                                DetailedProductSelectDateEvent(
                                    context: context, stateUpdate: null));
                          },
                          child: Icon(
                            Icons.timelapse_rounded,
                            color: state is DetailedProductSelectDateState
                                ? state.dateTime != null
                                    ? appColorFirst
                                    : Colors.black
                                : Colors.black,
                          ));
                    },
                  ),
                  SizedBox(
                    height: height * .05,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        widget.detailedProductBloc.add(
                            DetailedProductBookTravel(
                                context: context, placeId: widget.placeId));
                      },
                      child: Text("Confirm"))
                ]);
        },
      ),
    );
  }
}
