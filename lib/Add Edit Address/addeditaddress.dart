import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:wg_garment/Config/colors.dart';
import 'package:wg_garment/Config/textstyle.dart';

class AddEditAddressView extends StatefulWidget {
  const AddEditAddressView({super.key});

  @override
  State<AddEditAddressView> createState() => _AddEditAddressViewState();
}

class _AddEditAddressViewState extends State<AddEditAddressView> {
  String dropdownCountryvalue = 'India';
  var dropdownCountryItems = ["India"];

  String dropdownCityvalue = 'City 1';
  var dropdownCityItems = ["City 1", "City 2"];
  bool isChecked = false;
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
  

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
                          // controller: _emailCon, // (Optional: TextEditingController, currently commented)
                          // onChanged:checkoutViewModel.setComments , // Called on text change
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
                              filled: false, // No fill color
                              border:
                                  OutlineInputBorder(), // Shows border around text field
                              hintText:
                                  'First Name', // Hint text (optional, also passed above)
                            ),
                          ),
                        ),
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
                          // controller: _emailCon, // (Optional: TextEditingController, currently commented)
                          // onChanged:checkoutViewModel.setComments , // Called on text change
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
                              border:
                                  OutlineInputBorder(), // Shows border around text field
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
                          // controller: _emailCon, // (Optional: TextEditingController, currently commented)
                          // onChanged:checkoutViewModel.setComments , // Called on text change
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
                              border:
                                  OutlineInputBorder(), // Shows border around text field
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
                          // controller: _emailCon, // (Optional: TextEditingController, currently commented)
                          // onChanged:checkoutViewModel.setComments , // Called on text change
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
                              border:
                                  OutlineInputBorder(), // Shows border around text field
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
                          // controller: _emailCon, // (Optional: TextEditingController, currently commented)
                          // onChanged:checkoutViewModel.setComments , // Called on text change
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
                              border:
                                  OutlineInputBorder(), // Shows border around text field
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
                          // controller: _emailCon, // (Optional: TextEditingController, currently commented)
                          // onChanged:checkoutViewModel.setComments , // Called on text change
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
                              border:
                                  OutlineInputBorder(), // Shows border around text field
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
                          // controller: _emailCon, // (Optional: TextEditingController, currently commented)
                          // onChanged:checkoutViewModel.setComments , // Called on text change
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
                              border:
                                  OutlineInputBorder(), // Shows border around text field
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
                              value: dropdownCountryvalue,
                              items: dropdownCountryItems
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
                                setState(() {
                                  dropdownCountryvalue = value.toString();
                                });
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
                              value: dropdownCityvalue,
                              items: dropdownCityItems
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
                                setState(() {
                                  dropdownCityvalue = value.toString();
                                });
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
                                  setState(() {
                                    isChecked = !isChecked;
                                  });
                                },
                                icon: Icon(
                                  isChecked ? Icons.check_box : Icons.check_box_outline_blank,
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
                        child: TextButton(onPressed: (){

                        }, child: Text("Add/Edit Address",
                        style: textStyleForButton,)),
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
