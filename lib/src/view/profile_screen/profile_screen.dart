import 'package:flutter/material.dart';
import 'package:traveloi/src/config/utils.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Expanded(
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            CircleAvatar(radius: 35),
            SizedBox(
              height: height * .02,
            ),
            Text(
              "Name",
              style: TextStyle(fontSize: 32),
            ),
          ])),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                alignment: Alignment.center,
                width: width * .55,
                height: height * .05,
                decoration: BoxDecoration(
                    color: appColorThird,
                    borderRadius: BorderRadius.circular(18)),
                child: Text(
                  "Logout",
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
              ),
              SizedBox(
                height: height * .04,
              )
            ],
          )),
        ]),
      )),
    );
  }
}
