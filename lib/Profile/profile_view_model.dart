import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wg_garment/Address%20List/addresslist.dart';
import 'package:wg_garment/Api%20call/api_constant.dart';
import 'package:wg_garment/Api%20call/api_service.dart';
import 'package:wg_garment/Change%20Password/changepassword.dart';
import 'package:wg_garment/Edit%20Profile/editprofile.dart';
import 'package:wg_garment/Home/home_model.dart';
import 'package:wg_garment/Login/login.dart';
import 'package:wg_garment/My%20Order/myorderview.dart';
import 'package:wg_garment/Profile/profile_model.dart';
import 'package:wg_garment/Slug%20Page/slugview.dart';

class ProfileViewModel extends ChangeNotifier {
  UserData? profileDta;

  void navigateToEditProfile(BuildContext context) async {
    // Provider.of<ProductDetailsViewModel>(context, listen: false).selectedProductID(ProductID);

    // Push the second screen and pass the user data
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfileView(),
      ),
    );

    if (result != null) {
      // Handle the returned result (pop data)
      print("Received Data: $result");
    }
  }


   void navigateToLoginPage(BuildContext context) async {
    // Provider.of<ProductDetailsViewModel>(context, listen: false).selectedProductID(ProductID);
    final prefs = await SharedPreferences.getInstance();
      await prefs.remove('isLoggedIn');
    // Push the second screen and pass the user data
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginView(),
      ),
    );

    if (result != null) {
      // Handle the returned result (pop data)
      print("Received Data: $result");
    }
  }

  void navigateToMyOrder(BuildContext context) async {
    // Provider.of<ProductDetailsViewModel>(context, listen: false).selectedProductID(ProductID);

    // Push the second screen and pass the user data
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyOrderListView(),
      ),
    );

    if (result != null) {
      // Handle the returned result (pop data)
      print("Received Data: $result");
    }
  }

  void navigateToAddressList(BuildContext context) async {
    // Provider.of<ProductDetailsViewModel>(context, listen: false).selectedProductID(ProductID);

    // Push the second screen and pass the user data
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddresslistView(),
      ),
    );

    if (result != null) {
      // Handle the returned result (pop data)
      print("Received Data: $result");
    }
  }

  void navigateToChangePassword(BuildContext context) async {
    // Provider.of<ProductDetailsViewModel>(context, listen: false).selectedProductID(ProductID);

    // Push the second screen and pass the user data
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChangePasswordView(),
      ),
    );

    if (result != null) {
      // Handle the returned result (pop data)
      print("Received Data: $result");
    }
  }

  void navigateToSlugPage(BuildContext context) async {
    // Provider.of<ProductDetailsViewModel>(context, listen: false).selectedProductID(ProductID);

    // Push the second screen and pass the user data
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Slugview(),
      ),
    );

    if (result != null) {
      // Handle the returned result (pop data)
      print("Received Data: $result");
    }
  }

  Future<NormalModel?> deleteYourAccountApi() async {
    final prefs = await SharedPreferences.getInstance();
    String? userID = prefs.getString("userID");
    try {
      final response = await ApiServices().postApiCall({
        "userId": userID,
        "deviceToken": "",
        "deviceType": "I",
      }, ApiConstant.profiledetailsUrl);
      print("Response Type: ${response.runtimeType}");
      final _responseData = normalModelFromJson(response);
      

     

      notifyListeners();
      return _responseData;
    } catch (error) {
      print("Error parse: $error");
      notifyListeners();
      return null;
    }
  }

  Future<NormalModel?> logOutApi() async {
    final prefs = await SharedPreferences.getInstance();
    String? userID = prefs.getString("userID");
    try {
      final response = await ApiServices().postApiCall({
        "userId": userID,
        "deviceToken": "",
        "deviceType": "I",
      }, ApiConstant.logout);
      print("Response Type: ${response.runtimeType}");
      final _responseData = normalModelFromJson(response);


      notifyListeners();
      return _responseData;
    } catch (error) {
      print("Error parse: $error");
      notifyListeners();
      return null;
    }
  }

  Future<UserModel?> profileApiCall() async {
    final prefs = await SharedPreferences.getInstance();
    String? userID = prefs.getString("userID");
    try {
      final response = await ApiServices()
          .postApiCall({"userId": userID}, ApiConstant.profiledetailsUrl);
      print("Response Type: ${response.runtimeType}");
      final _responseData = userModelFromJson(response);
      profileDta = _responseData.responseData;
      notifyListeners();
      return _responseData;
    } catch (error) {
      print("Error parse: $error");
      notifyListeners();
      return null;
    }
  }

  Future<NormalModel?> updatenewslatterApi(
      String productFeed, String newsLetter) async {
    final prefs = await SharedPreferences.getInstance();
    String? userID = prefs.getString("userID");
    try {
      final response = await ApiServices().postApiCall({
        "userId": userID,
        "productFeed": productFeed,
        "newsLetter": newsLetter
      }, ApiConstant.updatenewslatter);
      print("Response Type: ${response.runtimeType}");
      final responseData = normalModelFromJson(response);

      profileApiCall();

      notifyListeners();
      return responseData;
    } catch (error) {
      print("Error parse: $error");
      notifyListeners();
      return null;
    }
  }
}
