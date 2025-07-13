import 'dart:convert';

CartListModel cartListModelFromJson(String str) => CartListModel.fromJson(json.decode(str));
String cartListModelToJson(CartListModel data) => json.encode(data.toJson()); 

class CartListModel {
    String? responseText;
    int? responseCode;
    List<CartProductData>? responseData;
    String? totalPrice;
    String? savePrice;

    CartListModel({
        this.responseText,
        this.responseCode,
        this.responseData,
        this.totalPrice,
        this.savePrice,
    });

    CartListModel copyWith({
        String? responseText,
        int? responseCode,
        List<CartProductData>? responseData,
        String? totalPrice,
        String? savePrice,
    }) => 
        CartListModel(
            responseText: responseText ?? this.responseText,
            responseCode: responseCode ?? this.responseCode,
            responseData: responseData ?? this.responseData,
            totalPrice: totalPrice ?? this.totalPrice,
            savePrice: savePrice ?? this.savePrice,
        );

    factory CartListModel.fromRawJson(String str) => CartListModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory CartListModel.fromJson(Map<String, dynamic> json) => CartListModel(
        responseText: json["responseText"],
        responseCode: json["responseCode"],
        responseData: json["responseData"] == null ? [] : List<CartProductData>.from(json["responseData"]!.map((x) => CartProductData.fromJson(x))),
        totalPrice: json["totalPrice"],
        savePrice: json["savePrice"],
    );

    Map<String, dynamic> toJson() => {
        "responseText": responseText,
        "responseCode": responseCode,
        "responseData": responseData == null ? [] : List<dynamic>.from(responseData!.map((x) => x.toJson())),
        "totalPrice": totalPrice,
        "savePrice": savePrice,
    };
}

class CartProductData {
    String? cartId;
    String? productId;
    String? isWishlist;
    String? productImage;
    String? productOffPercentage;
    String? productShortDescription;
    String? productName;
    String? productOriginalPrice;
    String? productSellPrice;
    String? productQuantity;
    String? size;
    String? color;

    CartProductData({
        this.cartId,
        this.productId,
        this.isWishlist,
        this.productImage,
        this.productOffPercentage,
        this.productShortDescription,
        this.productName,
        this.productOriginalPrice,
        this.productSellPrice,
        this.productQuantity,
        this.size,
        this.color,
    });

    CartProductData copyWith({
        String? cartId,
        String? productId,
        String? isWishlist,
        String? productImage,
        String? productOffPercentage,
        String? productShortDescription,
        String? productName,
        String? productOriginalPrice,
        String? productSellPrice,
        String? productQuantity,
        String? size,
        String? color,
    }) => 
        CartProductData(
            cartId: cartId ?? this.cartId,
            productId: productId ?? this.productId,
            isWishlist: isWishlist ?? this.isWishlist,
            productImage: productImage ?? this.productImage,
            productOffPercentage: productOffPercentage ?? this.productOffPercentage,
            productShortDescription: productShortDescription ?? this.productShortDescription,
            productName: productName ?? this.productName,
            productOriginalPrice: productOriginalPrice ?? this.productOriginalPrice,
            productSellPrice: productSellPrice ?? this.productSellPrice,
            productQuantity: productQuantity ?? this.productQuantity,
            size: size ?? this.size,
            color: color ?? this.color,
        );

    factory CartProductData.fromRawJson(String str) => CartProductData.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory CartProductData.fromJson(Map<String, dynamic> json) => CartProductData(
        cartId: json["cartId"],
        productId: json["productId"],
        isWishlist: json["isWishlist"],
        productImage: json["productImage"],
        productOffPercentage: json["productOffPercentage"],
        productShortDescription: json["productShortDescription"],
        productName: json["productName"],
        productOriginalPrice: json["productOriginalPrice"],
        productSellPrice: json["productSellPrice"],
        productQuantity: json["productQuantity"],
        size: json["size"],
        color: json["color"],
    );

    Map<String, dynamic> toJson() => {
        "cartId": cartId,
        "productId": productId,
        "isWishlist": isWishlist,
        "productImage": productImage,
        "productOffPercentage": productOffPercentage,
        "productShortDescription": productShortDescription,
        "productName": productName,
        "productOriginalPrice": productOriginalPrice,
        "productSellPrice": productSellPrice,
        "productQuantity": productQuantity,
        "size": size,
        "color": color,
    };
}
