import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traveloi/src/config/extention/string_extentions.dart';
import 'package:traveloi/src/config/utils.dart';
import 'package:traveloi/src/view/book_detail/bloc/booking_detail_bloc.dart';

class BookingDetailScreen extends StatefulWidget {
  const BookingDetailScreen({super.key});

  @override
  State<BookingDetailScreen> createState() => _BookingDetailScreenState();
}

class _BookingDetailScreenState extends State<BookingDetailScreen> {
  BookingDetailBloc bookingDetailBloc = BookingDetailBloc();

  @override
  void initState() {
    bookingDetailBloc.add(BookingDetailGetAllBooksEvent(context: context));
    super.initState();
  }

  @override
  void dispose() {
    bookingDetailBloc.close();
    super.dispose();
  }

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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: SizedBox(
                width: width * .94,
                child: const Text(
                  "Your books",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: height * .03,
            ),
            BlocConsumer<BookingDetailBloc, BookingDetailState>(
              bloc: bookingDetailBloc,
              listenWhen: (previous, current) =>
                  current is BookingDetailMsgState,
              buildWhen: (previous, current) =>
                  current is BookingDetailGetAllBooksState ||
                  current is BookingDetailLoadingState,
              listener: (context, state) {
                state as BookingDetailMsgState;
                messenger(context, state.msg, state.isError);
              },
              builder: (context, state) {
                switch (state.runtimeType) {
                  case BookingDetailLoadingState:
                    {
                      return defaultIndicator(null);
                    }
                  case BookingDetailGetAllBooksState:
                    {
                      state as BookingDetailGetAllBooksState;
                      return SizedBox(
                        width: width,
                        height: height * .63,
                        child: ListView.builder(
                            itemCount: state.allBooks.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 12),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: width * .25,
                                          height: height * .077,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              image: const DecorationImage(
                                                  image: AssetImage(
                                                    "assets/images/product_image.png",
                                                  ),
                                                  fit: BoxFit.fill)),
                                        ),
                                        SizedBox(
                                          width: width * .03,
                                        ),
                                        SizedBox(
                                          width: width * .6,
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  children: [
                                                    SizedBox(
                                                      width: width * .46,
                                                      child: Text(
                                                        state.allBooks[index]
                                                            ["name"],
                                                        style: const TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: height * .01,
                                                    ),
                                                    SizedBox(
                                                      width: width * .46,
                                                      child: Text(
                                                        state.allBooks[index]
                                                                ["location"]
                                                            .toString()
                                                            .listMarksRemover,
                                                        style: const TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  state.allBooks[index]
                                                      ["price"],
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ]),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }),
                      );
                    }

                  default:
                    {
                      return const SizedBox();
                    }
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
