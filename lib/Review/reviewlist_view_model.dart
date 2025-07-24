import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wg_garment/Api%20call/api_constant.dart';
import 'package:wg_garment/Api%20call/api_service.dart';
import 'package:wg_garment/Home/home_model.dart';
import 'package:wg_garment/Review/reviewlist_model.dart';

class ReviewlistViewModel extends ChangeNotifier {
  final TextEditingController commentsController = TextEditingController();
  String ratingValue = '1';
   String productId = '';
   List<ReviewDetails> reviewList = [];


   void setProductID(String proID){
    productId = proID;
    notifyListeners();
   }

   void clearData(){
    reviewList.clear();
    notifyListeners();
   }

    Future<ReviewListModel?> getReviewList() async {
    final prefs = await SharedPreferences.getInstance();
    String? userID = prefs.getString("userID");

    try {
      var response = await ApiServices()
          .postApiCall({
            "userId": userID,
            "productId":productId,
            }, ApiConstant.reviewlist);

      print("Response Type: ${response.runtimeType}");
      var _responseData = reviewListModelFromJson(response);
      reviewList = _responseData.responseData ?? [];

      notifyListeners();
      return _responseData;
    } catch (error) {
      print("Error: $error");
      notifyListeners();
      return null;
    }
  }

   Future<NormalModel?> addReview() async {
    final prefs = await SharedPreferences.getInstance();
    String? userID = prefs.getString("userID");

    try {
      var response = await ApiServices()
          .postApiCall({
            "userId": userID,
            "productId":productId,
            "review":commentsController.text,
            "rating":ratingValue
            }, ApiConstant.addreview);

      print("Response Type: ${response.runtimeType}");
      var _responseData = normalModelFromJson(response);  
      commentsController.clear();
      ratingValue = "1";
      getReviewList();   
      notifyListeners();
      return _responseData;
    } catch (error) {
      print("Error: $error");
      notifyListeners();
      return null;
    }
  }
  
}