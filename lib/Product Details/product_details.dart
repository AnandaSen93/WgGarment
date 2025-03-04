import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';
import 'package:wg_garment/Config/colors.dart';
import 'package:wg_garment/Config/textstyle.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'dart:async';

import 'package:wg_garment/Product%20Details/product_details_view_model.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({super.key});

  get pages => null;

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  bool _isInitialized = false;
  PageController pageController = PageController();
  int currentPageIndex = 0;
  Timer? _timer;
  bool _like = true;
  var _selectedIndex = 0;

  int item_count = 1;

  var starArray = ["5", "4", "3", "2", "1"];

  var listForPageView = [
    "Description",
    "Highlights",
    "Material and Care",
    "Other Info"
  ];

  var list = [
    Image.asset(
      'assets/images/banner.png',
      fit: BoxFit.fill,
    ),
    Image.asset(
      'assets/images/banner.png',
      fit: BoxFit.fill,
    ),
    Image.asset(
      'assets/images/banner.png',
      fit: BoxFit.fill,
    ),
    Image.asset(
      'assets/images/banner.png',
      fit: BoxFit.fill,
    ),
    Image.asset(
      'assets/images/banner.png',
      fit: BoxFit.fill,
    ),
  ];

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    // _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    pageController.dispose();
    super.dispose();
  }



  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      Provider.of<ProductDetailsViewModel>(context, listen: false).productDetailsApi();
      _isInitialized = true; // Ensure it's called only once
    }
  }



  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      currentPageIndex = currentPageIndex + 1;
      if (currentPageIndex >= list.length) {
        currentPageIndex = 0;
      }
      // pageController.animateToPage(
      //   currentPageIndex,
      //   duration: Duration(milliseconds: 500),
      //   curve: Curves.easeIn,
      // );
    });
  }

  double getStringWidth(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(); // Lays out the text to calculate its size

    return textPainter.size.width; // Get the width
  }



  @override
  Widget build(BuildContext context) {
 final productDetailsViewModel = Provider.of<ProductDetailsViewModel>(context);

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return PlatformScaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Product image slider
                  Stack(children: [
                    AspectRatio(
                      aspectRatio: 2,
                      child: Container(
                        color: Colors.transparent,
                        child: PageView(
                          controller: pageController,
                          onPageChanged: (int index) {
                            setState(() {
                              currentPageIndex = index;
                            });
                          },
                          children: list,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 10,
                      child: SizedBox(
                        height: 40, // Give it a height
                        width: list.length * 20,
                        child: ListView.builder(
                          itemCount: list.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.symmetric(horizontal: 2),
                              child: Icon(
                                Icons.circle,
                                size: 10,
                                color: index == currentPageIndex
                                    ? Colors.red
                                    : Colors.grey,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Positioned(
                        top: 0,
                        right: 10,
                        child: IconButton(
                          onPressed: () {},
                          icon: Image.asset(
                            "assets/images/shareBtn.png", // Replace with your image path
                            width: 30,
                            height: 30,
                          ),
                        )),
                    Positioned(
                        bottom: 0,
                        right: 10,
                        child: IconButton(
                          onPressed: () {},
                          icon: Image.asset(
                            (productDetailsViewModel.productDetailsData?.isWishlist.toString() == "1")
                                ? "assets/images/dislike.png"
                                : "assets/images/like.png", // Replace with your image path
                            width: 30,
                            height: 30,
                          ),
                        )),
                  ]),
                  // Name and Price
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    height: 50,
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                          productDetailsViewModel.productDetailsData?.productName.toString() ?? "",
                          style: textStyleForProductName,
                        )),
                        AspectRatio(
                          aspectRatio: 1,
                          child: Container(
                            color: Colors.transparent,
                            alignment: Alignment.center,
                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  (productDetailsViewModel.productDetailsData
                                                              ?.productSellPrice
                                                              .toString() !=
                                                          "" && productDetailsViewModel.productDetailsData
                                                              ?.productSellPrice
                                                              .toString() !=
                                                          "0.00")
                                                      ? Text(
                                                          productDetailsViewModel
                                                              .productDetailsData
                                                              ?.productSellPrice
                                                              .toString() ?? "",
                                                          style:
                                                              textStyleForMainPrice,maxLines: 1,)
                                                      : Text(
                                                          productDetailsViewModel
                                                              .productDetailsData
                                                              ?.productOriginalPrice
                                                              .toString() ?? "",
                                                          style:
                                                              textStyleForMainPrice,maxLines: 1),
                                                  (productDetailsViewModel
                                                              .productDetailsData
                                                              ?.productSellPrice
                                                              .toString() ==
                                                          "" || productDetailsViewModel
                                                              .productDetailsData
                                                              ?.productSellPrice
                                                              .toString() ==
                                                          "0.00")
                                                      ? Text("",
                                                          style:
                                                              textStyleForCutPrice,maxLines: 1)
                                                      : Text(
                                                          productDetailsViewModel
                                                              .productDetailsData
                                                              ?.productOriginalPrice
                                                              .toString() ?? "",
                                                          style:
                                                              textStyleForCutPrice,maxLines: 1)
                                                ],
                                              )
                          ),
                        )
                      ],
                    ),
                  ),
                  // ratting and quantity
                  Container(
                    height: 40,
                    padding: EdgeInsets.only(left: 10, right: 10),
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        RatingBar.readOnly(
                          filledIcon: Icons.star,
                          emptyIcon: Icons.star_border,
                          initialRating: 4,
                          maxRating: 5,
                          size: 20,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "(15)",
                          style: textStyleForMainProductDescription,
                        ),
                        Spacer(),
                        AspectRatio(
                          aspectRatio: 3,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(
                                color: Colors.black,
                                width: 1.0,
                              ),
                            ),
                            child: Row(
                              children: [
                                AspectRatio(
                                  aspectRatio: 1,
                                  child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          if (item_count > 1) {
                                            item_count = (item_count - 1);
                                          }
                                        });
                                      },
                                      icon: Icon(Icons.remove)),
                                ),
                                Spacer(),
                                Text(
                                  "${item_count}",
                                  style: textStyleForCategorytName,
                                ),
                                Spacer(),
                                AspectRatio(
                                  aspectRatio: 1,
                                  child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          if (item_count < 10) {
                                            print("${item_count}");
                                            item_count = (item_count + 1);
                                          }
                                        });
                                      },
                                      icon: Icon(Icons.add)),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  // pageview
                  Container(
                      height: 40,
                      child: ListView.builder(
                          itemCount: listForPageView.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedIndex = index;
                                });
                              },
                              child: Container(
                                // padding: EdgeInsets.all(5),
                                color: Colors.transparent,
                                child: Column(
                                  children: [
                                    Text(
                                      " ${listForPageView[index]} ",
                                      style: textStyleForCategorytName,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      height: 1,
                                      width: (getStringWidth(
                                              listForPageView[index],
                                              textStyleForCategorytName) *
                                          1.2), // Height of the underline
                                      color: _selectedIndex == index
                                          ? Colors.black
                                          : Colors
                                              .black38, // Color of the underline
                                    )
                                  ],
                                ),
                              ),
                            );
                          })),
                  SizedBox(height: 15),
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Product Description",
                          style: textStyleForCategorytName2,
                        ),
                        SizedBox(height: 15),
                        Text(
                          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                          style: textStyleForMainProductDescription,
                        )
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 1,
                      color: Colors.black38,
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Reviews and Ratings",
                          style: textStyleForCategorytName2,
                        ),
                        SizedBox(height: 15),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black12,
                          ),
                          child: AspectRatio(
                            aspectRatio: 2,
                            child: Row(
                              children: [
                                AspectRatio(
                                  aspectRatio: 0.8,
                                  child: Container(
                                    color: Colors.transparent,
                                    padding: EdgeInsets.all(15),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Overall Rating",
                                            style: textStyleForCategorytName2),
                                        SizedBox(height: 15),
                                        Text("4.2/5", style: textstyleLarge),
                                        SizedBox(height: 5),
                                        RatingBar.readOnly(
                                          filledIcon: Icons.star,
                                          emptyIcon: Icons.star_border,
                                          initialRating: 4,
                                          maxRating: 5,
                                          size: 20,
                                        ),
                                        SizedBox(height: 5),
                                        Text("Based on 15 reviews",
                                            style: textstyleSmall),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: 15, right: 15, top: 25),
                                    child: Container(
                                      color: Colors.transparent,
                                      alignment: Alignment.center,
                                      child: ListView.builder(
                                          itemCount: starArray.length,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              padding:
                                                  EdgeInsets.only(bottom: 5),
                                              child: Row(
                                                children: [
                                                  SizedBox(width: 5),
                                                  Text(
                                                    starArray[index],
                                                    style:
                                                        textStyleForCategorytName,
                                                  ),
                                                  SizedBox(width: 5),
                                                  Icon(Icons.star,
                                                      size: 20,
                                                      color: Colors.amber),
                                                  SizedBox(width: 5),
                                                  Expanded(
                                                    child: Container(
                                                      height: 5,
                                                      child:
                                                          LinearProgressIndicator(
                                                        value: 0.5,
                                                        color: Colors.amber,
                                                        backgroundColor:
                                                            Colors.grey[200],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Text(
                                                    "${index}",
                                                    style:
                                                        textStyleForCategorytName,
                                                  ),
                                                  SizedBox(width: 5),
                                                ],
                                              ),
                                            );
                                          }),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        ListView.builder(
                          shrinkWrap:
                              true, // Ensures ListView takes up space only for its children
                          physics:
                              NeverScrollableScrollPhysics(), // Disables internal scrolling
                          itemCount: 2, // Number of items
                          itemBuilder: (context, index) {
                            return AspectRatio(
                              aspectRatio: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.black26,
                                      width: 1.0,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      AspectRatio(
                                          aspectRatio: 0.8,
                                          child: Container(
                                            padding: EdgeInsets.all(15),
                                            child: Container(
                                              padding: EdgeInsets.all(20),
                                              decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  shape: BoxShape.circle),
                                              child: ClipOval(
                                                child: AspectRatio(
                                                    aspectRatio: 1,
                                                    child: Image.asset(
                                                        "assets/images/product.png")),
                                              ),
                                            ),
                                          )),
                                      Expanded(
                                        child: Container(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Overall Rating",
                                                  style:
                                                      textStyleForCategorytName2),
                                              SizedBox(height: 5),
                                              RatingBar.readOnly(
                                                filledIcon: Icons.star,
                                                emptyIcon: Icons.star_border,
                                                initialRating: 4,
                                                maxRating: 5,
                                                size: 20,
                                              ),
                                              SizedBox(height: 5),
                                              Text(
                                                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been ",
                                                  style:
                                                      textStyleForProductName),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                            height: 50,
                            width: double.infinity,
                              child: TextButton(
                                  onPressed: () {
                                    debugPrint("Login tapped");
                                  },
                                  style: TextButton.styleFrom(
                                    backgroundColor:
                                        pinkcolor, // Button background color
                                    foregroundColor: Colors.white, // Text color
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 15),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          5.0), // Rounded corners
                                    ),
                                  ),
                                  child: Text("Add Review")),
                            ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 1,
                      color: Colors.black38,
                    ),
                  ),

                  Container(
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Similar Products ",
                              style: textStyleForHomePageHeading,
                            ),
                            Spacer(),
                            TextButton(
                                onPressed: () {},
                                child: Text(
                                  "View All",
                                  style: textStyleForViewAll,
                                ))
                          ],
                        ),
                        SizedBox(height: 10),
                        Container(
                          color: Colors.transparent,
                          height: screenWidth - 30,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 4,
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: EdgeInsets.only(right: 8),
                                  height: double.infinity,
                                  width: ((screenWidth / 2.07)),
                                  color: Colors.transparent,
                                  child: Column(
                                    children: [
                                      Container(
                                        color: productbackgroundcolor,
                                        child: AspectRatio(
                                          aspectRatio: 0.65,
                                          child: Stack(children: [
                                            Image.asset(
                                                'assets/images/product.png'),
                                            Positioned(
                                              bottom: 0,
                                              right: 0,
                                              child: IconButton(
                                                icon: Image.asset(
                                                  _like
                                                      ? "assets/images/dislike.png"
                                                      : "assets/images/like.png", // Replace with your image path
                                                  width: 30,
                                                  height: 30,
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
                                        ),
                                      ),
                                      Container(
                                        color: Colors.transparent,
                                        child: AspectRatio(
                                          aspectRatio: 4,
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  'Tristique Mauris Sollicitudin',
                                                  style:
                                                      textStyleForProductName,
                                                ),
                                              ),
                                              AspectRatio(
                                                aspectRatio: 1.5,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text('kr 40.00',
                                                        style:
                                                            textStyleForMainPrice),
                                                    Text('kr 55.00',
                                                        style:
                                                            textStyleForCutPrice)
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        color: Colors.transparent,
                                        child: AspectRatio(
                                          aspectRatio: 5,
                                          child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: 4,
                                              itemBuilder: (context, index) {
                                                return Icon(
                                                  Icons.circle,
                                                  size: 35,
                                                  color: Colors.red,
                                                );
                                              }),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 15),

                  Container(
                    padding: EdgeInsets.all(10),
                    child: SizedBox(
                        height: 50,
                        width: double.infinity,
                          child: TextButton(
                              onPressed: () {
                                debugPrint("Login tapped");
                              },
                              style: TextButton.styleFrom(
                                backgroundColor:
                                    pinkcolor, // Button background color
                                foregroundColor: Colors.white, // Text color
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      5.0), // Rounded corners
                                ),
                              ),
                              child: Text("Add To Cart")),
                        ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
              top: 0,
              left: 10,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Image.asset(
                  "assets/images/backBtn.png", // Replace with your image path
                  width: 30,
                  height: 30,
                ),
              )),
        ],
      )),
    );
  }
}
