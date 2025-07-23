import 'package:flutter/material.dart';
import 'package:wg_garment/Api%20call/api_constant.dart';
import 'package:wg_garment/Api%20call/api_service.dart';
import 'package:wg_garment/Home/home_model.dart';

class SignupViewModel extends ChangeNotifier {
  String _firstName = '';
  String _lastName = '';
  String _phone = '';
  String _email = '';
  String _password = '';
  String _confirmPassword = '';

  void setEmail(String email) {
    _email = email;
     print(_email);
    notifyListeners();
  }

  void setFirstName(String firstName) {
    _firstName = firstName;
    print(_firstName);
    notifyListeners();
  }

  void setLastName(String lastName) {
    _lastName = lastName;
     print(_lastName);
    notifyListeners();
  }

  void setPhone(String phone) {
    _phone = phone;
     print(_phone);
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
    print(_firstName);
    print(_lastName);
    print(_phone);
    print(_email);
    print(_password);
    print(_confirmPassword);
    String str = "";
    if (_firstName == "") {
      str = "Please enter your first name.";
    }else if (_lastName == "") {
      str = "Please enter your last name.";
    }else if (_phone == "") {
      str = "Please enter your phone number.";
    }else if (_phone.length < 10) {
      str = "Please enter a valid phone number.";
    }else if (_phone.length > 15) {
      str = "Please enter a valid phone number.";
    } else if (_email == "") {
      str = "Please enter your email.";
    } else if (!Helper.isValidEmail(_email)) {
      str = "Please enter your valid email.";
    } else if (_password == "") {
      str = "Please enter your password.";
    }else if (_confirmPassword == "") {
      str = "Please enter confirm password.";
    }else if (_confirmPassword != _password) {
      str = "Please enter same as password.";
    } else {
      str = "success";
    }
    return str;
  }

  Future<NormalModel?> signUpApiCall() async {
    try {
      final response = await ApiServices().postApiCall({
        "firstName": _firstName,
        "lastName": _lastName,
        "phone": _phone,
        "email": _email,
        "password": _password,
        "newsLetter": "1",
        "productFeed": "1",
      }, ApiConstant.signupUrl);

      print("Response Type: ${response.runtimeType}");
      var signupModel = normalModelFromJson(response);
      return signupModel;
    } catch (Error) {
      print("error: ${Error}");
      return null;
    }
  }
}
