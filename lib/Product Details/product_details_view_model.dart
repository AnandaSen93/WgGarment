import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wg_garment/Api%20call/api_constant.dart';
import 'package:wg_garment/Api%20call/api_service.dart';
import 'package:wg_garment/Home/home_model.dart';
import 'package:wg_garment/Menu/menu.dart';
import 'package:wg_garment/Menu/menu_view_model.dart';
import 'package:wg_garment/Product%20Details/product_details_model.dart';
import 'package:wg_garment/Product%20List/product_list_model.dart';
import 'package:wg_garment/Review/reviewlist.dart';
import 'package:wg_garment/Review/reviewlist_view_model.dart';

class ProductDetailsViewModel extends ChangeNotifier {
  String productId = "";
  String isWishlist = "";
  List<ProductListData> similarProductlist = [];
  List<String> bannerImage = [];
  ProductData? productDetailsData;
  List<ColorListElement> colorList = [];
  List<ColorListElement> SizeList = [];

  String selectedColorId = "";
  String selecetedSizeId = "";
  String cartQuantity = "1";


  void clearData() {
    productId = "";
    similarProductlist.clear();
    bannerImage.clear();
    colorList.clear();
    SizeList.clear();
    productDetailsData = null;
    selectedColorId = '';
    selecetedSizeId = '';
    cartQuantity = '1';
  }


  void updateSelectedColorId(String ID) {
    selectedColorId = ID;
    notifyListeners();
  }

  void updateSelectedSizeId(String ID) {
    selecetedSizeId = ID;
    notifyListeners();
  }

  void updateQuantity(String quantity) {
    cartQuantity = quantity;
    notifyListeners();
  }

  void selectedProductID(String productID) {
    productId = productID;
    notifyListeners();
  }


  void setProductId(String productID) {
    productId = productID;
    notifyListeners(); // Notify UI to update
  }

    void navigateMainMenu(BuildContext context) async {
    Provider.of<MenuViewModel>(context, listen: false).setPageNav(3);

    // Push the second screen and pass the user data
    // final result = await Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => MenuView(),
    //   ),
    // );

      final result = Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => MenuView()),
      (Route<dynamic> route) => false,
    );


    // Handle the returned result (pop data)
    print("Received Data: $result");
    }

     void navigateToReviewPage(BuildContext context) async {    

    Provider.of<ReviewlistViewModel>(context, listen: false).setProductID(productId);

      print("Received Data:");
    // Push the second screen and pass the user data
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReviewListView(),
      ),
    );

    if (result != null) {
      // Handle the returned result (pop data)
      print("Received Data: $result");
    }
  }


  String checkValidation() {
    String str = "";
    if ((colorList.length != 0) && (SizeList.length != 0)) {
      if (selectedColorId == "") {
        str = "Please select color.";
      } else if (selecetedSizeId == "") {
        str = "Please select size.";
      } else if (cartQuantity == "") {
         str = "please add quantity";
      } else {
        str = "success";
      }
    } else if (colorList.length != 0) {
      if (selectedColorId == "") {
        str = "Please select color.";
      } else if (cartQuantity == "") {
         str = "please add quantity";
      } else {
        str = "success";
      }
    } else if (SizeList.length != 0) {
      if (selecetedSizeId == "") {
        str = "Please select size.";
      } else if (cartQuantity == "") {
        str = "please add quantity";
      } else {
        str = "success";
      }
    }

    return str;
  }

  Future<ProductDetailsModel?> productDetailsApi() async {
    final prefs = await SharedPreferences.getInstance();
    String? userID = prefs.getString("userID");

    print("userID: ${userID}");
    try {
      final response = await ApiServices().postApiCall({
        "userId": userID,
        "productId": productId,
      }, ApiConstant.productdetailsUrl);

      print("Response Type: ${response.runtimeType}");
      var _data = productDetailsModelFromJson(response);
      similarProductlist = _data.responseData?.similarProduct ?? [];
      productDetailsData = _data.responseData;
      bannerImage = productDetailsData?.productImageList ?? [];
      colorList = productDetailsData?.colorList ?? [];
      SizeList = productDetailsData?.sizeList ?? [];
      notifyListeners();
      return _data;
    } catch (Error) {
      print("error: ${Error}");
      notifyListeners();
      return null;
    }
  }

  Future<NormalModel?> addToCartApi() async {
    final prefs = await SharedPreferences.getInstance();
    String? userID = prefs.getString("userID");

    print("cartQuantity: ${cartQuantity}");
    try {
      final response = await ApiServices().postApiCall({
        "userId": userID,
        "productId": productId,
        "quantity": cartQuantity,
        "sizeId": selecetedSizeId,
        "colorId": selectedColorId,
        "sessionId": ""
      }, ApiConstant.addToCartUrl);

      print("Response Type: ${response.runtimeType}");
      var _data = normalModelFromJson(response);

      return _data;
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
          {"userId": userID, "productId": productID}, ApiConstant.addremovewishlistUrl);
          
          print("Response : ${response.runtimeType}");
          var normalData = normalModelFromJson(response);
          print(normalData.responseText);
         
          await productDetailsApi();
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
