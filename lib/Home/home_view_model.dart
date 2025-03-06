import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wg_garment/Api%20call/api_constant.dart';
import 'package:wg_garment/Api%20call/api_service.dart';
import 'package:wg_garment/Api%20call/loader.dart';
import 'package:wg_garment/Home/home_model.dart';
import 'package:wg_garment/Product%20Details/product_details.dart';
import 'package:wg_garment/Product%20Details/product_details_model.dart';
import 'package:wg_garment/Product%20Details/product_details_view_model.dart';

class HomeViewModel extends ChangeNotifier {
  HomeModel homeModel = HomeModel();
  List<BannerClass> topbanner = [];
  List<Category> topCategory = [];
  List<Product> newArrival = [];
  List<Product> mostWanted = [];
  List<Product> backInaStack = [];

  List<BannerClass> allBanner = [];


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



  Future<HomeModel?> homeApiCall() async {
    final prefs = await SharedPreferences.getInstance();
    String? userID = prefs.getString("userID");
    try {
      final response = await ApiServices().postApiCall(
          {"userId": userID, "deviceToken": "", "deviceType": "I"},
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
     final prefs = await SharedPreferences.getInstance();
    String? userID = prefs.getString("userID");
    try {
      final response = await ApiServices().postApiCall(
          {"userId": userID, "productId": productID}, ApiConstant.addremovewishlistUrl);
          
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
