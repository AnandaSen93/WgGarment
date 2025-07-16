import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:wg_garment/Add%20Edit%20Address/addedit_address_view_model.dart';
import 'package:wg_garment/Config/colors.dart';
import 'package:wg_garment/Config/textstyle.dart';
import 'package:wg_garment/Home/home_model.dart';

class AddEditAddressView extends StatefulWidget {
  const AddEditAddressView({super.key});

  @override
  State<AddEditAddressView> createState() => _AddEditAddressViewState();
}

class _AddEditAddressViewState extends State<AddEditAddressView> {
  bool _isInitialized = false;
  late AddeditAddressViewModel _viewModel;
    @override
  void dispose() {
    _viewModel.clearData();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      _viewModel = Provider.of<AddeditAddressViewModel>(context, listen: false);
      _viewModel.getCountryList();

      //Provider.of<HomeViewModel>(context).homeApiCall(); // Call API
      _isInitialized = true; // Ensure it's called only once
    }
  }

  bool isChecked = false;
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final addeditAddressViewModel =
        Provider.of<AddeditAddressViewModel>(context);

    void _toggleKeyboard() {
      if (_focusNode.hasFocus) {
        _focusNode.unfocus(); // Hide keyboard
      } else {
        FocusScope.of(context).requestFocus(_focusNode); // Show keyboard
      }
    }

    return PlatformScaffold(
      body: SafeArea(
          child: Column(
        children: [
          // Header
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

          // Form

          Expanded(
            child: SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      // First Name
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
                            controller: addeditAddressViewModel
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
                                      color: Colors.black), // Text color on iOS
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

                      // Lsat Name
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
                          controller: addeditAddressViewModel
                              .lastNameController, // (Optional: TextEditingController, currently commented)
                          //onChanged: addeditAddressViewModel.setLastName, // Called on text change
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
                                color: Colors.black), // Text color on iOS
                          ),

                          // Android Specific Customization
                          material: (context, platform) =>
                              MaterialTextFieldData(
                            decoration: InputDecoration(
                              filled: false, // No fill color
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(
                                  10), // Shows border around text field
                              hintText:
                                  'Last Name', // Hint text (optional, also passed above)
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 10),

                      // Company

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
                          controller: addeditAddressViewModel
                              .companyController, // (Optional: TextEditingController, currently commented)
                          //onChanged: addeditAddressViewModel.setCompany, // Called on text change
                          keyboardType: TextInputType.emailAddress,
                          // minLines: 4,         // Minimum height (optional)
                          // maxLines: null, // Keyboard optimized for name input
                          onSubmitted: (_) => _toggleKeyboard(),
                          hintText:
                              'Company', // Common hint text (can override per platform)

                          // iOS Specific Customization
                          cupertino: (context, platform) =>
                              CupertinoTextFieldData(
                            decoration: BoxDecoration(
                              color: Colors
                                  .transparent, // No background color for iOS field
                            ),
                            style: TextStyle(
                                color: Colors.black), // Text color on iOS
                          ),

                          // Android Specific Customization
                          material: (context, platform) =>
                              MaterialTextFieldData(
                            decoration: InputDecoration(
                              filled: false, // No fill color
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(
                                  10), // Shows border around text field
                              hintText:
                                  'Company', // Hint text (optional, also passed above)
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 10),

                      // Address 1

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
                          controller: addeditAddressViewModel
                              .address1Controller, // (Optional: TextEditingController, currently commented)
                          //onChanged: addeditAddressViewModel.setAddress1, // Called on text change
                          keyboardType: TextInputType.emailAddress,
                          // minLines: 4,         // Minimum height (optional)
                          // maxLines: null, // Keyboard optimized for name input
                          onSubmitted: (_) => _toggleKeyboard(),
                          hintText:
                              'Address 1', // Common hint text (can override per platform)

                          // iOS Specific Customization
                          cupertino: (context, platform) =>
                              CupertinoTextFieldData(
                            decoration: BoxDecoration(
                              color: Colors
                                  .transparent, // No background color for iOS field
                            ),
                            style: TextStyle(
                                color: Colors.black), // Text color on iOS
                          ),

                          // Android Specific Customization
                          material: (context, platform) =>
                              MaterialTextFieldData(
                            decoration: InputDecoration(
                              filled: false, // No fill color
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(
                                  10), // Shows border around text field
                              hintText:
                                  'Address 1', // Hint text (optional, also passed above)
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 10),

                      //Address 2

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
                          controller: addeditAddressViewModel
                              .address2Controller, // (Optional: TextEditingController, currently commented)
                          //onChanged: addeditAddressViewModel.setAddress2, // Called on text change
                          keyboardType: TextInputType.emailAddress,
                          // minLines: 4,         // Minimum height (optional)
                          // maxLines: null, // Keyboard optimized for name input
                          onSubmitted: (_) => _toggleKeyboard(),
                          hintText:
                              'Address 2', // Common hint text (can override per platform)

                          // iOS Specific Customization
                          cupertino: (context, platform) =>
                              CupertinoTextFieldData(
                            decoration: BoxDecoration(
                              color: Colors
                                  .transparent, // No background color for iOS field
                            ),
                            style: TextStyle(
                                color: Colors.black), // Text color on iOS
                          ),

                          // Android Specific Customization
                          material: (context, platform) =>
                              MaterialTextFieldData(
                            decoration: InputDecoration(
                              filled: false, // No fill color
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(
                                  10), // Shows border around text field
                              hintText:
                                  'Address 2', // Hint text (optional, also passed above)
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 10),

                      // City

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
                          controller: addeditAddressViewModel
                              .cityController, // (Optional: TextEditingController, currently commented)
                          //onChanged: addeditAddressViewModel/.setCity, // Called on text change
                          keyboardType: TextInputType.emailAddress,
                          // minLines: 4,         // Minimum height (optional)
                          // maxLines: null, // Keyboard optimized for name input
                          onSubmitted: (_) => _toggleKeyboard(),
                          hintText:
                              'City', // Common hint text (can override per platform)

                          // iOS Specific Customization
                          cupertino: (context, platform) =>
                              CupertinoTextFieldData(
                            decoration: BoxDecoration(
                              color: Colors
                                  .transparent, // No background color for iOS field
                            ),
                            style: TextStyle(
                                color: Colors.black), // Text color on iOS
                          ),

                          // Android Specific Customization
                          material: (context, platform) =>
                              MaterialTextFieldData(
                            decoration: InputDecoration(
                              filled: false, // No fill color
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(
                                  10), // Shows border around text field
                              hintText:
                                  'City', // Hint text (optional, also passed above)
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 10),

                      // Post Code

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
                          controller: addeditAddressViewModel
                              .postCodeController, // (Optional: TextEditingController, currently commented)
                          // onChanged: addeditAddressViewModel.setPostCode, // Called on text change
                          keyboardType: TextInputType.emailAddress,
                          // minLines: 4,         // Minimum height (optional)
                          // maxLines: null, // Keyboard optimized for name input
                          onSubmitted: (_) => _toggleKeyboard(),
                          hintText:
                              'Post Code', // Common hint text (can override per platform)

                          // iOS Specific Customization
                          cupertino: (context, platform) =>
                              CupertinoTextFieldData(
                            decoration: BoxDecoration(
                              color: Colors
                                  .transparent, // No background color for iOS field
                            ),
                            style: TextStyle(
                                color: Colors.black), // Text color on iOS
                          ),

                          // Android Specific Customization
                          material: (context, platform) =>
                              MaterialTextFieldData(
                            decoration: InputDecoration(
                              filled: false, // No fill color
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(
                                  10), // Shows border around text field
                              hintText:
                                  'Post Code', // Hint text (optional, also passed above)
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 10),

                      // Country

                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black, // Black border color
                            width: 1.0, // Border width
                          ),
                          borderRadius: BorderRadius.circular(
                              0.0), // Optional: Rounded corners
                        ),
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Material(
                          child: DropdownButton(
                              isExpanded: true,
                              value: addeditAddressViewModel.countryName,
                              items: addeditAddressViewModel.countryList
                                  .map((country) =>
                                      country.countryName as String)
                                  .toList()
                                  .map(
                                    (e) => DropdownMenuItem(
                                        child: Text(
                                          e,
                                          style: textStyleForTextField,
                                          maxLines: 1,
                                        ),
                                        value: e),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                addeditAddressViewModel.countryName =
                                    value.toString();
                                debugPrint("hello");
                                addeditAddressViewModel
                                    .setCountryID(value.toString());

                                setState(() {});
                              }),
                        ),
                      ),

                      SizedBox(height: 10),

                      // State

                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black, // Black border color
                            width: 1.0, // Border width
                          ),
                          borderRadius: BorderRadius.circular(
                              0.0), // Optional: Rounded corners
                        ),
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Material(
                          child: DropdownButton(
                              isExpanded: true,
                              value: addeditAddressViewModel.stateName,
                              items: addeditAddressViewModel.stateList
                                  .map((state) => state.stateName as String)
                                  .toList()
                                  .map(
                                    (e) => DropdownMenuItem(
                                        child: Text(
                                          e,
                                          style: textStyleForTextField,
                                          maxLines: 1,
                                        ),
                                        value: e),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                addeditAddressViewModel.stateName =
                                    value.toString();
                                addeditAddressViewModel
                                    .setStateID(value.toString());

                                setState(() {});
                              }),
                        ),
                      ),

                      SizedBox(height: 10),

                      Container(
                        height: 50,
                        width: double.infinity,
                        //  color: Colors.green,
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  if (addeditAddressViewModel.isDefault ==
                                      "1") {
                                    addeditAddressViewModel.isDefault = "0";
                                  } else {
                                    addeditAddressViewModel.isDefault = "1";
                                  }
                                  setState(() {});
                                },
                                icon: Icon(
                                  (addeditAddressViewModel.isDefault == "1")
                                      ? Icons.check_box
                                      : Icons.check_box_outline_blank,
                                  size: 30,
                                )),
                            Text(
                              "Make it default",
                              style: textStyleForCategorytName,
                            )
                          ],
                        ),
                      ),

                      SizedBox(height: 10),

                      Container(
                        color: pinkcolor,
                        height: 50,
                        width: double.infinity,
                        child: TextButton(
                            onPressed: () async {
                              if (addeditAddressViewModel.checkValidation() ==
                                  "success") {
                                if (addeditAddressViewModel.addressFull?.addressId ==
                                    null) {
                                  NormalModel? response =
                                      await addeditAddressViewModel
                                          .addAddress();
                                  if (response?.responseCode == 1) {
                                    Navigator.pop(context);
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: response?.responseText ?? "");
                                  }
                                                                } else {
                                  NormalModel? response =
                                      await addeditAddressViewModel
                                          .updateAddress();
                                  if (response?.responseCode == 1) {
                                    Navigator.pop(context);
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: response?.responseText ?? "");
                                  }
                                                                }
                              } else {
                                setState(() {
                                  Fluttertoast.showToast(
                                      msg: addeditAddressViewModel
                                          .checkValidation());
                                });
                              }
                             },
                            child: Text(
                              "Add/Edit Address",
                              style: textStyleForButton,
                            )),
                      )

                      //sadsas
                    ],
                  )),
            ),
          )
        ],
      )),
    );
  }
}
