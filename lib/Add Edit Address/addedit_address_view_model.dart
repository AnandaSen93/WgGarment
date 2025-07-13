// countryId = 99

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wg_garment/Add%20Edit%20Address/address_model.dart';
import 'package:wg_garment/Api%20call/api_constant.dart';
import 'package:wg_garment/Api%20call/api_service.dart';
import 'package:wg_garment/Home/home_model.dart';

class AddeditAddressViewModel extends ChangeNotifier {
  String firstName = '';
  String lastName = '';
  String company = '';
  String address1 = '';
  String address2 = '';
  String city = '';
  String postCode = '';

  String isDefault = "0";

  List<StateModelData> stateList = [];
  String stateID = '';
  String stateName = '';

  List<CountryDetailsData> countryList = [];
  String countryID = '99';
  String countryName = '';

  void setFirstName(String firstNameT) {
    firstName = firstNameT;
    print(firstName);
    notifyListeners();
  }

  void setLastName(String lastNameT) {
    lastName = lastNameT;
    notifyListeners();
  }

  void setCompany(String companyT) {
    company = companyT;
    notifyListeners();
  }

  void setAddress1(String addressT) {
    address1 = addressT;
    notifyListeners();
  }

  void setAddress2(String addressT) {
    address2 = addressT;
    notifyListeners();
  }

  void setCity(String cityT) {
    city = cityT;
    notifyListeners();
  }

  void setPostCode(String postcodeT) {
    postCode = postcodeT;
    notifyListeners();
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
  }

  void setisDefault(String isdefault) {
    isDefault = isdefault;
    notifyListeners();
  }

  String checkValidation() {
    String str = "";
   // print(firstName);
    if (firstName == "") {
      str = "Please enter your first name.";
    } else if (lastName == "") {
      str = "Please enter your last name.";
    } else if (address1 == "") {
      str = "Please enter your address 1.";
    } else if (city == "") {
      str = "Please enter city.";
    } else if (postCode == "") {
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

      print("Response Type: ${response.runtimeType}");
      var _responseData = cityModelFromJson(response);
      stateList = _responseData.responseData ?? [];
      if (stateList.length != 0) {
        stateID = stateList[0].stateId ?? "";
        stateName = stateList[0].stateName ?? "";
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

      print("Response Type: ${response.runtimeType}");
      var _responseData = countryListModelFromJson(response);
      countryList = _responseData.responseData ?? [];
      if (countryList.length != 0) {
        stateID = countryList[0].countryId ?? "";
        countryName = countryList[0].countryName ?? "";
        getStateList();
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
        "firstName": firstName,
        "lastName": lastName,
        "pincode": postCode,
        "stateId": stateID,
        "isDefault": isDefault,
        "countryId": countryID,
        "city": city,
        "houseOne": address1,
        "houseTwo": address2,
        "company": company,
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
}
