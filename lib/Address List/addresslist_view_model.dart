import 'package:flutter/material.dart';
import 'package:wg_garment/Add%20Edit%20Address/addeditaddress.dart';

class AddresslistViewModel extends ChangeNotifier {




  void navigateToAddEditAddress(BuildContext context) async {    

   // Provider.of<ProductListViewModel>(context, listen: false).setcategoryId(selectedSubCatID);


    // Push the second screen and pass the user data
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEditAddressView(),
      ),
    );

    if (result != null) {
      // Handle the returned result (pop data)
      print("Received Data: $result");
    }
  }


}