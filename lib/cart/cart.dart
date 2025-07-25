import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:wg_garment/Api%20call/imageClass.dart';
import 'package:wg_garment/Config/colors.dart';
import 'package:wg_garment/Config/textstyle.dart';
import 'package:wg_garment/Home/home_model.dart';
import 'package:wg_garment/cart/cart_view_model.dart';

class CartView extends StatefulWidget {
  final VoidCallback onCButtonPressed;
  const CartView({super.key, required this.onCButtonPressed});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  late CartViewModel _viewModel;
  bool _isInitialized = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.clearData();
    super.dispose();
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    if (!_isInitialized) {
      _viewModel = Provider.of<CartViewModel>(context, listen: false);

      final response = await _viewModel.cartApicall();
      if (response != null) {
        if (response.responseCode != 1) {
          Fluttertoast.showToast(msg: response.responseText ?? "");
        }
      } else {
        Fluttertoast.showToast(msg: "Somethings went wrong!");
      }

      //Provider.of<HomeViewModel>(context).homeApiCall(); // Call API
      _isInitialized = true; // Ensure it's called only once
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartViewModel = Provider.of<CartViewModel>(context);
    return PlatformScaffold(
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.all(8),
        child: cartViewModel.cartList.length != 0
            ? Column(
                children: [
                  Expanded(
                      child: ListView.separated(
                    itemCount: cartViewModel.cartList.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 10); // Adds space between items
                    },
                    itemBuilder: (context, index) {
                      return AspectRatio(
                        aspectRatio: 2.5,
                        child: Stack(children: [
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: lightgraykcolor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                      right: 10, top: 10, bottom: 10),
                                  child: Container(
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                      color: productbackgroundcolor,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: AspectRatio(
                                        aspectRatio: 1,
                                        child: CustomNetworkImage(
                                          imageUrl: cartViewModel
                                              .cartList[index].productImage
                                              .toString(),
                                          height: double.infinity,
                                          width: double.infinity,
                                        )),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                      padding: EdgeInsets.only(right: 10),
                                      color: Colors.transparent,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Spacer(),
                                          Text(
                                            cartViewModel
                                                .cartList[index].productName
                                                .toString(),
                                            style: textStyleForMainProductName,
                                            maxLines: 1,
                                          ),
                                          Spacer(),
                                          Text(
                                            cartViewModel.cartList[index]
                                                .productShortDescription
                                                .toString(),
                                            style:
                                                textStyleForMainProductDescription,
                                            maxLines: 1,
                                          ),
                                          Spacer(),
                                          Text(
                                            cartViewModel.varientText(
                                                cartViewModel
                                                    .cartList[index].size
                                                    .toString(),
                                                cartViewModel
                                                    .cartList[index].color
                                                    .toString()),
                                            style:
                                                textStyleForMainProductvarient,
                                            maxLines: 2,
                                          ),
                                          Spacer(),
                                          Text( 
                                            "${currency + cartViewModel.cartList[index].productOriginalPrice.toString()}",
                                            //"hello",
                                            style: textStyleForMainPrice,
                                          ),
                                          Container(
                                            color: Colors.transparent,
                                            padding: EdgeInsets.all(0),
                                            height: 40,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  "Total Item:",
                                                  style:
                                                      textStyleForMainProductName,
                                                ),
                                                AspectRatio(
                                                  aspectRatio: 1,
                                                  child: IconButton(
                                                      onPressed: () {
                                                        if (cartViewModel
                                                                .cartList[index]
                                                                .productQuantity
                                                                .toString() ==
                                                            "1") {
                                                          cartViewModel
                                                              .deleteCartApicall(
                                                                  cartViewModel
                                                                      .cartList[
                                                                          index]
                                                                      .cartId
                                                                      .toString());
                                                        } else {
                                                          cartViewModel
                                                              .addRemoveCartQuantityApicall(
                                                                  cartViewModel
                                                                      .cartList[
                                                                          index]
                                                                      .cartId
                                                                      .toString(),
                                                                  "1",
                                                                  "DEC",
                                                                  cartViewModel
                                                                      .cartList[
                                                                          index]
                                                                      .productId
                                                                      .toString());
                                                        }
                                                      },
                                                      icon: Icon(
                                                        Icons
                                                            .remove_circle_outline,
                                                        color: pinkcolor,
                                                      )),
                                                ),
                                                Text(
                                                  cartViewModel.cartList[index]
                                                      .productQuantity
                                                      .toString(),
                                                  style: textStyleForMainPrice,
                                                ),
                                                AspectRatio(
                                                  aspectRatio: 1,
                                                  child: IconButton(
                                                      onPressed: () async {
                                                        cartViewModel
                                                            .addRemoveCartQuantityApicall(
                                                                cartViewModel
                                                                    .cartList[
                                                                        index]
                                                                    .cartId
                                                                    .toString(),
                                                                "1",
                                                                "INC",
                                                                cartViewModel
                                                                    .cartList[
                                                                        index]
                                                                    .productId
                                                                    .toString());
                                                      },
                                                      icon: Icon(
                                                          Icons
                                                              .add_circle_outline,
                                                          color: pinkcolor)),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      )),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: -5,
                            right: 0,
                            child: IconButton(
                              icon: Image.asset(
                                "assets/images/delete.png", // Replace with your image path
                                width: 25,
                                height: 25,
                              ),
                              onPressed: () async {
                                // Action when pressed
                                print("delete");
                                NormalModel? response =
                                    await cartViewModel.deleteCartApicall(
                                        cartViewModel.cartList[index].cartId
                                            .toString());
                                if (response?.responseCode == 1) {
                                  widget.onCButtonPressed();
                                  setState(() {
                                    Fluttertoast.showToast(
                                        msg:
                                            response?.responseText ?? "");
                                  });
                                } else {
                                  Fluttertoast.showToast(
                                      msg: response?.responseText ?? "");
                                }
                                // setState(() {});
                                                            },
                            ),
                          ),
                          Positioned(
                            top: 10,
                            left: 0,
                            child: IconButton(
                              icon: Image.asset(
                                (cartViewModel.cartList[index].isWishlist !=
                                        "1")
                                    ? "assets/images/dislike.png"
                                    : "assets/images/like.png", // Replace with your image path
                                width: 25,
                                height: 25,
                              ),
                              onPressed: () {
                                // Action when pressed
                                print("hello");

                                cartViewModel.addRemoveWishlistApiCall(
                                    cartViewModel.cartList[index].productId
                                        .toString());
                              },
                            ),
                          )
                        ]),
                      );
                    },
                  )),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: pinkcolor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Total Pay: ${currency + cartViewModel.totalPay}",
                              style: textStyleForCategorytName,
                            ),
                            SizedBox(height: 5),
                            Text(
                              "Total Save: ${ currency + cartViewModel.totalsave}",
                              style: textStyleForMainPrice,
                            )
                          ],
                        ),
                        Spacer(),
                        TextButton(
                          onPressed: () {
                            print("Tap on checkout");
                            cartViewModel.navigateToCheckOutView(context);
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: pinkcolor,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            height: 50,
                            // color: lightgraykcolor,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "    Check Out   ",
                                  style: textStyleForButton,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )
            : Expanded(
                child: Center(
                  child: Text(
                    "NO Data Found",
                    style: textStyleForMainProductName,
                  ),
                ),
              ),
      )),
    );
  }
}
