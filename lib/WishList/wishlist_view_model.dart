

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wg_garment/Api%20call/api_constant.dart';
import 'package:wg_garment/Api%20call/api_service.dart';
import 'package:wg_garment/Product%20List/product_list_model.dart';
import 'package:wg_garment/WishList/wishList_model.dart';

class WishlistViewModel extends ChangeNotifier {

  List<ProductListData> wishListProduct = [];

  void clearData(){
    wishListProduct = [];
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
  
}