

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wg_garment/Api%20call/api_constant.dart';
import 'package:wg_garment/Api%20call/api_service.dart';
import 'package:wg_garment/Menu/menu_model.dart';

class MenuViewModel extends ChangeNotifier{

  String cartCount = "0";
  int selectedIndex = 0;


  void setPageNav(int value){
     selectedIndex = value;
     notifyListeners();
  }

  void clearData() {
  }

  Future<CountModel?> countApi() async{
    final prefs = await SharedPreferences.getInstance();
    String? userID = prefs.getString("userID");

    try {
      final response = await ApiServices().postApiCall({
        "userId": userID,
        "sessionId": "",        
      }, ApiConstant.countUrl);
      print("Response Type: ${response.runtimeType}");
      var countdata = countDataModelFromJson(response);
      cartCount = countdata.cartCount.toString();

      notifyListeners();
      return countdata;
    } catch (error) {
      return null;
    } 


  }
  
}