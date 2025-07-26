import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';
import 'package:wg_garment/Api%20call/imageClass.dart';
import 'package:wg_garment/Config/colors.dart';
import 'package:wg_garment/Config/textstyle.dart';
import 'package:wg_garment/Home/home_model.dart';
import 'package:wg_garment/Profile/profile_view_model.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
// 10-Return Policy
// 6 about Us
// 4 Delivery information
// 3 privacy policy
// 2 terms and conditions
// 1 who we are

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
      initialsApiCall();

      _isInitialized = true; // Ensure it's called only once
    }
  }

  void initialsApiCall() async {
    Provider.of<ProfileViewModel>(context, listen: false).setUI();
    if (await getLoginStatus()) {
      Provider.of<ProfileViewModel>(context, listen: false).profileApiCall();
      
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
            Container(
              child: profileViewModel.isLoggedIn ?
              Column(
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
                                    color: lightgraykcolor,
                                    shape: BoxShape.circle),
                                child: ClipOval(
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: CustomNetworkImage(
                                      imageUrl: profileViewModel
                                              .profileDta?.profileImage
                                              .toString() ??
                                          "",
                                      height: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
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
                                    profileViewModel.profileDta?.email
                                            .toString() ??
                                        "",
                                    style: textStyleForCategorytName,
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    profileViewModel.profileDta?.phone
                                            .toString() ??
                                        "",
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
                              //setState(() {
                              // api call

                              profileViewModel.updatenewslatterApi(
                                  profileViewModel.profileDta?.isProductFeed
                                          .toString() ??
                                      "",
                                  profileViewModel.profileDta?.isNewsLetter
                                              .toString() ==
                                          "1"
                                      ? "0"
                                      : "1");

                              // });
                            },
                            icon: Icon(
                              profileViewModel.profileDta?.isNewsLetter
                                          .toString() ==
                                      "1"
                                  ? Icons.check_box
                                  : Icons.check_box_outline_blank,
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
                              // setState(() {
                              // api call
                              profileViewModel.updatenewslatterApi(
                                  profileViewModel.profileDta?.isProductFeed
                                              .toString() ==
                                          "1"
                                      ? "0"
                                      : "1",
                                  profileViewModel.profileDta?.isNewsLetter
                                          .toString() ??
                                      "");
                              //  });
                            },
                            icon: Icon(
                              profileViewModel.profileDta?.isProductFeed
                                          .toString() ==
                                      "1"
                                  ? Icons.check_box
                                  : Icons.check_box_outline_blank,
                              size: 30,
                            )),
                        Text(
                          "Subscribe to product feed",
                          style: textStyleForCategorytName,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ): SizedBox(height: 0)
            ),
            Expanded(
                child: Container(
              //padding:EdgeInsets.only(right: 15,left: 15,),
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: profileViewModel.list.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async {
                        if (profileViewModel.list[index] == "Log Out") {
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

                                  NormalModel? _data =
                                      await profileViewModel.logOutApi();
                                  if (_data?.responseCode == 1) {
                                    profileViewModel
                                        .navigateToLoginPage(context);
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
                        } else if (profileViewModel.list[index] ==
                            "Delete Account") {
                          Alert(
                            context: context,
                            type: AlertType
                                .warning, // You can change the type (success, error, info, etc.)
                            title: "Delete Account",
                            desc:
                                "Are you sure you want to delete your account?",
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
                                  NormalModel? _data = await profileViewModel
                                      .deleteYourAccountApi();
                                  if (_data?.responseCode == 1) {
                                    profileViewModel
                                        .navigateToLoginPage(context);
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
                        } else if (profileViewModel.list[index] ==
                            "My Address") {
                          profileViewModel.navigateToAddressList(context);
                        } else if (profileViewModel.list[index] ==
                            "Terms And Aonditions") {
                          //2
                          profileViewModel.navigateToSlugPage("2", context);
                        } else if (profileViewModel.list[index] ==
                            "Privacy Policy") {
                          //3
                          profileViewModel.navigateToSlugPage("3", context);
                        } else if (profileViewModel.list[index] ==
                            "Who We Are") {
                          //1
                          profileViewModel.navigateToSlugPage("1", context);
                        } else if (profileViewModel.list[index] ==
                            "Return Policy") {
                          //10
                          profileViewModel.navigateToSlugPage("10", context);
                        } else if (profileViewModel.list[index] == "About Us") {
                          //6
                          profileViewModel.navigateToSlugPage("6", context);
                        } else if (profileViewModel.list[index] ==
                            "Delivery information") {
                          //4
                          profileViewModel.navigateToSlugPage("4", context);
                        } else if (profileViewModel.list[index] == "Privacy") {
                          profileViewModel.navigateToChangePassword(context);
                        } else if (profileViewModel.list[index] == "My Order") {
                          profileViewModel.navigateToMyOrder(context);
                        } else if (profileViewModel.list[index] == "Log In") {
                          profileViewModel.navigateToLoginPage(context);
                        }

// 10-Return Policy
// 6 about Us
// 4 Delivery information
// 3 privacy policy
// 2 terms and conditions
// 1 who we are
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        profileViewModel.list[index],
                                        style: textStyleForCategorytName2,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        profileViewModel.list1[index],
                                        style:
                                            textStyleForMainProductDescription,
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
