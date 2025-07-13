// To parse this JSON data, do
//
//     final orderDetailsModel = orderDetailsModelFromJson(jsonString);

import 'dart:convert';

import 'package:wg_garment/Address%20List/address_model.dart';

OrderDetailsModel orderDetailsModelFromJson(String str) => OrderDetailsModel.fromJson(json.decode(str));

String orderDetailsModelToJson(OrderDetailsModel data) => json.encode(data.toJson());

class OrderDetailsModel {
    String? responseText;
    int? responseCode;
    OrderDetailsFullData? responseData;

    OrderDetailsModel({
        this.responseText,
        this.responseCode,
        this.responseData,
    });

    factory OrderDetailsModel.fromJson(Map<String, dynamic> json) => OrderDetailsModel(
        responseText: json["responseText"],
        responseCode: json["responseCode"],
        responseData: json["responseData"] == null ? null : OrderDetailsFullData.fromJson(json["responseData"]),
    );

    Map<String, dynamic> toJson() => {
        "responseText": responseText,
        "responseCode": responseCode,
        "responseData": responseData?.toJson(),
    };
}

class OrderDetailsFullData {
    String? orderId;
    String? orderDateTime;
    String? orderStatus;
    String? shippingDateTime;
    String? expectedDeliveryDateTime;
    String? paymentMethod;
    String? orderProductImage;
    String? totalMrp;
    String? discountMrp;
    String? deliveryCharge;
    String? totalPayableAmount;
    List<OrderedProduct>? product;
    AddressDetailsData? billingAddress;
    AddressDetailsData? shippingAddress;

    OrderDetailsFullData({
        this.orderId,
        this.orderDateTime,
        this.orderStatus,
        this.shippingDateTime,
        this.expectedDeliveryDateTime,
        this.paymentMethod,
        this.orderProductImage,
        this.totalMrp,
        this.discountMrp,
        this.deliveryCharge,
        this.totalPayableAmount,
        this.product,
        this.billingAddress,
        this.shippingAddress,
    });

    factory OrderDetailsFullData.fromJson(Map<String, dynamic> json) => OrderDetailsFullData(
        orderId: json["orderId"],
        orderDateTime: json["orderDateTime"],
        orderStatus: json["orderStatus"],
        shippingDateTime: json["shippingDateTime"],
        expectedDeliveryDateTime: json["expectedDeliveryDateTime"],
        paymentMethod: json["paymentMethod"],
        orderProductImage: json["orderProductImage"],
        totalMrp: json["totalMRP"],
        discountMrp: json["discountMRP"],
        deliveryCharge: json["deliveryCharge"],
        totalPayableAmount: json["totalPayableAmount"],
        product: json["product"] == null ? [] : List<OrderedProduct>.from(json["product"]!.map((x) => OrderedProduct.fromJson(x))),
        billingAddress: json["billingAddress"] == null ? null : AddressDetailsData.fromJson(json["billingAddress"]),
        shippingAddress: json["shippingAddress"] == null ? null : AddressDetailsData.fromJson(json["shippingAddress"]),
    );

    Map<String, dynamic> toJson() => {
        "orderId": orderId,
        "orderDateTime": orderDateTime,
        "orderStatus": orderStatus,
        "shippingDateTime": shippingDateTime,
        "expectedDeliveryDateTime": expectedDeliveryDateTime,
        "paymentMethod": paymentMethod,
        "orderProductImage": orderProductImage,
        "totalMRP": totalMrp,
        "discountMRP": discountMrp,
        "deliveryCharge": deliveryCharge,
        "totalPayableAmount": totalPayableAmount,
        "product": product == null ? [] : List<dynamic>.from(product!.map((x) => x.toJson())),
        "billingAddress": billingAddress?.toJson(),
        "shippingAddress": shippingAddress?.toJson(),
    };
}

class OrderedProduct {
    String? productId;
    String? productName;
    String? productImage;
    String? productSellPrice;
    String? productOriginalPrice;
    String? productOffPercentage;
    String? productShortDescription;
    String? productQuantity;
    String? isWishlist;
    String? size;
    String? color;

    OrderedProduct({
        this.productId,
        this.productName,
        this.productImage,
        this.productSellPrice,
        this.productOriginalPrice,
        this.productOffPercentage,
        this.productShortDescription,
        this.productQuantity,
        this.isWishlist,
        this.size,
        this.color,
    });

    factory OrderedProduct.fromJson(Map<String, dynamic> json) => OrderedProduct(
        productId: json["productId"],
        productName: json["productName"],
        productImage: json["productImage"],
        productSellPrice: json["productSellPrice"],
        productOriginalPrice: json["productOriginalPrice"],
        productOffPercentage: json["productOffPercentage"],
        productShortDescription: json["productShortDescription"],
        productQuantity: json["productQuantity"],
        isWishlist: json["isWishlist"],
        size: json["size"],
        color: json["color"],
    );

    Map<String, dynamic> toJson() => {
        "productId": productId,
        "productName": productName,
        "productImage": productImage,
        "productSellPrice": productSellPrice,
        "productOriginalPrice": productOriginalPrice,
        "productOffPercentage": productOffPercentage,
        "productShortDescription": productShortDescription,
        "productQuantity": productQuantity,
        "isWishlist": isWishlist,
        "size": size,
        "color": color,
    };
}
