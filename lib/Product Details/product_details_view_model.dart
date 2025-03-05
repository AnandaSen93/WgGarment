import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wg_garment/Api%20call/api_constant.dart';
import 'package:wg_garment/Api%20call/api_service.dart';
import 'package:wg_garment/Home/home_model.dart';
import 'package:wg_garment/Product%20Details/product_details_model.dart';
import 'package:wg_garment/Product%20List/product_list_model.dart';

class ProductDetailsViewModel extends ChangeNotifier {
  String productId = "";
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
    similarProductlist = [];
    bannerImage = [];
    colorList = [];
    SizeList = [];
    productDetailsData = null;
    selectedColorId = '';
    selecetedSizeId = '';
    cartQuantity = '';
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

    print("userID: ${userID}");
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
}
