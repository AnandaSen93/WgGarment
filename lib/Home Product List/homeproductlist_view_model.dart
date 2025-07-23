import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wg_garment/Api%20call/api_constant.dart';
import 'package:wg_garment/Api%20call/api_service.dart';
import 'package:wg_garment/Home/home_model.dart';
import 'package:wg_garment/Product%20Details/product_details.dart';
import 'package:wg_garment/Product%20Details/product_details_view_model.dart';
import 'package:wg_garment/Product%20List/product_list_model.dart';

class HomeproductlistViewModel extends ChangeNotifier {
   List<ProductListData> productList = [];
  var listtype = '';

  void clearData() {
    productList = [];
    listtype = '';
    
  }

  void setListType(String value) {
    listtype = value;
    notifyListeners(); // Notify UI to update
  }

   void navigateToProductDetails(String ProductID,BuildContext context) async {    

    Provider.of<ProductDetailsViewModel>(context, listen: false).selectedProductID(ProductID);


    // Push the second screen and pass the user data
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailsView(),
      ),
    );

    if (result != null) {
      // Handle the returned result (pop data)
      print("Received Data: $result");
    }
  }

  Future<ProductListModel?> productListApi() async {
    final prefs = await SharedPreferences.getInstance();
    String? userID = prefs.getString("userID");

    print("userID: ${userID}");
    try {
      final response = await ApiServices().postApiCall({
        "userId": userID,
        "get":listtype,
      }, ApiConstant.homeProductList);

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


  Future<NormalModel?> addRemoveWishlistApiCall(String productID) async {
    final prefs = await SharedPreferences.getInstance();
    String? userID = prefs.getString("userID");
    try {
      final response = await ApiServices().postApiCall(
          {"userId": userID, "productId": productID},
          ApiConstant.addremovewishlistUrl);

      print("Response : ${response.runtimeType}");
      var normalData = normalModelFromJson(response);
      print(normalData.responseText);

      await productListApi();
      //notifyListeners();
      print("homeApiCall() executed successfully!");
      return normalData;
    } catch (error, stackTrace) {
      print("Error in addRemoveWishlistApiCall: $error");
      print(stackTrace);
      return null;
    } // Log the full stack trace for debugging
  }
  
}