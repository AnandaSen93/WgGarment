import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wg_garment/Address%20List/address_model.dart';
import 'package:wg_garment/Address%20List/addresslist.dart';
import 'package:wg_garment/Address%20List/addresslist_view_model.dart';
import 'package:wg_garment/Api%20call/api_constant.dart';
import 'package:wg_garment/Api%20call/api_service.dart';
import 'package:wg_garment/Home/home_model.dart';

class ForgotpasswordViewModel extends ChangeNotifier {
  String _email = '';

   void setEmail(String email) {
    _email = email;
    print(_email);
    notifyListeners();
  }

String checkValidation() {
    String str = "";
    if (_email.isEmpty) {
      str = "Please enter your email.";
    } else if (!Helper.isValidEmail(_email)) {
      str = "Please enter your valid email.";
    } else {
      str = "success";
    }
    return str;
  }

  Future<NormalModel?> forgotpasswordApi() async {
    try {
      final response = await ApiServices().postApiCall({
        "email": _email,
      }, ApiConstant.forgotpassword);

      print("Response Type: ${response.runtimeType}");
      var _response = normalModelFromJson(response);
      return _response;
    } catch (Error) {
      print("error: ${Error}");
      return null;
    }
  }

}