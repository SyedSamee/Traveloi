import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:traveloi/src/config/utils.dart';
import 'package:traveloi/src/view/home/bloc/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeBloc homeBloc = HomeBloc();

  @override
  void dispose() {
    homeBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        bottomNavigationBar: Container(
          width: width,
          height: height * .065,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Column(children: [
              SvgPicture.asset("assets/images/icons/icon_home.svg"),
              SizedBox(height: height * .01),
              CircleAvatar(
                backgroundColor: Colors.red,
                radius: 3,
              )
            ]),
            Column(children: [
              SvgPicture.asset("assets/images/icons/icon_clock.svg")
            ]),
            Column(children: [
              SvgPicture.asset("assets/images/icons/icon_heart.svg")
            ]),
            Column(children: [
              SvgPicture.asset(
                "assets/images/icons/icon_user.svg",
              )
            ]),
          ]),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: height * .02,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Hi, David 👋",
                            style: TextStyle(
                              color: Color(0xFF2E2E2E),
                              fontSize: 30,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "Explore the world",
                            style: TextStyle(
                              color: Color(0xFF888888),
                              fontSize: 21.2,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?cs=srgb&dl=pexels-pixabay-220453.jpg&fm=jpg"),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: height * .03,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Container(
                    width: width,
                    height: height * .07,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Color(0xffD2D2D2))),
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
                                right: BorderSide(color: Color(0xffD2D2D2)))),
                        child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Search places",
                              hintStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.35)),
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 10)),
                        ),
                      ),
                      SizedBox(
                        width: width * .03,
                      ),
                      SvgPicture.asset("assets/images/icons/icon_setting.svg")
                    ]),
                  ),
                ),
                SizedBox(
                  height: height * .03,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Popular places",
                        style: TextStyle(
                          color: Color(0xFF2E2E2E),
                          fontSize: 20,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                      Text(
                        "View all",
                        style: TextStyle(
                          color: Color(0xFF888888),
                          fontSize: 16,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * .03,
                ),
                BlocBuilder<HomeBloc, HomeState>(
                  buildWhen: (previous, current) => current is HomeInitial,
                  bloc: homeBloc,
                  builder: (context, state) {
                    switch (state.runtimeType) {
                      case HomeInitial:
                        {
                          state as HomeInitial;
                          return Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Container(
                              height: height * .1,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: List.generate(
                                      3,
                                      (index) => Row(
                                            children: [
                                              Container(
                                                width: width * .34,
                                                height: height * .06,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    boxShadow: [
                                                      state.currentFilter ==
                                                              index
                                                          ? BoxShadow(
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.24),
                                                              spreadRadius:
                                                                  0.050,
                                                              offset:
                                                                  Offset(0, 4),
                                                              blurRadius: 6,
                                                            )
                                                          : BoxShadow(
                                                              color: Colors
                                                                  .transparent)
                                                    ],
                                                    color:
                                                        state.currentFilter ==
                                                                index
                                                            ? Color(0xFF2E2E2E)
                                                            : Color(0xffFBFBFB),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                child: Text(
                                                  popularPlaceList[index],
                                                  style: TextStyle(
                                                    color:
                                                        state.currentFilter ==
                                                                index
                                                            ? Colors.white
                                                            : Color(0xffC5C5C5),
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
                              ),
                            ),
                          );
                        }

                      default:
                        {
                          return SizedBox();
                        }
                    }
                  },
                ),
                SizedBox(
                  height: height * .04,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    children: [
                      Container(
                        width: width * .58,
                        height: height * .5,
                        child: Stack(
                          children: [
                            Positioned(
                              top: height * .34,
                              left: width * .045,
                              child: Container(
                                width: width * .5,
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
                              width: width * .58,
                              height: height * .4,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                        "assets/images/product_image.png",
                                      ),
                                      fit: BoxFit.cover),
                                  borderRadius: BorderRadius.circular(30)),
                              child: Column(children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(right: 16, top: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      CircleAvatar(
                                        backgroundColor:
                                            Color.fromRGBO(29, 29, 29, 0.40),
                                        child: SvgPicture.asset(
                                          "assets/images/icons/heart_icon.svg",
                                          width: width * .055,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  width: width * .47,
                                  height: height * .095,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Color.fromRGBO(29, 29, 29, 0.40),
                                  ),
                                  child: Column(children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 12, left: 12),
                                      child: Row(
                                        children: [
                                          Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'Mount Fuji, ',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontFamily: 'Roboto',
                                                    fontWeight: FontWeight.w500,
                                                    height: 0,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: 'Tokyo',
                                                  style: TextStyle(
                                                    color: Color(0xFFC9C8C8),
                                                    fontSize: 14,
                                                    fontFamily: 'Roboto',
                                                    fontWeight: FontWeight.w500,
                                                    height: 0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 12, left: 12),
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
                                              SvgPicture.asset(
                                                  "assets/images/icons/star_icon.svg"),
                                              SizedBox(
                                                width: width * .015,
                                              ),
                                              Text(
                                                '4.8',
                                                style: TextStyle(
                                                  color: Color(0xFFC9C8C8),
                                                  fontSize: 14,
                                                  fontFamily: 'Roboto',
                                                  fontWeight: FontWeight.w400,
                                                  height: 0,
                                                ),
                                              ),
                                              SizedBox(
                                                width: width * .015,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ]),
                                ),
                                SizedBox(
                                  height: height * .03,
                                ),
                              ]),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
