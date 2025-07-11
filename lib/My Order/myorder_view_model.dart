import 'package:flutter/material.dart';
//import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wg_garment/Add%20Edit%20Address/addeditaddress.dart';
import 'package:wg_garment/Address%20List/address_model.dart';
import 'package:wg_garment/Api%20call/api_constant.dart';
import 'package:wg_garment/Api%20call/api_service.dart';
import 'package:wg_garment/Home/home_model.dart';
import 'package:wg_garment/My%20Order/myorder_model.dart';

class MyorderViewModel extends ChangeNotifier {
  
   List<OrderDetailsData> orderList = [];

    Future<OrderListModel?> getOrderList() async {
    final prefs = await SharedPreferences.getInstance();
    String? userID = prefs.getString("userID");

    try {
      var response = await ApiServices()
          .postApiCall({"userId": userID}, ApiConstant.orderlist);

      print("Response Type: ${response.runtimeType}");
      var _responseData = orderListModelFromJson(response);
      orderList = _responseData.responseData ?? [];

      notifyListeners();
      return _responseData;
    } catch (error) {
      print("Error: $error");
      notifyListeners();
      return null;
    }
  }
}