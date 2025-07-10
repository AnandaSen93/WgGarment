import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wg_garment/Api%20call/api_constant.dart';
import 'package:wg_garment/Api%20call/api_service.dart';

class CheckoutViewModel extends ChangeNotifier {

   String couponText = '';
   String commetsText = "";

    void setCouponCode(String couponText) {
    couponText = couponText;
    notifyListeners();
  }

    void setComments(String commetsText) {
    commetsText = commetsText;
    notifyListeners();
  }
}