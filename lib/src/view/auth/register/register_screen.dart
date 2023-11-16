import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:traveloi/src/config/utils.dart';
import 'package:traveloi/src/view/auth/register/bloc/register_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  RegisterBloc registerBloc = RegisterBloc();
  TextEditingController fullName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  void dispose() {
    registerBloc.close();
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
                    controller: fullName,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 15),
                        // contentPadding: EdgeInsets.symmetric(horizontal: 15),
                        hintText: "Full name",
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
                    controller: email,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 15),
                        // contentPadding: EdgeInsets.symmetric(horizontal: 15),
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
              BlocConsumer<RegisterBloc, RegisterState>(
                bloc: registerBloc,
                listenWhen: (previous, current) => current is RegisterMsgState,
                buildWhen: (previous, current) =>
                    current is RegisterInitial ||
                    current is RegisterLoadingState,
                listener: (context, state) {
                  state as RegisterMsgState;

                  messenger(context, state.msg, state.isError);
                },
                builder: (context, state) {
                  switch (state.runtimeType) {
                    case RegisterInitial:
                      {
                        return ElevatedButton(
                            onPressed: () {
                              registerBloc.add(RegisterAUserEvent(
                                  context: context,
                                  fullName: fullName.text,
                                  email: email.text,
                                  password: password.text));
                            },
                            child: Icon(Icons.arrow_forward_ios));
                      }
                    case RegisterLoadingState:
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
