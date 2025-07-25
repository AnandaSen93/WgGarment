import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:wg_garment/Api%20call/imageClass.dart';
import 'package:wg_garment/Config/colors.dart';
import 'package:wg_garment/Config/textstyle.dart';
import 'package:wg_garment/Login/login.dart';
import 'package:wg_garment/Product%20List/product_list_view_model.dart';

class ProductListView extends StatefulWidget {
  //final String catID;
  //ProductListView({required this.catID});

  const ProductListView({super.key});

  @override
  State<ProductListView> createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  RangeValues _selectedRange = RangeValues(500, 5000);
  String dropdownvalue = 'Newest';
  var dropdownItems = ["Price Low To Hight", "Price Hight To Low", "Newest"];

  bool _isInitialized = false;
  late ProductListViewModel _viewModel;

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
      _viewModel = Provider.of<ProductListViewModel>(context, listen: false);

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



  void _showRangeSliderDialog() {
    RangeValues tempRange = _selectedRange; // ✅ Store temporary range

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          // ✅ Make the dialog stateful
          builder: (context, setStateDialog) {
            // setStateDialog updates dialog UI
            return AlertDialog(
              title: Text("Select Price Range"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                      "Selected price Range: ${tempRange.start.round()} - ${tempRange.end.round()}"),
                  RangeSlider(
                    values: tempRange,
                    min: 0,
                    max: 10000,
                    divisions: 500,
                    activeColor: pinkcolor,
                    inactiveColor: Colors.grey,
                    labels: RangeLabels(
                      tempRange.start.round().toString(),
                      tempRange.end.round().toString(),
                    ),
                    onChanged: (RangeValues values) {
                      setStateDialog(() {
                        // ✅ Update only the dialog UI
                        tempRange = values;
                      });
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () =>
                      Navigator.pop(context), // ❌ Close without saving
                  child: Text(
                    "Cancel",
                    style: textStyleForredText,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      // ✅ Update main UI after dialog closes
                      _selectedRange = tempRange;
                    });
                    Navigator.pop(context);

                    _viewModel.lowerPrice = _selectedRange.start.toString();
                    _viewModel.upperPrice = _selectedRange.end.toString();
                    _viewModel.productListApi();
                  },
                  child: Text(
                    "Done",
                    style: textStyleForredText,
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }



    void loginAlert() {
    Alert(
      context: context,
      type: AlertType
          .none, // You can change the type (success, error, info, etc.)
      title: "Login or Sign Up Required",
      desc:
          "You need to be logged in to use this feature. Please login or create a new account to continue.",
      buttons: [
        DialogButton(
          child: Text(
            "Yes",
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
          onPressed: () async {
            Navigator.pop(context);
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoginView(),
              ),
            );
          },
          color: Colors.white,
        ),
        DialogButton(
          child: Text(
            "No",
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
          onPressed: () {
            Navigator.pop(context);
            print("No");
          
          },
          color: Colors.white,
        )
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    final productListViewModel = Provider.of<ProductListViewModel>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return PlatformScaffold(
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.only(left: 10, right: 10),
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
            Container(
              color: Colors.transparent,
              height: 40,
              child: Row(
                children: [
                  SizedBox(width: 5),
                  GestureDetector(
                    onTap: _showRangeSliderDialog,
                    child: Container(
                        height: double.infinity,
                        width: screenWidth * 0.45,
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 5),
                            Icon(Icons.sort),
                            Spacer(),
                            Text(
                              "Sort",
                              style: textStyleForCategorytName,
                            ),
                            Spacer(),
                            Icon(Icons.arrow_drop_down),
                          ],
                        )),
                  ),
                  Spacer(),
                  Container(
                      height: double.infinity,
                      width: screenWidth * 0.45,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: EdgeInsets.only(left: 10, right: 5),
                      child: Material(
                        child: DropdownButton(
                            isExpanded: true,
                            value: dropdownvalue,
                            items: dropdownItems
                                .map(
                                  (e) => DropdownMenuItem(
                                      child: Text(
                                        e,
                                        style: textStyleForTextField,
                                        maxLines: 1,
                                      ),
                                      value: e),
                                )
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                dropdownvalue = value.toString();
                                productListViewModel.sortBy = value.toString();
                                productListViewModel.productListApi();
                              });
                            }),
                      )

                      // Row(
                      //   children: [
                      //     SizedBox(width: 5),
                      //     Icon(Icons.sort),
                      //     Text(
                      //       "Filter     ",
                      //       style: textStyleForCategorytName,
                      //     ),
                      //     Icon(Icons.arrow_drop_down),
                      //   ],
                      // )

                      ),
                  SizedBox(width: 5),
                ],
              ),
            ),
            SizedBox(height: 15),
            (productListViewModel.productList.length != 0)
                ? Expanded(
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Number of columns
                          crossAxisSpacing: 8, // Horizontal spacing
                          mainAxisSpacing: 8, // Vertical spacing
                          childAspectRatio: 0.5, // Makes items square
                        ),
                        itemCount: productListViewModel.productList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              productListViewModel.navigateToProductDetails(
                                  productListViewModel
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
                                          imageUrl: productListViewModel
                                              .productList[index].productImage
                                              .toString(),
                                          height: double.infinity,
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          right: 0,
                                          child: IconButton(
                                            icon: Image.asset(
                                              (productListViewModel
                                                          .productList[index]
                                                          .isWishlist
                                                          .toString() !=
                                                      "1")
                                                  ? "assets/images/dislike.png"
                                                  : "assets/images/like.png", // Replace with your image path
                                              width: 30,
                                              height: 30,
                                            ),
                                            onPressed: () async{

                                                   if (await getLoginStatus()) {
                                                      productListViewModel.addRemoveWishlistApiCall(productListViewModel
                                                          .productList[index].productId ?? "");
                                                    } else {
                                                      loginAlert();
                                                    }
                                             
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
                                              productListViewModel
                                                  .productList[index]
                                                  .productName
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
                                                (productListViewModel
                                                                .productList[
                                                                    index]
                                                                .productSellPrice
                                                                .toString() !=
                                                            "" &&
                                                        productListViewModel
                                                                .productList[
                                                                    index]
                                                                .productSellPrice
                                                                .toString() !=
                                                            "0.00")
                                                    ? Text(currency +
                                                        productListViewModel
                                                            .productList[index]
                                                            .productSellPrice
                                                            .toString(),
                                                        style:
                                                            textStyleForMainPrice,
                                                        maxLines: 1,
                                                      )
                                                    : Text(currency +
                                                        productListViewModel
                                                            .productList[index]
                                                            .productOriginalPrice
                                                            .toString(),
                                                        style:
                                                            textStyleForMainPrice,
                                                        maxLines: 1),
                                                (productListViewModel
                                                                .productList[
                                                                    index]
                                                                .productSellPrice
                                                                .toString() ==
                                                            "" ||
                                                        productListViewModel
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
                                                        productListViewModel
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
                                          itemCount: productListViewModel
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
                                                          productListViewModel
                                                              .productList[
                                                                  index]
                                                              .colorList![
                                                                  index1]
                                                              .code
                                                              .toString(),
                                                        ),
                                                      ),
                                                    )),
                                              ),
                                            );
                                          }),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }))
                : Expanded(
                    child: Center(
                      child: Text(
                        "NO Data Found",
                        style: textStyleForMainProductName,
                      ),
                    ),
                  )
          ],
        ),
      )),
    );
  }
}
