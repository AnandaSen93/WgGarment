import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wg_garment/Home/home_model.dart';
import 'package:wg_garment/Product%20List/product_list.dart';
import 'package:wg_garment/Product%20List/product_list_view_model.dart';

class SubcategoryViewModel extends ChangeNotifier {

    List<SubCategory> subCategory_list =[];


    void setSubcatList(List<SubCategory> subCategoryList){
      subCategory_list = subCategoryList;
    }

    void navigateToProductListing(String selectedSubCatID, BuildContext context) async {    

    Provider.of<ProductListViewModel>(context, listen: false).setcategoryId(selectedSubCatID);


    // Push the second screen and pass the user data
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductListView(),
      ),
    );

    if (result != null) {
      // Handle the returned result (pop data)
      print("Received Data: $result");
    }
  }

}