import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wg_garment/Address%20List/address_model.dart';
import 'package:wg_garment/Address%20List/addresslist.dart';
import 'package:wg_garment/Address%20List/addresslist_view_model.dart';
import 'package:wg_garment/Api%20call/api_constant.dart';
import 'package:wg_garment/Api%20call/api_service.dart';
import 'package:wg_garment/Home/home_model.dart';

class ChangepasswordViewModel extends ChangeNotifier {
  String _oldPassword = '';
  String _password = '';
  String _confirmPassword = '';

  void setOldPassword(String oldPassword) {
    _oldPassword = oldPassword;
    print(_password);
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    print(_password);
    notifyListeners();
  }

  void setConfirmPassword(String confirmPassword) {
    _confirmPassword = confirmPassword;
    print(_confirmPassword);
    notifyListeners();
  }

  String checkValidation() {
    print(_password);
    print(_confirmPassword);
    String str = "";
    if (_oldPassword == "") {
      str = "Please enter your old password.";
    }
    if (_password == "") {
      str = "Please enter new password.";
    } else if (_confirmPassword == "") {
      str = "Please enter confirm password.";
    } else if (_confirmPassword != _password) {
      str = "Please enter new password again.";
    } else {
      str = "success";
    }
    return str;
  }

  Future<NormalModel?> changepasswordApi() async {
    final prefs = await SharedPreferences.getInstance();
    String? userID = prefs.getString("userID");
    try {
      final response = await ApiServices().postApiCall({
        "userId": userID,
        "oldPassword": _oldPassword,
        "newPassword": _confirmPassword,
      }, ApiConstant.changepassword);

      print("Response Type: ${response.runtimeType}");
      var _response = normalModelFromJson(response);
      return _response;
    } catch (Error) {
      print("error: ${Error}");
      return null;
    }
  }
}
