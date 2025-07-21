import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:wg_garment/Api%20call/imageClass.dart';
import 'package:wg_garment/Config/colors.dart';
import 'package:wg_garment/Config/textstyle.dart';
import 'package:wg_garment/WishList/wishlist_view_model.dart';

class WishlistView extends StatefulWidget {
  const WishlistView({super.key});

  @override
  State<WishlistView> createState() => _WishlistViewState();
}

class _WishlistViewState extends State<WishlistView> {
  

  late WishlistViewModel _viewModel;
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
      _viewModel = Provider.of<WishlistViewModel>(context, listen: false);

      final response = await _viewModel.wishListApi();
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

  @override
  Widget build(BuildContext context) {
    final wishlistViewModel = Provider.of<WishlistViewModel>(context);
    return PlatformScaffold(
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.all(5),
        child: GridView.builder(
            itemCount: wishlistViewModel.wishListProduct.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Number of columns
              crossAxisSpacing: 8, // Horizontal spacing
              mainAxisSpacing: 8, // Vertical spacing
              childAspectRatio: 0.5, // Makes items square
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: (){
                  wishlistViewModel.navigateToProductDetails(wishlistViewModel.wishListProduct[index].productId ?? "", context);
                },
                child: Container(
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      Container(
                        color: productbackgroundcolor,
                        child: AspectRatio(
                          aspectRatio: 0.65,
                          child: Stack(children: [
                            CustomNetworkImage(
                              imageUrl: wishlistViewModel
                                  .wishListProduct[index].productImage
                                  .toString(),
                              height: double.infinity,
                              width: double.infinity,
                            ),
                            Positioned(
                              top: 10,
                              right: 10,
                               child:
                              // IconButton(
                              //   icon: 
                                Image.asset(
                                  "assets/images/remove_cart.png", // Replace with your image path
                                  width: 30,
                                  height: 30,
                                ),
                              //   onPressed: () {
                              //     // Action when pressed
                              //     print("hello");
                
                              //     setState(() {});
                              //   },
                              // ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: IconButton(
                                icon: Image.asset(
                                  (wishlistViewModel.wishListProduct[index]
                                              .isWishlist !=
                                          "1")
                                      ? "assets/images/dislike.png"
                                      : "assets/images/like.png", // Replace with your image path
                                  width: 30,
                                  height: 30,
                                ),
                                onPressed: () {
                                  wishlistViewModel.addRemoveWishlistApiCall(wishlistViewModel.wishListProduct[index].productId ?? "");
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
                                  wishlistViewModel
                                      .wishListProduct[index].productName
                                      .toString(),
                                  style: textStyleForProductName,
                                ),
                              ),
                              AspectRatio(
                                aspectRatio: 1.5,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    (wishlistViewModel.wishListProduct[index]
                                                    .productSellPrice
                                                    .toString() !=
                                                "" &&
                                            wishlistViewModel
                                                    .wishListProduct[index]
                                                    .productSellPrice
                                                    .toString() !=
                                                "0.00")
                                        ? Text( currency + 
                                            wishlistViewModel
                                                .wishListProduct[index]
                                                .productSellPrice
                                                .toString(),
                                            style: textStyleForMainPrice,
                                            maxLines: 1,
                                          )
                                        : Text( currency +
                                            wishlistViewModel
                                                .wishListProduct[index]
                                                .productOriginalPrice
                                                .toString(),
                                            style: textStyleForMainPrice,
                                            maxLines: 1,
                                          ),
                                    (wishlistViewModel.wishListProduct[index]
                                                    .productSellPrice
                                                    .toString() ==
                                                "" ||
                                            wishlistViewModel
                                                    .wishListProduct[index]
                                                    .productSellPrice
                                                    .toString() !=
                                                "0.00")
                                        ? Text( 
                                            "",
                                            style: textStyleForCutPrice,
                                            maxLines: 1,
                                          )
                                        : Text( currency +
                                            wishlistViewModel
                                                .wishListProduct[index]
                                                .productOriginalPrice
                                                .toString(),
                                            style: textStyleForCutPrice,
                                            maxLines: 1,
                                          )
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
                              itemCount: wishlistViewModel.wishListProduct[index].colorList?.length,
                              itemBuilder: (context, index1) {
                                return Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: Container(
                                      padding: EdgeInsets.all(1),
                                      decoration: BoxDecoration(
                                        shape: BoxShape
                                            .circle, // Ensures circular border
                                        border: Border.all(
                                            color: Colors
                                                .black54, // Border color for selection
                                            width:
                                                1.0 // Border width when selected
                                            ),
                                      ),
                                      child: FittedBox(
                                        child: Icon(
                                          Icons.circle,
                                          //color: Colors.red,
                                          color: hexToColor(wishlistViewModel
                                              .wishListProduct[index]
                                              .colorList![index1]
                                              .code
                                              .toString()),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
      )),
    );
  }
}
