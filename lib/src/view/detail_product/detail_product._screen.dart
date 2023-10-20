import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DetailProductScreen extends StatefulWidget {
  const DetailProductScreen({super.key});

  @override
  State<DetailProductScreen> createState() => _DetailProductScreenState();
}

class _DetailProductScreenState extends State<DetailProductScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: height * .03,
              ),
              Container(
                width: width * .87,
                height: height * .55,
                child: Stack(
                  children: [
                    Positioned(
                      top: height * .43,
                      left: width * .04,
                      child: Container(
                        width: width * .8,
                        height: height * .07,
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.45),
                                offset: Offset(0, 6),
                                blurRadius: 20,
                              )
                            ]),
                      ),
                    ),
                    Container(
                      width: width * .87,
                      height: height * .5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(26),
                        image: DecorationImage(
                            image:
                                AssetImage("assets/images/product_image.png"),
                            fit: BoxFit.cover),
                      ),
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  width: width * .1,
                                  height: height * .1,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color.fromRGBO(29, 29, 29, 0.40),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 7),
                                    child: Icon(Icons.arrow_back_ios,
                                        color:
                                            Color.fromRGBO(225, 225, 225, 1)),
                                  )),
                              Container(
                                  width: width * .1,
                                  height: height * .1,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color.fromRGBO(29, 29, 29, 0.40),
                                  ),
                                  child: Padding(
                                      padding: const EdgeInsets.only(left: 0),
                                      child: SvgPicture.asset(
                                        "assets/images/icons/archive_icon.svg",
                                        width: width * .05,
                                      ))),
                            ],
                          ),
                        ),
                        Spacer(),
                        Container(
                          width: width * .77,
                          height: height * .12,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color.fromRGBO(29, 29, 29, 0.40),
                          ),
                          child: Column(children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 12, left: 12, right: 12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Mount Fuji, ',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                    ),
                                  ),
                                  Text(
                                    'Price',
                                    style: TextStyle(
                                      color: Color(0xFFC9C8C8),
                                      fontSize: 16,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 12, left: 12, right: 12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                          "assets/images/icons/map_icon.svg"),
                                      SizedBox(
                                        width: width * .015,
                                      ),
                                      Text(
                                        'Tokyo, Japan',
                                        style: TextStyle(
                                          color: Color(0xFFC9C8C8),
                                          fontSize: 14,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w400,
                                          height: 0,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text.rich(TextSpan(children: [
                                        TextSpan(
                                          text: '\$',
                                          style: TextStyle(
                                            color: Color(0xFF424242),
                                            fontSize: 20,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w500,
                                            height: 0,
                                          ),
                                        ),
                                        TextSpan(
                                          text: '230',
                                          style: TextStyle(
                                            color: Color(0xFFC9C8C8),
                                            fontSize: 26,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w500,
                                            height: 0,
                                          ),
                                        )
                                      ])),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ]),
                        ),
                        SizedBox(
                          height: height * .03,
                        )
                      ]),
                    ),
                  ],
                ),
              ),
              Container(
                width: width * .87,
                child: Row(
                  children: [
                    Text(
                      'Overview',
                      style: TextStyle(
                        color: Color(0xFF1B1B1B),
                        fontSize: 22,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                    SizedBox(
                      width: width * .05,
                    ),
                    Text('Details',
                        style: TextStyle(
                          color: Color(0x9E1B1B1B),
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          height: 0,
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: height * .03,
              ),
              Container(
                width: width * .87,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: width * .08,
                            height: height * .035,
                            decoration: ShapeDecoration(
                              color: Color(0xFFECECEC),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: SvgPicture.asset(
                                "assets/images/icons/icon_clock_highlighted.svg",
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width * .02,
                          ),
                          Text(
                            '8 hours',
                            style: TextStyle(
                              color: Color(0xFF7E7E7E),
                              fontSize: 16,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: width * .08,
                            height: height * .035,
                            decoration: ShapeDecoration(
                              color: Color(0xFFECECEC),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: SvgPicture.asset(
                                "assets/images/icons/icon_cloud.svg",
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width * .02,
                          ),
                          Text(
                            '16  C',
                            style: TextStyle(
                              color: Color(0xFF7E7E7E),
                              fontSize: 16,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: width * .08,
                            height: height * .035,
                            decoration: ShapeDecoration(
                              color: Color(0xFFECECEC),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: SvgPicture.asset(
                                "assets/images/icons/icon_star.svg",
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width * .02,
                          ),
                          Text(
                            '4.5',
                            style: TextStyle(
                              color: Color(0xFF7E7E7E),
                              fontSize: 16,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                        ],
                      )
                    ]),
              ),
              SizedBox(
                height: height * .03,
              ),
              Container(
                width: width * .87,
                height: height * .15,
                child: Stack(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: width * .87,
                          height: height * .13,
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: SingleChildScrollView(
                            child: Text(
                              'This vast mountain range is renowned for its remarkable diversity in terms of topography and climate. It features towering peaks, active volcanoes, deep canyons, expansive plateaus, and lush valleys. The Andes are also home to ',
                              style: TextStyle(
                                color: Color(0xFFA4A4A4),
                                fontSize: 18,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      top: height * .1,
                      child: Container(
                        width: width * .9,
                        height: height * .04,
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.white,
                                  blurRadius: 29,
                                  spreadRadius: 1)
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * .03,
              ),
              Container(
                width: width * .87,
                height: height * .08,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Color(0xFF1A1A1A),
                  shadows: [
                    BoxShadow(
                      color: Color(0x1E000000),
                      blurRadius: 26,
                      offset: Offset(0, 13),
                      spreadRadius: -2,
                    )
                  ],
                ),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    'Book Now',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                  SizedBox(
                    width: width * .04,
                  ),
                  SvgPicture.asset("assets/images/icons/icon_send.svg")
                ]),
              ),
              SizedBox(
                height: height * .05,
              ),
            ],
          ),
        ),
      )),
    );
  }
}
