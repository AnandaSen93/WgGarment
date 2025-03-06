

import 'package:flutter/material.dart';
import 'package:wg_garment/Api%20call/api_constant.dart';
import 'package:wg_garment/Api%20call/api_service.dart';
import 'package:wg_garment/Profile/profile_model.dart';

class ProfileViewModel extends ChangeNotifier{

  UserData? profileDta;

  Future<UserModel?> profileApiCall() async{

    try {
      final response = await ApiServices().postApiCall({
        "userId":"3"
      }, ApiConstant.profiledetailsUrl);
      print("Response Type: ${response.runtimeType}");
      final profileApiData = userModelFromJson(response);
      profileDta = profileApiData.responseData;
      
      notifyListeners();
      return profileApiData;

    } catch (error) {
      print("Error parse: $error");
      notifyListeners();
      return null;
    }
  }
  
}