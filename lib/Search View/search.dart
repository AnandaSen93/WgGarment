import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:wg_garment/Api%20call/imageClass.dart';
import 'package:wg_garment/Config/colors.dart';
import 'package:wg_garment/Config/textstyle.dart';
import 'package:wg_garment/Search%20View/search_model.dart';
import 'package:wg_garment/Search%20View/search_view_model.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
late SearchViewModel _viewModel;
 bool _isInitialized = false;

 final FocusNode _focusNode = FocusNode();


 @override
  void dispose() {
    _viewModel.clearData();
    super.dispose();
  }
    
   void _toggleKeyboard() {
    if (_focusNode.hasFocus) {
      _focusNode.unfocus(); // Hide keyboard
    } else {
      FocusScope.of(context).requestFocus(_focusNode); // Show keyboard
    }
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    if (!_isInitialized) {
      _viewModel = Provider.of<SearchViewModel>(context, listen: false);

      //Provider.of<HomeViewModel>(context).homeApiCall(); // Call API
      _isInitialized = true; // Ensure it's called only once
    }
  }



  @override
  Widget build(BuildContext context) {
    final searchViewModel = Provider.of<SearchViewModel>(context);
    return PlatformScaffold(
      body: SafeArea(child: Column(
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
          // Search 
          
          Container(
            padding: EdgeInsets.all(10),
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: lightgraykcolor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  height: 50,
                  // color: lightgraykcolor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       Expanded(
                         child: PlatformTextField(
//                                      obscureText: true,
                                      textInputAction: TextInputAction.done,
                                      //controller: _passwordCon,
                                      onChanged: searchViewModel.setSearchText,
                                      keyboardType: TextInputType.emailAddress,
                                      //focusNode: _focusNode,
                                      onSubmitted: (_) => _toggleKeyboard(),
                                      hintText: "What are you looking for?",
                                      cupertino: (context, platform) =>
                                          CupertinoTextFieldData(
                                        decoration: BoxDecoration(
                                          color: Colors
                                              .transparent, // Remove background color for iOS
                                        ),
                                        // padding: EdgeInsets.symmetric(
                                        //     horizontal: 16.0,
                                        //     vertical: 12.0), // Optional: Custom padding
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      material: (context, platform) =>
                                          MaterialTextFieldData(
                                        decoration: InputDecoration(
                                          filled:
                                              false, // Remove the background color for Android
                                          border: InputBorder.none,
                                contentPadding: EdgeInsets.all(
                                    10), // You can add a border if needed
                                          hintText:
                                              "What are you looking for?", // Optional: hint text for Android
                                        ),
                                      ),
                                    ),
                       ),

                        IconButton(onPressed: ()  async{

                           if (searchViewModel.searchText != ""){
                            
                            SearchListModel? response = await searchViewModel.searchTextApi();
                           }else{
                            Fluttertoast.showToast(msg: "Please enter text for search.");
                           }

                        }, icon: Icon(Icons.search))
                      ],
                  ),
                ),
              ),

          
          // Main Secroll Section

          (searchViewModel.productList.length != 0) ?
          Expanded(
            child:  Container(
            padding: EdgeInsets.all(10),
            child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Number of columns
                        crossAxisSpacing: 8, // Horizontal spacing
                        mainAxisSpacing: 8, // Vertical spacing
                        childAspectRatio: 0.5, // Makes items square
                      ),
                      itemCount: searchViewModel.productList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: (){
                            searchViewModel.navigateToProductDetails(searchViewModel.productList[index].productId ?? "", context);
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: Column(
                              children: [
                                Container(
                                  color: productbackgroundcolor,
                                  child: AspectRatio(
                                    aspectRatio: 0.65,
                                    child: Stack(children: [
                                      //Image.network(productListViewModel.productList[index].productImage.toString()),
                                      CustomNetworkImage(
                                        imageUrl: searchViewModel
                                            .productList[index].productImage
                                            .toString(),
                                        height: double.infinity,
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: IconButton(
                                          icon: Image.asset(
                                            (searchViewModel.productList[index]
                                                        .isWishlist
                                                        .toString() !=
                                                    "1")
                                                ? "assets/images/dislike.png"
                                                : "assets/images/like.png", // Replace with your image path
                                            width: 30,
                                            height: 30,
                                          ),
                                          onPressed: () {
                                            // Action when pressed
                                          },
                                        ),
                                      )
                                    ]),
                                  ),
                                ),
                                Container(
                                  color: Colors.transparent,
                                  child: AspectRatio(
                                    aspectRatio: 4,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            searchViewModel
                                                .productList[index].productName
                                                .toString(),
                                            style: textStyleForProductName,
                                          ),
                                        ),
                                        AspectRatio(
                                          aspectRatio: 1.5,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              (searchViewModel.productList[index] .productSellPrice.toString() != "" && searchViewModel.productList[index] .productSellPrice.toString() != "0.00")
                                                  ? Text(
                                                      searchViewModel
                                                          .productList[index]
                                                          .productSellPrice
                                                          .toString(),
                                                      style: textStyleForMainPrice,
                                                      maxLines: 1,
                                                    )
                                                  : Text(
                                                      searchViewModel
                                                          .productList[index]
                                                          .productOriginalPrice
                                                          .toString(),
                                                      style: textStyleForMainPrice,
                                                      maxLines: 1),
                                              (searchViewModel.productList[index].productSellPrice.toString() == "" || searchViewModel.productList[index].productSellPrice.toString() == "0.00")
                                                  ? Text("",
                                                      style: textStyleForCutPrice,
                                                      maxLines: 1)
                                                  : Text(
                                                      searchViewModel
                                                          .productList[index]
                                                          .productOriginalPrice
                                                          .toString(),
                                                      style: textStyleForCutPrice,
                                                      maxLines: 1)
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  color: Colors.transparent,
                                  child: AspectRatio(
                                    aspectRatio: 5,
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: searchViewModel
                                                .productList[index]
                                                .colorList
                                                ?.length ??
                                            0,
                                        itemBuilder: (context, index1) {
                                          return Container(
                                            //padding: EdgeInsets.only(right: 2),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: Colors.grey,
                                                width: 1,
                                              ),
                                            ),
                                            child: Icon(
                                              Icons.circle,
                                              size: 35,
                                              color: hexToColor(searchViewModel
                                                  .productList[index]
                                                  .colorList![index1]
                                                  .code
                                                  .toString()),
                                            ),
                                          );
                                        }),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
          )
          )
          :  Expanded(
                        child: Center(
                          child: Text(
                            "NO Data Found",
                            style: textStyleForMainProductName,
                          ),
                        ),
                      )
        ],
      )),
    );
  }
}