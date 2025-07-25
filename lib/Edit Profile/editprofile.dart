import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:wg_garment/Config/colors.dart';
import 'package:wg_garment/Config/textstyle.dart';
import 'package:wg_garment/Edit%20Profile/editprofile_view_model.dart';
import 'package:wg_garment/Home/home_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wg_garment/Profile/profile_model.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  bool _isInitialized = false;
  late EditprofileViewModel _viewModel;
  final ImagePicker _picker = ImagePicker();
  final FocusNode _focusNode = FocusNode();
  XFile? _imageFile;


  // Future<void> pickImage(ImageSource source) async {
  //   final XFile? pickedFile = await _picker.pickImage(source: source);

  //   if (pickedFile != null) {
  //     setState(() async {
  //       _imageFile = pickedFile;
  //     });
  //      NormalModel? response =
  //           await _viewModel.uploadprofileImage(File(_imageFile?.path ?? ""));
  //       if (response != null) {
  //         if (response.responseCode == 1) {
  //           Fluttertoast.showToast(msg: response.responseText ?? "");
  //         } else {
  //           Fluttertoast.showToast(msg: response.responseText ?? "");
  //         }
  //         _viewModel.navigateMainMenu(context);
  //       } else {
  //         Fluttertoast.showToast(msg: "Something went wrong");
  //       }
  //   }
  // }


  Future<void> pickImage(ImageSource source) async {
  try {
    final XFile? pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _imageFile = pickedFile;
      });

      NormalModel? response =
          await _viewModel.uploadprofileImage(File(pickedFile.path));

      if (response != null) {
        Fluttertoast.showToast(msg: response.responseText ?? "");
        _viewModel.navigateMainMenu(context);
      } else {
        Fluttertoast.showToast(msg: "Something went wrong");
      }
    }
  } catch (e) {
    Fluttertoast.showToast(msg: "Failed to pick image: $e");
  }
}

@override
void didChangeDependencies() {
  super.didChangeDependencies();
  if (!_isInitialized) {
    _viewModel = Provider.of<EditprofileViewModel>(context, listen: false);
    _initAsync(); // <- Move async part here
    _isInitialized = true;
  }
}

