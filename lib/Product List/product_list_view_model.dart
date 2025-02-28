import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wg_garment/Api%20call/api_constant.dart';
import 'package:wg_garment/Api%20call/api_service.dart';
import 'package:wg_garment/Product%20List/product_list_model.dart';

class ProductListViewModel extends ChangeNotifier {
  List<ProductListData> productList = [];
  var categoryId = '';
  var sortBy = '';
  var lowerPrice = '';
  var upperPrice = '';

  void clearData() {
    productList = [];
    categoryId = '';
    sortBy = '';
    lowerPrice = '';
    upperPrice = '';
  }

  void setcategoryId(String categoryID) {
    categoryId = categoryID;
    notifyListeners(); // Notify UI to update
  }

  Future<ProductListModel?> productListApi() async {
    final prefs = await SharedPreferences.getInstance();
    String? userID = prefs.getString("userID");

    print("userID: ${userID}");
    try {
      final response = await ApiServices().postApiCall({
        "userId": userID,
        "categoryId": categoryId,
        "sortBy": sortBy,
        "lowerPrice": lowerPrice,
        "upperPrice": upperPrice,
      }, ApiConstant.productllistingurl);

      print("Response Type: ${response.runtimeType}");
      var productListData = productListModelFromJson(response);
      productList = productListData.responseData ?? [];
      notifyListeners();
      return productListData;
    } catch (Error) {
      print("error: ${Error}");
      notifyListeners();
      return null;
    }
  }
}
