

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wg_garment/Api%20call/api_constant.dart';
import 'package:wg_garment/Api%20call/api_service.dart';
import 'package:wg_garment/cart/cart_model.dart';

class CartViewModel extends ChangeNotifier {

List<CartProductData> cartList = [];
String totalPay = "";
String totalsave = "";

void clearData(){
   cartList = [];
}

String varientText(String size, String color){
  var str = "";
  if ((size == "") && (color == "")){
    str = "";
  }else if (size == ""){
    str = "Color : ${color}";
  }else if (color == ""){
       str = "Size : ${size}";
  }else{
     str = "Color : ${color}, Size : ${size} "; 
  }
   return str;
}

Future<CartListModel?> cartApicall() async{

  final prefarance = await SharedPreferences.getInstance();
  String? userID = prefarance.getString("userID");
    try {
    final response = await ApiServices().postApiCall({
      "userId":userID,
     "sessionId":""  
    }, ApiConstant.cartlistUrl);
    print("Response : ${response.runtimeType}");
    var cartData = cartListModelFromJson(response);
    cartList = cartData.responseData ?? [];
    totalPay = cartData.totalPrice.toString();
    totalsave = cartData.savePrice.toString();

    notifyListeners();
    return cartData;
  } catch (error) {
    print("Error:${error}");
    notifyListeners();
    return null;
  }
}



}