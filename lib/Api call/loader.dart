import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wg_garment/Config/colors.dart';
import 'package:wg_garment/Config/textstyle.dart';

class GlobalLoader {
  static final GlobalLoader _instance = GlobalLoader._internal();
  factory GlobalLoader() => _instance;
  GlobalLoader._internal();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  void showLoadingDialog() {
    showDialog(
      context: navigatorKey.currentContext!,
      barrierDismissible: false, // Prevent closing on tap
      builder: (context) {
        return Container(          
          color: Colors.white.withOpacity(0.2),
          child: Center(

            child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  SpinKitCircle(color: pinkcolor, size: 50.0),
                  Text("Please wait....",
                    style: textStyleForTextField,
                  )
              ],
            )
            
            
            //SpinKitChasingDots(color: Colors.red, size: 50.0),
            //CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  void hideLoadingDialog() {
    if (navigatorKey.currentContext != null) {
      Navigator.pop(navigatorKey.currentContext!);
    }
  }
}
