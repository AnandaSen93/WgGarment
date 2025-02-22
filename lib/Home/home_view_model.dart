import 'package:flutter/material.dart';
import 'package:wg_garment/Api%20call/api_constant.dart';
import 'package:wg_garment/Api%20call/api_service.dart';
import 'package:wg_garment/Home/home_model.dart';

class HomeViewModel extends ChangeNotifier {
  HomeModel homeModel = HomeModel();
  List<BannerClass> topbanner = [];
  List<Category> topCategory = [];
  List<Product> newArrival = [];
  List<Product> mostWanted = [];
  List<Product> backInaStack = [];

  List<BannerClass> allBanner = [];

  Future<HomeModel?> homeApiCall() async {
    try {
      final response = await ApiServices().postApiCall(
          {"userId": "1", "deviceToken": "", "deviceType": "I"},
          ApiConstant.homeUrl);

      print("Response Type: ${response.runtimeType}");
      homeModel = homeModelFromJson(response);
      topbanner = homeModel.responseData?.slidingBanner ?? [];
      topCategory = homeModel.responseData?.category ?? [];
      newArrival = homeModel.responseData?.newArrival ?? [];
      allBanner = homeModel.responseData?.normalBanner ?? [];
      mostWanted = homeModel.responseData?.mostWanted ?? [];
      backInaStack = homeModel.responseData?.backInStock ?? [];

      print("allBanner: ${newArrival}");
      notifyListeners();
      return HomeModel();
    } catch (error) {
      print("Error: $error");
      notifyListeners();
      return null;
    }
  }

  Future<NormalModel?> addRemoveWishlistApiCall(String productID) async {
    try {
      final response = await ApiServices().postApiCall(
          {"userId": "1", "productId": productID}, ApiConstant.addremovewishlistUrl);
          print("Response : ${response.runtimeType}");

          var normalData = normalModelFromJson(response);
          print(normalData.responseText);
         
          await homeApiCall();
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
