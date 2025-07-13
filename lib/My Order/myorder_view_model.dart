import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wg_garment/Api%20call/api_constant.dart';
import 'package:wg_garment/Api%20call/api_service.dart';
import 'package:wg_garment/My%20Order/myorder_model.dart';
import 'package:wg_garment/Order%20Details/orderdetails_view_model.dart';
import 'package:wg_garment/Order%20Details/orerdetailsview.dart';

class MyorderViewModel extends ChangeNotifier {

  
   List<OrderDetailsData> orderList = [];


   void navigateToOrderDetails(String OrderID,BuildContext context) async {    

    Provider.of<OrderdetailsViewModel>(context, listen: false).selectedOrderID(OrderID);

      print("Received Data:");
    // Push the second screen and pass the user data
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrderDetailsView(),
      ),
    );

    if (result != null) {
      // Handle the returned result (pop data)
      print("Received Data: $result");
    }
  }

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