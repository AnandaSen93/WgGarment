

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wg_garment/Api%20call/api_constant.dart';
import 'package:wg_garment/Api%20call/api_service.dart';
import 'package:wg_garment/Home/home_model.dart';
import 'package:wg_garment/Product%20Details/product_details.dart';
import 'package:wg_garment/Product%20Details/product_details_view_model.dart';
import 'package:wg_garment/Product%20List/product_list_model.dart';
import 'package:wg_garment/WishList/wishList_model.dart';

class WishlistViewModel extends ChangeNotifier {

  List<ProductListData> wishListProduct = [];

  void clearData(){
    wishListProduct.clear();
    notifyListeners();
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

  Future<WishListModel?> wishListApi() async {
    
    final prefarence = await SharedPreferences.getInstance();
    String? userID = prefarence.getString("userID");

    try {
      final response = await ApiServices().postApiCall({
        "userId": userID
      }, ApiConstant.wishlistUrl);
      print("Response Type: ${response.runtimeType}");
      final _data = wishListModelFromJson(response);
      wishListProduct = _data.responseData ?? [];
      notifyListeners();
      return _data;      
    } catch (error) {
      print("Error:${error}");
      notifyListeners();
      return null;
    }

  }

    Future<NormalModel?> addRemoveWishlistApiCall(String productID) async {
     final prefs = await SharedPreferences.getInstance();
    String? userID = prefs.getString("userID");
    try {
      final response = await ApiServices().postApiCall(
          {"userId": userID, "productId": productID}, ApiConstant.addremovewishlistUrl);
          
          print("Response : ${response.runtimeType}");
          var normalData = normalModelFromJson(response);
          print(normalData.responseText);
         
          await wishListApi();
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