import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:wg_garment/Api%20call/imageClass.dart';
import 'package:wg_garment/Config/colors.dart';
import 'package:wg_garment/Config/textstyle.dart';
import 'package:wg_garment/Home/home_model.dart';
import 'package:wg_garment/Order%20Details/orderdetails_view_model.dart';

class OrderDetailsView extends StatefulWidget {
  const OrderDetailsView({super.key});

  @override
  State<OrderDetailsView> createState() => _OrderDetailsViewState();
}

class _OrderDetailsViewState extends State<OrderDetailsView> {
  bool _isInitialized = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      Provider.of<OrderdetailsViewModel>(context, listen: false)
          .getOrderDetails();

      //Provider.of<HomeViewModel>(context).homeApiCall(); // Call API
      _isInitialized = true; // Ensure it's called only once
    }
  }

  @override
  Widget build(BuildContext context) {
    final orderdetailsViewModel = Provider.of<OrderdetailsViewModel>(context);
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

          Text(
            "Order Details",
            style: textStyleForHomePageHeading,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12, // shadow color
                            spreadRadius: 2, // how much the shadow spreads
                            blurRadius: 5, // how soft the shadow is
                            offset: Offset(2, 3), // shadow position (x, y)
                          ),
                        ], // Optional: Rounded corners
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Order Id: ${orderdetailsViewModel.ordreDetails?.orderId ?? ""}',
                            style: textStyleForMainProductDescription,
                          ),
                          Spacer(),
                          Text(
                            'Order On: ${orderdetailsViewModel.ordreDetails?.orderDateTime ?? ""}',
                            style: textStyleForMainProductDescription,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12, // shadow color
                            spreadRadius: 2, // how much the shadow spreads
                            blurRadius: 5, // how soft the shadow is
                            offset: Offset(2, 3), // shadow position (x, y)
                          ),
                        ], // Optional: Rounded corners
                      ),
                      child: ListView.separated(
                          shrinkWrap:
                              true, // ✅ Important: Allows ListView to size based on content
                          physics: NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 10);
                          },
                          itemCount: orderdetailsViewModel
                                  .ordreDetails?.product?.length ??
                              0,
                          itemBuilder: (context, index) {
                            return Container(
                              height: 160,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12, // shadow color
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
                                              imageUrl: orderdetailsViewModel
                                                  .orderProductList[index]
                                                  .productImage
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
                                          width: double.infinity,
                                          child: Text(
                                            orderdetailsViewModel
                                                .orderProductList[index]
                                                .productName
                                                .toString(),
                                            textAlign: TextAlign.left,
                                            style: textStyleForMainProductName,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Container(
                                          width: double.infinity,
                                          child: Text(
                                            "QTY: " +
                                                orderdetailsViewModel
                                                    .orderProductList[index]
                                                    .productQuantity
                                                    .toString(),
                                            textAlign: TextAlign.left,
                                            style:
                                                textStyleForMainProductDescription,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Container(
                                          width: double.infinity,
                                          child: Text(
                                            "Size: " +
                                                orderdetailsViewModel
                                                    .orderProductList[index]
                                                    .size
                                                    .toString(),
                                            textAlign: TextAlign.left,
                                            style:
                                                textStyleForMainProductDescription,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Container(
                                          width: double.infinity,
                                          child: Text(
                                            "Color: " +
                                                orderdetailsViewModel
                                                    .orderProductList[index]
                                                    .color
                                                    .toString(),
                                            textAlign: TextAlign.left,
                                            style:
                                                textStyleForMainProductDescription,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          width: double.infinity,
                                          child: Text(
                                            "Price: " +
                                                currency +
                                                orderdetailsViewModel
                                                    .orderProductList[index]
                                                    .productOriginalPrice
                                                    .toString(),
                                            textAlign: TextAlign.left,
                                            style: textStyleForMainPrice,
                                          ),
                                        ),
                                      ],
                                    ))
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12, // shadow color
                            spreadRadius: 2, // how much the shadow spreads
                            blurRadius: 5, // how soft the shadow is
                            offset: Offset(2, 3), // shadow position (x, y)
                          ),
                        ], // Optional: Rounded corners
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            child: Text(
                              "Billing Address",
                              style: textStyleForHeading,
                              textAlign: TextAlign.left,
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            width: double.infinity,
                            child: Text(
                              (orderdetailsViewModel.ordreDetails
                                          ?.billingAddress?.firstName ??
                                      "") +
                                  " " +
                                  (orderdetailsViewModel.ordreDetails
                                          ?.billingAddress?.lastName ??
                                      ""),
                              style: textStyleForMainProductName,
                            ),
                          ),
                          SizedBox(height: 5),
                          Container(
                            width: double.infinity,
                            child: Text(
                              (orderdetailsViewModel.ordreDetails?.billingAddress?.houseOne ?? "") +
                                  "," +
                                  (orderdetailsViewModel.ordreDetails
                                          ?.billingAddress?.houseTwo ??
                                      "") +
                                  "," +
                                  (orderdetailsViewModel
                                          .ordreDetails?.billingAddress?.city ??
                                      "") +
                                  "," +
                                  (orderdetailsViewModel.ordreDetails
                                          ?.billingAddress?.state ??
                                      "") +
                                  "," +
                                  (orderdetailsViewModel.ordreDetails
                                          ?.billingAddress?.country ??
                                      "") +
                                  "," +
                                  (orderdetailsViewModel.ordreDetails
                                          ?.billingAddress?.pincode ??
                                      ""),
                              style: textStyleForMainProductDescription,
                            ),
                          ),
                          SizedBox(height: 5),
                          Container(
                            height: 1,
                            color: Colors.black, // 🔹 Set background color here
                          ),
                          SizedBox(height: 5),
                          Container(
                            padding: EdgeInsets.all(5),
                            child: Text(
                              orderdetailsViewModel
                                      .ordreDetails?.paymentMethod ??
                                  "",
                              style: textStyleForredText,
                            ),
                          ),

                          // Container(
                          // //  color: Colors.amber,
                          //   padding: EdgeInsets.symmetric(
                          //       horizontal: 0, vertical: 0),
                          //   child: Row(
                          //     children: [

                          //        orderdetailsViewModel.ordreDetails?.orderStatus == "Pending" ?
                          //       TextButton(
                          //         onPressed: () async {

                          //           Alert(
                          //   context: context,
                          //   type: AlertType
                          //       .warning, // You can change the type (success, error, info, etc.)
                          //   title: "Cancel Order",
                          //   desc: "Are you sure you want to cancel this order?",
                          //   buttons: [
                          //     DialogButton(
                          //       child: Text(
                          //         "Yes",
                          //         style: TextStyle(
                          //             color: Colors.white, fontSize: 18),
                          //       ),
                          //       onPressed: () async {
                          //         print("Yes");
                          //         Navigator.pop(context);

                          //             NormalModel? _data =
                          //               await orderdetailsViewModel
                          //                   .cancelOrder();
                          //           if (_data?.responseCode == 1) {
                          //             Fluttertoast.showToast(
                          //                 msg: _data?.responseText ?? "");
                          //            Future.delayed(Duration(seconds: 2), () {
                          //               orderdetailsViewModel
                          //                   .navigateMainMenu(context);
                          //             });
                          //           } else {
                          //             Fluttertoast.showToast(
                          //                 msg: _data?.responseText ?? "");
                          //           }

                          //         // Close the alert
                          //       },
                          //       color: Colors.green,
                          //     ),
                          //     DialogButton(
                          //       child: Text(
                          //         "No",
                          //         style: TextStyle(
                          //             color: Colors.white, fontSize: 18),
                          //       ),
                          //       onPressed: () {
                          //         print("No");
                          //         Navigator.pop(context); // Close the alert
                          //       },
                          //       color: Colors.red,
                          //     )
                          //   ],
                          // ).show();

                          //         },
                          //         style: TextButton.styleFrom(
                          //           padding: EdgeInsets.zero,
                          //           minimumSize: Size(0, 0),
                          //           tapTargetSize:
                          //               MaterialTapTargetSize.shrinkWrap,
                          //         ),
                          //         child: Container(
                          //           padding: EdgeInsets.symmetric(
                          //               horizontal: 12, vertical: 6),
                          //           decoration: BoxDecoration(
                          //             color: Colors.white,
                          //             border: Border.all(
                          //               color: pinkcolor,
                          //               width: 1,
                          //             ),
                          //             borderRadius: BorderRadius.circular(8),
                          //           ),
                          //           child: Text(
                          //             "Cancel Order",
                          //             style: textStyleForredText,
                          //           ),
                          //         ),
                          //       ) :
                          //       Spacer(),

                          //       Spacer(),
                          // TextButton(
                          //   onPressed: () async {
                          //     NormalModel? _data =
                          //         await orderdetailsViewModel.reOrder();
                          //     if (_data?.responseCode == 1) {
                          //       Fluttertoast.showToast(
                          //           msg: _data?.responseText ?? "");
                          //       Future.delayed(Duration(seconds: 2), () {
                          //         orderdetailsViewModel
                          //             .navigateMainMenu(context);
                          //       });
                          //     } else {
                          //       Fluttertoast.showToast(
                          //           msg: _data?.responseText ?? "");
                          //     }
                          //   },
                          //   style: TextButton.styleFrom(
                          //     padding: EdgeInsets.zero,
                          //     minimumSize: Size(0, 0),
                          //     tapTargetSize:
                          //         MaterialTapTargetSize.shrinkWrap,
                          //   ),
                          //   child: Container(
                          //     padding: EdgeInsets.symmetric(
                          //         horizontal: 12, vertical: 6),
                          //     decoration: BoxDecoration(
                          //       color: Colors.white,
                          //       border: Border.all(
                          //         color: skybluecolor,
                          //         width: 1,
                          //       ),
                          //       borderRadius: BorderRadius.circular(8),
                          //     ),
                          //     child: Text(
                          //       "Reorder",
                          //       style: textStyleForSkyText,
                          //     ),
                          //   ),
                          // ),
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12, // shadow color
                            spreadRadius: 2, // how much the shadow spreads
                            blurRadius: 5, // how soft the shadow is
                            offset: Offset(2, 3), // shadow position (x, y)
                          ),
                        ], // Optional: Rounded corners
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            child: Text(
                              "Shipping Address",
                              style: textStyleForHeading,
                              textAlign: TextAlign.left,
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            width: double.infinity,
                            child: Text(
                              (orderdetailsViewModel.ordreDetails
                                          ?.shippingAddress?.firstName ??
                                      "") +
                                  " " +
                                  (orderdetailsViewModel.ordreDetails
                                          ?.shippingAddress?.lastName ??
                                      ""),
                              style: textStyleForMainProductName,
                            ),
                          ),
                          SizedBox(height: 5),
                          Container(
                            width: double.infinity,
                            child: Text(
                              (orderdetailsViewModel.ordreDetails?.shippingAddress?.houseOne ?? "") +
                                  "," +
                                  (orderdetailsViewModel.ordreDetails
                                          ?.shippingAddress?.houseTwo ??
                                      "") +
                                  "," +
                                  (orderdetailsViewModel.ordreDetails
                                          ?.shippingAddress?.city ??
                                      "") +
                                  "," +
                                  (orderdetailsViewModel.ordreDetails
                                          ?.shippingAddress?.state ??
                                      "") +
                                  "," +
                                  (orderdetailsViewModel.ordreDetails
                                          ?.shippingAddress?.country ??
                                      "") +
                                  "," +
                                  (orderdetailsViewModel.ordreDetails
                                          ?.shippingAddress?.pincode ??
                                      ""),
                              style: textStyleForMainProductDescription,
                            ),
                          ),
                          SizedBox(height: 5),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12, // shadow color
                            spreadRadius: 2, // how much the shadow spreads
                            blurRadius: 5, // how soft the shadow is
                            offset: Offset(2, 3), // shadow position (x, y)
                          ),
                        ], // Optional: Rounded corners
                      ),
                      child: Column(
                        children: [
                          Container(
                              width: double.infinity,
                              child: Text(
                                "Price Details (${orderdetailsViewModel.orderProductList.length} items)",
                                style: textStyleForHeading,
                                textAlign: TextAlign.left,
                              )),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Text(
                                "Sub total",
                                style: textStyleForProductName,
                              ),
                              Spacer(),
                              Text(
                                "${currency + (orderdetailsViewModel.ordreDetails?.totalMrp ?? "")}",
                                style: textStyleForMainProductDescription,
                              )
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Text(
                                "delivery Charge",
                                style: textStyleForProductName,
                              ),
                              Spacer(),
                              Text(
                                " ${currency + (orderdetailsViewModel.ordreDetails?.deliveryCharge ?? "")}",
                                style: textStyleForMainProductDescription,
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Text(
                                "Discount",
                                style: textStyleForProductName,
                              ),
                              Spacer(),
                              Text(
                                "${currency + (orderdetailsViewModel.ordreDetails?.discountMrp ?? "")}",
                                style: textStyleForMainProductDescription,
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Container(
                            height: 1,
                            color: Colors.black, // 🔹 Set background color here
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                "Total Amount",
                                style: textStyleForredText,
                              ),
                              Spacer(),
                              Text(
                                currency +
                                    (orderdetailsViewModel
                                            .ordreDetails?.totalPayableAmount ??
                                        ""),
                                style: textStyleForProductName,
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    if (orderdetailsViewModel.ordreDetails?.orderStatus ==
                        "Pending")
                      TextButton(
                        onPressed: () async {
                          Alert(
                            context: context,
                            type: AlertType
                                .warning, // You can change the type (success, error, info, etc.)
                            title: "Cancel Order",
                            desc: "Are you sure you want to cancel this order?",
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
                                      await orderdetailsViewModel.cancelOrder();
                                  if (_data?.responseCode == 1) {
                                    Fluttertoast.showToast(
                                        msg: _data?.responseText ?? "");
                                    Future.delayed(Duration(seconds: 2), () {
                                      orderdetailsViewModel
                                          .navigateMainMenu(context);
                                    });
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: _data?.responseText ?? "");
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
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size(0, 0),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(10),                     
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: pinkcolor,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            "Cancel Order",
                            style: textStyleForredText,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
