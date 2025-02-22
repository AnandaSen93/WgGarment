import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:wg_garment/Api%20call/api_constant.dart';
import 'package:wg_garment/Api%20call/api_service.dart';
import 'package:wg_garment/Login/login_model.dart';

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
    } else if (isValidEmail(_email)) {
      str = "Please enter your valid email.";
    } else if (_password == "") {
      str = "Please enter your password.";
    } else {
      str = "success";
    }
    return str;
  }

  bool isValidEmail(String email) {
    // Regular expression for email validation
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(email);
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

        return loginModel;
      } catch (error) {
        print("Error: $error");
        return null;
      }
    }

  


  }
