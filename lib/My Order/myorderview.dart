import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';
import 'package:wg_garment/Api%20call/imageClass.dart';
import 'package:wg_garment/Config/colors.dart';
import 'package:wg_garment/Config/textstyle.dart';
import 'package:wg_garment/My%20Order/myorder_view_model.dart';

class MyOrderListView extends StatefulWidget {
  const MyOrderListView({super.key});

  @override
  State<MyOrderListView> createState() => _MyOrderListViewState();
}

class _MyOrderListViewState extends State<MyOrderListView> {
  bool _isInitialized = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      Provider.of<MyorderViewModel>(context, listen: false).getOrderList();

      //Provider.of<HomeViewModel>(context).homeApiCall(); // Call API
      _isInitialized = true; // Ensure it's called only once
    }
  }

  @override
  Widget build(BuildContext context) {
    final myorderViewModel = Provider.of<MyorderViewModel>(context);
    return PlatformScaffold(
      body: SafeArea(
          child: Column(
        children: [
          // Header
          Container(
            color: Colors.transparent,
            height: 60,
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios_new)),
                SizedBox(width: 80),
                Image.asset(
                  'assets/images/app_logo.png',
                  fit: BoxFit.contain,
                ),
                Spacer()
              ],
            ),
          ),

          (myorderViewModel.orderList.length != 0)
              ? Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: ListView.separated(
                        scrollDirection: Axis.vertical,
                        itemCount: myorderViewModel.orderList.length,
                        separatorBuilder: (context, index) {
                          return SizedBox(
                              height: 10); // Adds space between items
                        },
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              myorderViewModel.navigateToOrderDetails(myorderViewModel.orderList[index].orderId ?? "", context);
                            },
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                // border: Border.all(
                                //   color: Colors.black, // Black border color
                                //   width: 0.5, // Border width
                                // ),
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26, // shadow color
                                    spreadRadius:
                                        2, // how much the shadow spreads
                                    blurRadius: 5, // how soft the shadow is
                                    offset:
                                        Offset(2, 3), // shadow position (x, y)
                                  ),
                                ], // Optional: Rounded corners
                              ),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 120,
                                      child: AspectRatio(
                                        aspectRatio: 1,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.black,
                                              width: 0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                                10.0), // Same radius as container
                                            child: CustomNetworkImage(
                                              imageUrl: myorderViewModel
                                                  .orderList[index]
                                                  .orderProductImage
                                                  .toString(),
                                              height: double.infinity,
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Container(
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Order ID: ",
                                                  style:
                                                      textStyleForMainProductName,
                                                ),
                                                Text(
                                                  myorderViewModel
                                                      .orderList[index].orderId
                                                      .toString(),
                                                  style:
                                                      textStyleForMainProductDescription,
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Container(
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Order Date: ",
                                                  style:
                                                      textStyleForMainProductName,
                                                ),
                                                Spacer(),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Container(
                                            width: double.infinity,
                                            child: Text(
                                              myorderViewModel
                                                  .orderList[index].orderDateTime
                                                  .toString(),
                                              style:
                                                  textStyleForMainProductDescription,
                                              overflow: TextOverflow
                                                  .ellipsis, // ✅ Adds '...'
                                              maxLines: 1,
                                              textAlign: TextAlign.right,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Container(
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Order Price: ",
                                                  style:
                                                      textStyleForMainProductName,
                                                ),
                                                Text(
                                                  currency +
                                                      (myorderViewModel
                                                          .orderList[index]
                                                          .orderPrice
                                                          .toString()),
                                                  style:
                                                      textStyleForMainProductDescription,
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Container(
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Pay Using: ",
                                                  style:
                                                      textStyleForMainProductName,
                                                ),
                                                Text((myorderViewModel
                                                          .orderList[index]
                                                          .paymentMethod
                                                          .toString()),
                                                  style:
                                                      textStyleForMainProductDescription,
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 5,),
                                           Container(
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Order status: ",
                                                  style:
                                                      textStyleForMainProductName,
                                                ),
                                                Text(myorderViewModel.getStatusName(myorderViewModel
                                                          .orderList[index]
                                                          .orderStatusId
                                                          .toString()),
                                                  style:
                                                      textStyleForMainProductDescription,
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                )
              : Expanded(
                  child: Center(
                    child: Text(
                      "NO Data Found",
                      style: textStyleForMainProductName,
                    ),
                  ),
                )
        ],
      )),
    );
  }
}
