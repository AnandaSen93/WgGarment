import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wg_garment/Api%20call/api_constant.dart';
import 'package:wg_garment/Api%20call/api_service.dart';
import 'package:wg_garment/Order%20Details/orderdetails_model.dart';

class OrderdetailsViewModel extends ChangeNotifier {
  String orderID = '';

  List<OrderedProduct> orderProductList = [];

  OrderDetailsFullData?  ordreDetails = OrderDetailsFullData();

  void selectedOrderID(String ID) {
    print("Order ID: $orderID");
    orderID = ID;
    notifyListeners();
  }

      Future<OrderDetailsModel?> getOrderDetails() async {
    final prefs = await SharedPreferences.getInstance();
    String? userID = prefs.getString("userID");

    try {
      var response = await ApiServices()
          .postApiCall({
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
}
