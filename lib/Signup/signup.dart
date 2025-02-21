import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:wg_garment/Config/colors.dart';
import 'package:wg_garment/Config/textstyle.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {

  final TextEditingController _emailCon = TextEditingController();
  final TextEditingController _passwordCon = TextEditingController();


  @override
  Widget build(BuildContext context) {
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
                                  controller: _emailCon,
                                  keyboardType: TextInputType.emailAddress,
                                  focusNode: FocusNode(),
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
                                      border:
                                          OutlineInputBorder(), // You can add a border if needed
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
                                  controller: _emailCon,
                                  keyboardType: TextInputType.emailAddress,
                                  focusNode: FocusNode(),
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
                                      border:
                                          OutlineInputBorder(), // You can add a border if needed
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
                                  controller: _emailCon,
                                  keyboardType: TextInputType.emailAddress,
                                  focusNode: FocusNode(),
                                  hintText: 'Please enter your phone number...',
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
                                  controller: _emailCon,
                                  keyboardType: TextInputType.emailAddress,
                                  focusNode: FocusNode(),
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
                                      border:
                                          OutlineInputBorder(), // You can add a border if needed
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
                                  controller: _passwordCon,
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
                                  controller: _emailCon,
                                  keyboardType: TextInputType.emailAddress,
                                  focusNode: FocusNode(),
                                  hintText: 'Please enter your confirm password...',
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
                                          'Please enter confirm password...', // Optional: hint text for Android
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      ),
                      SizedBox(height: 15),

                       SizedBox(height: 20),
                        SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: Expanded(
                              child: TextButton(
                                  onPressed: () {
                                    debugPrint("Login tapped");
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
                            )),
                        TextButton(
                            onPressed: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => Signup()));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("You have an account?"),
                                Text(" LOGIN"),
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