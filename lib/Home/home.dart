import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:wg_garment/Config/colors.dart';
import 'package:wg_garment/Config/textstyle.dart';
import 'package:wg_garment/Product%20Details/product_details.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
   bool _like = true;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

   

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
                color: Colors.red,
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
                          itemCount: 10,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.only(right: 8),
                              child: Container(
                                height: double.infinity,
                                color: Colors.transparent,
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "assets/images/category.png",
                                      height: 120,
                                      fit: BoxFit.fill,
                                    ),
                                    Spacer(),
                                    Text(
                                      "Category Name",
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
                      height: ((((screenWidth - 30) / 2) * 2.06) * 2),
                      child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: 4,
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
                                    builder: (context) => ProductDetailsView()));
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
                                          Image.asset(
                                              'assets/images/product.png'),
                                          Positioned(
                                            bottom: 0,
                                            right: 0,
                                            child: IconButton(
                                              icon:   Image.asset( 
                                                _like ? "assets/images/dislike.png":"assets/images/like.png", // Replace with your image path
                                                width: 30,
                                                height: 30,
                                               ),
                                              onPressed: () {
                                                // Action when pressed
                                                print("hello");
                                                
                                                setState(() {
                                                  _like = !_like;
                                                });
                                                print("Button Pressed: ${_like ? 'Liked' : 'Disliked'}");
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
                                                      style:
                                                          textStyleForMainPrice),
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
              Container(
                height: 200,
                color: Colors.red,
              ),
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
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.only(right: 8),
                               height: double.infinity,
                               width: ((screenWidth  /  2.07)),
                              color: Colors.transparent,
                              child: Column(
                                children: [
                                  Container(                                   
                                    color: productbackgroundcolor,
                                    child: AspectRatio(
                                      aspectRatio: 0.65,
                                      child: Stack(children: [
                                        Image.asset(
                                            'assets/images/product.png'),
                                        Positioned(
                                          bottom: 0,
                                          right: 0,
                                          child: IconButton(
                                            icon:   Image.asset( 
                                              _like ? "assets/images/dislike.png":"assets/images/like.png", // Replace with your image path
                                              width: 30,
                                              height: 30,
                                             ),
                                            onPressed: () {
                                              // Action when pressed
                                              print("hello");
                                              
                                              setState(() {
                                                _like = !_like;
                                              });
                                              print("Button Pressed: ${_like ? 'Liked' : 'Disliked'}");
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
                                                    style:
                                                        textStyleForMainPrice),
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
                          }),
                    ),
                  ],
                ),
              ),
              // Most wanted end
              SizedBox(height: 10),

              // banner 3 start
              Container(
                height: 200,
                color: Colors.red,
              ),
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
                      height: ((((screenWidth - 30) / 2) * 2.06) * 2),
                      child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: 4,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
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
                                        Image.asset(
                                            'assets/images/product.png'),
                                        Positioned(
                                          bottom: 0,
                                          right: 0,
                                          child: IconButton(
                                            icon:   Image.asset( 
                                              _like ? "assets/images/dislike.png":"assets/images/like.png", // Replace with your image path
                                              width: 30,
                                              height: 30,
                                             ),
                                            onPressed: () {
                                              // Action when pressed
                                              print("hello");
                                              
                                              setState(() {
                                                _like = !_like;
                                              });
                                              print("Button Pressed: ${_like ? 'Liked' : 'Disliked'}");
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
                                                    style:
                                                        textStyleForMainPrice),
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
