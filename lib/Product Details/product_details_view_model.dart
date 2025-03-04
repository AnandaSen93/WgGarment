
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wg_garment/Api%20call/api_constant.dart';
import 'package:wg_garment/Api%20call/api_service.dart';
import 'package:wg_garment/Product%20Details/product_details_model.dart';
import 'package:wg_garment/Product%20List/product_list_model.dart';

class ProductDetailsViewModel extends ChangeNotifier {
  
  String productId = "";
  List<ProductListData> similarProductlist = [];
  ProductData? productDetailsData;

  void selectedProductID(String productID){
    productId = productID;
    notifyListeners();
  }
  


void clearData() {    
    productId = '';    
  }

  void setProductId(String productID) {
    productId = productID;
    notifyListeners(); // Notify UI to update
  }

  Future<ProductDetailsModel?> productDetailsApi() async {
    final prefs = await SharedPreferences.getInstance();
    String? userID = prefs.getString("userID");

    print("userID: ${userID}");
    try {
      final response = await ApiServices().postApiCall({
        "userId": userID,
        "productId": productId,
      }, ApiConstant.profiledetailsUrl);

      print("Response Type: ${response.runtimeType}");
      var productDetailsData = productDetailsModelFromJson(response);
      similarProductlist = productDetailsData.responseData?.similarProduct ?? [];
      productDetailsData = productDetailsData;
      notifyListeners();
      return productDetailsData;
    } catch (Error) {
      print("error: ${Error}");
      notifyListeners();
      return null;
    }
  }
}