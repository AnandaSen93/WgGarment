

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wg_garment/Api%20call/api_constant.dart';
import 'package:wg_garment/Api%20call/api_service.dart';
import 'package:wg_garment/Checkout/checkout.dart';
import 'package:wg_garment/Checkout/checkout_view_model.dart';
import 'package:wg_garment/Home/home_model.dart';
import 'package:wg_garment/cart/cart_model.dart';

class CartViewModel extends ChangeNotifier {

List<CartProductData> cartList = [];
String totalPay = "";
String totalsave = "";



void clearData(){
   cartList = [];
}




  void navigateToCheckOutView(BuildContext context) async {    

    String cartIds = cartList.map((item) => item.cartId.toString()).toList().join(',');

    Provider.of<CheckoutViewModel>(context, listen: false).setCartIdsAndPrice(cartIds, totalPay);


    // Push the second screen and pass the user data
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CheckOutView(),
      ),
    );

    if (result != null) {
      // Handle the returned result (pop data)
      print("Received Data: $result");
    }
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

Future<NormalModel?> addRemoveCartQuantityApicall(String cartID, String quantity,String valueInDe,String productId) async{

  final prefarance = await SharedPreferences.getInstance();
  String? userID = prefarance.getString("userID");
    try {
    final response = await ApiServices().postApiCall({
      "userId":userID,
       "sessionId":"",
       "cartId":cartID,
       "quantity":quantity,
       "value":valueInDe,
       "productId":productId
    }, ApiConstant.quantityaddremove);
    print("Response : ${response.runtimeType}");
    var deleteCartData = normalModelFromJson(response);
    totalPay = deleteCartData.responseText.toString();
    await cartApicall();
    notifyListeners();
    return deleteCartData;
  } catch (error) {
    print("Error:${error}");
    notifyListeners();
    return null;
  }
}


Future<NormalModel?> deleteCartApicall(String cartID) async{

  final prefarance = await SharedPreferences.getInstance();
  String? userID = prefarance.getString("userID");
    try {
    final response = await ApiServices().postApiCall({
      "userId":userID,
       "sessionId":"",
       "cartId":cartID  
    }, ApiConstant.deletecart);
    print("Response : ${response.runtimeType}");
    var deleteCartData = normalModelFromJson(response);
    totalPay = deleteCartData.responseText.toString();
    await cartApicall();
    notifyListeners();
    return deleteCartData;
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
         
          await cartApicall();
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