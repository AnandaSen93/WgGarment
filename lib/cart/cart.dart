import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:wg_garment/Config/colors.dart';
import 'package:wg_garment/Config/textstyle.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  bool _like = true;
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded(
                child: ListView.separated(
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
                            padding:
                                EdgeInsets.only(right: 10, top: 10, bottom: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                color: productbackgroundcolor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: AspectRatio(
                                  aspectRatio: 1,
                                  child:
                                      Image.asset("assets/images/product.png")),
                            ),
                          ),
                          Expanded(
                            child: Container(
                                padding: EdgeInsets.only(right: 10),
                                color: Colors.transparent,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Spacer(),
                                    Text(
                                      "Product Name",
                                      style: textStyleForMainProductName,
                                    ),
                                    Spacer(),
                                    Text(
                                      "Product DescriptionDescriptionDescriptionDescriptionDescription",
                                      style: textStyleForMainProductDescription,
                                      maxLines: 2,
                                    ),
                                    Spacer(),
                                    Text(
                                      "Product varient",
                                      style: textStyleForMainProductvarient,
                                      maxLines: 2,
                                    ),
                                    Spacer(),
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
                                            style: textStyleForMainProductName,
                                          ),
                                          AspectRatio(
                                            aspectRatio: 1,
                                            child: IconButton(
                                                onPressed: () {
                                                  print("remove");
                                                },
                                                icon: Icon(
                                                  Icons.remove_circle_outline,
                                                  color: pinkcolor,
                                                )),
                                          ),
                                          Text(
                                            "1",
                                            style: textStyleForMainPrice,
                                          ),
                                          AspectRatio(
                                            aspectRatio: 1,
                                            child: IconButton(
                                                onPressed: () {
                                                  print("add");
                                                },
                                                icon: Icon(
                                                    Icons.add_circle_outline,
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
                        onPressed: () {
                          // Action when pressed
                          print("delete");

                          setState(() {});
                        },
                      ),
                    ),
                    Positioned(
                      top: 10,
                      left: 0,
                      child: IconButton(
                        icon: Image.asset(
                          _like
                              ? "assets/images/dislike.png"
                              : "assets/images/like.png", // Replace with your image path
                          width: 25,
                          height: 25,
                        ),
                        onPressed: () {
                          // Action when pressed
                          print("hello");

                          setState(() {
                            _like = !_like;
                          });
                          print(
                              "Button Pressed: ${_like ? 'Liked' : 'Disliked'}");
                        },
                      ),
                    )
                  ]),
                );
              },
              itemCount: 10,
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
                    children: [
                      Text(
                        "Total Pay: \$500",
                        style: textStyleForCategorytName,
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Total Save: \$50",
                        style: textStyleForMainPrice,
                      )
                    ],
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      print("Tap on checkout");
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
        ),
      )),
    );
  }
}