void _initAsync() async {
  UserModel? _response = await _viewModel.profileApiCall();
  if (_response != null) {
    Fluttertoast.showToast(msg: _response.responseText ?? "");
  } else {
    Fluttertoast.showToast(msg: "wrong");
  }
}

  void _toggleKeyboard() {
    if (_focusNode.hasFocus) {
      _focusNode.unfocus(); // Hide keyboard
    } else {
      FocusScope.of(context).requestFocus(_focusNode); // Show keyboard
    }
  }

  @override
  Widget build(BuildContext context) {
    final editProfileViewModel = Provider.of<EditprofileViewModel>(context);
    return PlatformScaffold(
      body: SafeArea(
          child: Column(
        children: [
          //Header
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

          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: Column(
                    children: [
                      // Profile image
                      Stack(children: [
                        Container(
                          padding: EdgeInsets.only(top: 20, bottom: 20),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12, // shadow color
                                spreadRadius: 2, // how much the shadow spreads
                                blurRadius: 5, // how soft the shadow is
                                offset: Offset(2, 3), // shadow position (x, y)
                              ),
                            ], // Optional: Rounded corners
                          ),

                          // profile image
                          child: Row(
                            children: [
                              Spacer(),
                              Container(
                                width: 200,
                                height: 200,
                                decoration: BoxDecoration(
                                    color: lightgraykcolor,
                                    shape: BoxShape.circle),
                                child: ClipOval(
                                  child: AspectRatio(
                                      aspectRatio: 1,
                                      child: _imageFile != null
                                          ? Image.file(File(_imageFile!.path))
                                          : ((editProfileViewModel.profileDta
                                                          ?.profileImage
                                                          .toString() ??
                                                      "") !=
                                                  "")
                                              ? Image.network(
                                                  editProfileViewModel
                                                          .profileDta
                                                          ?.profileImage
                                                          .toString() ??
                                                      "",
                                                  fit: BoxFit.cover,
                                                )
                                              : Image.asset(
                                                  "assets/images/profile.png")),
                                ),
                              ),
                              Spacer()
                            ],
                          ),

                          // Profile image
                        ),
                        Positioned(
                          top: 10,
                          right: 110,
                          child: IconButton(
                            onPressed: () {
                              Alert(
                                context: context,
                                type: AlertType
                                    .none, // You can change the type (success, error, info, etc.)
                                title: "Upload Profile Picture",
                                desc:
                                    "Choose an option to set your profile photo",
                                buttons: [
                                  DialogButton(
                                    child: Text(
                                      "Camera",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18),
                                    ),
                                    onPressed: () async {
                                      print("Yes");
                                      Navigator.pop(context);
                                      pickImage(ImageSource.camera);
                                    },
                                    color: Colors.white,
                                  ),
                                  DialogButton(
                                    child: Text(
                                      "Gallery",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18),
                                    ),
                                    onPressed: () {
                                      print("No");
                                      pickImage(ImageSource.gallery);
                                      Navigator.pop(context); // Close the alert
                                    },
                                    color: Colors.white,
                                  )
                                ],
                              ).show();
                            },
                            icon: Image.asset(
                              "assets/images/edit_text.png", // Replace with your image path
                              width: 25,
                              height: 25,
                            ),
                          ),
                        ),
                      ]),

                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12, // shadow color
                              spreadRadius: 2, // how much the shadow spreads
                              blurRadius: 5, // how soft the shadow is
                              offset: Offset(2, 3), // shadow position (x, y)
                            ),
                          ], // Optional: Rounded corners
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: 50,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black, // Black border color
                                  width: 1.0, // Border width
                                ),
                                borderRadius: BorderRadius.circular(
                                    0.0), // Optional: Rounded corners
                              ),
                              child: PlatformTextField(
                                 inputFormatters: [
                                      FilteringTextInputFormatter.deny(RegExp(
                                          r'[0-9]')),
                                    ],
                                  controller: editProfileViewModel
                                      .firstNameController, // (Optional: TextEditingController, currently commented)
                                  // onChanged: addeditAddressViewModel.setFirstName, // Called on text change
                                  keyboardType: TextInputType.emailAddress,
                                  // minLines: 4,         // Minimum height (optional)
                                  // maxLines: null, // Keyboard optimized for name input
                                  onSubmitted: (_) => _toggleKeyboard(),
                                  hintText:
                                      'First Name', // Common hint text (can override per platform)

                                  // iOS Specific Customization
                                  cupertino: (context, platform) =>
                                      CupertinoTextFieldData(
                                        decoration: BoxDecoration(
                                          color: Colors
                                              .transparent, // No background color for iOS field
                                        ),
                                        style: TextStyle(
                                            color: Colors
                                                .black), // Text color on iOS
                                      ),

                                  // Android Specific Customization
                                  material: (context, platform) =>
                                      MaterialTextFieldData(
                                        decoration: InputDecoration(
                                          hintText: 'First Name',
                                          border: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          filled: false, // No background fill
                                          contentPadding: EdgeInsets.all(10),
                                          // Optional: reduce padding
                                        ),
                                      )),
                            ),
                            SizedBox(height: 10),
                            Container(
                              height: 50,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black, // Black border color
                                  width: 1.0, // Border width
                                ),
                                borderRadius: BorderRadius.circular(
                                    0.0), // Optional: Rounded corners
                              ),
                              child: PlatformTextField(
                                 inputFormatters: [
                                      FilteringTextInputFormatter.deny(RegExp(
                                          r'[0-9]')),
                                    ],
                                  controller: editProfileViewModel
                                      .lastNameController, // (Optional: TextEditingController, currently commented)
                                  // onChanged: addeditAddressViewModel.setFirstName, // Called on text change
                                  keyboardType: TextInputType.emailAddress,
                                  // minLines: 4,         // Minimum height (optional)
                                  // maxLines: null, // Keyboard optimized for name input
                                  onSubmitted: (_) => _toggleKeyboard(),
                                  hintText:
                                      'Last Name', // Common hint text (can override per platform)

                                  // iOS Specific Customization
                                  cupertino: (context, platform) =>
                                      CupertinoTextFieldData(
                                        decoration: BoxDecoration(
                                          color: Colors
                                              .transparent, // No background color for iOS field
                                        ),
                                        style: TextStyle(
                                            color: Colors
                                                .black), // Text color on iOS
                                      ),

                                  // Android Specific Customization
                                  material: (context, platform) =>
                                      MaterialTextFieldData(
                                        decoration: InputDecoration(
                                          hintText: 'Last Name',
                                          border: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          filled: false, // No background fill
                                          contentPadding: EdgeInsets.all(10),
                                          // Optional: reduce padding
                                        ),
                                      )),
                            ),
                            SizedBox(height: 10),
                            Container(
                              height: 50,
                              width: double.infinity,
                              child: TextButton(
                                  onPressed: () async {
                                    if (editProfileViewModel
                                            .checkValidation() ==
                                        "success") {
                                      NormalModel? response =
                                          await editProfileViewModel
                                              .updateProfileApi();
                                      if (response?.responseCode == 1) {
                                        Fluttertoast.showToast(
                                            msg: response?.responseText ?? "");
                                      } else {
                                        Fluttertoast.showToast(
                                            msg: response?.responseText ?? "");
                                      }
                                      editProfileViewModel
                                          .navigateMainMenu(context);
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: editProfileViewModel
                                              .checkValidation());
                                    }
                                  },
                                  style: TextButton.styleFrom(
                                    backgroundColor:
                                        Colors.black, // Button background color
                                    foregroundColor: Colors.white, // Text color
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 15),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          0.0), // Rounded corners
                                    ),
                                  ),
                                  child: Text("SUBMIT")),
                            ),
                            SizedBox(height: 40),
                            Container(
                              height: 50,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors
                                              .black, // Black border color
                                          width: 1.0, // Border width
                                        ),
                                        borderRadius: BorderRadius.circular(
                                            0.0), // Optional: Rounded corners
                                      ),
                                      child: PlatformTextField(
                                          controller: editProfileViewModel
                                              .emailController, // (Optional: TextEditingController, currently commented)
                                          // onChanged: addeditAddressViewModel.setFirstName, // Called on text change
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          // minLines: 4,         // Minimum height (optional)
                                          // maxLines: null, // Keyboard optimized for name input
                                          onSubmitted: (_) => _toggleKeyboard(),
                                          hintText:
                                              'Email Address', // Common hint text (can override per platform)

                                          // iOS Specific Customization
                                          cupertino: (context, platform) =>
                                              CupertinoTextFieldData(
                                                decoration: BoxDecoration(
                                                  color: Colors
                                                      .transparent, // No background color for iOS field
                                                ),
                                                style: TextStyle(
                                                    color: Colors
                                                        .black), // Text color on iOS
                                              ),

                                          // Android Specific Customization
                                          material: (context, platform) =>
                                              MaterialTextFieldData(
                                                decoration: InputDecoration(
                                                  hintText: 'Email Address',
                                                  border: InputBorder.none,
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  disabledBorder:
                                                      InputBorder.none,
                                                  filled:
                                                      false, // No background fill
                                                  contentPadding:
                                                      EdgeInsets.all(10),
                                                  // Optional: reduce padding
                                                ),
                                              )),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Container(
                                    color: pinkcolor,
                                    child: TextButton(
                                        onPressed: () async {
                                          if (editProfileViewModel
                                                  .checkValidationForEmail() ==
                                              "success") {
                                            NormalModel? response =
                                                await editProfileViewModel
                                                    .updateEmailApi();
                                            if (response?.responseCode == 1) {
                                              Fluttertoast.showToast(
                                                  msg: response?.responseText ??
                                                      "");
                                            } else {
                                              Fluttertoast.showToast(
                                                  msg: "Somethings Went Wrong");
                                            }
                                            editProfileViewModel
                                                .navigateMainMenu(context);
                                          } else {
                                            Fluttertoast.showToast(
                                                msg: editProfileViewModel
                                                    .checkValidationForEmail());
                                          }
                                        },
                                        child: Text(
                                          "   Update   ",
                                          style: textStyleForButton,
                                        )),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              height: 50,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors
                                              .black, // Black border color
                                          width: 1.0, // Border width
                                        ),
                                        borderRadius: BorderRadius.circular(
                                            0.0), // Optional: Rounded corners
                                      ),
                                      child: PlatformTextField(
                                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                          controller: editProfileViewModel
                                              .phoneController, // (Optional: TextEditingController, currently commented)
                                          // onChanged: addeditAddressViewModel.setFirstName, // Called on text change
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          // minLines: 4,         // Minimum height (optional)
                                          // maxLines: null, // Keyboard optimized for name input
                                          onSubmitted: (_) => _toggleKeyboard(),
                                          hintText:
                                              'Phone Number', // Common hint text (can override per platform)

                                          // iOS Specific Customization
                                          cupertino: (context, platform) =>
                                              CupertinoTextFieldData(
                                                decoration: BoxDecoration(
                                                  color: Colors
                                                      .transparent, // No background color for iOS field
                                                ),
                                                style: TextStyle(
                                                    color: Colors
                                                        .black), // Text color on iOS
                                              ),

                                          // Android Specific Customization
                                          material: (context, platform) =>
                                              MaterialTextFieldData(
                                                decoration: InputDecoration(
                                                  hintText: 'Phone Number',
                                                  border: InputBorder.none,
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  disabledBorder:
                                                      InputBorder.none,
                                                  filled:
                                                      false, // No background fill
                                                  contentPadding:
                                                      EdgeInsets.all(10),
                                                  // Optional: reduce padding
                                                ),
                                              )),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Container(
                                    color: pinkcolor,
                                    child: TextButton(
                                        onPressed: () async {
                                          if (editProfileViewModel
                                                  .checkValidationForPhone() ==
                                              "success") {
                                            NormalModel? response =
                                                await editProfileViewModel
                                                    .updatePhoneApi();
                                            if (response?.responseCode == 1) {
                                              Fluttertoast.showToast(
                                                  msg: response?.responseText ??
                                                      "");
                                            } else {
                                              Fluttertoast.showToast(
                                                  msg: response?.responseText ??
                                                      "");
                                            }
                                            editProfileViewModel
                                                .navigateMainMenu(context);
                                          } else {
                                            Fluttertoast.showToast(
                                                msg: editProfileViewModel
                                                    .checkValidationForPhone());
                                          }
                                        },
                                        child: Text(
                                          "   Update   ",
                                          style: textStyleForButton,
                                        )),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 30)
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
            ),
          )),
        ],
      )),
    );
  }
}
