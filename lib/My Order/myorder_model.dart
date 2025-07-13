// To parse this JSON data, do
//
//     final orderListModel = orderListModelFromJson(jsonString);

import 'dart:convert';

OrderListModel orderListModelFromJson(String str) => OrderListModel.fromJson(json.decode(str));

String orderListModelToJson(OrderListModel data) => json.encode(data.toJson());

class OrderListModel {
    String? responseText;
    int? responseCode;
    List<OrderDetailsData>? responseData;

    OrderListModel({
        this.responseText,
        this.responseCode,
        this.responseData,
    });

    factory OrderListModel.fromJson(Map<String, dynamic> json) => OrderListModel(
        responseText: json["responseText"],
        responseCode: json["responseCode"],
        responseData: json["responseData"] == null ? [] : List<OrderDetailsData>.from(json["responseData"]!.map((x) => OrderDetailsData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "responseText": responseText,
        "responseCode": responseCode,
        "responseData": responseData == null ? [] : List<dynamic>.from(responseData!.map((x) => x.toJson())),
    };
}

class OrderDetailsData {
    String? orderId;
    DateTime? orderDateTime;
    String? orderPrice;
    String? paymentMethod;
    String? orderProductImage;

    OrderDetailsData({
        this.orderId,
        this.orderDateTime,
        this.orderPrice,
        this.paymentMethod,
        this.orderProductImage,
    });

    factory OrderDetailsData.fromJson(Map<String, dynamic> json) => OrderDetailsData(
        orderId: json["orderId"],
        orderDateTime: json["orderDateTime"] == null ? null : DateTime.parse(json["orderDateTime"]),
        orderPrice: json["orderPrice"],
        paymentMethod: json["paymentMethod"],
        orderProductImage: json["orderProductImage"],
    );

    Map<String, dynamic> toJson() => {
        "orderId": orderId,
        "orderDateTime": orderDateTime?.toIso8601String(),
        "orderPrice": orderPrice,
        "paymentMethod": paymentMethod,
        "orderProductImage": orderProductImage,
    };
}
