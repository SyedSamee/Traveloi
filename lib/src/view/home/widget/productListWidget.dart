import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:traveloi/src/config/extention/string_extentions.dart';
import 'package:traveloi/src/view/home/bloc/home_bloc.dart';

class ProductList extends StatefulWidget {
  final HomeSearchPlaceState? searchState;
  final HomeGetAllProductsState? productsState;
  final HomeBloc homeBloc;
  const ProductList(
      {this.productsState, this.searchState, required this.homeBloc});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
        width: width,
        height: height * .43,
        child: widget.searchState != null &&
                widget.searchState?.products == null
            ? Center(
                child: Text("No product found"),
              )
            : ListView.builder(
                itemCount: widget.productsState != null
                    ? widget.productsState!.products.length
                    : widget.searchState?.products!.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
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
                                    padding: const EdgeInsets.only(
                                        right: 16, top: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                            onTap: () {
                                              widget.productsState != null
                                                  ? widget.homeBloc.add(HomeAddOrRemoveFavEvent(
                                                      productId: widget
                                                              .productsState!
                                                              .products[index]
                                                          ["product_id"],
                                                      homeBloc: widget.homeBloc,
                                                      loadingIndex: index,
                                                      context: context,
                                                      productList: widget
                                                          .productsState!
                                                          .products,
                                                      isSearchState: false))
                                                  : widget.homeBloc.add(HomeAddOrRemoveFavEvent(
                                                      productId: widget
                                                              .searchState!
                                                              .products![index]
                                                          ["product_id"],
                                                      homeBloc: widget.homeBloc,
                                                      loadingIndex: index,
                                                      context: context,
                                                      productList: widget
                                                          .searchState!
                                                          .products!,
                                                      isSearchState: true));
                                            },
                                            child: CircleAvatar(
                                              backgroundColor: Color.fromRGBO(
                                                  29, 29, 29, 0.40),
                                              child: SvgPicture.asset(
                                                  "assets/images/icons/heart_icon.svg",
                                                  width: width * .055,
                                                  color: widget.productsState !=
                                                          null
                                                      ? widget.productsState!
                                                                          .products[
                                                                      index][
                                                                  "isFavByUser"] ==
                                                              1
                                                          ? Colors.redAccent
                                                          : null
                                                      : widget.searchState!
                                                                          .products![
                                                                      index][
                                                                  "isFavByUser"] ==
                                                              1
                                                          ? Colors.redAccent
                                                          : null),
                                            ))
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
                                                    text:
                                                        '${widget.searchState != null ? widget.searchState!.products![index]["product_detail"]["name"] : widget.productsState != null ? widget.productsState!.products[index]["product_detail"]["name"] : ""} ',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontFamily: 'Roboto',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      height: 0,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text:
                                                        '${widget.searchState != null ? widget.searchState!.products![index]["product_detail"]["location"].toString().separateFirstLocation() : widget.productsState != null ? widget.productsState!.products[index]["product_detail"]["location"].toString().separateFirstLocation() : ""}',
                                                    style: TextStyle(
                                                      color: Color(0xFFC9C8C8),
                                                      fontSize: 14,
                                                      fontFamily: 'Roboto',
                                                      fontWeight:
                                                          FontWeight.w500,
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
                                                  '${widget.searchState != null ? widget.searchState!.products![index]["product_detail"]["location"].toString().listMarksRemover : widget.productsState != null ? widget.productsState!.products[index]["product_detail"]["location"].toString().listMarksRemover : ""}',
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
                                                  '${widget.searchState != null ? widget.searchState!.products![index]["product_detail"]["rating"] : widget.productsState != null ? widget.productsState!.products[index]["product_detail"]["rating"] : ""}',
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
                  );
                }));
  }
}
