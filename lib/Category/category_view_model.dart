


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wg_garment/Api%20call/api_constant.dart';
import 'package:wg_garment/Api%20call/api_service.dart';
import 'package:wg_garment/Category/category_model.dart';
import 'package:wg_garment/Home/home_model.dart';
import 'package:wg_garment/Product%20List/product_list.dart';
import 'package:wg_garment/Product%20List/product_list_view_model.dart';
import 'package:wg_garment/Sub%20Category/subcategory_view_model.dart';
import 'package:wg_garment/Sub%20Category/subcategorylist.dart';

class CategoryViewModel extends ChangeNotifier {

  List<CategoryData> category_list = [];
  List<SubCategory> subCategory_list =[];
  int isSelected = 1;

  String selectedSubCatID = "";


  void navigateToProductListing(BuildContext context) async {    

    Provider.of<ProductListViewModel>(context, listen: false).setcategoryId(selectedSubCatID);


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
  }

    void navigateToSubCat(String catID, int index,BuildContext context) async {   

    var subCategorylist = category_list[index].subCategory ?? [];

    if (subCategorylist.length == 0){

    Provider.of<ProductListViewModel>(context, listen: false).setcategoryId(catID);
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
    }else{
        Provider.of<SubcategoryViewModel>(context, listen: false).setSubcatList(subCategorylist);
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
  

   void getsubCategoryList(int index){
      isSelected = index;
      subCategory_list = category_list[index].subCategory ?? [];
      print("subcategory count :${subCategory_list.length}");
      notifyListeners();
   }



  Future<CategoryModel?> getcategoryList() async {
      try {
        var response = await ApiServices().postApiCall(
          {},
          ApiConstant.categorylistUrl);

      print("Response Type: ${response.runtimeType}");
      var category_model = categoryModelFromJson(response);
      category_list = category_model.responseData ?? [];
      getsubCategoryList(0);
      print("category count :${category_list.length}");
      notifyListeners();
      return category_model;
      } catch (error) {
          print("Error: $error");
          notifyListeners();
          return null;
      }
  }
  
}