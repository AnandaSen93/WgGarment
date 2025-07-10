import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wg_garment/Config/colors.dart';
import 'package:wg_garment/Config/textstyle.dart';
import 'package:wg_garment/Login/login.dart';
import 'package:wg_garment/Profile/profile_view_model.dart';
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
    "Privacy",
    "Terms And Aonditions",
    "Privacy Policy",
    "Who We Are",
    "Contact",
    "Return Policy",
    "Log Out",
    "Delete Account"
  ];

  bool isNewsLetterSubscribe = false;
  bool isProductFeedSubscribe = false;



  bool _isInitialized = false;


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
      Provider.of<ProfileViewModel>(context, listen: false).profileApiCall();

      //Provider.of<HomeViewModel>(context).homeApiCall(); // Call API
      _isInitialized = true; // Ensure it's called only once
    }
  }



  @override
  Widget build(BuildContext context) {
     final profileViewModel = Provider.of<ProfileViewModel>(context);
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
                                child: ((profileViewModel.profileDta?.profileImage.toString() ?? "") != "") ? 
                                    Image.network(
                                      profileViewModel.profileDta?.profileImage.toString() ?? "",
                                      fit: BoxFit.cover,
                                    ):Image.asset("assets/images/profile.png")),
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
                              "${profileViewModel.profileDta?.firstName.toString() ?? ""} ${profileViewModel.profileDta?.lastName.toString() ?? ""}",
                              style: textStyleForCategorytName,
                            ),
                            SizedBox(height: 5),
                            Text(
                              profileViewModel.profileDta?.email.toString() ?? "",
                              style: textStyleForCategorytName,
                            ),
                            SizedBox(height: 5),
                            Text(
                              profileViewModel.profileDta?.phone.toString() ?? "",
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
            Container(
                        height: 40,
                        width: double.infinity,
                        //  color: Colors.green,
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    isNewsLetterSubscribe = !isNewsLetterSubscribe;
                                  });
                                },
                                icon: Icon(
                                  isNewsLetterSubscribe ? Icons.check_box : Icons.check_box_outline_blank,
                                  size: 30,
                                )),
                            Text(
                              "Subscribe newsletter",
                              style: textStyleForCategorytName,
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 40,
                        width: double.infinity,
                        //  color: Colors.green,
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    isProductFeedSubscribe = !isProductFeedSubscribe;
                                  });
                                },
                                icon: Icon(
                                  isProductFeedSubscribe ? Icons.check_box : Icons.check_box_outline_blank,
                                  size: 30,
                                )),
                            Text(
                              "Subscribe to product feed",
                              style: textStyleForCategorytName,
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                      
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
                        } else if (list[index] == "My Address") {
                          profileViewModel.navigateToAddressList(context);
                        }
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
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
                              //Icon(Icons.audiotrack_rounded),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                   Text(
                                list[index],
                                style: textStyleForTextField,
                              ),
                               Text(
                                list[index],
                                style: textstyleSmall,
                              ),
                                ],
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
