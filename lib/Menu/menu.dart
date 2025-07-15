import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:wg_garment/Category/category.dart';
import 'package:wg_garment/Config/colors.dart';
import 'package:wg_garment/Config/textstyle.dart';
import 'package:wg_garment/Home/home.dart';
import 'package:wg_garment/Menu/menu_view_model.dart';
import 'package:wg_garment/Profile/profile.dart';
import 'package:wg_garment/WishList/wishlist.dart';
import 'package:wg_garment/cart/cart.dart';

class MenuView extends StatefulWidget {
  const MenuView({super.key});

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> with RouteAware{



  
  var pageList = [ ];

  late MenuViewModel _viewModel;
  bool _isInitialized = false;
  @override
  void initState() {
    super.initState();
    pageList = [
    HomeView(onCButtonPressed: fetchMenuData),
    CategoryView(),
    WishlistView(),
    CartView(onCButtonPressed: fetchMenuData),
    ProfileView(),
  ];
  }

  @override
  void dispose() {
    _viewModel.clearData();
    super.dispose();
  }

  void _onItemTapped(int index) {
    fetchMenuData();
    setState(() {
      _viewModel.selectedIndex = index;
    });
  }


  @override
  void didPopNext() {
    print("Returned to First Screen! (Like viewDidAppear)");
    // This method is called when coming back from the Second Screen
  }

    @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    if (!_isInitialized) {
     await fetchMenuData();
     _isInitialized = true;
    }
  }

  Future<void> fetchMenuData() async {
  _viewModel = Provider.of<MenuViewModel>(context, listen: false);

  final response = await _viewModel.countApi();
  if (response != null) {
    if (response.responseCode != 1) {
      Fluttertoast.showToast(msg: response.responseText ?? "");
    }
  } else {
    Fluttertoast.showToast(msg: "Somethings went wrong!");
  }
}

  @override
  Widget build(BuildContext context) {
    
     final menuViewModel = Provider.of<MenuViewModel>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return PlatformScaffold(
      body: SafeArea(
          child: Column(
        children: [
          Container(
            height: 60,
            color: Colors.transparent,
            padding: EdgeInsets.all(2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/app_logo.png',
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),
          Expanded(child: pageList[menuViewModel.selectedIndex]),
          Container(
            height: 60,
            color: Colors.white,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    _onItemTapped(0);
                  },
                  child: Container(
                    width: screenWidth / 5,
                    height: double.infinity,
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        Container(
                          height: 2,
                          color: menuViewModel.selectedIndex == 0
                              ? pinkcolor
                              : Colors.transparent,
                        ),
                        Spacer(),
                        Icon(
                          Icons.home_outlined,
                          color: menuViewModel.selectedIndex == 0 ? pinkcolor : Colors.grey,
                          size: 30,
                        ),
                        Spacer(),
                        Text(
                          "HOME",
                          style: TextStyle(
                              fontFamily:
                                  'Poppins', // Use the font family defined in `pubspec.yaml`
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.none),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _onItemTapped(1);
                  },
                  child: Container(
                    width: screenWidth / 5,
                    height: double.infinity,
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        Container(
                          height: 2,
                          color: menuViewModel.selectedIndex == 1
                              ? pinkcolor
                              : Colors.transparent,
                        ),
                        Spacer(),
                        Icon(
                          Icons.category_outlined,
                          color: menuViewModel.selectedIndex == 1 ? pinkcolor : Colors.grey,
                          size: 30,
                        ),
                        Spacer(),
                        Text(
                          "CATEGORY",
                          style: TextStyle(
                              fontFamily:
                                  'Poppins', // Use the font family defined in `pubspec.yaml`
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.none),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _onItemTapped(2);
                  },
                  child: Container(
                    width: screenWidth / 5,
                    height: double.infinity,
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        Container(
                          height: 2,
                          color: menuViewModel.selectedIndex == 2
                              ? pinkcolor
                              : Colors.transparent,
                        ),
                        Spacer(),
                        ImageIcon(
                          AssetImage('assets/images/heart.png'),
                          color: menuViewModel.selectedIndex == 2 ? pinkcolor : Colors.grey,
                          size: 30,
                        ),
                        Spacer(),
                        Text(
                          "WISHLIST",
                          style: TextStyle(
                              fontFamily:
                                  'Poppins', // Use the font family defined in `pubspec.yaml`
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.none),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _onItemTapped(3);
                  },
                  child: Stack(children: [
                    Container(
                      width: screenWidth / 5,
                      height: double.infinity,
                      color: Colors.transparent,
                      child: Column(
                        children: [
                          Container(
                            height: 2,
                            color: menuViewModel.selectedIndex == 3
                                ? pinkcolor
                                : Colors.transparent,
                          ),
                          Spacer(),
                          ImageIcon(
                            AssetImage('assets/images/shopping_bags.png'),
                            color:
                                menuViewModel.selectedIndex == 3 ? pinkcolor : Colors.grey,
                            size: 30,
                          ),
                          Spacer(),
                          Text(
                            "CART",
                            style: TextStyle(
                                fontFamily:
                                    'Poppins', // Use the font family defined in `pubspec.yaml`
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.none),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                    if (menuViewModel.cartCount != "0")
                    Positioned(
                        top: 0,
                        right: 5,
                        child: Container(
                          padding: EdgeInsets.all(7), // Adjust padding
                          decoration: BoxDecoration(
                            color: pinkcolor, // Background color
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            menuViewModel.cartCount, // Your label text
                            style: textStyleCounter,
                          ),
                        ))
                  ]),
                ),
                GestureDetector(
                  onTap: () {
                    _onItemTapped(04);
                  },
                  child: Container(
                    width: screenWidth / 5,
                    height: double.infinity,
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        Container(
                          height: 2,
                          color: menuViewModel.selectedIndex == 4
                              ? pinkcolor
                              : Colors.transparent,
                        ),
                        Spacer(),
                        ImageIcon(
                          AssetImage('assets/images/profile.png'),
                          color: menuViewModel.selectedIndex == 4 ? pinkcolor : Colors.grey,
                          size: 30,
                        ),
                        Spacer(),
                        Text(
                          "PROFILE",
                          style: TextStyle(
                              fontFamily:
                                  'Poppins', // Use the font family defined in `pubspec.yaml`
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.none),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
