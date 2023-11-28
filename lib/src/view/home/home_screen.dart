import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:traveloi/src/config/extention/string_extentions.dart';
import 'package:traveloi/src/config/utils.dart';
import 'package:traveloi/src/controller/home_controller/home_controller.dart';
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
                                        Border.all(color: Color(0xffD2D2D2))),
                                child: Row(children: [
                                  SizedBox(
                                    width: width * .05,
                                  ),
                                  Container(
                                    width: width * .65,
                                    height: height * .05,
                                    decoration: BoxDecoration(
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
                                          contentPadding: EdgeInsets.symmetric(
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
                              child: Container(
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
                                                offset: Offset(0, 4),
                                                blurRadius: 6,
                                              )
                                            ],
                                            color: Color(0xFF2E2E2E),
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Text(
                                          popularPlaceList,
                                          style: TextStyle(
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
                            // state is HomeSearchPlaceState &&
                            //     state.products == null
                            // ? SizedBox(
                            //     height: height * .43,
                            //     child: Text("No product found"))
                            // : SizedBox()

                            ProductList(
                                productsState: state is HomeGetAllProductsState
                                    ? state
                                    : null,
                                searchState: state is HomeSearchPlaceState
                                    ? state
                                    : null,
                                homeBloc: widget.homeBloc)

                            // Container(
                            //     width: width,
                            //     height: height * .43,
                            //     child: state is HomeSearchPlaceState ||
                            //             state is HomeGetAllProductsState
                            //         ? ListView.builder(
                            //             itemCount: state is HomeSearchPlaceState
                            //                 ? state.products?.length
                            //                 : state is HomeGetAllProductsState
                            //                     ? state.products.length
                            //                     : 0,
                            //             scrollDirection: Axis.horizontal,
                            //             itemBuilder: (context, index) {
                            //               return Padding(
                            //                 padding: const EdgeInsets.symmetric(
                            //                     horizontal: 30),
                            //                 child: Row(
                            //                   children: [
                            //                     Container(
                            //                       width: width * .58,
                            //                       height: height * .5,
                            //                       child: Stack(
                            //                         children: [
                            //                           Positioned(
                            //                             top: height * .34,
                            //                             left: width * .045,
                            //                             child: Container(
                            //                               width: width * .5,
                            //                               height: height * .07,
                            //                               decoration:
                            //                                   BoxDecoration(
                            //                                       color: Colors
                            //                                           .transparent,
                            //                                       boxShadow: [
                            //                                     BoxShadow(
                            //                                       color: Colors
                            //                                           .black
                            //                                           .withOpacity(
                            //                                               0.45),
                            //                                       offset:
                            //                                           Offset(
                            //                                               0, 6),
                            //                                       blurRadius:
                            //                                           20,
                            //                                     )
                            //                                   ]),
                            //                             ),
                            //                           ),
                            //                           Container(
                            //                             width: width * .58,
                            //                             height: height * .4,
                            //                             decoration:
                            //                                 BoxDecoration(
                            //                                     image:
                            //                                         DecorationImage(
                            //                                             image:
                            //                                                 AssetImage(
                            //                                               "assets/images/product_image.png",
                            //                                             ),
                            //                                             fit: BoxFit
                            //                                                 .cover),
                            //                                     borderRadius:
                            //                                         BorderRadius
                            //                                             .circular(
                            //                                                 30)),
                            //                             child:
                            //                                 Column(children: [
                            //                               Padding(
                            //                                 padding:
                            //                                     const EdgeInsets
                            //                                         .only(
                            //                                         right: 16,
                            //                                         top: 10),
                            //                                 child: Row(
                            //                                   mainAxisAlignment:
                            //                                       MainAxisAlignment
                            //                                           .end,
                            //                                   children: [
                            //                                     GestureDetector(
                            //                                         onTap: () {
                            //                                           state
                            //                                                   is HomeGetAllProductsState
                            //                                               ? widget.homeBloc.add(HomeAddOrRemoveFavEvent(
                            //                                                   productId: state.products[index]["product_id"],
                            //                                                   homeBloc: widget.homeBloc,
                            //                                                   loadingIndex: index,
                            //                                                   context: context,
                            //                                                   productList: state.products))
                            //                                               : state is HomeSearchPlaceState
                            //                                                   ? widget.homeBloc.add(HomeAddOrRemoveFavEvent(productId: state.products![index]["product_id"], homeBloc: widget.homeBloc, loadingIndex: index, context: context, productList: state.products!))
                            //                                                   : null;
                            //                                         },
                            //                                         child:
                            //                                             CircleAvatar(
                            //                                           backgroundColor: Color.fromRGBO(
                            //                                               29,
                            //                                               29,
                            //                                               29,
                            //                                               0.40),
                            //                                           child: SvgPicture.asset(
                            //                                               "assets/images/icons/heart_icon.svg",
                            //                                               width:
                            //                                                   width * .055,
                            //                                               color: state is HomeGetAllProductsState
                            //                                                   ? state.products[index]["isFavByUser"] == 1
                            //                                                       ? Colors.redAccent
                            //                                                       : null
                            //                                                   : state is HomeSearchPlaceState
                            //                                                       ? state.products![index]["isFavByUser"] == 1
                            //                                                           ? Colors.redAccent
                            //                                                           : null
                            //                                                       : null),
                            //                                         ))
                            //                                   ],
                            //                                 ),
                            //                               ),
                            //                               Spacer(),
                            //                               Container(
                            //                                 width: width * .47,
                            //                                 height:
                            //                                     height * .095,
                            //                                 decoration:
                            //                                     BoxDecoration(
                            //                                   borderRadius:
                            //                                       BorderRadius
                            //                                           .circular(
                            //                                               15),
                            //                                   color: Color
                            //                                       .fromRGBO(
                            //                                           29,
                            //                                           29,
                            //                                           29,
                            //                                           0.40),
                            //                                 ),
                            //                                 child: Column(
                            //                                     children: [
                            //                                       Padding(
                            //                                         padding: const EdgeInsets
                            //                                             .only(
                            //                                             top: 12,
                            //                                             left:
                            //                                                 12),
                            //                                         child: Row(
                            //                                           children: [
                            //                                             Text.rich(
                            //                                               TextSpan(
                            //                                                 children: [
                            //                                                   TextSpan(
                            //                                                     text: '${state is HomeSearchPlaceState ? state.products![index]["product_detail"]["name"] : state is HomeGetAllProductsState ? state.products[index]["product_detail"]["name"] : ""} ',
                            //                                                     style: TextStyle(
                            //                                                       color: Colors.white,
                            //                                                       fontSize: 16,
                            //                                                       fontFamily: 'Roboto',
                            //                                                       fontWeight: FontWeight.w500,
                            //                                                       height: 0,
                            //                                                     ),
                            //                                                   ),
                            //                                                   TextSpan(
                            //                                                     text: '${state is HomeSearchPlaceState ? state.products![index]["product_detail"]["location"].toString().separateFirstLocation() : state is HomeGetAllProductsState ? state.products[index]["product_detail"]["location"].toString().separateFirstLocation() : ""}',
                            //                                                     style: TextStyle(
                            //                                                       color: Color(0xFFC9C8C8),
                            //                                                       fontSize: 14,
                            //                                                       fontFamily: 'Roboto',
                            //                                                       fontWeight: FontWeight.w500,
                            //                                                       height: 0,
                            //                                                     ),
                            //                                                   ),
                            //                                                 ],
                            //                                               ),
                            //                                             )
                            //                                           ],
                            //                                         ),
                            //                                       ),
                            //                                       Padding(
                            //                                         padding: const EdgeInsets
                            //                                             .only(
                            //                                             top: 12,
                            //                                             left:
                            //                                                 12),
                            //                                         child: Row(
                            //                                           mainAxisAlignment:
                            //                                               MainAxisAlignment
                            //                                                   .spaceBetween,
                            //                                           children: [
                            //                                             Row(
                            //                                               children: [
                            //                                                 SvgPicture.asset("assets/images/icons/map_icon.svg"),
                            //                                                 SizedBox(
                            //                                                   width: width * .015,
                            //                                                 ),
                            //                                                 Text(
                            //                                                   '${state is HomeSearchPlaceState ? state.products![index]["product_detail"]["location"].toString().listMarksRemover : state is HomeGetAllProductsState ? state.products[index]["product_detail"]["location"].toString().listMarksRemover : ""}',
                            //                                                   style: TextStyle(
                            //                                                     color: Color(0xFFC9C8C8),
                            //                                                     fontSize: 14,
                            //                                                     fontFamily: 'Roboto',
                            //                                                     fontWeight: FontWeight.w400,
                            //                                                     height: 0,
                            //                                                   ),
                            //                                                 ),
                            //                                               ],
                            //                                             ),
                            //                                             Row(
                            //                                               children: [
                            //                                                 SvgPicture.asset("assets/images/icons/star_icon.svg"),
                            //                                                 SizedBox(
                            //                                                   width: width * .015,
                            //                                                 ),
                            //                                                 Text(
                            //                                                   '${state is HomeSearchPlaceState ? state.products![index]["product_detail"]["rating"] : state is HomeGetAllProductsState ? state.products[index]["product_detail"]["rating"] : ""}',
                            //                                                   style: TextStyle(
                            //                                                     color: Color(0xFFC9C8C8),
                            //                                                     fontSize: 14,
                            //                                                     fontFamily: 'Roboto',
                            //                                                     fontWeight: FontWeight.w400,
                            //                                                     height: 0,
                            //                                                   ),
                            //                                                 ),
                            //                                                 SizedBox(
                            //                                                   width: width * .015,
                            //                                                 ),
                            //                                               ],
                            //                                             )
                            //                                           ],
                            //                                         ),
                            //                                       )
                            //                                     ]),
                            //                               ),
                            //                               SizedBox(
                            //                                 height:
                            //                                     height * .03,
                            //                               ),
                            //                             ]),
                            //                           ),
                            //                         ],
                            //                       ),
                            //                     ),
                            //                   ],
                            //                 ),
                            //               );
                            //             })
                            //         : null)
                          ],
                        );
                      }

                    default:
                      {
                        return SizedBox();
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
