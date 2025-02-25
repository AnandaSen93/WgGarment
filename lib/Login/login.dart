import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:wg_garment/Api%20call/api_service.dart';
import 'package:wg_garment/Config/colors.dart';
import 'package:wg_garment/Config/textstyle.dart';
import 'package:wg_garment/Login/login_model.dart';
import 'package:wg_garment/Login/login_view_model.dart';
import 'package:wg_garment/Menu/menu.dart';
import 'package:wg_garment/Signup/signup.dart';


class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView>
  with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final TextEditingController _emailCon = TextEditingController();
  final TextEditingController _passwordCon = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    _emailCon.dispose();
    _passwordCon.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginViewModel = Provider.of<LoginViewModel>(context);
    //final loginViewModel = Provider.of<LoginViewModel>(context, listen: false);
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
                    onPressed: () {}, icon: Icon(Icons.arrow_back_ios_new)),
                Spacer(),
                Spacer()
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
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
                                  controller: _emailCon,
                                  onChanged: loginViewModel.setEmail,
                                  keyboardType: TextInputType.emailAddress,
                                  focusNode: FocusNode(),
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
                                      border:
                                          OutlineInputBorder(), // You can add a border if needed
                                      hintText:
                                          'Enter text here', // Optional: hint text for Android
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
                                  controller: _passwordCon,
                                  onChanged: loginViewModel.setPassword,
                                  keyboardType: TextInputType.emailAddress,
                                  focusNode: FocusNode(),
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
                                      border:
                                          OutlineInputBorder(), // You can add a border if needed
                                      hintText:
                                          'Please enter password here....', // Optional: hint text for Android
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .end, // Align text to the right
                            children: [
                              Text('Forget Password'),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 50),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: TextButton(
                            onPressed: () async {
                              if (loginViewModel.checkValidation() ==
                                  "success") {
                                LoginModel? response =
                                    await loginViewModel.loginApiCall();
                                if (response != null) {
                                  if (response.responseCode == 1) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MenuView()));
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
                                      msg: loginViewModel.checkValidation());
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
                            child: Text("LOG IN")),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignupView()));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Don't have an account?"),
                              Text(" SIGN UP"),
                            ],
                          )),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
