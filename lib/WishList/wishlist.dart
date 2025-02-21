import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:wg_garment/Config/colors.dart';
import 'package:wg_garment/Config/textstyle.dart';

class WishlistView extends StatefulWidget {
  const WishlistView({super.key});

  @override
  State<WishlistView> createState() => _WishlistViewState();
}

class _WishlistViewState extends State<WishlistView> {
  bool _like = true;
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: SafeArea(
          child: GridView.builder(
              itemCount: 11,
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
                              top: 0,
                              right: 0,
                              child: IconButton(
                                icon: Image.asset(
                                  "assets/images/remove_cart.png", // Replace with your image path
                                  width: 30,
                                  height: 30,
                                ),
                                onPressed: () {
                                  // Action when pressed
                                  print("hello");

                                  setState(() {
                                    
                                  });
                                     
                                },
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: IconButton(
                                icon: Image.asset(
                                  !_like
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
                                  mainAxisAlignment: MainAxisAlignment.center,
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
              })),
    );
  }
}
