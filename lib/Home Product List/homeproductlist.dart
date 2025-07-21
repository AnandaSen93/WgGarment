import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:wg_garment/Api%20call/imageClass.dart';
import 'package:wg_garment/Config/colors.dart';
import 'package:wg_garment/Config/textstyle.dart';
import 'package:wg_garment/Home%20Product%20List/homeproductlist_view_model.dart';

class HomeproductlistView extends StatefulWidget {
  const HomeproductlistView({super.key});

  @override
  State<HomeproductlistView> createState() => _HomeproductlistViewState();
}

class _HomeproductlistViewState extends State<HomeproductlistView> {
  bool _isInitialized = false;
  late HomeproductlistViewModel _viewModel;

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
      _viewModel =
          Provider.of<HomeproductlistViewModel>(context, listen: false);

      final response = await _viewModel.productListApi();
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
    final homeProductListViewModel =
        Provider.of<HomeproductlistViewModel>(context);
    return PlatformScaffold(
      body: SafeArea(
          child: Column(
        children: [
          Container(
            color: Colors.transparent,
            height: 60,
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios_new)),
                Spacer(),
                Image.asset(
                  'assets/images/app_logo.png',
                  fit: BoxFit.contain,
                ),
                Spacer()
              ],
            ),
          ),
          SizedBox(height: 15),
          (homeProductListViewModel.productList.length != 0)
              ? Expanded(
                  child: Container(
                  padding: EdgeInsets.all(10),
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Number of columns
                        crossAxisSpacing: 8, // Horizontal spacing
                        mainAxisSpacing: 8, // Vertical spacing
                        childAspectRatio: 0.5, // Makes items square
                      ),
                      itemCount: homeProductListViewModel.productList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            homeProductListViewModel.navigateToProductDetails(
                                homeProductListViewModel
                                        .productList[index].productId ??
                                    "",
                                context);
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
                                      //Image.network(productListViewModel.productList[index].productImage.toString()),
                                      CustomNetworkImage(
                                        imageUrl: homeProductListViewModel
                                            .productList[index].productImage
                                            .toString(),
                                        height: double.infinity,
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: IconButton(
                                          icon: Image.asset(
                                            (homeProductListViewModel
                                                        .productList[index]
                                                        .isWishlist
                                                        .toString() !=
                                                    "1")
                                                ? "assets/images/dislike.png"
                                                : "assets/images/like.png", // Replace with your image path
                                            width: 30,
                                            height: 30,
                                          ),
                                          onPressed: () {
                                            // Action when pressed
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
                                            homeProductListViewModel
                                                .productList[index].productName
                                                .toString(),
                                            style: textStyleForProductName,
                                            maxLines: 2,
                                          ),
                                        ),
                                        AspectRatio(
                                          aspectRatio: 1.5,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              (homeProductListViewModel
                                                              .productList[
                                                                  index]
                                                              .productSellPrice
                                                              .toString() !=
                                                          "" &&
                                                      homeProductListViewModel
                                                              .productList[
                                                                  index]
                                                              .productSellPrice
                                                              .toString() !=
                                                          "0.00")
                                                  ? Text(currency +
                                                      homeProductListViewModel
                                                          .productList[index]
                                                          .productSellPrice
                                                          .toString(),
                                                      style:
                                                          textStyleForMainPrice,
                                                      maxLines: 1,
                                                    )
                                                  : Text(currency +
                                                      homeProductListViewModel
                                                          .productList[index]
                                                          .productOriginalPrice
                                                          .toString(),
                                                      style:
                                                          textStyleForMainPrice,
                                                      maxLines: 1),
                                              (homeProductListViewModel
                                                              .productList[
                                                                  index]
                                                              .productSellPrice
                                                              .toString() ==
                                                          "" ||
                                                      homeProductListViewModel
                                                              .productList[
                                                                  index]
                                                              .productSellPrice
                                                              .toString() ==
                                                          "0.00")
                                                  ? Text("",
                                                      style:
                                                          textStyleForCutPrice,
                                                      maxLines: 1)
                                                  : Text(currency +
                                                      homeProductListViewModel
                                                          .productList[index]
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
                                        scrollDirection: Axis.horizontal,
                                        itemCount: homeProductListViewModel
                                                .productList[index]
                                                .colorList
                                                ?.length ??
                                            0,
                                        itemBuilder: (context, index1) {
                                          return Padding(
                                            padding: EdgeInsets.only(left: 5),
                                            child: AspectRatio(
                                              aspectRatio: 1,
                                              child: Container(
                                                  padding: EdgeInsets.all(3),
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
                                                  child: Container(
                                                    height: double.infinity,
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: hexToColor(
                                                          homeProductListViewModel
                                                              .productList[
                                                                  index]
                                                              .colorList![
                                                                  index1]
                                                              .code
                                                              .toString()),
                                                    ),
                                                  )

                                                  // FittedBox(
                                                  //   child: Icon(
                                                  //     Icons.circle,
                                                  //     //color: Colors.red,
                                                  //     color: hexToColor(
                                                  //               homeProductListViewModel
                                                  //                   .productList[index]
                                                  //                   .colorList![index1]
                                                  //                   .code
                                                  //                   .toString()),
                                                  //   ),
                                                  // ),

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
                ))
              : Expanded(
                  child: Center(
                    child: Text(
                      "NO Data Found",
                      style: textStyleForMainProductName,
                    ),
                  ),
                )
        ],
      )),
    );
  }
}
