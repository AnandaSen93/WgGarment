import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:wg_garment/Api%20call/imageClass.dart';
import 'package:wg_garment/Config/colors.dart';
import 'package:wg_garment/Config/textstyle.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'dart:async';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:wg_garment/Home/home_model.dart';
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
  late ProductDetailsViewModel _viewModel;
  var listForPageView = [
    "Description",
    "Highlights",
    "Material and Care",
    "Other Info"
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
    _viewModel.clearData();
    super.dispose();
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    if (!_isInitialized) {
      _viewModel = Provider.of<ProductDetailsViewModel>(context, listen: false);

      final response = await _viewModel.productDetailsApi();
      if (response != null) {
        if (response.responseCode != 1) {
          Fluttertoast.showToast(msg: response.responseText ?? "");
        }
      } else {
        Fluttertoast.showToast(msg: "Somethings went wrong!");
      }

      _isInitialized = true; // Ensure it's called only once
    }
  }

  // void _startTimer() {
  //   _timer = Timer.periodic(Duration(seconds: 2), (timer) {
  //     currentPageIndex = currentPageIndex + 1;
  //     if (currentPageIndex >= list.length) {
  //       currentPageIndex = 0;
  //     }
  //   });
  // }

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
    final productDetailsViewModel =
        Provider.of<ProductDetailsViewModel>(context);

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
                        child: (productDetailsViewModel.bannerImage.length != 0)
                            ? ImageSlideshow(
                                indicatorColor: pinkcolor,
                                onPageChanged: (value) {},
                                autoPlayInterval: 3000,
                                isLoop: true,
                                children: productDetailsViewModel.bannerImage
                                        .map((imageUrl) {
                                      return ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: CustomNetworkImage(
                                          imageUrl: imageUrl
                                              .toString(), // Convert String to Widget
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: double.infinity,
                                        ),
                                      );
                                    }).toList() ??
                                    [],
                              )
                            : Container(
                                color: Colors.grey[300],
                                child: Center(
                                  child: Text(""),
                                ),
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
                          onPressed: () {
                            productDetailsViewModel.addRemoveWishlistApiCall(
                                productDetailsViewModel.productId);
                          },
                          icon: Image.asset(
                            (productDetailsViewModel
                                        .productDetailsData?.isWishlist
                                        .toString() ==
                                    "0")
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
                          productDetailsViewModel
                                  .productDetailsData?.productName
                                  .toString() ??
                              "",
                          style: textStyleForMainProductName,
                        )),
                        AspectRatio(
                          aspectRatio: 1,
                          child: Container(
                              color: Colors.transparent,
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  (productDetailsViewModel.productDetailsData
                                                  ?.productSellPrice
                                                  .toString() !=
                                              "" &&
                                          productDetailsViewModel
                                                  .productDetailsData
                                                  ?.productSellPrice
                                                  .toString() !=
                                              "0.00")
                                      ? Text(
                                          currency +
                                              (productDetailsViewModel
                                                      .productDetailsData
                                                      ?.productSellPrice
                                                      .toString() ??
                                                  ""),
                                          style: textStyleForMainPrice,
                                          maxLines: 1,
                                        )
                                      : Text(
                                          currency +
                                              (productDetailsViewModel
                                                      .productDetailsData
                                                      ?.productOriginalPrice
                                                      .toString() ??
                                                  ""),
                                          style: textStyleForMainPrice,
                                          maxLines: 1),
                                  (productDetailsViewModel.productDetailsData
                                                  ?.productSellPrice
                                                  .toString() ==
                                              "" ||
                                          productDetailsViewModel
                                                  .productDetailsData
                                                  ?.productSellPrice
                                                  .toString() ==
                                              "0.00")
                                      ? Text("",
                                          style: textStyleForCutPrice,
                                          maxLines: 1)
                                      : Text(
                                          currency +
                                              (productDetailsViewModel
                                                      .productDetailsData
                                                      ?.productOriginalPrice
                                                      .toString() ??
                                                  ""),
                                          style: textStyleForCutPrice,
                                          maxLines: 1)
                                ],
                              )),
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
                          emptyColor: pinkcolor,
                          filledColor: pinkcolor,
                          initialRating: ((productDetailsViewModel
                                          .productDetailsData?.productRating
                                          .toString() ??
                                      "0") !=
                                  "")
                              ? double.parse(productDetailsViewModel
                                      .productDetailsData?.productRating
                                      .toString() ??
                                  "0")
                              : 0,
                          maxRating: 5,
                          size: 20,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "(${productDetailsViewModel.productDetailsData?.productReviewCount.toString() ?? "0"})",
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
                                          } else {
                                            Fluttertoast.showToast(
                                                msg: "Minimum quantity: 1");
                                          }
                                        });
                                        productDetailsViewModel
                                            .updateQuantity("${item_count}");
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
                                          } else {
                                            Fluttertoast.showToast(
                                                msg: "Maximum quantity: 10");
                                          }
                                        });
                                        productDetailsViewModel
                                            .updateQuantity("${item_count}");
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
                  // Color and Size List

                  if (productDetailsViewModel.colorList.length != 0)
                    Container(
                        height: 50,
                        padding: EdgeInsets.only(left: 10, right: 10),
                        color: Colors.transparent,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Color:",
                              style: textStyleForMainProductName,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: Container(
                              width: double.infinity,
                              color: Colors.transparent,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      productDetailsViewModel.colorList.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                        onTap: () {
                                          productDetailsViewModel
                                              .updateSelectedColorId(
                                                  productDetailsViewModel
                                                      .colorList[index].valueId
                                                      .toString());
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape
                                                .circle, // Ensures circular border
                                            border: Border.all(
                                              color: (productDetailsViewModel
                                                          .selectedColorId ==
                                                      productDetailsViewModel
                                                          .colorList[index]
                                                          .valueId)
                                                  ? Colors.black
                                                  : Colors
                                                      .transparent, // Border color for selection
                                              width: (productDetailsViewModel
                                                          .selectedColorId ==
                                                      productDetailsViewModel
                                                          .colorList[index]
                                                          .valueId)
                                                  ? 1.0
                                                  : 0.0, // Border width when selected
                                            ),
                                          ),
                                          child: Icon(
                                            Icons.circle,
                                            size: 35,
                                            color: hexToColor(
                                                productDetailsViewModel
                                                    .colorList[index].code
                                                    .toString()),
                                          ),
                                        ));
                                  }),
                            ))
                          ],
                        )),

                  SizedBox(
                    height: 10,
                  ),
                  if (productDetailsViewModel.SizeList.length != 0)
                    Container(
                        height: 40,
                        padding: EdgeInsets.only(left: 10, right: 10),
                        color: Colors.transparent,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Size:",
                              style: textStyleForMainProductName,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: Container(
                              width: double.infinity,
                              color: Colors.transparent,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      productDetailsViewModel.SizeList.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        productDetailsViewModel
                                            .updateSelectedSizeId(
                                                productDetailsViewModel
                                                    .SizeList[index].valueId
                                                    .toString());
                                      },
                                      child: Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 8),
                                            decoration: BoxDecoration(
                                              color: (productDetailsViewModel
                                                          .selecetedSizeId ==
                                                      productDetailsViewModel
                                                          .SizeList[index]
                                                          .valueId)
                                                  ? Colors.black
                                                  : Colors
                                                      .white, // Background color
                                              borderRadius: BorderRadius.circular(
                                                  8), // Rounded corners (radius 2)
                                              border: Border.all(
                                                  color: Colors.black,
                                                  width:
                                                      1), // Border color & width
                                            ),
                                            child: Text(
                                              productDetailsViewModel
                                                  .SizeList[index].name
                                                  .toString(),
                                              style: (productDetailsViewModel
                                                          .selecetedSizeId ==
                                                      productDetailsViewModel
                                                          .SizeList[index]
                                                          .valueId)
                                                  ? textStyleForSelected
                                                  : textStyleForDeSelected,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          )
                                        ],
                                      ),
                                    );
                                  }),
                            ))
                          ],
                        )),

                  SizedBox(
                    height: 10,
                  ),

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
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          listForPageView[_selectedIndex],
                          style: textStyleForCategorytName2,
                        ),
                        SizedBox(height: 15),
                        Text(
                          decodeAndCleanHtml(
                            productDetailsViewModel
                                    .productDetailsData?.productDescription
                                    .toString() ??
                                "",
                          ),
                          style: textStyleForCategorytName,
                        )
                        // HtmlWidget(
                        //   productDetailsViewModel
                        //           .productDetailsData?.productDescription
                        //           .toString() ??
                        //       "",
                        //   textStyle: textStyleForCategorytName,
                        // )
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
                    padding: EdgeInsets.all(10),
                    child: SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: TextButton(
                          onPressed: () async {
                            if (productDetailsViewModel.checkValidation() ==
                                "success") {
                              NormalModel? response =
                                  await productDetailsViewModel.addToCartApi();
                              if (response?.responseCode == 1) {
                                setState(() {
                                  Fluttertoast.showToast(
                                      msg: response?.responseText ?? "");
                                  productDetailsViewModel
                                      .navigateMainMenu(context);
                                });
                              } else {
                                Fluttertoast.showToast(
                                    msg: response?.responseText ?? "");
                              }
                            } else {
                              setState(() {
                                Fluttertoast.showToast(
                                    msg: productDetailsViewModel
                                        .checkValidation());
                              });
                            }
                          },
                          style: TextButton.styleFrom(
                            backgroundColor:
                                pinkcolor, // Button background color
                            foregroundColor: Colors.white, // Text color
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(5.0), // Rounded corners
                            ),
                          ),
                          child: Text("Add To Cart")),
                    ),
                  ),
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
                                        Text(
                                            "${(productDetailsViewModel.productDetailsData?.productRating?.toString().isEmpty ?? true) ? "0" : productDetailsViewModel.productDetailsData?.productRating}/5",
                                            style: textstyleLarge),
                                        SizedBox(height: 5),
                                        RatingBar.readOnly(
                                          filledIcon: Icons.star,
                                          emptyIcon: Icons.star_border,
                                          filledColor: pinkcolor,
                                          emptyColor: pinkcolor,
                                          initialRating: double.tryParse(
                                                  productDetailsViewModel
                                                          .productDetailsData
                                                          ?.productRating ??
                                                      "0") ??
                                              0.0,
                                          maxRating: 5,
                                          size: 20,
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                            "Based on ${productDetailsViewModel.productDetailsData?.productReviewCount.toString() ?? ""} reviews",
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
                                      child: Column(
                                        children: [
                                          RatingSlideBar(
                                              ratingLabel: "5",
                                              progressValue: double.parse(
                                                  productDetailsViewModel
                                                          .productDetailsData
                                                          ?.ratingAll
                                                          ?.five ??
                                                      "0"),
                                              index: 0),
                                          RatingSlideBar(
                                              ratingLabel: "4",
                                              progressValue: double.parse(
                                                  productDetailsViewModel
                                                          .productDetailsData
                                                          ?.ratingAll
                                                          ?.four ??
                                                      "0"),
                                              index: 0),
                                          RatingSlideBar(
                                              ratingLabel: "3",
                                              progressValue: double.parse(
                                                  productDetailsViewModel
                                                          .productDetailsData
                                                          ?.ratingAll
                                                          ?.three ??
                                                      "0"),
                                              index: 0),
                                          RatingSlideBar(
                                              ratingLabel: "2",
                                              progressValue: double.parse(
                                                  productDetailsViewModel
                                                          .productDetailsData
                                                          ?.ratingAll
                                                          ?.two ??
                                                      "0"),
                                              index: 0),
                                          RatingSlideBar(
                                              ratingLabel: "1",
                                              progressValue: double.parse(
                                                  productDetailsViewModel
                                                          .productDetailsData
                                                          ?.ratingAll
                                                          ?.one ??
                                                      "0"),
                                              index: 0),
                                        ],
                                      ),
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
                        ListView.separated(
                          separatorBuilder: (context, index) {
                            return SizedBox(
                                height: 10); // Adds space between items
                          },
                          shrinkWrap:
                              true, // Ensures ListView takes up space only for its children
                          physics:
                              NeverScrollableScrollPhysics(), // Disables internal scrolling
                          itemCount: (productDetailsViewModel.productDetailsData
                                          ?.productReviewList?.length ??
                                      0) >
                                  2
                              ? 2
                              : productDetailsViewModel.productDetailsData
                                      ?.productReviewList?.length ??
                                  0, // Number of items
                          itemBuilder: (context, index) {
                            return Container(
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
                                  Container(
                                    padding: EdgeInsets.all(15),
                                    child: Container(
                                      // padding: EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          shape: BoxShape.circle),
                                      child: ClipOval(
                                        child: Container(
                                            height: 80,
                                            width: 80,
                                            child: CustomNetworkImage(
                                              imageUrl: productDetailsViewModel
                                                      .productDetailsData
                                                      ?.productReviewList?[
                                                          index]
                                                      .userImage
                                                      .toString() ??
                                                  "",
                                              height: double.infinity,
                                              width: double.infinity,
                                            )),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              productDetailsViewModel
                                                      .productDetailsData
                                                      ?.productReviewList?[
                                                          index]
                                                      .userName
                                                      .toString() ??
                                                  "",
                                              style:
                                                  textStyleForCategorytName2),
                                          SizedBox(height: 5),
                                          RatingBar.readOnly(
                                            filledIcon: Icons.star,
                                            emptyIcon: Icons.star_border,
                                            emptyColor: pinkcolor,
                                            filledColor: pinkcolor,
                                            initialRating: double.parse(
                                                productDetailsViewModel
                                                        .productDetailsData
                                                        ?.productReviewList?[
                                                            index]
                                                        .rating
                                                        .toString() ??
                                                    "0.0"),
                                            maxRating: 5,
                                            size: 20,
                                          ),
                                          SizedBox(height: 5),
                                          Container(
                                            padding: EdgeInsets.all(5),
                                            child: Text(
                                                productDetailsViewModel
                                                        .productDetailsData
                                                        ?.productReviewList?[
                                                            index]
                                                        .review
                                                        .toString() ??
                                                    "",
                                                style: textStyleForProductName),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 10),
                        // if (productDetailsViewModel
                        //         .productDetailsData?.isAlreadyBuy
                        //         .toString() ==
                        //     "1")
                        SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: TextButton(
                              onPressed: () {
                                productDetailsViewModel
                                    .navigateToReviewPage(context);
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

                  if (productDetailsViewModel.similarProductlist.length != 0)
                    Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Similar Products ",
                                style: textStyleForHomePageHeading,
                              ),
                              // Expanded(
                              //   child: TextButton(
                              //       onPressed: () {},
                              //       child: Text(
                              //         "View All",
                              //         style: textStyleForViewAll,
                              //       )),
                              // )
                            ],
                          ),
                          SizedBox(height: 10),
                          Container(
                            color: Colors.transparent,
                            height: screenWidth - 30,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: productDetailsViewModel
                                    .similarProductlist.length,
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
                                              CustomNetworkImage(
                                                imageUrl:
                                                    productDetailsViewModel
                                                        .similarProductlist[
                                                            index]
                                                        .productImage
                                                        .toString(),
                                                height: double.infinity,
                                                width: double.infinity,
                                              ),
                                              Positioned(
                                                bottom: 0,
                                                right: 0,
                                                child: IconButton(
                                                  icon: Image.asset(
                                                    productDetailsViewModel
                                                                .similarProductlist[
                                                                    index]
                                                                .isWishlist ==
                                                            "0"
                                                        ? "assets/images/dislike.png"
                                                        : "assets/images/like.png", // Replace with your image path
                                                    width: 30,
                                                    height: 30,
                                                  ),
                                                  onPressed: () {
                                                    // Action when pressed
                                                    print("hello");

                                                    productDetailsViewModel
                                                        .addRemoveWishlistApiCall(
                                                            productDetailsViewModel
                                                                .similarProductlist[
                                                                    index]
                                                                .productId
                                                                .toString());
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
                                                    productDetailsViewModel
                                                        .similarProductlist[
                                                            index]
                                                        .productName
                                                        .toString(),
                                                    style:
                                                        textStyleForProductName,
                                                  ),
                                                ),
                                                AspectRatio(
                                                  aspectRatio: 1.5,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      (productDetailsViewModel
                                                                      .similarProductlist[
                                                                          index]
                                                                      .productSellPrice
                                                                      .toString() !=
                                                                  "" &&
                                                              productDetailsViewModel
                                                                      .similarProductlist[
                                                                          index]
                                                                      .productSellPrice
                                                                      .toString() !=
                                                                  "0.00")
                                                          ? Text(
                                                              currency +
                                                                  productDetailsViewModel
                                                                      .similarProductlist[
                                                                          index]
                                                                      .productSellPrice
                                                                      .toString(),
                                                              style:
                                                                  textStyleForMainPrice,
                                                              maxLines: 1,
                                                            )
                                                          : Text(
                                                              currency +
                                                                  productDetailsViewModel
                                                                      .similarProductlist[
                                                                          index]
                                                                      .productOriginalPrice
                                                                      .toString(),
                                                              style:
                                                                  textStyleForMainPrice,
                                                              maxLines: 1),
                                                      (productDetailsViewModel
                                                                      .similarProductlist[
                                                                          index]
                                                                      .productSellPrice
                                                                      .toString() ==
                                                                  "" ||
                                                              productDetailsViewModel
                                                                      .similarProductlist[
                                                                          index]
                                                                      .productSellPrice
                                                                      .toString() ==
                                                                  "0.00")
                                                          ? Text("",
                                                              style:
                                                                  textStyleForCutPrice,
                                                              maxLines: 1)
                                                          : Text(
                                                              currency +
                                                                  productDetailsViewModel
                                                                      .similarProductlist[
                                                                          index]
                                                                      .productOriginalPrice
                                                                      .toString(),
                                                              style:
                                                                  textStyleForCutPrice,
                                                              maxLines: 1)
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
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount:
                                                    productDetailsViewModel
                                                            .similarProductlist[
                                                                index]
                                                            .colorList
                                                            ?.length ??
                                                        0,
                                                itemBuilder: (context, index1) {
                                                  return Icon(
                                                    Icons.circle,
                                                    size: 35,
                                                    color: hexToColor(
                                                        productDetailsViewModel
                                                            .similarProductlist[
                                                                index]
                                                            .colorList![index1]
                                                            .code
                                                            .toString()),
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

class RatingSlideBar extends StatelessWidget {
  final String ratingLabel;
  final double progressValue;
  final int index;

  const RatingSlideBar({
    Key? key,
    required this.ratingLabel,
    required this.progressValue,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          SizedBox(width: 5),
          Text(
            ratingLabel,
            style: textStyleForCategorytName,
          ),
          SizedBox(width: 5),
          Icon(Icons.star, size: 20, color: pinkcolor),
          SizedBox(width: 5),
          Expanded(
            child: Container(
              height: 5,
              child: LinearProgressIndicator(
                value: progressValue / 5, // Dynamic progress value
                color: pinkcolor,
                backgroundColor: Colors.grey[200],
              ),
            ),
          ),
          SizedBox(width: 10),
          Text(
            "$index",
            style: textStyleForCategorytName,
          ),
          SizedBox(width: 5),
        ],
      ),
    );
  }
}
