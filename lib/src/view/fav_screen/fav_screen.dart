import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:traveloi/src/config/utils.dart';
import 'package:traveloi/src/view/fav_screen/bloc/fav_bloc.dart';

class FavScreen extends StatefulWidget {
  const FavScreen({super.key});

  @override
  State<FavScreen> createState() => FavScreenState();
}

class FavScreenState extends State<FavScreen> {
  FavBloc favBloc = FavBloc();
  @override
  void initState() {
    favBloc.add(FavGetAllEvent(context: context));
    super.initState();
  }

  @override
  void dispose() {
    favBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 14),
                child: Row(
                  children: [
                    Text(
                      'Favourite',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * .02,
              ),
              BlocConsumer<FavBloc, FavState>(
                bloc: favBloc,
                buildWhen: (previous, current) =>
                    current is FavLoadingState || current is FavProductState,
                listener: (context, state) {},
                builder: (context, state) {
                  switch (state.runtimeType) {
                    case FavLoadingState:
                      {
                        return SizedBox(
                          height: height * .3,
                          child: defaultIndicator("Getting Products"),
                        );
                      }
                    case FavProductState:
                      {
                        state as FavProductState;
                        return Container(
                          width: width,
                          alignment: Alignment.center,
                          height: height * .3,
                          child: state.products.isNotEmpty
                              ? ListView.builder(
                                  itemCount: state.products.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 12),
                                      child: Container(
                                        width: width * .51,
                                        height: height * .3,
                                        decoration: BoxDecoration(
                                            image: const DecorationImage(
                                                image: AssetImage(
                                                  "assets/images/product_image.png",
                                                ),
                                                fit: BoxFit.fill),
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Column(children: [
                                          const Expanded(child: SizedBox()),
                                          Expanded(
                                            child: SizedBox(
                                              child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Container(
                                                      width: width,
                                                      height: height * .075,
                                                      decoration: BoxDecoration(
                                                          color: const Color.fromRGBO(
                                                              29, 29, 29, 0.40),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              children: [
                                                                Text(
                                                                  '${state.products[index]["name"]}',
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        15.69,
                                                                    fontFamily:
                                                                        'Inter',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    height: 0,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  '${state.products[index]["price"]}',
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Color(
                                                                        0xFFC9C8C8),
                                                                    fontSize:
                                                                        10.46,
                                                                    fontFamily:
                                                                        'Roboto',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    height: 0,
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    SvgPicture
                                                                        .asset(
                                                                            "assets/images/icons/map_icon.svg"),
                                                                    SizedBox(
                                                                      width:
                                                                          width *
                                                                              .01,
                                                                    ),
                                                                    const Text(
                                                                      'South, America',
                                                                      style:
                                                                          TextStyle(
                                                                        color: Color(
                                                                            0xFFC9C8C8),
                                                                        fontSize:
                                                                            11.77,
                                                                        fontFamily:
                                                                            'Roboto',
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                        height:
                                                                            0,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                const Text.rich(
                                                                  TextSpan(
                                                                    children: [
                                                                      TextSpan(
                                                                        text:
                                                                            '\$',
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Color(0xFF424242),
                                                                          fontSize:
                                                                              13.08,
                                                                          fontFamily:
                                                                              'Roboto',
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          height:
                                                                              0,
                                                                        ),
                                                                      ),
                                                                      TextSpan(
                                                                        text:
                                                                            '230',
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Color(0xFFC9C8C8),
                                                                          fontSize:
                                                                              17,
                                                                          fontFamily:
                                                                              'Roboto',
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          height:
                                                                              0,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          ]),
                                                    )
                                                  ]),
                                            ),
                                          ),
                                          SizedBox(
                                            height: height * .04,
                                          )
                                        ]),
                                      ),
                                    );
                                  })
                              : const Text(
                                  "No Product found",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                        );
                      }

                    default:
                      {
                        return const SizedBox();
                      }
                  }
                },
              )
            ],
          )
        ],
      )),
    );
  }
}
