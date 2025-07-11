import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:wg_garment/Checkout/checkout_model.dart';
import 'package:wg_garment/Checkout/checkout_view_model.dart';
import 'package:wg_garment/Config/colors.dart';
import 'package:wg_garment/Config/textstyle.dart';
import 'package:wg_garment/Home/home_model.dart';

class CheckOutView extends StatefulWidget {
  const CheckOutView({super.key});

  @override
  State<CheckOutView> createState() => _CheckOutViewState();
}

class _CheckOutViewState extends State<CheckOutView> {
  bool _isInitialized = false;
  late CheckoutViewModel _viewModel;
  @override
  void dispose() {
    _viewModel.clearData();
    super.dispose();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (!_isInitialized) {
      _viewModel = Provider.of<CheckoutViewModel>(context, listen: false);

      final response = await _viewModel.getAddressList();
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

  String dropdownvalue = 'COD';
  var dropdownItems = ["COD", "Online"];
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final checkoutViewModel = Provider.of<CheckoutViewModel>(context);

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    void _toggleKeyboard() {
      if (_focusNode.hasFocus) {
        _focusNode.unfocus(); // Hide keyboard
      } else {
        FocusScope.of(context).requestFocus(_focusNode); // Show keyboard
      }
    }

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
                SizedBox(width: 80),
                Image.asset(
                  'assets/images/app_logo.png',
                  fit: BoxFit.contain,
                ),
                Spacer()
              ],
            ),
          ),
          Text(
            "Checkout",
            style: textStyleForCategorytName2,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(right: 10, left: 10),
              child: Column(
                children: [
                  Container(
                    width: double.infinity, // Makes Container take full width
                    child: Text(
                      "Shipping Address",
                      textAlign: TextAlign.start, // Aligns text to start (left)
                      style: textStyleForCategorytName2,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black, // Black border color
                          width: 1.0, // Border width
                        ),
                        borderRadius: BorderRadius.circular(
                            0.0), // Optional: Rounded corners
                      ),
                      child: Container(
                        width: double.infinity,
                        child: Column(
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Spacer(),
                                  TextButton(
                                    onPressed: () {
                                      checkoutViewModel.adddressType =
                                          "shipping";
                                      checkoutViewModel
                                          .navigateToAddressPage(context);
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize
                                          .min, // Shrink to fit content
                                      children: [
                                        Image.asset(
                                          'assets/images/edit.png',
                                          width: 24,
                                          height: 24,
                                          color:
                                              pinkcolor, // Change to desired color
                                          colorBlendMode: BlendMode.srcIn,
                                        ),
                                        SizedBox(
                                            width:
                                                8), // Space between image and text
                                        Text("Change or add address",
                                            style: textStyleForredText),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/images/location.png',
                                    width: 30,
                                    height: 30,
                                    color: pinkcolor, // Change to desired color
                                    colorBlendMode: BlendMode.srcIn,
                                  ),
                                  Expanded(
                                    child:
                                        Text(
                                            (checkoutViewModel.shippingAddress.houseOne ?? "") +
                                                "," +
                                                (checkoutViewModel
                                                        .shippingAddress
                                                        .houseTwo ??
                                                    "") +
                                                "," +
                                                (checkoutViewModel
                                                        .shippingAddress.city ??
                                                    "") +
                                                "," +
                                                (checkoutViewModel
                                                        .shippingAddress
                                                        .state ??
                                                    "") +
                                                "," +
                                                (checkoutViewModel
                                                        .shippingAddress
                                                        .country ??
                                                    "") +
                                                "," +
                                                (checkoutViewModel
                                                        .shippingAddress
                                                        .pincode ??
                                                    ""),
                                            maxLines:
                                                3, // Limit lines (optional)
                                            overflow: TextOverflow.ellipsis,
                                            style: textStyleForredText),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    child: Text(
                      "Payment Address",
                      textAlign: TextAlign.start,
                      style: textStyleForCategorytName2,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black, // Black border color
                          width: 1.0, // Border width
                        ),
                        borderRadius: BorderRadius.circular(
                            0.0), // Optional: Rounded corners
                      ),
                      child: Container(
                        width: double.infinity,
                        child: Column(
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Spacer(),
                                  TextButton(
                                    onPressed: () {
                                      checkoutViewModel.adddressType = "billng";
                                      checkoutViewModel
                                          .navigateToAddressPage(context);
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize
                                          .min, // Shrink to fit content
                                      children: [
                                        Image.asset(
                                          'assets/images/edit.png',
                                          width: 24,
                                          height: 24,
                                          color:
                                              pinkcolor, // Change to desired color
                                          colorBlendMode: BlendMode.srcIn,
                                        ),
                                        SizedBox(
                                            width:
                                                8), // Space between image and text
                                        Text("Change or add address",
                                            style: textStyleForredText),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/images/location.png',
                                    width: 30,
                                    height: 30,
                                    color: pinkcolor, // Change to desired color
                                    colorBlendMode: BlendMode.srcIn,
                                  ),
                                  Expanded(
                                    child: Text(
                                        (checkoutViewModel.billingAddress.houseOne ?? "") +
                                            "," +
                                            (checkoutViewModel
                                                    .billingAddress.houseTwo ??
                                                "") +
                                            "," +
                                            (checkoutViewModel
                                                    .billingAddress.city ??
                                                "") +
                                            "," +
                                            (checkoutViewModel
                                                    .billingAddress.state ??
                                                "") +
                                            "," +
                                            (checkoutViewModel
                                                    .billingAddress.country ??
                                                "") +
                                            "," +
                                            (checkoutViewModel
                                                    .billingAddress.pincode ??
                                                ""),
                                        maxLines: 3, // Limit lines (optional)
                                        overflow: TextOverflow.ellipsis,
                                        style: textStyleForredText),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    child: Text(
                      "Payment Methods",
                      textAlign: TextAlign.start,
                      style: textStyleForCategorytName2,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black, // Black border color
                        width: 1.0, // Border width
                      ),
                      borderRadius: BorderRadius.circular(
                          0.0), // Optional: Rounded corners
                    ),
                    padding: EdgeInsets.only(left: 10, right: 10),
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
                            });
                          }),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    child: Text(
                      "Enter your coupon here",
                      textAlign: TextAlign.start,
                      style: textStyleForCategorytName2,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Row(
                      children: [
                        Flexible(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black, // Black border color
                                width: 1.0, // Border width
                              ),
                              borderRadius: BorderRadius.circular(
                                  0.0), // Optional: Rounded corners
                            ),
                            height: 50,
                            child: PlatformTextField(
                              controller:
                                  checkoutViewModel.couponCodeController,
                              onChanged: checkoutViewModel.setCouponCode,
                              keyboardType: TextInputType.emailAddress,
                              onSubmitted: (_) => _toggleKeyboard(),
                              hintText: 'Enter your coupon here',
                              cupertino: (context, platform) =>
                                  CupertinoTextFieldData(
                                decoration: BoxDecoration(
                                  color: Colors
                                      .transparent, // Remove background color for iOS
                                ),
                                // Optional: Custom padding
                                style: TextStyle(color: Colors.black),
                              ),
                              material: (context, platform) =>
                                  MaterialTextFieldData(
                                decoration: InputDecoration(
                                  filled:
                                      false, // Remove the background color for Android
                                  border:
                                      OutlineInputBorder(), // You can add a border if needed
                                  hintText:
                                      'Enter your coupon here', // Optional: hint text for Android
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Container(
                            // padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: pinkcolor,
                            ),
                            height: 50,
                            width: 100,
                            // color: lightgraykcolor,
                            child: TextButton(
                              onPressed: () async {
                                if (checkoutViewModel.isCouponApply) {
                                  checkoutViewModel.removeCouponCode();
                                } else {
                                  CouponModel? response =
                                      await checkoutViewModel.applyCouponCode();
                                  if (response != null) {
                                    Fluttertoast.showToast(
                                        msg: response.responseText ?? "");
                                  }
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    checkoutViewModel.isCouponApply
                                        ? "Remove"
                                        : "Apply",
                                    style: textStyleForButton,
                                  )
                                ],
                              ),
                            ))
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 30,
                  ),
                  // Container(
                  //   width: double.infinity,
                  //   child: Text(
                  //     "Payment Methods",
                  //     textAlign: TextAlign.center,
                  //     style: textStyleForCategorytName2,
                  //   ),
                  // ),

                  Container(
                    width: double.infinity,
                    child: Text(
                      "Add comments about your order",
                      textAlign: TextAlign.start,
                      style: textStyleForCategorytName2,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black, // Black border color
                        width: 1.0, // Border width
                      ),
                      borderRadius: BorderRadius.circular(
                          0.0), // Optional: Rounded corners
                    ),
                    width: double.infinity,
                    height: 100,
                    child: PlatformTextField(
                      // controller: _emailCon, // (Optional: TextEditingController, currently commented)
                      onChanged: checkoutViewModel
                          .setComments, // Called on text change
                      keyboardType: TextInputType.multiline,
                      minLines: 4, // Minimum height (optional)
                      maxLines: null,
                      onSubmitted: (_) =>
                          _toggleKeyboard(), // Keyboard optimized for name input
                      hintText:
                          'Add comments...', // Common hint text (can override per platform)

                      // iOS Specific Customization
                      cupertino: (context, platform) => CupertinoTextFieldData(
                        decoration: BoxDecoration(
                          color: Colors
                              .transparent, // No background color for iOS field
                        ),
                        style:
                            TextStyle(color: Colors.black), // Text color on iOS
                      ),

                      // Android Specific Customization
                      material: (context, platform) => MaterialTextFieldData(
                        decoration: InputDecoration(
                          filled: false, // No fill color
                          border:
                              OutlineInputBorder(), // Shows border around text field
                          hintText:
                              'Add comments...', // Hint text (optional, also passed above)
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black, // Black border color
                        width: 1.0, // Border width
                      ),
                      borderRadius: BorderRadius.circular(
                          0.0), // Optional: Rounded corners
                    ),
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: double.infinity,
                          child: Text("Price Details of products",
                              textAlign: TextAlign.start,
                              style: textStyleForTextField),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text("Total MRP:", style: textStyleForTextField),
                            Spacer(),
                            Text("\$" + checkoutViewModel.totalMRP,
                                style: textStyleForTextField)
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text("Discount on MRP:",
                                style: textStyleForTextField),
                            Spacer(),
                            Text(
                                "- \$" + (checkoutViewModel.discountMRP ?? "0"),
                                style: textStyleForTextField)
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text("Delivary Charge:",
                                style: textStyleForTextField),
                            Spacer(),
                            Text("\$" + checkoutViewModel.deliveryCharge,
                                style: textStyleForTextField)
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 1,
                          color: Colors.black,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text("Total Amount:", style: textStyleForTextField),
                            Spacer(),
                            Text("\$" + checkoutViewModel.totalPayableAmount,
                                style: textStyleForTextField)
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      // padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: pinkcolor,
                      ),
                      height: 50,
                      width: double.infinity,
                      // color: lightgraykcolor,
                      child: TextButton(
                        onPressed: () async {
                          if (checkoutViewModel.checkValidation() ==
                              "success") {
                            NormalModel? response =
                                await checkoutViewModel.placeOrder();
                            if (response != null) {
                              Fluttertoast.showToast(
                                  msg: response.responseText ?? "");
                              Future.delayed(Duration(seconds: 2), () {
                                checkoutViewModel.navigateMainMenu(context);
                              });
                            }
                          } else {
                            Fluttertoast.showToast(
                                msg: checkoutViewModel.checkValidation());
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Order Placed",
                              style: textStyleForButton,
                            )
                          ],
                        ),
                      ))
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
