import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wg_garment/Api%20call/api_constant.dart';
import 'package:wg_garment/Api%20call/api_service.dart';
import 'package:wg_garment/Home/home_model.dart';
import 'package:wg_garment/Menu/menu.dart';
import 'package:wg_garment/Menu/menu_view_model.dart';
import 'package:wg_garment/Order%20Details/orderdetails_model.dart';

class OrderdetailsViewModel extends ChangeNotifier {
  String orderID = '';

  List<OrderedProduct> orderProductList = [];

  OrderDetailsFullData? ordreDetails = OrderDetailsFullData();

  void selectedOrderID(String ID) {
    print("Order ID: $orderID");
    orderID = ID;
    notifyListeners();
  }

  Future<OrderDetailsModel?> getOrderDetails() async {
    final prefs = await SharedPreferences.getInstance();
    String? userID = prefs.getString("userID");

    try {
      var response = await ApiServices().postApiCall({
        "userId": userID,
        "orderId": orderID,
      }, ApiConstant.orderdetails);

      print("Response Type: ${response}");
      var _responseData = orderDetailsModelFromJson(response);
      ordreDetails = _responseData.responseData;
      orderProductList = _responseData.responseData?.product ?? [];

      notifyListeners();
      return _responseData;
    } catch (error) {
      print("Error: $error");
      notifyListeners();
      return null;
    }
  }

  Future<NormalModel?> cancelOrder() async {
    final prefs = await SharedPreferences.getInstance();
    String? userID = prefs.getString("userID");

    try {
      var response = await ApiServices().postApiCall({
        "userId": userID,
        "orderId": orderID,
        "deviceToken": "",
      }, ApiConstant.ordercancel);

      print("Response Type: ${response}");
      var _responseData = normalModelFromJson(response);

      notifyListeners();
      return _responseData;
    } catch (error) {
      print("Error: $error");
      notifyListeners();
      return null;
    }
  }

  Future<NormalModel?> reOrder() async {
    final prefs = await SharedPreferences.getInstance();
    String? userID = prefs.getString("userID");

    try {
      var response = await ApiServices().postApiCall({
        "userId": userID,
        "orderId": orderID,
        "deviceToken": "",
      }, ApiConstant.reorder);

      print("Response Type: ${response}");
      var _responseData = normalModelFromJson(response);

      notifyListeners();
      return _responseData;
    } catch (error) {
      print("Error: $error");
      notifyListeners();
      return null;
    }
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
}
