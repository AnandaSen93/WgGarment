import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:wg_garment/Config/colors.dart';
import 'package:wg_garment/Config/textstyle.dart';
import 'package:wg_garment/Home/home_model.dart';
import 'package:wg_garment/Signup/signup_view_model.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final TextEditingController _emailCon = TextEditingController();
  final TextEditingController _passwordCon = TextEditingController();
  final FocusNode _focusNode = FocusNode();

      void _toggleKeyboard() {
      if (_focusNode.hasFocus) {
        _focusNode.unfocus(); // Hide keyboard
      } else {
        FocusScope.of(context).requestFocus(_focusNode); // Show keyboard
      }
    }
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailCon.dispose();
    _passwordCon.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final signuoViewModel = Provider.of<SignupViewModel>(context);
    return PlatformScaffold(
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: SafeArea(
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
                  Spacer(),
                  Spacer()
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: GestureDetector(
                  onTap: (){
                    _toggleKeyboard();
                  },
                  child: SingleChildScrollView(
                    child: Container(
                      color: Colors.transparent,
                      width: double.infinity,
                      child: Column(
                        children: [
                          Container(
                            height: 80,
                            child: Image.asset(
                              'assets/images/app_logo.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                          // Text(
                          //   "Log In To Continue",
                          //   style: textStyleForCategorytName,
                          // ),
                          SizedBox(height: 50),
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "First name",
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
                                      inputFormatters: [
                                        FilteringTextInputFormatter.deny(RegExp(
                                            r'[0-9]')),
                                      ],
                                      onChanged: signuoViewModel.setFirstName,
                                      keyboardType: TextInputType.name,
                                      //focusNode: FocusNode(),
                                      hintText: 'Please enter your first name...',
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
                                              'Please enter your first name...', // Optional: hint text for Android
                                        ),
                                      ),
                                    ))
                              ],
                            ),
                          ),
                          SizedBox(height: 15),
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Last name",
                                  style: textStyleForTextField,
                                ),
                                Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.transparent,
                                    ),
                                    height: 40,
                                    child: PlatformTextField(
                                      //controller: _emailCon,
                                       inputFormatters: [
                                        FilteringTextInputFormatter.deny(RegExp(
                                            r'[0-9]')),
                                      ],
                                      onChanged: signuoViewModel.setLastName,
                                      keyboardType: TextInputType.name,
                                      //focusNode: FocusNode(),
                                      hintText: 'Please enter your last name...',
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
                                              'Please enter your last name...', // Optional: hint text for Android
                                        ),
                                      ),
                                    ))
                              ],
                            ),
                          ),
                          SizedBox(height: 15),
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Phone number",
                                  style: textStyleForTextField,
                                ),
                                Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.transparent,
                                    ),
                                    height: 40,
                                    child: PlatformTextField(
                                      //controller: _emailCon,
                                      onChanged: signuoViewModel.setPhone,
                                      keyboardType: TextInputType.phone,
                                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                      //focusNode: FocusNode(),
                                      hintText:
                                          'Please enter your phone number...',
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
                                              'Please enter your phone number...', // Optional: hint text for Android
                                        ),
                                      ),
                                    ))
                              ],
                            ),
                          ),
                          SizedBox(height: 15),
                  
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
                            child: Column(
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
                                      //controller: _emailCon,
                                      onChanged: signuoViewModel.setEmail,
                                      keyboardType: TextInputType.emailAddress,
                                      //focusNode: FocusNode(),
                                      hintText: 'Please enter email address...',
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
                                              'Please enter email address...', // Optional: hint text for Android
                                        ),
                                      ),
                                    ))
                              ],
                            ),
                          ),
                          SizedBox(height: 15),
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Password",
                                  style: textStyleForTextField,
                                ),
                                Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.transparent,
                                    ),
                                    height: 40,
                                    child: PlatformTextField(
                                      obscureText: true,
                                      //controller: _passwordCon,
                                      onChanged: signuoViewModel.setPassword,
                                      keyboardType: TextInputType.visiblePassword,
                                      //focusNode: FocusNode(),
                                      hintText: 'Please enter password here....',
                                      cupertino: (context, platform) =>
                                          CupertinoTextFieldData(
                                        decoration: BoxDecoration(
                                          color: Colors
                                              .transparent, // Remove background color for iOS
                                        ),
                                        // padding: EdgeInsets.symmetric(
                                        //     horizontal: 16.0,
                                        //     vertical: 12.0), // Optional: Custom padding
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
                                              'Please enter password here....', // Optional: hint text for Android
                                        ),
                                      ),
                                    ))
                              ],
                            ),
                          ),
                          SizedBox(height: 15),
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Confirm password",
                                  style: textStyleForTextField,
                                ),
                                Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.transparent,
                                    ),
                                    height: 40,
                                    child: PlatformTextField(
                                      obscureText: true,
                                      //controller: _emailCon,
                                      onChanged:
                                          signuoViewModel.setConfirmPassword,
                                      keyboardType: TextInputType.visiblePassword,
                                      //focusNode: FocusNode(),
                                      hintText:
                                          'Please enter your confirm password...',
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
                                              'Please enter confirm password...', // Optional: hint text for Android
                                        ),
                                      ),
                                    ))
                              ],
                            ),
                          ),
                          SizedBox(height: 15),
                           Container(
                        height: 40,
                        width: double.infinity,
                        
                        child: Row(
                          children: [
                            Text(
                              "Subscribe newsletter :",
                              style: textStyleForCategorytName,
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    signuoViewModel.isNewsLetter.toString() == "1" ? signuoViewModel.isNewsLetter = "0" : signuoViewModel.isNewsLetter = "1";
                                 });
                                },
                                icon: Icon(
                                  signuoViewModel.isNewsLetter.toString() == "1" ? Icons.check_box : Icons.check_box_outline_blank,
                                  size: 30,
                                )),
                            
                          ],
                        ),
                      ),
            Container(
                        height: 40,
                        width: double.infinity,
                        //  color: Colors.green,
                        child: Row(
                          children: [
                            Text(
                              "Subscribe to product feed :",
                              style: textStyleForCategorytName,
                            ),
                            IconButton(
                                onPressed: () {
                                 setState(() {
                                    signuoViewModel.isProductFeed.toString() == "1" ? signuoViewModel.isProductFeed = "0" : signuoViewModel.isProductFeed = "1";
                                     
                                 });
                                },
                                icon: Icon(
                                  signuoViewModel.isProductFeed.toString() == "1" ? Icons.check_box : Icons.check_box_outline_blank,
                                  size: 30,
                                )),
                            
                          ],
                        ),
                      ),
                  
                          SizedBox(height: 10),
                          SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: TextButton(
                                onPressed: () async {
                                  if (signuoViewModel.checkValidation() ==
                                      "success") {
                                    NormalModel? response =
                                        await signuoViewModel.signUpApiCall();
                                    if (response?.responseCode == 1) {
                                      Fluttertoast.showToast(
                                          msg: response?.responseText ?? "");
                                      Future.delayed(Duration(seconds: 2), () {
                                        Navigator.pop(context);
                                      });
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: response?.responseText ?? "");
                                    }
                                  } else {
                                    setState(() {
                                      Fluttertoast.showToast(
                                          msg: signuoViewModel.checkValidation());
                                    });
                                  }
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor:
                                      pinkcolor, // Button background color
                                  foregroundColor: Colors.white, // Text color
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        25.0), // Rounded corners
                                  ),
                                ),
                                child: Text("Sign Up")),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("You have an account?",
                                  style: textstyleSmall.copyWith(color: Colors.black54 )
                                  ),
                                  Text(" LOGIN",
                                  style: textstyleSmall.copyWith(color: pinkcolor
                                  )),
                                ],
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
