import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traveloi/src/config/utils.dart';
import 'package:traveloi/src/view/profile_screen/bloc/profile_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileBloc profileBloc = ProfileBloc();
  @override
  void initState() {
    profileBloc.add(ProfileGetUserDetailEvent(context: context));
    super.initState();
  }

  @override
  void dispose() {
    profileBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: BlocConsumer<ProfileBloc, ProfileState>(
          bloc: profileBloc,
          buildWhen: (previous, current) =>
              current is ProfileLoadingState ||
              current is ProfileGetUserDetailState,
          listenWhen: (previous, current) => current is ProfileMsgState,
          listener: (context, state) {
            state as ProfileMsgState;
            messenger(context, state.msg, state.isError);
          },
          builder: (context, state) {
            switch (state.runtimeType) {
              case ProfileGetUserDetailState:
                {
                  state as ProfileGetUserDetailState;
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                              CircleAvatar(
                                radius: 35,
                              ),
                              SizedBox(
                                height: height * .02,
                              ),
                              Text(
                                state.userData["name"],
                                style: TextStyle(fontSize: 32),
                              ),
                            ])),
                        Expanded(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                profileBloc
                                    .add(ProfileLogoutEvent(context: context));
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: width * .55,
                                height: height * .05,
                                decoration: BoxDecoration(
                                    color: appColorThird,
                                    borderRadius: BorderRadius.circular(18)),
                                child: Text(
                                  "Logout",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height * .04,
                            )
                          ],
                        )),
                      ]);
                }

              case ProfileLoadingState:
                {
                  return defaultIndicator(null);
                }
              default:
                {
                  return SizedBox();
                }
            }
          },
        ),
      )),
    );
  }
}
