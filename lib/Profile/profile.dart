import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wg_garment/Config/colors.dart';
import 'package:wg_garment/Config/textstyle.dart';
import 'package:wg_garment/Login/login.dart';
import 'package:wg_garment/Signup/signup.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  var list = [
    "My Order",
    "My Address",
    "Notification",
    "Change Password",
    "Log Out",
    "Delete Account"
  ];


  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 2.5,
              child: Stack(children: [
                Container(
                  decoration: BoxDecoration(
                    color: pinkcolor.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Container(
                          decoration: BoxDecoration(
                              color: lightgraykcolor, shape: BoxShape.circle),
                          child: ClipOval(
                            child: AspectRatio(
                                aspectRatio: 1,
                                child:
                                    Image.asset("assets/images/product.png")),
                          ),
                        ),
                      ),
                      Expanded(
                          child: Container(
                        color: Colors.transparent,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Spacer(),
                            Text(
                              "User Name",
                              style: textStyleForCategorytName,
                            ),
                            SizedBox(height: 5),
                            Text(
                              "email:testuser@test.com",
                              style: textStyleForCategorytName,
                            ),
                            SizedBox(height: 5),
                            Text(
                              "phone:9876543210",
                              style: textStyleForCategorytName,
                            ),
                            Spacer(),
                          ],
                        ),
                      ))
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: IconButton(
                    icon: Image.asset(
                      "assets/images/edit_text.png", // Replace with your image path
                      width: 25,
                      height: 25,
                    ),
                    onPressed: () {
                      // Action when pressed
                      print("delete");
                      setState(() {});
                    },
                  ),
                ),
              ]),
            ),
            SizedBox(height: 10),
            Expanded(
                child: Container(
              //padding:EdgeInsets.only(right: 15,left: 15,),
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async {
                        if (list[index] == "Log Out") {
                          Alert(
                            context: context,
                            type: AlertType
                                .warning, // You can change the type (success, error, info, etc.)
                            title: "Log Out",
                            desc: "Are you sure you want to logout?",
                            buttons: [
                              DialogButton(
                                child: Text(
                                  "Yes",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                                onPressed: () async {
                                  print("Yes");
                                  Navigator.pop(context);
                                  final prefs =
                                      await SharedPreferences.getInstance();
                                  await prefs.remove('isLoggedIn');
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginView()));

                                  // Close the alert
                                },
                                color: Colors.green,
                              ),
                              DialogButton(
                                child: Text(
                                  "No",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                                onPressed: () {
                                  print("No");
                                  Navigator.pop(context); // Close the alert
                                },
                                color: Colors.red,
                              )
                            ],
                          ).show();
                        } else if (list[index] == "Delete Account") {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignupView()));
                        }
                      },
                      child: Column(children: [
                        Container(
                          // padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: lightgraykcolor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          height: 50,
                          // color: lightgraykcolor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(width: 10),
                              Icon(Icons.audiotrack_rounded),
                              SizedBox(width: 10),
                              Text(
                                list[index],
                                style: textStyleForTextField,
                              ),
                              Spacer(),
                              Icon(Icons.chevron_right_sharp),
                              SizedBox(width: 5),
                            ],
                          ),
                        ),
                        SizedBox(height: 5)
                      ]),
                    );
                  }),
            ))
          ],
        ),
      )),
    );
  }
}
