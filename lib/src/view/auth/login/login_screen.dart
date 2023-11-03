import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:traveloi/src/config/utils.dart';
import 'package:traveloi/src/view/auth/login/bloc/login_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginBloc loginBloc = LoginBloc();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  void dispose() {
    loginBloc.close();
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Travel',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 44,
                      fontFamily: 'Lobster',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * .03,
                  ),
                  SvgPicture.asset(
                    "assets/images/main_logo.svg",
                    color: Colors.black,
                    width: screenWidth * .085,
                  )
                ],
              ),
              SizedBox(
                height: screenHeight * .1,
              ),
              Container(
                width: screenWidth * .8,
                height: screenHeight * .065,
                decoration: ShapeDecoration(
                  color: Color(0xFFE3F5FF).withOpacity(0.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: TextField(
                    controller: email,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 15),
                        hintText: "Email",
                        hintStyle: TextStyle(color: Colors.black),
                        border: InputBorder.none)),
              ),
              SizedBox(
                height: screenHeight * .03,
              ),
              Container(
                width: screenWidth * .8,
                height: screenHeight * .065,
                decoration: ShapeDecoration(
                  color: Color(0xFFE3F5FF).withOpacity(0.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: TextField(
                    controller: password,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 15),
                        hintText: "Password",
                        hintStyle: TextStyle(color: Colors.black),
                        border: InputBorder.none)),
              ),
              SizedBox(
                height: screenHeight * .03,
              ),
              BlocConsumer<LoginBloc, LoginState>(
                bloc: loginBloc,
                buildWhen: (previous, current) =>
                    current is LoginInitial || current is LoginLoadingState,
                listenWhen: (previous, current) => current is LoginMsgState,
                listener: (context, state) {
                  state as LoginMsgState;
                  Messenger(context, state.msg, state.isError);
                },
                builder: (context, state) {
                  switch (state.runtimeType) {
                    case LoginInitial:
                      {
                        return ElevatedButton(
                            onPressed: () {
                              loginBloc.add(LoginAUserEvent(
                                  context: context,
                                  email: email.text,
                                  password: password.text));
                            },
                            child: Icon(Icons.arrow_forward_ios));
                      }

                    case LoginLoadingState:
                      {
                        return loadingIndicator;
                      }

                    default:
                      {
                        return SizedBox();
                      }
                  }
                },
              )
            ],
          ),
          SizedBox(
            height: screenHeight * .1,
          ),
        ]),
      ),
    );
  }
}
