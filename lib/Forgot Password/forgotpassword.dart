import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
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
    final forgotpasswordViewModel = Provider.of<ForgotpasswordViewModel>(context);
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
                Image.asset(
                  'assets/images/app_logo.png',
                  fit: BoxFit.contain,
                ),
                Spacer()
              ],
            ),
          ),
          Container(
            width: double.infinity,
            child: Text(
              "Forgot Password",
              textAlign: TextAlign.center,
              style: textStyleForMainProductName,
            ),
          ),
          SizedBox(height: 20),
          Expanded(
              child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black, // Black border color
                        width: 1.0, // Border width
                      ),
                      borderRadius: BorderRadius.circular(
                          5.0), // Optional: Rounded corners
                    ),
                    child: PlatformTextField(
                      //obscureText: true,
                      // controller: _emailCon, // (Optional: TextEditingController, currently commented)
                      onChanged: forgotpasswordViewModel
                          .setEmail, // Called on text change
                      keyboardType: TextInputType.emailAddress,
                      // minLines: 4,         // Minimum height (optional)
                      // maxLines: null, // Keyboard optimized for name input
                      onSubmitted: (_) => _toggleKeyboard(),
                      hintText:
                          'Confirm new Password', // Common hint text (can override per platform)

                      // iOS Specific Customization
                      cupertino: (context, platform) => CupertinoTextFieldData(
                        decoration: BoxDecoration(
                          color: Colors
                              .transparent, // No background color for iOS field
                        ),
                        style: textStyleForTextField, // Text color on iOS
                      ),

                      // Android Specific Customization
                      material: (context, platform) => MaterialTextFieldData(
                        decoration: InputDecoration(
                          filled: false, // No fill color
                          border:
                              OutlineInputBorder(), // Shows border around text field
                          hintText:
                              'Confirm new Password', // Hint text (optional, also passed above)
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    color: Colors.black,
                    height: 50,
                    width: double.infinity,
                    child: TextButton(
                        onPressed: () async {
                          if (forgotpasswordViewModel.checkValidation() ==
                              "success") {
                            NormalModel? response =
                                await forgotpasswordViewModel
                                    .forgotpasswordApi();
                            if (response != null) {
                              if (response.responseCode == 1) {
                                Fluttertoast.showToast(
                                    msg: response.responseText ?? "");

                                Navigator.pop(context);
                              } else {
                                Fluttertoast.showToast(
                                    msg: response.responseText ?? "");
                              }
                            } else {
                              print("Login failed");
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
                          "Save",
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
