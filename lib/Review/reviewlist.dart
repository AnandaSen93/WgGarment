import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:wg_garment/Api%20call/imageClass.dart';
import 'package:wg_garment/Config/colors.dart';
import 'package:wg_garment/Config/textstyle.dart';
import 'package:wg_garment/Home/home_model.dart';
import 'package:wg_garment/Review/reviewlist_view_model.dart';

class ReviewListView extends StatefulWidget {
  const ReviewListView({super.key});

  @override
  State<ReviewListView> createState() => _ReviewListViewState();
}

class _ReviewListViewState extends State<ReviewListView> {
  bool _isInitialized = false;
  late ReviewlistViewModel _viewModel;
  final FocusNode _focusNode = FocusNode();
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      _viewModel = Provider.of<ReviewlistViewModel>(context, listen: false);
      _viewModel..getReviewList();

      //Provider.of<HomeViewModel>(context).homeApiCall(); // Call API
      _isInitialized = true; // Ensure it's called only once
    }
  }

  void showTwoFieldDialog(BuildContext context) {
    void _toggleKeyboard() {
      if (_focusNode.hasFocus) {
        _focusNode.unfocus(); // Hide keyboard
      } else {
        FocusScope.of(context).requestFocus(_focusNode); // Show keyboard
      }
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Container(
            width: double.infinity,
            child: Text(
              "Add Review",
              style: textStyleForredText,
              textAlign: TextAlign.center,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: pinkcolor, // Black border color
                    width: 0.5, // Border width
                  ),
                  borderRadius:
                      BorderRadius.circular(10.0), // Optional: Rounded corners
                ),
                width: double.infinity,
                height: 100,
                child: PlatformTextField(
                  controller: _viewModel
                      .commentsController, // (Optional: TextEditingController, currently commented)

                  keyboardType: TextInputType.multiline,
                  minLines: 4, // Minimum height (optional)
                  maxLines: null,
                  onSubmitted: (_) =>
                      _toggleKeyboard(), // Keyboard optimized for name input
                  hintText:
                      'Add comments...', // Common hint text (can override per platform)

                  // iOS Specific Customization
                  cupertino: (context, platform) => CupertinoTextFieldData(
                    decoration: BoxDecoration(
                      color: Colors
                          .transparent, // No background color for iOS field
                    ),
                    style: TextStyle(color: Colors.black), // Text color on iOS
                  ),

                  // Android Specific Customization
                  material: (context, platform) => MaterialTextFieldData(
                    decoration: InputDecoration(
                      filled: false, // No fill color
                      border:
                          OutlineInputBorder(), // Shows border around text field
                      hintText:
                          'Add comments...', // Hint text (optional, also passed above)
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: double.infinity,
                child: RatingBar(
                  filledIcon: Icons.star,
                  emptyIcon: Icons.star_border,
                  emptyColor: pinkcolor,
                  filledColor: pinkcolor,
                  initialRating: 1,
                  maxRating: 5,
                  size: 40,
                  alignment: Alignment.center,
                  onRatingChanged: (value) => _viewModel.ratingValue = value.toString(),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: pinkcolor,
                  border: Border.all(
                    color: pinkcolor, // Black border color
                    width: 0.5, // Border width
                  ),
                  borderRadius:
                      BorderRadius.circular(5.0), // Optional: Rounded corners
                ),
                child: TextButton(
                    onPressed: () async {
                      

                      NormalModel? response = await _viewModel.addReview();
                      if (response != null) {
                          Fluttertoast.showToast(
                              msg: response.responseText ?? "");
                              Navigator.of(context).pop();
                        
                      }
                    },
                    child: Text(
                      "Submit",
                      style: textStyleForButton,
                      textAlign: TextAlign.center,
                    )),
              )
            ],
          ),
          actions: [],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final reviewlistViewModel = Provider.of<ReviewlistViewModel>(context);
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
          SizedBox(height: 10),
          Row(
            children: [
              Spacer(),
              Container(
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: pinkcolor, // Black border color
                    width: 1.0, // Border width
                  ),
                  borderRadius:
                      BorderRadius.circular(10.0), // Optional: Rounded corners
                ),
                child: Container(
                  child: TextButton(
                      onPressed: () {
                        showTwoFieldDialog(context);
                      },
                      child: Text(
                        " Add a Review ",
                        style: textstyleNormalBlackText,
                      )),
                ),
              ),
              SizedBox(width: 10),
            ],
          ),

          SizedBox(height: 10),

          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  itemCount: reviewlistViewModel.reviewList.length,
                  shrinkWrap:
                      true, // Ensures ListView takes up space only for its children
                  physics: NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 10); // Adds space between items
                  },
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        // border: Border.all(
                        //   color: Colors.black, // Black border color
                        //   width: 0.5, // Border width
                        // ),
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26, // shadow color
                            spreadRadius: 2, // how much the shadow spreads
                            blurRadius: 5, // how soft the shadow is
                            offset: Offset(2, 3), // shadow position (x, y)
                          ),
                        ], // Optional: Rounded corners
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(15),
                            child: Container(
                              // padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  color: Colors.black, shape: BoxShape.circle),
                              child: ClipOval(
                                child: Container(
                                    height: 80,
                                    width: 80,
                                    child: CustomNetworkImage(
                                      imageUrl: reviewlistViewModel
                                              .reviewList[index].userImage
                                              .toString() ??
                                          "",
                                      height: double.infinity,
                                      width: double.infinity,
                                    )),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      reviewlistViewModel
                                              .reviewList[index].userName
                                              .toString() ??
                                          "",
                                      style: textStyleForCategorytName2),
                                  SizedBox(height: 5),
                                  RatingBar.readOnly(
                                    filledIcon: Icons.star,
                                    emptyIcon: Icons.star_border,
                                    emptyColor: pinkcolor,
                                    filledColor: pinkcolor,
                                    initialRating: double.parse(
                                        reviewlistViewModel
                                                .reviewList[index].rating
                                                .toString() ??
                                            "0.0"),
                                    maxRating: 5,
                                    size: 20,
                                  ),
                                  SizedBox(height: 5),
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    child: Text(
                                        reviewlistViewModel
                                                .reviewList[index].review
                                                .toString() ??
                                            "",
                                        style: textStyleForProductName),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );

                    ;
                  }),
            ),
          )
        ],
      )),
    );
  }
}
