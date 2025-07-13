import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wg_garment/Add%20Edit%20Address/addedit_address_view_model.dart';
import 'package:wg_garment/Add%20Edit%20Address/addeditaddress.dart';
import 'package:wg_garment/Address%20List/address_model.dart';
import 'package:wg_garment/Api%20call/api_constant.dart';
import 'package:wg_garment/Api%20call/api_service.dart';
import 'package:wg_garment/Home/home_model.dart';

class AddresslistViewModel extends ChangeNotifier {
  List<AddressDetailsData> addressList = [];

  String addressType = '';

  void setAddressType(String addressTypeData){
       addressType = addressTypeData;
  }

  Future<AddressListModel?> getAddressList() async {
    final prefs = await SharedPreferences.getInstance();
    String? userID = prefs.getString("userID");

    try {
      var response = await ApiServices()
          .postApiCall({"userId": userID}, ApiConstant.addresslist);

      print("Response Type: ${response.runtimeType}");
      var _responseData = addressListModelFromJson(response);
      addressList = _responseData.responseData ?? [];

      notifyListeners();
      return _responseData;
    } catch (error) {
      print("Error: $error");
      notifyListeners();
      return null;
    }
  }

  Future<NormalModel?> deleteAddress(String addressId) async {
    final prefs = await SharedPreferences.getInstance();
    String? userID = prefs.getString("userID");

    try {
      var response = await ApiServices().postApiCall(
          {"userId": userID, "addressId": addressId},
          ApiConstant.deleteaddress);

      print("Response Type: ${response.runtimeType}");
      var _responseData = normalModelFromJson(response);
      var _responseCode = _responseData.responseCode ?? 0;
      if (_responseCode != 0) {
        getAddressList();
      }

      notifyListeners();
      return _responseData;
    } catch (error) {
      print("Error: $error");
      notifyListeners();
      return null;
    }
  }

  void navigateToAddEditAddress(BuildContext context) async {
    // Provider.of<ProductListViewModel>(context, listen: false).setcategoryId(selectedSubCatID);

    // Push the second screen and pass the user data
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEditAddressView(),
      ),
    ).then((_) {
      // Refresh after coming back
      getAddressList();
    });
  }

    void navigateToAddEditAddressWithData(AddressDetailsData address,BuildContext context) async {
     Provider.of<AddeditAddressViewModel>(context, listen: false).setAddressForUpdate(address);

    // Push the second screen and pass the user data
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEditAddressView(),
      ),
    ).then((_) {
      // Refresh after coming back
      getAddressList();
    });

    if (result != null) {
      // Handle the returned result (pop data)
      print("Received Data: $result");
    }
  }
}
