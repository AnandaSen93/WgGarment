import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';
import 'package:wg_garment/Config/colors.dart';
import 'package:wg_garment/Config/textstyle.dart';
import 'package:wg_garment/Home/home_model.dart';
import 'package:wg_garment/Home/home_view_model.dart';
import 'package:wg_garment/Product%20Details/product_details.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool _like = true;
  bool _isInitialized = false;
  List<String> banner_image_List = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];

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
      Provider.of<HomeViewModel>(context, listen: false).homeApiCall();

      //Provider.of<HomeViewModel>(context).homeApiCall(); // Call API
      _isInitialized = true; // Ensure it's called only once
    }
  }

  @override
  Widget build(BuildContext context) {
    final homeViewModel = Provider.of<HomeViewModel>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    void homeApiCall() {
      homeViewModel.homeApiCall();
    }

    return PlatformScaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: [
              // Search Start
              Container(
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
                      Icon(Icons.search),
                      Text(
                        "What are you looking for?",
                        style: textStyleForTextField,
                      )
                    ],
                  ),
                ),
              ),
              //Search End

              SizedBox(height: 10),

              // Banner 1 start

              Container(
                height: 200,
                color: Colors.transparent,
                child: (homeViewModel.topbanner.length != 0)
                    ? ImageSlideshow(
                        indicatorColor: Colors.blue,
                        onPageChanged: (value) {},
                        autoPlayInterval: 3000,
                        isLoop: true,
                        children: homeViewModel
                                .homeModel.responseData?.slidingBanner
                                ?.map((imageUrl) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  imageUrl.image
                                      .toString(), // Convert String to Widget
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              );
                            }).toList() ??
                            [],
                      )
                    : Container(
                        color: Colors.grey[300],
                        child: Center(
                          child: Text("No images available"),
                        ),
                      ),
              ),
              //Banner 2 end
              SizedBox(height: 10),

              // Categories Start
              Container(
                color: Colors.transparent,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Categories",
                          style: textStyleForHomePageHeading,
                        ),
                        Spacer(),
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              "View All",
                              style: textStyleForViewAll,
                            ))
                      ],
                    ),
                    SizedBox(height: 10),
                    Container(
                      color: Colors.transparent,
                      height: 150,
                      child: ListView.builder(
                          itemCount: homeViewModel.topCategory.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.only(right: 8),
                              child: Container(
                                height: double.infinity,
                                color: Colors.transparent,
                                child: Column(
                                  children: [
                                    Image.network(
                                      homeViewModel
                                          .topCategory[index].categoryImage
                                          .toString(),
                                      height: 120,
                                      fit: BoxFit.fill,
                                    ),
                                    Spacer(),
                                    Text(
                                      homeViewModel
                                          .topCategory[index].categoryName
                                          .toString(),
                                      style: textStyleForTextField,
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                    )
                  ],
                ),
              ),
              // Categories End

              SizedBox(height: 10),

              // New Arrival Start
              Container(
                color: Colors.transparent,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "New Arrival ",
                          style: textStyleForHomePageHeading,
                        ),
                        Spacer(),
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              "View All",
                              style: textStyleForViewAll,
                            ))
                      ],
                    ),
                    SizedBox(height: 10),
                    Container(
                      color: Colors.transparent,
                      height: ((((screenWidth - 30) / 2) * 2.06) * (homeViewModel.newArrival.length/2).ceil()), 
                      child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: homeViewModel.newArrival.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // Number of columns
                            crossAxisSpacing: 8, // Horizontal spacing
                            mainAxisSpacing: 8, // Vertical spacing
                            childAspectRatio: 0.5, // Makes items square
                          ),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ProductDetailsView()));
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
                                          Image.network(
                                            homeViewModel
                                                .newArrival[index].productImage
                                                .toString(),
                                            height: double.infinity,
                                            fit: BoxFit.fill,
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            right: 0,
                                            child: IconButton(
                                              icon: Image.asset(
                                                (homeViewModel.newArrival[index]
                                                            .isWishlist ==
                                                        "0")
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
                                                homeViewModel.newArrival[index]
                                                    .productName
                                                    .toString(),
                                                maxLines: 2,
                                                style: textStyleForProductName,
                                              ),
                                            ),
                                            AspectRatio(
                                              aspectRatio: 1.5,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  (homeViewModel
                                                              .newArrival[index]
                                                              .productSellPrice
                                                              .toString() !=
                                                          "")
                                                      ? Text(
                                                          homeViewModel
                                                              .newArrival[index]
                                                              .productSellPrice
                                                              .toString(),
                                                          style:
                                                              textStyleForMainPrice,maxLines: 1,)
                                                      : Text(
                                                          homeViewModel
                                                              .newArrival[index]
                                                              .productOriginalPrice
                                                              .toString(),
                                                          style:
                                                              textStyleForMainPrice,maxLines: 1),
                                                  (homeViewModel
                                                              .newArrival[index]
                                                              .productSellPrice
                                                              .toString() ==
                                                          "")
                                                      ? Text("",
                                                          style:
                                                              textStyleForCutPrice,maxLines: 1)
                                                      : Text(
                                                          homeViewModel
                                                              .newArrival[index]
                                                              .productOriginalPrice
                                                              .toString(),
                                                          style:
                                                              textStyleForCutPrice,maxLines: 1)
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
                                            itemCount: homeViewModel
                                                .newArrival[index]
                                                .colorList
                                                ?.length,
                                            itemBuilder: (context, index2) {
                                              return Icon(
                                                Icons.circle,
                                                size: 35,
                                                color: hexToColor(homeViewModel
                                                    .newArrival[index]
                                                    .colorList![index2]
                                                    .code
                                                    .toString()),
                                              );
                                            }),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),

              // New Arrival End
              SizedBox(height: 10),

              // banner 2 start

              homeViewModel.allBanner.length > 0
                  ? Container(
                      height: 200,
                      color: Colors.red,
                      child: Image.network(
                        homeViewModel.allBanner[0].image.toString(),
                        height: double.infinity,
                        width: double.infinity,
                        fit: BoxFit.fill,
                      ),
                    )
                  : SizedBox(height: 0),
              // banner 2 end
              SizedBox(height: 10),
              // Most wanted start
              Container(
                color: Colors.transparent,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Most Wanted ",
                          style: textStyleForHomePageHeading,
                        ),
                        Spacer(),
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              "View All",
                              style: textStyleForViewAll,
                            ))
                      ],
                    ),
                    SizedBox(height: 10),
                    Container(
                      color: Colors.transparent,
                      height: screenWidth - 30,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: homeViewModel.mostWanted.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ProductDetailsView()));
                              },
                              child: Container(
                                padding: EdgeInsets.only(right: 8),
                                height: double.infinity,
                                width: ((screenWidth / 2.07)),
                                color: Colors.transparent,
                                child: Column(
                                  children: [
                                    Container(
                                      color: productbackgroundcolor,
                                      child: AspectRatio(
                                        aspectRatio: 0.65,
                                        child: Stack(children: [
                                          Image.network(homeViewModel
                                              .mostWanted[index].productImage
                                              .toString(),
                                              height: double.infinity,
                                              width: double.infinity,
                                              fit: BoxFit.fill,
                                              ),
                                          Positioned(
                                            bottom: 0,
                                            right: 0,
                                            child: IconButton(
                                              icon: Image.asset(
                                                (homeViewModel.mostWanted[index]
                                                            .isWishlist ==
                                                        "1")
                                                    ? "assets/images/dislike.png"
                                                    : "assets/images/like.png", // Replace with your image path
                                                width: 30,
                                                height: 30,
                                              ),
                                              onPressed: () {
                                                // Action when pressed
                                                print("hello");

                                                setState(() {
                                                  // wishlistApi call
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
                                                homeViewModel.mostWanted[index]
                                                    .productName
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
                                                  (homeViewModel
                                                              .mostWanted[index]
                                                              .productSellPrice
                                                              .toString() !=
                                                          "")
                                                      ? Text(
                                                          homeViewModel
                                                              .mostWanted[index]
                                                              .productSellPrice
                                                              .toString(),
                                                          style:
                                                              textStyleForMainPrice,maxLines: 1,)
                                                      : Text(
                                                          homeViewModel
                                                              .mostWanted[index]
                                                              .productOriginalPrice
                                                              .toString(),
                                                          style:
                                                              textStyleForMainPrice,maxLines: 1,),
                                                  (homeViewModel
                                                              .mostWanted[index]
                                                              .productSellPrice
                                                              .toString() ==
                                                          "")
                                                      ? Text("",
                                                          style:
                                                              textStyleForCutPrice,maxLines: 1,)
                                                      : Text(
                                                          homeViewModel
                                                              .mostWanted[index]
                                                              .productOriginalPrice
                                                              .toString(),
                                                          style:
                                                              textStyleForCutPrice,maxLines: 1,)
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
                                            itemCount: homeViewModel
                                                .mostWanted[index]
                                                .colorList
                                                ?.length,
                                            itemBuilder: (context, index2) {
                                              return Icon(
                                                Icons.circle,
                                                size: 35,
                                                color: hexToColor(homeViewModel
                                                    .mostWanted[index]
                                                    .colorList![index2]
                                                    .code
                                                    .toString()),
                                              );
                                            }),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
              // Most wanted end
              SizedBox(height: 10),

              // banner 3 start
              homeViewModel.allBanner.length > 1
                  ? Container(
                      height: 200,
                      color: Colors.red,
                      child: Image.network(
                        homeViewModel.allBanner[1].image.toString(),
                        height: double.infinity,
                        width: double.infinity,
                        fit: BoxFit.fill,
                      ),
                    )
                  : SizedBox(height: 0),
              // banner 3 end

              // Back in Stock Start
              Container(
                color: Colors.transparent,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Back in Stock ",
                          style: textStyleForHomePageHeading,
                        ),
                        Spacer(),
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              "View All",
                              style: textStyleForViewAll,
                            ))
                      ],
                    ),
                    SizedBox(height: 10),
                    Container(
                      color: Colors.transparent,
                      height: ((((screenWidth - 30) / 2) * 2.06) * (homeViewModel.backInaStack.length/2).ceil()),
                      child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: homeViewModel.backInaStack.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // Number of columns
                            crossAxisSpacing: 8, // Horizontal spacing
                            mainAxisSpacing: 8, // Vertical spacing
                            childAspectRatio: 0.5, // Makes items square
                          ),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ProductDetailsView()));
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
                                          Image.network(
                                            homeViewModel
                                                .backInaStack[index].productImage
                                                .toString(),
                                            height: double.infinity,
                                            fit: BoxFit.fill,
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            right: 0,
                                            child: IconButton(
                                              icon: Image.asset(
                                                (homeViewModel.backInaStack[index]
                                                            .isWishlist ==
                                                        "0")
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
                                                homeViewModel.backInaStack[index]
                                                    .productName
                                                    .toString(),
                                                maxLines: 2,
                                                style: textStyleForProductName,
                                              ),
                                            ),
                                            AspectRatio(
                                              aspectRatio: 1.5,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  (homeViewModel
                                                              .backInaStack[index]
                                                              .productSellPrice
                                                              .toString() !=
                                                          "")
                                                      ? Text(
                                                          homeViewModel
                                                              .backInaStack[index]
                                                              .productSellPrice
                                                              .toString(),
                                                          style:
                                                              textStyleForMainPrice,maxLines: 1,)
                                                      : Text(
                                                          homeViewModel
                                                              .backInaStack[index]
                                                              .productOriginalPrice
                                                              .toString(),
                                                          style:
                                                              textStyleForMainPrice,maxLines: 1),
                                                  (homeViewModel
                                                              .backInaStack[index]
                                                              .productSellPrice
                                                              .toString() ==
                                                          "")
                                                      ? Text("",
                                                          style:
                                                              textStyleForCutPrice,maxLines: 1)
                                                      : Text(
                                                          homeViewModel
                                                              .backInaStack[index]
                                                              .productOriginalPrice
                                                              .toString(),
                                                          style:
                                                              textStyleForCutPrice,maxLines: 1)
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
                                            itemCount: homeViewModel
                                                .backInaStack[index]
                                                .colorList
                                                ?.length,
                                            itemBuilder: (context, index2) {
                                              return Icon(
                                                Icons.circle,
                                                size: 35,
                                                color: hexToColor(homeViewModel
                                                    .backInaStack[index]
                                                    .colorList![index2]
                                                    .code
                                                    .toString()),
                                              );
                                            }),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
              // Back in Stock End
            ],
          ),
        ),
      )),
    );
  }
}
