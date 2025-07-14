import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wg_garment/Config/colors.dart';
import 'package:wg_garment/Config/textstyle.dart';
import 'package:wg_garment/Home/home_model.dart';
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

   var list1 = [
    "View all orders",
    "Add and update address",
    "Change your password",
    "Please check",
    "Please check",
    "Please check",
    "Please check",
    "Please check",
    "",
    ""
  ];

 



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
                    onPressed: () {
                     profileViewModel.navigateToEditProfile(context);
                    },
                    icon: Image.asset(
                      "assets/images/edit_text.png", // Replace with your image path
                      width: 25,
                      height: 25,
                    ),
                    
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
                                    // api call

                                    profileViewModel.updatenewslatterApi(
                                      profileViewModel.profileDta?.isProductFeed.toString() ?? "",
                                      profileViewModel.profileDta?.isNewsLetter.toString() == "1" ? "0" : "1"
                                       );


                                  });
                                },
                                icon: Icon(
                                  profileViewModel.profileDta?.isNewsLetter.toString() == "1" ? Icons.check_box : Icons.check_box_outline_blank,
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
                                    // api call
                                      profileViewModel.updatenewslatterApi(
                                      profileViewModel.profileDta?.isProductFeed.toString() == "1" ? "0" : "1",
                                      profileViewModel.profileDta?.isNewsLetter.toString() ?? ""
                                       );
                                  });
                                },
                                icon: Icon(
                                  profileViewModel.profileDta?.isProductFeed.toString() == "1" ? Icons.check_box : Icons.check_box_outline_blank,
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

                                  NormalModel? _data = await profileViewModel.logOutApi();
                                  if (_data != null){
                                    if (_data.responseCode == "1"){
                                      profileViewModel.navigateToLoginPage(context);
                                    }
                                  }

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

                          Alert(
                            context: context,
                            type: AlertType
                                .warning, // You can change the type (success, error, info, etc.)
                            title: "Delete Account",
                            desc: "Are you sure you want to delete your account?",
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
                                     NormalModel? _data = await profileViewModel.deleteYourAccountApi();
                                  if (_data != null){
                                    if (_data.responseCode == "1"){
                                      profileViewModel.navigateToLoginPage(context);
                                    }
                                  }
                              

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


                        } else if (list[index] == "My Address") {
                          profileViewModel.navigateToAddressList(context);
                        } else if (list[index] == "Terms And Aonditions" ) {
                          profileViewModel.navigateToSlugPage(context);
                        } else if (list[index] == "Privacy Policy" ) {
                          profileViewModel.navigateToSlugPage(context);
                        } else if (list[index] == "Who We Are" ) {
                          profileViewModel.navigateToSlugPage(context);
                        } else if (list[index] =="Return Policy" ) {
                          profileViewModel.navigateToSlugPage(context);
                        } else if (list[index] == "Privacy" ){
                          profileViewModel.navigateToChangePassword(context);
                        } else if (list[index] == "My Order"){
                          profileViewModel.navigateToMyOrder(context);
                        }

                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Container(
                           padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: lightgraykcolor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                         // height: 50,
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
                                style: textStyleForCategorytName2,
                              ),
                              SizedBox(height: 5,),
                               Text(
                                list1[index],
                                style: textStyleForMainProductDescription,
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
