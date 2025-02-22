import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:wg_garment/Api%20call/api_service.dart';
import 'package:wg_garment/Home/home_view_model.dart';
import 'package:wg_garment/Login/login_view_model.dart';
import 'package:wg_garment/Menu/menu.dart';
import 'package:wg_garment/Home/home.dart';

import 'package:wg_garment/Login/login.dart';
import 'package:wg_garment/Product%20Details/product_details.dart';
import 'package:wg_garment/Product%20List/product_list.dart';
import 'package:wg_garment/Signup/signup.dart';


void main() {
  runApp( 
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginViewModel()),
        ChangeNotifierProvider(create: (context) => HomeViewModel()), // Another ViewModel
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MenuView(),
      routes: {
        'HomeView': (context) => const HomeView(),
        'MenuView': (context) => MenuView(),
        'LoginView': (context) => LoginView(),
        'SignupView': (context) => const SignupView(),
        'ProductDetailsView': (context) => const ProductDetailsView(),
        'productList': (context) => const ProductListView(),
      },
    );
  }
}
