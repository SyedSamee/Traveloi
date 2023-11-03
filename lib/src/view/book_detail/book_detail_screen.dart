import 'package:flutter/material.dart';

class BookingDetailScreen extends StatefulWidget {
  const BookingDetailScreen({super.key});

  @override
  State<BookingDetailScreen> createState() => _BookingDetailScreenState();
}

class _BookingDetailScreenState extends State<BookingDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: height * .16,
            ),
            SizedBox(
              width: width * .94,
              child: Text(
                "Your books",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: height * .03,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: width * .25,
                        height: height * .077,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                                image: AssetImage(
                                  "assets/images/product_image.png",
                                ),
                                fit: BoxFit.fill)),
                      ),
                      SizedBox(
                        width: width * .03,
                      ),
                      Container(
                        width: width * .6,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    width: width * .46,
                                    child: Text(
                                      "name",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * .01,
                                  ),
                                  Container(
                                    width: width * .46,
                                    child: Text(
                                      "location",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "price",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ]),
                      ),

                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Column(
                      //       children: [
                      //         Text(
                      //           "Name",
                      //           style: TextStyle(
                      //               fontSize: 20, fontWeight: FontWeight.w500),
                      //         ),
                      //         Text("Name"),
                      //       ],
                      //     ),
                      //     Text("Name"),
                      //   ],
                      // ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
