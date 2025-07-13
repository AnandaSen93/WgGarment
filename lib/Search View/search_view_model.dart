
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wg_garment/Api%20call/api_constant.dart';
import 'package:wg_garment/Api%20call/api_service.dart';
import 'package:wg_garment/Product%20Details/product_details.dart';
import 'package:wg_garment/Product%20Details/product_details_view_model.dart';
import 'package:wg_garment/Product%20List/product_list_model.dart';
import 'package:wg_garment/Search%20View/search_model.dart';

class SearchViewModel extends ChangeNotifier {
  
  String searchText = '';
  List<ProductListData> productList = [];


  void clearData() {
    productList = [];
    searchText = '';
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


  void setSearchText(String searchTextInput) {
    searchText = searchTextInput;
    print(searchText);
    notifyListeners();
  }

    Future<SearchListModel?> searchTextApi() async {
       final prefs = await SharedPreferences.getInstance();
    String? userID = prefs.getString("userID");
    try {
      final response = await ApiServices().postApiCall({
        "userId": userID,
        "searchText": searchText,
        
      }, ApiConstant.searchList);

      print("Response Type: ${response.runtimeType}");
      var _response = searchListModelFromJson(response);
      productList = _response.responseData ?? [];
      notifyListeners();
      return _response;
    } catch (Error) {
      print("error: ${Error}");
      return null;
    }
  }

  
}