import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';
import 'package:wg_garment/Add%20Edit%20Address/addeditaddress.dart';
import 'package:wg_garment/Address%20List/addresslist_view_model.dart';
import 'package:wg_garment/Config/textstyle.dart';

class AddresslistView extends StatefulWidget {
  const AddresslistView({super.key});

  @override
  State<AddresslistView> createState() => _AddresslistViewState();
}

class _AddresslistViewState extends State<AddresslistView> {
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
                        width: 0.5, // Border width
                      ),
                      borderRadius: BorderRadius.circular(
                          5.0), // Optional: Rounded corners
                    ),
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      child: TextButton(
                          onPressed: () {
                            addresslistViewModel.navigateToAddEditAddress(context);
                          },
                          child: Text(
                            "Add New Address",
                            style: textStyleForMainProductName,
                          )),
                    )),
                SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black, // Black border color
                                  width: 0.5, // Border width
                                ),
                                borderRadius: BorderRadius.circular(
                                    2.0), // Optional: Rounded corners
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
                                          Spacer(),
                                          IconButton(
                                              onPressed: () {},
                                              icon: Icon(
                                                Icons.edit,
                                                size:20, // This controls both width and height (icons are square)
                                                color: Colors.black45,
                                              )),
                                          IconButton(
                                              onPressed: () {},
                                              icon: Icon(
                                                Icons.delete,
                                                size:20, // This controls both width and height (icons are square)
                                                color: Colors.red,
                                              ))
                                        ],
                                      ),
                                    ),
                                    Container(
                                      //padding: EdgeInsets.only(top: 10,bottom: 10),
                                      width: double.infinity,
                                      height: 25,
                                      child: Text(
                                        "Name Name",
                
                                        style: textStyleForMainProductName,
                                      ),
                                    ),
                                    Text("21 Custom House Street, Suite 700, Boston, MA 02110, United States21 Custom House Street, Suite 700, Boston, MA 02110, United States",
                                         style: textStyleForMainProductName,
                                    )
                                  
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 10)
                          ],
                        );
                      }),
                ),
              ],
            ),
          ),
        )
      ])),
    );
  }
}
