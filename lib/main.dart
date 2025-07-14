import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wg_garment/Add%20Edit%20Address/addedit_address_view_model.dart';
import 'package:wg_garment/Add%20Edit%20Address/addeditaddress.dart';
import 'package:wg_garment/Address%20List/addresslist.dart';
import 'package:wg_garment/Address%20List/addresslist_view_model.dart';

import 'package:wg_garment/Api%20call/api_service.dart';
import 'package:wg_garment/Api%20call/loader.dart';
import 'package:wg_garment/Category/category.dart';
import 'package:wg_garment/Category/category_view_model.dart';
import 'package:wg_garment/Change%20Password/changepassword.dart';
import 'package:wg_garment/Change%20Password/changepassword_view_model.dart';
import 'package:wg_garment/Checkout/checkout.dart';
import 'package:wg_garment/Checkout/checkout_view_model.dart';
import 'package:wg_garment/Edit%20Profile/editprofile_view_model.dart';
import 'package:wg_garment/Forgot%20Password/forgotpassword_view_model.dart';
import 'package:wg_garment/Home/home_view_model.dart';
import 'package:wg_garment/Login/login_view_model.dart';
import 'package:wg_garment/Menu/menu.dart';
import 'package:wg_garment/Home/home.dart';

import 'package:wg_garment/Login/login.dart';
import 'package:wg_garment/Menu/menu_view_model.dart';
import 'package:wg_garment/My%20Order/myorder_view_model.dart';
import 'package:wg_garment/Order%20Details/orderdetails_view_model.dart';
import 'package:wg_garment/Product%20Details/product_details.dart';
import 'package:wg_garment/Product%20Details/product_details_view_model.dart';
import 'package:wg_garment/Product%20List/product_list.dart';
import 'package:wg_garment/Product%20List/product_list_view_model.dart';
import 'package:wg_garment/Profile/profile_view_model.dart';
import 'package:wg_garment/Review/reviewlist_view_model.dart';
import 'package:wg_garment/Search%20View/search_view_model.dart';
import 'package:wg_garment/Signup/signup.dart';
import 'package:wg_garment/Signup/signup_view_model.dart';
import 'package:wg_garment/Slug%20Page/slugview.dart';
import 'package:wg_garment/Splash/splash.dart';
import 'package:wg_garment/WishList/wishlist_view_model.dart';
import 'package:wg_garment/cart/cart_view_model.dart';


void main() {
  runApp( 
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginViewModel()),
        ChangeNotifierProvider(create: (context) => HomeViewModel()),
        ChangeNotifierProvider(create: (context) => CategoryViewModel()),
        ChangeNotifierProvider(create: (context) => ProfileViewModel()),
        ChangeNotifierProvider(create: (context) => SignupViewModel()),
        ChangeNotifierProvider(create: (context) => ProductListViewModel()),
        ChangeNotifierProvider(create: (context) => ProductDetailsViewModel()),
        ChangeNotifierProvider(create: (context) => MenuViewModel()),
        ChangeNotifierProvider(create: (context) => CartViewModel()),
        ChangeNotifierProvider(create: (context) => WishlistViewModel()),
        ChangeNotifierProvider(create: (context) => CheckoutViewModel()),
        ChangeNotifierProvider(create: (context) => AddresslistViewModel()),
        ChangeNotifierProvider(create: (context) => AddeditAddressViewModel()),
        ChangeNotifierProvider(create: (context) => MyorderViewModel()),
        ChangeNotifierProvider(create: (context) => ChangepasswordViewModel()),
        ChangeNotifierProvider(create: (context) => ForgotpasswordViewModel()),
        ChangeNotifierProvider(create: (context) => SearchViewModel()),
        ChangeNotifierProvider(create: (context) => OrderdetailsViewModel()),
        ChangeNotifierProvider(create: (context) => EditprofileViewModel()),
        ChangeNotifierProvider(create: (context) => ReviewlistViewModel()),


        


        Provider(create: (context) => ApiServices()), // Non ChangeNotifier provider
      ],
      child: const MyApp(),
    ),);
}

// void main() {
//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (context) => LoginViewModel()),
//         Provider(create: (context) => ApiServices()),
//       ],
//       child: Builder(
//         builder: (context) => MyApp(),
//       ),
//     ),
//   );
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return 
        MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: GlobalLoader().navigatorKey,
          home:  Splash(),
          routes: {
            'HomeView': (context) =>  HomeView(onCButtonPressed: (){}),
            'MenuView': (context) => MenuView(),
            'LoginView': (context) => LoginView(),
            'Splash': (context) => Splash(),
            'Category': (context) => CategoryView(),        
            'SignupView': (context) => const SignupView(),
            'ProductDetailsView': (context) => const ProductDetailsView(),
            'productList': (context) => const ProductListView(),
            'checkoutView': (context) => const CheckOutView(),
            'addresslistView': (context) => const AddresslistView(),
            'addEditAddressView': (context) => const AddEditAddressView(),
            'slugView': (context) => const Slugview(),
            'changepasswordView': (context) => const ChangePasswordView(),
            
          },
    );
  }
}

extension on Future<SharedPreferences> {
  getBool(String s) {}
}
