import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:wg_garment/Api%20call/imageClass.dart';
import 'package:wg_garment/Category/category_view_model.dart';
import 'package:wg_garment/Config/colors.dart';
import 'package:wg_garment/Config/textstyle.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({super.key});

  @override
  State<CategoryView> createState() => _CategoryState();
}

class _CategoryState extends State<CategoryView> {



  bool _isInitialized = false;


  @override
  void initState() {
    super.initState();
  }

 

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      Provider.of<CategoryViewModel>(context, listen: false).getcategoryList();

      //Provider.of<HomeViewModel>(context).homeApiCall(); // Call API
      _isInitialized = true; // Ensure it's called only once
    }
  }







  @override
  Widget build(BuildContext context) {
 final categoryViewModel = Provider.of<CategoryViewModel>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return PlatformScaffold(
      body: SafeArea(
          child: Column(
        children: [
          Text(
            "Categories",
            style: textStyleForHomePageHeading,
          ),
          SizedBox(height: 10),
          Container(
            color: lightgraykcolor,
             height: 2,
          ),Container(
              height: 40,
              width: screenWidth * 0.8,
              color: Colors.transparent,
              child: ListView.builder(
                  itemCount: categoryViewModel.category_list.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async {
                        categoryViewModel.getsubCategoryList(index);
                      },
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.only(right: 10),
                          child: Text(
                            categoryViewModel.category_list[index].categoryName.toString(),
                            style: categoryViewModel.isSelected == index
                                ? textStyleForCategorytName2
                                : textStyleForCategorytName,
                          ),
                        ),
                      ),
                    );
                  }),
            ),
        Container(
            color: lightgraykcolor,
             height: 2,
          ),
          Expanded(
            child: Container(
              padding:EdgeInsets.only(right: 15,left: 15,),
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: categoryViewModel.subCategory_list.length,
                itemBuilder: (context, index1){
                return GestureDetector(
                  onTap: (){
                    Fluttertoast.showToast(msg: categoryViewModel.subCategory_list[index1].subcategoryId.toString());
                    categoryViewModel.selectedSubCatID = categoryViewModel.subCategory_list[index1].subcategoryId.toString();
                    categoryViewModel.navigateToProductListing(context);
                  },
                  child: Column(
                    children:[ Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: lightgraykcolor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        height: 50,
                        // color: lightgraykcolor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 10),
                            CustomNetworkImage(
                             imageUrl: categoryViewModel.subCategory_list[index1].subcategoryImage.toString(),
                        height: 30,
                        width: 30,
                        fit: BoxFit.fill,
                        ),
                            
                            //Icon(Icons.deblur),
                            SizedBox(width: 10),
                            Text(
                              categoryViewModel.subCategory_list[index1].subcategoryName.toString(),
                              style: textStyleForTextField,
                            ),
                            Spacer(),
                            Icon(Icons.chevron_right_sharp),
                            SizedBox(width: 10),
                          ],
                  
                        ),
                      ),
                      SizedBox(height: 10)
                      ]
                  ),
                );
              }),
            )
            )


        
        ],
      )),
    );
  }
}
