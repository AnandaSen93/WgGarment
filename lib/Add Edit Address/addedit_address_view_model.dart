// countryId = 99

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wg_garment/Add%20Edit%20Address/address_model.dart';
import 'package:wg_garment/Address%20List/address_model.dart';
import 'package:wg_garment/Api%20call/api_constant.dart';
import 'package:wg_garment/Api%20call/api_service.dart';
import 'package:wg_garment/Home/home_model.dart';

class AddeditAddressViewModel extends ChangeNotifier {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController address1Controller = TextEditingController();
  final TextEditingController address2Controller = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController postCodeController = TextEditingController();

  AddressDetailsData? addressFull = AddressDetailsData();

  String isDefault = "0";

  List<StateModelData> stateList = [];
  String stateID = '';
  String stateName = '';

  List<CountryDetailsData> countryList = [];
  String countryID = '99';
  String countryName = '';

  void clearData(){
    addressFull = AddressDetailsData();
    countryList = [];
    countryID = '';
    countryName = '';
    stateList = [];
    stateID = '';
    stateName = '';

    firstNameController.text = "";
    lastNameController.text = "";
    companyController.text = "";
    address1Controller.text = "";
    address2Controller.text = "";
    cityController.text = "";
    postCodeController.text = "";
    isDefault =  addressFull?.isDefault ?? "0";

}

  void setAddressForUpdate(AddressDetailsData address) {
    addressFull = address;
    firstNameController.text = addressFull?.firstName ?? "";
    lastNameController.text = addressFull?.lastName ?? "";
    companyController.text = addressFull?.company ?? "";
    address1Controller.text = addressFull?.houseOne ?? "";
    address2Controller.text = addressFull?.houseTwo ?? "";
    cityController.text = addressFull?.city ?? "";
    postCodeController.text = addressFull?.pincode ?? "";

    stateID = addressFull?.stateId ?? "";
    stateName = addressFull?.state ?? "";

    countryID = addressFull?.countryId ?? "";
    countryName = addressFull?.country ?? "";
    isDefault =  addressFull?.isDefault ?? "0";

    getCountryList();
    getStateList();

    
  }

  void setCountryID(String countryName) {
    var matchedCountry = countryList.firstWhere(
      (state) => state.countryName!.toLowerCase() == countryName.toLowerCase(),
      orElse: () => CountryDetailsData(),
    );
    countryID = matchedCountry.countryId ?? "";
    debugPrint(countryID);
    getStateList();
    
  }

  void setStateID(String StateName) {
    var matchedState = stateList.firstWhere(
      (state) => state.stateName!.toLowerCase() == stateName.toLowerCase(),
      orElse: () => StateModelData(),
    );
    stateID = matchedState.stateId ?? "";
    debugPrint(matchedState.stateId);
    notifyListeners();
  }

  void setisDefault(String isdefault) {
    isDefault = isdefault;
    notifyListeners();
  }

  String checkValidation() {
    String str = "";
    // print(firstName);
    if (firstNameController.text == "") {
      str = "Please enter your first name.";
    } else if (lastNameController.text == "") {
      str = "Please enter your last name.";
    } else if (address1Controller.text == "") {
      str = "Please enter your address 1.";
    } else if (cityController.text == "") {
      str = "Please enter city.";
    } else if (postCodeController.text == "") {
      str = "Please enter your postcode.";
    } else if (countryID == "") {
      str = "Please select your country.";
    } else if (stateID == "") {
      str = "Please select your state.";
    } else {
      str = "success";
    }
    return str;
  }

  Future<CityModel?> getStateList() async {
    try {
      var response = await ApiServices()
          .postApiCall({"countryId": countryID}, ApiConstant.getstate);

      print("Response Type: ${response}");
      var _responseData = cityModelFromJson(response);
      stateList = _responseData.responseData ?? [];
      if (addressFull?.addressId == null) {
          if (stateList.length != 0) {
            stateID = stateList[0].stateId ?? "";
            stateName = stateList[0].stateName ?? "";
          }
      }

      notifyListeners();
      return _responseData;
    } catch (error) {
      print("Error: $error");
      notifyListeners();
      return null;
    }
  }

  Future<CountryListModel?> getCountryList() async {
    try {
      var response =
          await ApiServices().postApiCall({}, ApiConstant.getcountry);

      print("Response Type: ${response}");
      var _responseData = countryListModelFromJson(response);
      countryList = _responseData.responseData ?? [];

      if (addressFull?.addressId == null) {
        if (countryList.length != 0) {
          countryID = "99";
          //countryList[0].countryId ?? "";
          countryName = "India";
          getStateList();
        }
      }

      notifyListeners();
      return _responseData;
    } catch (error) {
      print("Error: $error");
      notifyListeners();
      return null;
    }
  }

  Future<NormalModel?> addAddress() async {
    final prefs = await SharedPreferences.getInstance();
    String? userID = prefs.getString("userID");

    try {
      var response = await ApiServices().postApiCall({
        "userId": userID,
        "firstName": firstNameController.text,
        "lastName": lastNameController.text,
        "pincode": postCodeController.text,
        "stateId": stateID,
        "isDefault": isDefault,
        "countryId": countryID,
        "city": cityController.text,
        "houseOne": address1Controller.text,
        "houseTwo": address2Controller.text,
        "company": companyController.text,
      }, ApiConstant.addaddress);

      print("Response Type: ${response.runtimeType}");
      var _responseData = normalModelFromJson(response);

      notifyListeners();
      return _responseData;
    } catch (error) {
      print("Error: $error");
      notifyListeners();
      return null;
    }
  }

  Future<NormalModel?> updateAddress() async {
    final prefs = await SharedPreferences.getInstance();
    String? userID = prefs.getString("userID");

    try {
      var response = await ApiServices().postApiCall({
        "userId": userID,
        "addressId": addressFull?.addressId ?? "",
        "firstName": firstNameController.text,
        "lastName": lastNameController.text,
        "pincode": postCodeController.text,
        "stateId": stateID,
        "isDefault": isDefault,
        "countryId": countryID,
        "city": cityController.text,
        "houseOne": address1Controller.text,
        "houseTwo": address2Controller.text,
        "company": companyController.text,
      }, ApiConstant.updateaddress);

      print("Response Type: ${response.runtimeType}");
      var _responseData = normalModelFromJson(response);

      notifyListeners();
      return _responseData;
    } catch (error) {
      print("Error: $error");
      notifyListeners();
      return null;
    }
  }
}
