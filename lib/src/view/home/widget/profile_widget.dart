import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traveloi/src/config/utils.dart';
import 'package:traveloi/src/view/home/bloc/home_bloc.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({
    super.key,
    required this.homeBloc,
    required this.height,
  });

  final HomeBloc homeBloc;

  final double height;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      buildWhen: (previous, current) =>
          current is HomeInitState || current is HomeLoadingState,
      listenWhen: (previous, current) => current is HomeMsgState,
      listener: (context, state) {
        state as HomeMsgState;
        messenger(context, state.msg, state.isError);
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            {
              return defaultIndicator(null);
            }
          case HomeInitState:
            {
              state as HomeInitState;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    SizedBox(
                      height: height * .02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Hi, ${state.name} 👋",
                              style: const TextStyle(
                                color: Color(0xFF2E2E2E),
                                fontSize: 30,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Text(
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
                          backgroundImage: NetworkImage(state.profileImg),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * .03,
                    ),
                  ],
                ),
              );
            }

          default:
            {
              return const SizedBox();
            }
        }
      },
    );
  }
}
