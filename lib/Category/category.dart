import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:wg_garment/Config/colors.dart';
import 'package:wg_garment/Config/textstyle.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({super.key});

  @override
  State<CategoryView> createState() => _CategoryState();
}

class _CategoryState extends State<CategoryView> {
  int _isSelected = 1;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return PlatformScaffold(
      body: SafeArea(
          child: Column(
        children: [
          Text(
            "Categories",
            style: textStyleForHomePageHeading,
          ),
          SizedBox(height: 10),
          Container(
            color: lightgraykcolor,
             height: 2,
          ),Container(
              height: 40,
              width: screenWidth * 0.8,
              color: Colors.transparent,
              child: ListView.builder(
                  itemCount: 3,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Center(
                      child: Container(
                        padding: EdgeInsets.only(right: 10),
                        child: Text(
                          "category-${index} ",
                          style: _isSelected == index
                              ? textStyleForCategorytName2
                              : textStyleForCategorytName,
                        ),
                      ),
                    );
                  }),
            ),
        Container(
            color: lightgraykcolor,
             height: 2,
          ),
          Expanded(
            child: Container(
              padding:EdgeInsets.only(right: 15,left: 15,),
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: 10,
                itemBuilder: (context, index){
                return Column(
                  children:[ Container(
                      padding: EdgeInsets.all(10),
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
                          Icon(Icons.deblur),
                          SizedBox(width: 10),
                          Text(
                            "Sub-category-${index} ",
                            style: textStyleForTextField,
                          ),
                          Spacer(),
                          Icon(Icons.chevron_right_sharp),
                          SizedBox(width: 10),
                        ],

                      ),
                    ),
                    SizedBox(height: 10)
                    ]
                );
              }),
            )
            )


        
        ],
      )),
    );
  }
}
