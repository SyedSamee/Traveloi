import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:traveloi/src/view/book_detail/book_detail_screen.dart';
import 'package:traveloi/src/view/bottom_viewer/bloc/bottom_viewer_bloc.dart';
import 'package:traveloi/src/view/fav_screen/fav_screen.dart';
import 'package:traveloi/src/view/home/bloc/home_bloc.dart';
import 'package:traveloi/src/view/home/home_screen.dart';
import 'package:traveloi/src/view/profile_screen/profile_screen.dart';

class BottomViewer extends StatefulWidget {
  const BottomViewer({super.key});

  @override
  State<BottomViewer> createState() => _BottomViewerState();
}

class _BottomViewerState extends State<BottomViewer> {
  HomeBloc homeBloc = HomeBloc();
  BottomViewerBloc bottomViewerBloc = BottomViewerBloc();
  PageController pageController = PageController();
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
        bottomNavigationBar: BlocBuilder<BottomViewerBloc, BottomViewerState>(
          bloc: bottomViewerBloc,
          buildWhen: (previous, current) => current is BottomViewerInitial,
          builder: (context, state) {
            state as BottomViewerInitial;
            return SizedBox(
              width: width,
              height: height * .065,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        pageController.jumpToPage(0);
                        bottomViewerBloc
                            .add(BottomViewerChangePageEvent(requestPage: 0));
                      },
                      child: Column(children: [
                        SvgPicture.asset("assets/images/icons/icon_home.svg"),
                        SizedBox(height: height * .01),
                        state.currentPage == 0
                            ? const CircleAvatar(
                                backgroundColor: Colors.red,
                                radius: 3,
                              )
                            : const SizedBox()
                      ]),
                    ),
                    GestureDetector(
                      onTap: () {
                        pageController.jumpToPage(1);
                        bottomViewerBloc
                            .add(BottomViewerChangePageEvent(requestPage: 1));
                      },
                      child: Column(children: [
                        SvgPicture.asset("assets/images/icons/icon_clock.svg"),
                        SizedBox(height: height * .01),
                        state.currentPage == 1
                            ? const CircleAvatar(
                                backgroundColor: Colors.red,
                                radius: 3,
                              )
                            : const SizedBox()
                      ]),
                    ),
                    GestureDetector(
                      onTap: () {
                        pageController.jumpToPage(2);
                        bottomViewerBloc
                            .add(BottomViewerChangePageEvent(requestPage: 2));
                      },
                      child: Column(children: [
                        SvgPicture.asset("assets/images/icons/icon_heart.svg"),
                        SizedBox(height: height * .01),
                        state.currentPage == 2
                            ? const CircleAvatar(
                                backgroundColor: Colors.red,
                                radius: 3,
                              )
                            : const SizedBox()
                      ]),
                    ),
                    GestureDetector(
                      onTap: () {
                        pageController.jumpToPage(3);
                        bottomViewerBloc
                            .add(BottomViewerChangePageEvent(requestPage: 3));
                      },
                      child: Column(children: [
                        SvgPicture.asset(
                          "assets/images/icons/icon_user.svg",
                        ),
                        SizedBox(height: height * .01),
                        state.currentPage == 3
                            ? const CircleAvatar(
                                backgroundColor: Colors.red,
                                radius: 3,
                              )
                            : const SizedBox()
                      ]),
                    ),
                  ]),
            );
          },
        ),
        body: PageView(
          controller: pageController,
          onPageChanged: (value) {
            bottomViewerBloc
                .add(BottomViewerChangePageEvent(requestPage: value));
          },
          children: [
            HomeScreen(homeBloc: homeBloc),
            const BookingDetailScreen(),
            const FavScreen(),
            const ProfileScreen()
          ],
        ));
  }
}
