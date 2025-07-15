import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wg_garment/Api%20call/api_constant.dart';
import 'package:wg_garment/Api%20call/api_service.dart';
import 'package:wg_garment/Category/categorylist.dart';
import 'package:wg_garment/Home%20Product%20List/homeproductlist.dart';
import 'package:wg_garment/Home%20Product%20List/homeproductlist_view_model.dart';
import 'package:wg_garment/Home/home_model.dart';
import 'package:wg_garment/Product%20Details/product_details.dart';
import 'package:wg_garment/Product%20Details/product_details_view_model.dart';
import 'package:wg_garment/Product%20List/product_list.dart';
import 'package:wg_garment/Product%20List/product_list_view_model.dart';
import 'package:wg_garment/Search%20View/search.dart';
import 'package:wg_garment/Sub%20Category/subcategory_view_model.dart';
import 'package:wg_garment/Sub%20Category/subcategorylist.dart';

class HomeViewModel extends ChangeNotifier {
  HomeModel homeModel = HomeModel();
  List<BannerClass> topbanner = [];
  List<Category> topCategory = [];
  List<Product> newArrival = [];
  List<Product> mostWanted = [];
  List<Product> backInaStack = [];

  List<BannerClass> allBanner = [];

  void navigateToProductDetails(String ProductID, BuildContext context) async {
    Provider.of<ProductDetailsViewModel>(context, listen: false)
        .selectedProductID(ProductID);
    // Push the second screen and pass the user data
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailsView(),
      ),
    ).then((_) {
      // Refresh after coming back
    });
    ;

    if (result != null) {
      // Handle the returned result (pop data)
      print("Received Data: $result");
    }
  }

  void navigateToSubCat(String catID, int index, BuildContext context) async {
    var subCategory_list = topCategory[index].subCategory ?? [];

    if (subCategory_list.length == 0) {
      Provider.of<ProductListViewModel>(context, listen: false)
          .setcategoryId(catID);
      // Push the second screen and pass the user data
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductListView(),
        ),
      );

      if (result != null) {
        // Handle the returned result (pop data)
        print("Received Data: $result");
      }
    } else {
      Provider.of<SubcategoryViewModel>(context, listen: false)
          .setSubcatList(subCategory_list);
      // Push the second screen and pass the user data
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SubCategoryView(),
        ),
      );

      if (result != null) {
        // Handle the returned result (pop data)
        print("Received Data: $result");
      }
    }
  }

  void navigateToHomeProductList(String type,BuildContext context) async {
     Provider.of<HomeproductlistViewModel>(context, listen: false).setListType(type);

    // Push the second screen and pass the user data
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomeproductlistView(),
      ),
    ).then((_) {
      // Refresh after coming back
    });
    ;

    if (result != null) {
      // Handle the returned result (pop data)
      print("Received Data: $result");
    }
  }

  void navigateToCategoryList(BuildContext context) async {
    // Provider.of<ProductDetailsViewModel>(context, listen: false).selectedProductID(ProductID);

    // Push the second screen and pass the user data
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryListView(),
      ),
    ).then((_) {
      // Refresh after coming back
    });
    ;

    if (result != null) {
      // Handle the returned result (pop data)
      print("Received Data: $result");
    }
  }

  void navigateToSearchage(BuildContext context) async {
    // Provider.of<ProductDetailsViewModel>(context, listen: false).selectedProductID(ProductID);

    // Push the second screen and pass the user data
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchView(),
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
          {"userId": userID, "productId": productID},
          ApiConstant.addremovewishlistUrl);

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
