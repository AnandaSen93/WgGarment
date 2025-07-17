import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wg_garment/Api%20call/api_constant.dart';
import 'package:wg_garment/Api%20call/api_service.dart';
import 'package:wg_garment/Home/home_model.dart';
import 'package:wg_garment/Menu/menu.dart';
import 'package:wg_garment/Menu/menu_view_model.dart';
import 'package:wg_garment/Profile/profile_model.dart';

class EditprofileViewModel extends ChangeNotifier {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  UserData? profileDta;


    void navigateMainMenu(BuildContext context) async {
    Provider.of<MenuViewModel>(context, listen: false).setPageNav(4);

    // Push the second screen and pass the user data
    // final result = await Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => MenuView(),
    //   ),
    // );

      final result = Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => MenuView()),
      (Route<dynamic> route) => false,
    );

    if (result != null) {
      // Handle the returned result (pop data)
      print("Received Data: $result");
    }
  }

  String checkValidation() {
    String str = "";
    if (firstNameController.text.isEmpty) {
      str = "Please enter your first name.";
    } else if (lastNameController.text.isEmpty) {
      str = "Please enter your last name.";
    } else {
      str = "success";
    }
    return str;
  }

  String checkValidationForEmail() {
    String str = "";
    if (emailController.text.isEmpty) {
      str = "Please enter your email address.";
    } else if (!Helper.isValidEmail(emailController.text)) {
      str = "Please enter a valid email adddress.";
    } else {
      str = "success";
    }
    return str;
  }

  String checkValidationForPhone() {
    String str = "";
    if (phoneController.text.isEmpty) {
      str = "Please enter your phone number.";
    } else {
      str = "success";
    }
    return str;
  }

  Future<NormalModel?> uploadprofileImage(File? imageFile) async {
    final prefs = await SharedPreferences.getInstance();
    String? userID = prefs.getString("userID");

    try {
      final response = await ApiServices().postApiCall({
        "userId": userID,
        "image": imageFile,
      }, ApiConstant.updateprofileimage);
      print("Response Type: ${response.runtimeType}");
      final _response = normalModelFromJson(response);

      notifyListeners();
      return _response;
    } catch (error) {
      print("Error parse: $error");
      notifyListeners();
      return null;
    }
  }

  Future<NormalModel?> updateEmailApi() async {
    final prefs = await SharedPreferences.getInstance();
    String? userID = prefs.getString("userID");
    try {
      final response = await ApiServices().postApiCall({
        "userId": userID,
        "email": emailController.text,
      }, ApiConstant.editemail);
      print("Response Type: ${response.runtimeType}");
      final _response = normalModelFromJson(response);

      notifyListeners();
      return _response;
    } catch (error) {
      print("Error parse: $error");
      notifyListeners();
      return null;
    }
  }

  Future<NormalModel?> updatePhoneApi() async {
    final prefs = await SharedPreferences.getInstance();
    String? userID = prefs.getString("userID");
    try {
      final response = await ApiServices().postApiCall({
        "userId": userID,
        "phone": phoneController.text,
      }, ApiConstant.editemail);
      print("Response Type: ${response.runtimeType}");
      final _response = normalModelFromJson(response);

      notifyListeners();
      return _response;
    } catch (error) {
      print("Error parse: $error");
      notifyListeners();
      return null;
    }
  }

  Future<NormalModel?> updateProfileApi() async {
    final prefs = await SharedPreferences.getInstance();
    String? userID = prefs.getString("userID");
    try {
      final response = await ApiServices().postApiCall({
        "userId": userID,
        "firstName": firstNameController.text,
        "lastName": lastNameController.text
      }, ApiConstant.editprofile);
      print("Response Type: ${response.runtimeType}");
      final _response = normalModelFromJson(response);

      notifyListeners();
      return _response;
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
      final profileApiData = userModelFromJson(response);
      profileDta = profileApiData.responseData;
      firstNameController.text = profileDta?.firstName ?? "";
      lastNameController.text = profileDta?.lastName ?? "";
      phoneController.text = profileDta?.phone ?? "";
      emailController.text = profileDta?.email ?? "";

      notifyListeners();
      return profileApiData;
    } catch (error) {
      print("Error parse: $error");
      notifyListeners();
      return null;
    }
  }
}
