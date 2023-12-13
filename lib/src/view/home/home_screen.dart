import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:traveloi/src/config/utils.dart';
import 'package:traveloi/src/view/home/bloc/home_bloc.dart';
import 'package:traveloi/src/view/home/widget/productListWidget.dart';
import 'package:traveloi/src/view/home/widget/profile_widget.dart';

class HomeScreen extends StatefulWidget {
  final HomeBloc homeBloc;
  const HomeScreen({super.key, required this.homeBloc});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchPlace = TextEditingController();

  @override
  void initState() {
    widget.homeBloc
        .add(HomeInitialEvent(homeBloc: widget.homeBloc, context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SafeArea(
      child: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
            child: Column(
          children: [
            ProfileWidget(homeBloc: widget.homeBloc, height: height),
            SizedBox(
              width: width,
              child: BlocBuilder<HomeBloc, HomeState>(
                bloc: widget.homeBloc,
                buildWhen: (previous, current) =>
                    current is HomeSearchPlaceState ||
                    current is HomeGetAllProductsState ||
                    current is HomeProductLoadingState,
                builder: (context, state) {
                  switch (state.runtimeType) {
                    case HomeProductLoadingState:
                      {
                        state as HomeProductLoadingState;
                        return SizedBox(
                            height: height * .43,
                            child: defaultIndicator(state.msg));
                      }

                    case HomeGetAllProductsState || HomeSearchPlaceState:
                      {
                        return Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: Container(
                                width: width,
                                height: height * .07,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border:
                                        Border.all(color: const Color(0xffD2D2D2))),
                                child: Row(children: [
                                  SizedBox(
                                    width: width * .05,
                                  ),
                                  Container(
                                    width: width * .65,
                                    height: height * .05,
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        border: Border(
                                            right: BorderSide(
                                                color: Color(0xffD2D2D2)))),
                                    child: TextField(
                                      controller: searchPlace,
                                      onSubmitted: (value) {
                                        widget.homeBloc.add(
                                            HomeSearchPlacesEvent(
                                                query: searchPlace.text,
                                                homeBloc: widget.homeBloc,
                                                state: state,
                                                context: context));
                                      },
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Search places",
                                          hintStyle: TextStyle(
                                              color: Colors.black
                                                  .withOpacity(0.35)),
                                          contentPadding: const EdgeInsets.symmetric(
                                              vertical: 10)),
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * .03,
                                  ),
                                  SvgPicture.asset(
                                      "assets/images/icons/icon_setting.svg")
                                ]),
                              ),
                            ),
                            SizedBox(
                              height: height * .03,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: SizedBox(
                                  height: height * .1,
                                  child: Row(
                                    children: [
                                      Container(
                                        width: width * .34,
                                        height: height * .06,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.24),
                                                spreadRadius: 0.050,
                                                offset: const Offset(0, 4),
                                                blurRadius: 6,
                                              )
                                            ],
                                            color: const Color(0xFF2E2E2E),
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Text(
                                          popularPlaceList,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w500,
                                            height: 0,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * .1,
                                      )
                                    ],
                                  )),
                            ),
                            SizedBox(
                              height: height * .04,
                            ),
                            ProductList(
                                productsState: state is HomeGetAllProductsState
                                    ? state
                                    : null,
                                searchState: state is HomeSearchPlaceState
                                    ? state
                                    : null,
                                homeBloc: widget.homeBloc)
                          ],
                        );
                      }

                    default:
                      {
                        return const SizedBox();
                      }
                  }
                },
              ),
            )
          ],
        )),
      ),
    ));
  }
}
