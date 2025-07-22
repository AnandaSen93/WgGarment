import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:wg_garment/Address%20List/addresslist_view_model.dart';
import 'package:wg_garment/Config/textstyle.dart';
import 'package:wg_garment/Home/home_model.dart';

fgfgfgfgfg

class AddresslistView extends StatefulWidget {
  const AddresslistView({super.key});

  @override
  State<AddresslistView> createState() => _AddresslistViewState();
}

class _AddresslistViewState extends State<AddresslistView> {
  bool _isInitialized = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      Provider.of<AddresslistViewModel>(context, listen: false)
          .getAddressList();

      //Provider.of<HomeViewModel>(context).homeApiCall(); // Call API
      _isInitialized = true; // Ensure it's called only once
    }
  }

  @override
  Widget build(BuildContext context) {
    final addresslistViewModel = Provider.of<AddresslistViewModel>(context);

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return PlatformScaffold(
      body: SafeArea(
          child: Column(children: [
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

        // Add Address Button
        Expanded(
          child: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black, // Black border color
                        width: 1, // Border width
                      ),
                      borderRadius: BorderRadius.circular(
                          5.0), // Optional: Rounded corners
                    ),
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      child: TextButton(
                          onPressed: () {
                            addresslistViewModel
                                .navigateToAddEditAddress(context);
                          },
                          child: Text(
                            "Add New Address",
                            style: textStyleForMainProductName,
                          )),
                    )),
                SizedBox(height: 10),
                addresslistViewModel.addressList.length != 0
                    ? Expanded(
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: addresslistViewModel.addressList.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  if (addresslistViewModel.addressType != "") {
                                    Navigator.pop(context, {
                                      'form': addresslistViewModel.addressType,
                                      'address': addresslistViewModel
                                          .addressList[index],
                                    });
                                  }
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black12, // shadow color
                                            spreadRadius:
                                                2, // how much the shadow spreads
                                            blurRadius:
                                                5, // how soft the shadow is
                                            offset: Offset(
                                                2, 3), // shadow position (x, y)
                                          ),
                                        ], // Optional: Rounded corners
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 30,
                                              width: double.infinity,
                                              child: Row(
                                                children: [
                                                  Container(
                                                    //padding: EdgeInsets.only(top: 10,bottom: 10),
                                                    //width: double.infinity,
                                                    child: Text(
                                                      (addresslistViewModel
                                                                  .addressList[
                                                                      index]
                                                                  .firstName ??
                                                              "") +
                                                          " " +
                                                          (addresslistViewModel
                                                                  .addressList[
                                                                      index]
                                                                  .lastName ??
                                                              ""),
                                                      style:
                                                          textStyleForMainProductName,
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  IconButton(
                                                      onPressed: () {
                                                        addresslistViewModel
                                                            .navigateToAddEditAddressWithData(
                                                                addresslistViewModel
                                                                        .addressList[
                                                                    index],
                                                                context);
                                                      },
                                                      icon: Icon(
                                                        Icons.edit,
                                                        size:
                                                            20, // This controls both width and height (icons are square)
                                                        color: Colors.green,
                                                      )),
                                                  addresslistViewModel
                                                              .addressList[
                                                                  index]
                                                              .isDefault ==
                                                          "0"
                                                      ? IconButton(
                                                          onPressed: () async {
                                                            NormalModel?
                                                                response =
                                                                await addresslistViewModel.deleteAddress(
                                                                    addresslistViewModel
                                                                            .addressList[index]
                                                                            .addressId ??
                                                                        "");
                                                            if (response?.responseCode ==
                                                                1) {
                                                              Fluttertoast.showToast(
                                                                  msg: response?.responseText ??
                                                                      "");
                                                            } else {
                                                              Fluttertoast.showToast(
                                                                  msg: response?.responseText ??
                                                                      "");
                                                            }
                                                                                                                    },
                                                          icon: Icon(
                                                            Icons.delete,
                                                            size:
                                                                20, // This controls both width and height (icons are square)
                                                            color: Colors.red,
                                                          ))
                                                      : SizedBox()
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              width: double.infinity,
                                              child: Text(
                                                (addresslistViewModel
                                                            .addressList[index]
                                                            .houseOne ??
                                                        "") +
                                                    "," +
                                                    (addresslistViewModel
                                                            .addressList[index]
                                                            .houseTwo ??
                                                        "") +
                                                    "," +
                                                    (addresslistViewModel
                                                            .addressList[index]
                                                            .city ??
                                                        "") +
                                                    "," +
                                                    (addresslistViewModel
                                                            .addressList[index]
                                                            .state ??
                                                        "") +
                                                    "," +
                                                    (addresslistViewModel
                                                            .addressList[index]
                                                            .country ??
                                                        "") +
                                                    "," +
                                                    (addresslistViewModel
                                                            .addressList[index]
                                                            .pincode ??
                                                        ""),
                                                style:
                                                    textStyleForMainProductDescription,
                                                textAlign: TextAlign.left,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10)
                                  ],
                                ),
                              );
                            }),
                      )
                    : Expanded(
                        child: Center(
                          child: Text(
                            "NO Data Found",
                            style: textStyleForMainProductName,
                          ),
                        ),
                      )
              ],
            ),
          ),
        )
      ])),
    );
  }
}
