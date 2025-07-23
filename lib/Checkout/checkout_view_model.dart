import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wg_garment/Address%20List/address_model.dart';
import 'package:wg_garment/Address%20List/addresslist.dart';
import 'package:wg_garment/Address%20List/addresslist_view_model.dart';
import 'package:wg_garment/Api%20call/api_constant.dart';
import 'package:wg_garment/Api%20call/api_service.dart';
import 'package:wg_garment/Checkout/checkout_model.dart';
import 'package:wg_garment/Home/home_model.dart';
import 'package:wg_garment/Menu/menu.dart';
import 'package:wg_garment/Menu/menu_view_model.dart';

class CheckoutViewModel extends ChangeNotifier {
  final TextEditingController couponCodeController = TextEditingController();
  final TextEditingController commentController = TextEditingController();
  String couponText = '';
  String commetsText = '';

  String totalMRP = '0.0';
  String discountMRP = '0.0';
  String deliveryCharge = '10';
  String totalPayableAmount = '0.0';
  String cartIds = '';

  bool isCouponApply = false;

  AddressDetailsData shippingAddress = AddressDetailsData();
  AddressDetailsData billingAddress = AddressDetailsData();

  String adddressType = '';


  void clearData() {
    discountMRP = "0.0";
    deliveryCharge = "10";
    totalPayableAmount = "0.0";
    isCouponApply = false;
    couponCodeController.clear();
    commentController.clear();
    notifyListeners();
  }

  void navigateMainMenu(BuildContext context) async {
    Provider.of<MenuViewModel>(context, listen: false).setPageNav(4);

    // Push the second screen and pass the user data
    // final result = await Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => MenuView(),
    //   ),

    // );

    final result = Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => MenuView()),
      (Route<dynamic> route) => false,
    );

    // Handle the returned result (pop data)
    print("Received Data: $result");
    }

  void navigateToAddressPage(BuildContext context) async {
    Provider.of<AddresslistViewModel>(context, listen: false)
        .setAddressType(adddressType);

    // Push the second screen and pass the user data
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddresslistView(),
      ),
    );

    if (result != null) {
      // Handle the returned result (pop data)
      print("Received Data: $result");

      if (result['form'] == "shipping") {
        shippingAddress = result['address'];
      } else {
        billingAddress = result['address'];
      }
      notifyListeners();
    }
  }

  String checkValidation() {
    String str = "";
    if (shippingAddress.addressId == null) {
      str = "Please add your shipping address.";
    }else if (billingAddress.addressId == null) {
      str = "Please add your billing address.";
    } else {
      str = "success";
    }
    return str;
  }

  void setCartIdsAndPrice(String cartID, String totalMRPS) {
    cartIds = cartID;
    totalMRP = totalMRPS;
    print("totalMRP,$totalMRP");
    calculateTotalPayableAmount();
  }

  void setCouponCode(String couponTextValue) {
    couponText = couponTextValue;
    notifyListeners();
  }

  void setComments(String commetsText) {
    commetsText = commetsText;
    notifyListeners();
  }

  void intialDataApiCall() {
    getAddressList();
  }

  void removeCouponCode() {
    setCouponCode("");
    isCouponApply = false;
    discountMRP = "0.0";
    couponCodeController.clear();
    notifyListeners();
  }

  void calculateTotalPayableAmount() {
    // Parse strings to double safely
    print("totalMRP,$totalMRP");
    double total = double.tryParse(totalMRP) ?? 0.0;
    double discount = double.tryParse(discountMRP) ?? 0.0;
    double delivery = double.tryParse(deliveryCharge) ?? 0.0;

    // Calculate total payable amount
    double payable = total - discount + delivery;

    // Return formatted string (2 decimal places)
    totalPayableAmount = payable.toStringAsFixed(2);
    notifyListeners();
  }

  Future<CouponModel?> applyCouponCode() async {
    final prefs = await SharedPreferences.getInstance();
    String? userID = prefs.getString("userID");

    try {
      var response = await ApiServices().postApiCall({
        "userId": userID,
        "couponCode": couponText,
        "cartIds": cartIds,
      }, ApiConstant.applyCoupon);

      print("Response Type: ${response.runtimeType}");
      var _responseData = couponModelFromJson(response);
      var discountValue = _responseData.responseData ?? "";

      discountMRP = discountValue;

      if (_responseData.responseCode == 1) {
        isCouponApply = true;
      }

      calculateTotalPayableAmount();

      notifyListeners();
      return _responseData;
    } catch (error) {
      print("Error: $error");
      notifyListeners();
      return null;
    }
  }

  Future<AddressListModel?> getAddressList() async {
    final prefs = await SharedPreferences.getInstance();
    String? userID = prefs.getString("userID");

    try {
      var response = await ApiServices()
          .postApiCall({"userId": userID}, ApiConstant.addresslist);

      print("Response Type: ${response.runtimeType}");
      var _responseData = addressListModelFromJson(response);
      var addressList = _responseData.responseData ?? [];
      var defaultAddress = addressList.firstWhere(
        (address) => address.isDefault == "1",
        orElse: () => AddressDetailsData(addressId: ''),
      );

      if (defaultAddress.addressId!.isNotEmpty) {
        shippingAddress = defaultAddress;
        billingAddress = defaultAddress;
      } else {
        print("No Default Address Found");
      }

      notifyListeners();
      return _responseData;
    } catch (error) {
      print("Error: $error");
      notifyListeners();
      return null;
    }
  }

  Future<NormalModel?> placeOrder() async {
    final prefs = await SharedPreferences.getInstance();
    String? userID = prefs.getString("userID");

    try {
      var response = await ApiServices().postApiCall({
        "userId": userID,
        "shippingAddressId": shippingAddress.addressId ?? "",
        "cartIds": cartIds,
        "paymentMethod": "COD",
        "totalMRP": totalMRP,
        "discountMRP": discountMRP,
        "deliveryCharge": deliveryCharge,
        "totalPayableAmount": totalPayableAmount,
        "paymentAddressId": billingAddress.addressId ?? "",
        "couponCode": couponText,
        "comment": commetsText,
        "authorizationToken": "",
        "deviceToken": ""
      }, ApiConstant.placedorder);

      print("Response Type: ${response.runtimeType}");
      var _responseData = normalModelFromJson(response);

      notifyListeners();
      return _responseData;
    } catch (error) {
      print("Error: $error");
      notifyListeners();
      return null;
    }
  }
}


// couponCode:1111
// cartIds:"562"
// userId:3

// userId:3
// shippingAddressId:5
// cartIds:"192"
// paymentMethod:COD
// totalMRP:55.00
// discountMRP:00.00
// deliveryCharge:10.00
// totalPayableAmount:98.00
// paymentAddressId:5
// couponCode:
// comment:comment
// authorizationToken:TRN_7878787847
// deviceToken:

