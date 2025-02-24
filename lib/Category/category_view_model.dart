

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:wg_garment/Api%20call/api_constant.dart';
import 'package:wg_garment/Api%20call/api_service.dart';
import 'package:wg_garment/Category/category_model.dart';

class CategoryViewModel extends ChangeNotifier {

  List<CategoryData> category_list = [];
  List<SubCategory> subCategory_list =[];
  int isSelected = 1;

   void getsubCategoryList(int index){
      isSelected = index;
      subCategory_list = category_list[index].subCategory ?? [];
      print("subcategory count :${subCategory_list.length}");
      notifyListeners();
   }



  Future<CategoryModel?> getcategoryList() async {
      try {
        final response = await ApiServices().postApiCall(
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