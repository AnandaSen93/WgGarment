import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';
import 'package:wg_garment/Api%20call/imageClass.dart';
import 'package:wg_garment/Category/category_view_model.dart';
import 'package:wg_garment/Config/textstyle.dart';

class CategoryListView extends StatefulWidget {
  const CategoryListView({super.key});

  @override
  State<CategoryListView> createState() => _CategoryListViewState();
}

class _CategoryListViewState extends State<CategoryListView> {
  bool _isInitialized = false;

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
            "Categories",
            style: textStyleForHomePageHeading,
          ),
          Expanded(
              child: Container(
            padding: EdgeInsets.only(left: 8, right: 0, top: 10, bottom: 10),
            child: GridView.builder(
                itemCount: categoryViewModel.category_list.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // Number of columns
                  crossAxisSpacing: 8, // Horizontal spacing
                  mainAxisSpacing: 8, // Vertical spacing
                  childAspectRatio: 0.93, // Makes items square
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: (){
                      categoryViewModel.navigateToSubCat(categoryViewModel.category_list[index].categoryId ?? "", index, context);
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
                                imageUrl: categoryViewModel
                                    .category_list[index].categoryImage
                                    .toString(),
                                fit: BoxFit.fill,
                              ),
                            ),
                            Spacer(),
                            Text(
                              categoryViewModel.category_list[index].categoryName
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
