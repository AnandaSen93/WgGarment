import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:wg_garment/Config/colors.dart';
import 'package:wg_garment/Config/textstyle.dart';
import 'package:wg_garment/Forgot%20Password/forgotpassword_view_model.dart';
import 'package:wg_garment/Home/home_model.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final FocusNode _focusNode = FocusNode();
  void _toggleKeyboard() {
    if (_focusNode.hasFocus) {
      _focusNode.unfocus(); // Hide keyboard
    } else {
      FocusScope.of(context).requestFocus(_focusNode); // Show keyboard
    }
  }

  @override
  Widget build(BuildContext context) {
    final forgotpasswordViewModel =
        Provider.of<ForgotpasswordViewModel>(context);
    return PlatformScaffold(
      body: SafeArea(
          child: Column(
        children: [
          Container(
            color: Colors.transparent,
            height: 60,
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios_new)),
                SizedBox(width: 80),
                Text(
              "Forgot Password",
              textAlign: TextAlign.center,
              style: textStyleForMainProductName,
            ),
                Spacer()
              ],
            ),
          ),
          Container(
            height: 80,
            child: Image.asset(
              'assets/images/app_logo.png',
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: 20),
          Expanded(
              child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Email address",
                                style: textStyleForTextField,
                              ),
                              Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.transparent,
                                  ),
                                  height: 40,
                                  child: PlatformTextField(
                                    // controller: _emailCon,
                                    onChanged: forgotpasswordViewModel.setEmail,
                                    keyboardType: TextInputType.emailAddress,

                                    onSubmitted: (_) => _toggleKeyboard(),
                                    hintText: 'Please enter email address',
                                    cupertino: (context, platform) =>
                                        CupertinoTextFieldData(
                                      decoration: BoxDecoration(
                                        color: Colors
                                            .transparent, // Remove background color for iOS
                                      ),
                                      // Optional: Custom padding
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    material: (context, platform) =>
                                        MaterialTextFieldData(
                                      decoration: InputDecoration(
                                        filled:
                                            false, // Remove the background color for Android
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.all(
                                            10), // You can add a border if needed
                                        hintText:
                                            'Enter text here', // Optional: hint text for Android
                                      ),
                                    ),
                                  ))
                            ],
                          ), 
                  
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors
                                    .black54, // Set the color of the underline
                                width: 1.0, // Set the width of the underline
                              ),
                            ),
                          ),  
                        ),              
                  SizedBox(height: 30),
                  Container(
                    height: 50,
                    width: double.infinity,
                     decoration: BoxDecoration(
                      color: pinkcolor,
                          border: Border.all(
                            color: pinkcolor, // Black border color
                            width: 1.0, // Border width
                          ),
                          borderRadius: BorderRadius.circular(
                              25), // Optional: Rounded corners
                        ),
                    child: TextButton(
                        onPressed: () async {
                          if (forgotpasswordViewModel.checkValidation() ==
                              "success") {
                            NormalModel? response =
                                await forgotpasswordViewModel
                                    .forgotpasswordApi();
                            if (response?.responseCode == 1) {
                              Fluttertoast.showToast(
                                  msg: response?.responseText ?? "");

                              Navigator.pop(context);
                            } else {
                              Fluttertoast.showToast(
                                  msg: response?.responseText ?? "");
                            }
                                                    } else {
                            setState(() {
                              Fluttertoast.showToast(
                                  msg: forgotpasswordViewModel
                                      .checkValidation());
                            });
                          }
                        },
                        child: Text(
                          "Continue",
                          style: textStyleForButton,
                        )),
                  )
                ],
              ),
            ),
          )),
        ],
      )),
    );
  }
}
