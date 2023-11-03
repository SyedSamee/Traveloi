import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FavScreen extends StatefulWidget {
  const FavScreen({super.key});

  @override
  State<FavScreen> createState() => FavScreenState();
}

class FavScreenState extends State<FavScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Expanded(child: SizedBox()),
          Expanded(
              flex: 2,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
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
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 25),
                        child: Container(
                          width: width * .51,
                          height: height * .3,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                    "assets/images/product_image.png",
                                  ),
                                  fit: BoxFit.fill),
                              borderRadius: BorderRadius.circular(15)),
                          child: Column(children: [
                            Expanded(child: SizedBox()),
                            Expanded(
                              child: SizedBox(
                                // color: Colors.grey,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        width: width,
                                        height: height * .075,
                                        decoration: BoxDecoration(
                                            color: Color.fromRGBO(
                                                29, 29, 29, 0.40),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Text(
                                                    'Andes Mountain',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15.69,
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      height: 0,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Price',
                                                    style: TextStyle(
                                                      color: Color(0xFFC9C8C8),
                                                      fontSize: 10.46,
                                                      fontFamily: 'Roboto',
                                                      fontWeight:
                                                          FontWeight.w400,
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
                                                      SvgPicture.asset(
                                                          "assets/images/icons/map_icon.svg"),
                                                      SizedBox(
                                                        width: width * .01,
                                                      ),
                                                      Text(
                                                        'South, America',
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFFC9C8C8),
                                                          fontSize: 11.77,
                                                          fontFamily: 'Roboto',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          height: 0,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Text.rich(
                                                    TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text: '\$',
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xFF424242),
                                                            fontSize: 13.08,
                                                            fontFamily:
                                                                'Roboto',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 0,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text: '230',
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xFFC9C8C8),
                                                            fontSize: 17,
                                                            fontFamily:
                                                                'Roboto',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 0,
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
                      ),
                    ],
                  )
                ],
              )),
          Expanded(child: SizedBox()),
        ],
      )),
    );
  }
}
