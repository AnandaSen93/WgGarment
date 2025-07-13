import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:wg_garment/Api%20call/api_constant.dart';
import 'package:wg_garment/Api%20call/api_service.dart';
import 'package:wg_garment/Login/login_model.dart';

import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel extends ChangeNotifier {
  String _email = '';
  String _password = '';

  LoginModel loginModel = LoginModel();

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  String checkValidation() {
    String str = "";
    if (_email.isEmpty) {
      str = "Please enter your email.";
    } else if (!Helper.isValidEmail(_email)) {
      str = "Please enter your valid email.";
    } else if (_password == "") {
      str = "Please enter your password.";
    } else {
      str = "success";
    }
    return str;
  }

 

  Future<LoginModel?> loginApiCall() async {
    print('_email: $_email');
    print('_password: $_password');

    try {
        final response = await ApiServices().postApiCall({
          "email": _email,
          "password": _password,
          "deviceToken": "",
          "deviceType": "I"
        }, ApiConstant.loginUrl);

        print("Response Type: ${response.runtimeType}");
        loginModel = loginModelFromJson(response);
        print("Response Text: ${loginModel.responseText}");

        if (loginModel.responseCode == 1){
          var share = await SharedPreferences.getInstance();
          share.setBool("isLoggedIn", true);
          share.setString("userID",loginModel.responseData?.userId ?? "");
          print("isLoggedIn");
        }
        
        return loginModel;
      } catch (error) {
        print("Error parse: $error");
        return null;
      }
    }

  


  }
