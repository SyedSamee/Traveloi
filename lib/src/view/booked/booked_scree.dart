import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:traveloi/src/view/booked/bloc/booked_bloc.dart';

class BookedScreen extends StatefulWidget {
  const BookedScreen({super.key});

  @override
  State<BookedScreen> createState() => BookedScreenState();
}

class BookedScreenState extends State<BookedScreen> {
  BookedBloc bookedBloc = BookedBloc();
  @override
  void dispose() {
    bookedBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Booking Successfully",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
          SizedBox(
            height: height * .03,
          ),
          ElevatedButton(
              onPressed: () {
                bookedBloc
                    .add(BookedScreenHomeNavigationEvent(context: context));
              },
              child: Text("Go to home"))
        ],
      )),
    );
  }
}
