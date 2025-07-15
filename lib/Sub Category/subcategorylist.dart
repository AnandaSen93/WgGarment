import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';
import 'package:wg_garment/Api%20call/imageClass.dart';
import 'package:wg_garment/Config/textstyle.dart';
import 'package:wg_garment/Sub%20Category/subcategory_view_model.dart';

class SubCategoryView extends StatefulWidget {
  const SubCategoryView({super.key});

  @override
  State<SubCategoryView> createState() => _SubCategoryViewState();
}

class _SubCategoryViewState extends State<SubCategoryView> {
  @override
  Widget build(BuildContext context) {
        final subcategoryViewModel = Provider.of<SubcategoryViewModel>(context);
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

          Text(
            "Sub Categories",
            style: textStyleForHomePageHeading,
          ),
          Expanded(
              child: Container(
            padding: EdgeInsets.only(left: 8, right: 0, top: 10, bottom: 10),
            child: GridView.builder(
                itemCount: subcategoryViewModel.subCategory_list.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // Number of columns
                  crossAxisSpacing: 8, // Horizontal spacing
                  mainAxisSpacing: 8, // Vertical spacing
                  childAspectRatio: 0.93, // Makes items square
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: (){
                      subcategoryViewModel.navigateToProductListing(subcategoryViewModel.subCategory_list[index].subcategoryId ?? "", context);
                    },
                    child: Container(
                      padding: EdgeInsets.only(right: 8),
                      child: Container(
                        height: double.infinity,
                        color: Colors.transparent,
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                // border: Border.all(
                                //   color: Colors.black, // Black border color
                                //   width: 1.0, // Border width
                                // ),
                                borderRadius: BorderRadius.circular(
                                    10.0), // Optional: Rounded corners
                              ),
                                clipBehavior: Clip.hardEdge,
                              child: CustomNetworkImage(
                                imageUrl: subcategoryViewModel.subCategory_list[index].subcategoryImage.toString(),
                                fit: BoxFit.fill,
                              ),
                            ),
                            Spacer(),
                            Text(
                              subcategoryViewModel.subCategory_list[index].subcategoryName
                                  .toString(),
                              style: textStyleForTextField,
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ))
        ],
      )),
    );
  }
}