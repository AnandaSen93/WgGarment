import 'package:flutter/material.dart';
import 'package:wg_garment/Api%20call/api_constant.dart';
import 'package:wg_garment/Api%20call/api_service.dart';
import 'package:wg_garment/Slug%20Page/slug_model.dart';

class SlugViewModel extends ChangeNotifier {
  

   String pageID = '';
   String pageName = '';


    void setPageID(String _id){
      pageID = _id;
    }

  

  Future<SlugResponseModel?> slugpageURL() async {
      try {
      final response = await ApiServices().postApiCall({
        "pageId": pageID
      }, ApiConstant.slugpage);
      print("Response Type: ${response.runtimeType}");
      final _data = slugResponseModelFromJson(response);
     
      pageName = _data.responseData?.metaTitle ?? "";

      notifyListeners();
      return _data;      
    } catch (error) {
      print("Error:${error}");
      notifyListeners();
      return null;
    }

  }


}