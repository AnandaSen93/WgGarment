import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:wg_garment/Config/colors.dart';
import 'package:wg_garment/Config/textstyle.dart';

class ProductListView extends StatefulWidget {
  const ProductListView({super.key});

  @override
  State<ProductListView> createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  bool _like = true;
  String dropdownvalue = 'Apple';
  var items = [
    'Apple',
    'Banana',
    'Grapes',
    'Orange',
    'watermelon',
    'Pineapple'
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return PlatformScaffold(
      body: SafeArea(
          child: Container(
            padding: EdgeInsets.only(left: 10,right: 10),
        child: Column(
          children: [
            Container(
              color: Colors.transparent,
              height: 60,
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {}, icon: Icon(Icons.arrow_back_ios_new)),
                  Spacer(),
                  Image.asset(
                    'assets/images/app_logo.png',
                    fit: BoxFit.contain,
                  ),
                  Spacer()
                ],
              ),
            ),
            SizedBox(height: 15),
            Container(
              color: Colors.transparent,
              height: 40,
              child: Row(
                children: [
                  SizedBox(width: 20),
                  Container(
                    height: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 5),
                          Icon(Icons.sort),
                          Text("Sort     ",style: textStyleForCategorytName,),
                          Icon(Icons.arrow_drop_down),
                          
                        ],
                      )),
                      Spacer(),
                      Container(
                    height: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                           SizedBox(width: 5),
                          Icon(Icons.sort),
                          Text("Filter     ",style: textStyleForCategorytName,),
                          Icon(Icons.arrow_drop_down),
                          
                        ],
                      )),
                      SizedBox(width: 20),
                ],
              ),
            ),
            SizedBox(height: 15),
            Expanded(
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Number of columns
                      crossAxisSpacing: 8, // Horizontal spacing
                      mainAxisSpacing: 8, // Vertical spacing
                      childAspectRatio: 0.5, // Makes items square
                    ),
                    itemBuilder: (context, index) {
                      return Container(
                        color: Colors.transparent,
                        child: Column(
                          children: [
                            Container(
                              color: productbackgroundcolor,
                              child: AspectRatio(
                                aspectRatio: 0.65,
                                child: Stack(children: [
                                  Image.asset('assets/images/product.png'),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: IconButton(
                                      icon: Image.asset(
                                        _like
                                            ? "assets/images/dislike.png"
                                            : "assets/images/like.png", // Replace with your image path
                                        width: 30,
                                        height: 30,
                                      ),
                                      onPressed: () {
                                        // Action when pressed
                                        print("hello");

                                        setState(() {
                                          _like = !_like;
                                        });
                                        print(
                                            "Button Pressed: ${_like ? 'Liked' : 'Disliked'}");
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
                                        'Tristique Mauris Sollicitudin',
                                        style: textStyleForProductName,
                                      ),
                                    ),
                                    AspectRatio(
                                      aspectRatio: 1.5,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text('kr 40.00',
                                              style: textStyleForMainPrice),
                                          Text('kr 55.00',
                                              style: textStyleForCutPrice)
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
                                    itemCount: 4,
                                    itemBuilder: (context, index) {
                                      return Icon(
                                        Icons.circle,
                                        size: 35,
                                        color: Colors.red,
                                      );
                                    }),
                              ),
                            )
                          ],
                        ),
                      );
                    }))
          ],
        ),
      )),
    );
  }
}
