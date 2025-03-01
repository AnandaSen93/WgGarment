import 'dart:convert';

import 'package:wg_garment/Product%20List/product_list_model.dart';


ProductDetailsModel productDetailsModelFromJson(String str) => ProductDetailsModel.fromJson(json.decode(str));
String productDetailsModelToJson(ProductDetailsModel data) => json.encode(data.toJson());


class ProductDetailsModel {
    String? responseText;
    int? responseCode;
    ProductData? responseData;

    ProductDetailsModel({
        this.responseText,
        this.responseCode,
        this.responseData,
    });

    ProductDetailsModel copyWith({
        String? responseText,
        int? responseCode,
        ProductData? responseData,
    }) => 
        ProductDetailsModel(
            responseText: responseText ?? this.responseText,
            responseCode: responseCode ?? this.responseCode,
            responseData: responseData ?? this.responseData,
        );

    factory ProductDetailsModel.fromRawJson(String str) => ProductDetailsModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ProductDetailsModel.fromJson(Map<String, dynamic> json) => ProductDetailsModel(
        responseText: json["responseText"],
        responseCode: json["responseCode"],
        responseData: json["responseData"] == null ? null : ProductData.fromJson(json["responseData"]),
    );

    Map<String, dynamic> toJson() => {
        "responseText": responseText,
        "responseCode": responseCode,
        "responseData": responseData?.toJson(),
    };
}

class ProductData {
    String? productId;
    String? isAlreadyBuy;
    RatingAll? ratingAll;
    List<OptionList>? optionList;
    String? productReviewCount;
    List<ColorListElement>? colorList;
    List<ColorListElement>? sizeList;
    String? productDescription;
    String? tag;
    List<String>? productImageList;
    String? maxQuantity;
    String? isWishlist;
    String? productImage;
    String? productOffPercentage;
    String? productShortDescription;
    String? productName;
    String? productOriginalPrice;
    String? productSellPrice;
    String? productRating;
    List<ProductReviewList>? productReviewList;
    String? productShareableLink;
    List<ProductListData>? similarProduct;
    ProductData({
        this.productId,
        this.isAlreadyBuy,
        this.ratingAll,
        this.optionList,
        this.productReviewCount,
        this.colorList,
        this.sizeList,
        this.productDescription,
        this.tag,
        this.productImageList,
        this.maxQuantity,
        this.isWishlist,
        this.productImage,
        this.productOffPercentage,
        this.productShortDescription,
        this.productName,
        this.productOriginalPrice,
        this.productSellPrice,
        this.productRating,
        this.productReviewList,
        this.productShareableLink,
        this.similarProduct,
    });

    ProductData copyWith({
        String? productId,
        String? isAlreadyBuy,
        RatingAll? ratingAll,
        List<OptionList>? optionList,
        String? productReviewCount,
        List<ColorListElement>? colorList,
        List<ColorListElement>? sizeList,
        String? productDescription,
        String? tag,
        List<String>? productImageList,
        String? maxQuantity,
        String? isWishlist,
        String? productImage,
        String? productOffPercentage,
        String? productShortDescription,
        String? productName,
        String? productOriginalPrice,
        String? productSellPrice,
        String? productRating,
        List<ProductReviewList>? productReviewList,
        String? productShareableLink,
        List<ProductListData>? similarProduct,
    }) => 
        ProductData(
            productId: productId ?? this.productId,
            isAlreadyBuy: isAlreadyBuy ?? this.isAlreadyBuy,
            ratingAll: ratingAll ?? this.ratingAll,
            optionList: optionList ?? this.optionList,
            productReviewCount: productReviewCount ?? this.productReviewCount,
            colorList: colorList ?? this.colorList,
            sizeList: sizeList ?? this.sizeList,
            productDescription: productDescription ?? this.productDescription,
            tag: tag ?? this.tag,
            productImageList: productImageList ?? this.productImageList,
            maxQuantity: maxQuantity ?? this.maxQuantity,
            isWishlist: isWishlist ?? this.isWishlist,
            productImage: productImage ?? this.productImage,
            productOffPercentage: productOffPercentage ?? this.productOffPercentage,
            productShortDescription: productShortDescription ?? this.productShortDescription,
            productName: productName ?? this.productName,
            productOriginalPrice: productOriginalPrice ?? this.productOriginalPrice,
            productSellPrice: productSellPrice ?? this.productSellPrice,
            productRating: productRating ?? this.productRating,
            productReviewList: productReviewList ?? this.productReviewList,
            productShareableLink: productShareableLink ?? this.productShareableLink,
            similarProduct: similarProduct ?? this.similarProduct,
        );

    factory ProductData.fromRawJson(String str) => ProductData.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
        productId: json["productId"],
        isAlreadyBuy: json["isAlreadyBuy"],
        ratingAll: json["ratingAll"] == null ? null : RatingAll.fromJson(json["ratingAll"]),
        optionList: json["optionList"] == null ? [] : List<OptionList>.from(json["optionList"]!.map((x) => OptionList.fromJson(x))),
        productReviewCount: json["productReviewCount"],
        colorList: json["colorList"] == null ? [] : List<ColorListElement>.from(json["colorList"]!.map((x) => ColorListElement.fromJson(x))),
        sizeList: json["sizeList"] == null ? [] : List<ColorListElement>.from(json["sizeList"]!.map((x) => ColorListElement.fromJson(x))),
        productDescription: json["productDescription"],
        tag: json["tag"],
        productImageList: json["productImageList"] == null ? [] : List<String>.from(json["productImageList"]!.map((x) => x)),
        maxQuantity: json["maxQuantity"],
        isWishlist: json["isWishlist"],
        productImage: json["productImage"],
        productOffPercentage: json["productOffPercentage"],
        productShortDescription: json["productShortDescription"],
        productName: json["productName"],
        productOriginalPrice: json["productOriginalPrice"],
        productSellPrice: json["productSellPrice"],
        productRating: json["productRating"],
        productReviewList: json["productReviewList"] == null ? [] : List<ProductReviewList>.from(json["productReviewList"]!.map((x) => ProductReviewList.fromJson(x))),
        productShareableLink: json["productShareableLink"],
        similarProduct: json["similarProduct"] == null ? [] : List<ProductListData>.from(json["similarProduct"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "productId": productId,
        "isAlreadyBuy": isAlreadyBuy,
        "ratingAll": ratingAll?.toJson(),
        "optionList": optionList == null ? [] : List<dynamic>.from(optionList!.map((x) => x.toJson())),
        "productReviewCount": productReviewCount,
        "colorList": colorList == null ? [] : List<dynamic>.from(colorList!.map((x) => x.toJson())),
        "sizeList": sizeList == null ? [] : List<dynamic>.from(sizeList!.map((x) => x.toJson())),
        "productDescription": productDescription,
        "tag": tag,
        "productImageList": productImageList == null ? [] : List<dynamic>.from(productImageList!.map((x) => x)),
        "maxQuantity": maxQuantity,
        "isWishlist": isWishlist,
        "productImage": productImage,
        "productOffPercentage": productOffPercentage,
        "productShortDescription": productShortDescription,
        "productName": productName,
        "productOriginalPrice": productOriginalPrice,
        "productSellPrice": productSellPrice,
        "productRating": productRating,
        "productReviewList": productReviewList == null ? [] : List<dynamic>.from(productReviewList!.map((x) => x.toJson())),
        "productShareableLink": productShareableLink,
        "similarProduct": similarProduct == null ? [] : List<dynamic>.from(similarProduct!.map((x) => x)),
    };
}

class ColorListElement {
    String? code;
    String? name;
    String? valueId;
    String? priceAddOn;
    PricePrefix? pricePrefix;

    ColorListElement({
        this.code,
        this.name,
        this.valueId,
        this.priceAddOn,
        this.pricePrefix,
    });

    ColorListElement copyWith({
        String? code,
        String? name,
        String? valueId,
        String? priceAddOn,
        PricePrefix? pricePrefix,
    }) => 
        ColorListElement(
            code: code ?? this.code,
            name: name ?? this.name,
            valueId: valueId ?? this.valueId,
            priceAddOn: priceAddOn ?? this.priceAddOn,
            pricePrefix: pricePrefix ?? this.pricePrefix,
        );

    factory ColorListElement.fromRawJson(String str) => ColorListElement.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ColorListElement.fromJson(Map<String, dynamic> json) => ColorListElement(
        code: json["code"],
        name: json["name"],
        valueId: json["valueId"],
        priceAddOn: json["priceAddOn"],
        pricePrefix: pricePrefixValues.map[json["pricePrefix"]]!,
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "valueId": valueId,
        "priceAddOn": priceAddOn,
        "pricePrefix": pricePrefixValues.reverse[pricePrefix],
    };
}

enum PricePrefix {
    EMPTY
}

final pricePrefixValues = EnumValues({
    "+": PricePrefix.EMPTY
});

class OptionList {
    String? name;
    List<ColorListElement>? list;

    OptionList({
        this.name,
        this.list,
    });

    OptionList copyWith({
        String? name,
        List<ColorListElement>? list,
    }) => 
        OptionList(
            name: name ?? this.name,
            list: list ?? this.list,
        );

    factory OptionList.fromRawJson(String str) => OptionList.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory OptionList.fromJson(Map<String, dynamic> json) => OptionList(
        name: json["name"],
        list: json["list"] == null ? [] : List<ColorListElement>.from(json["list"]!.map((x) => ColorListElement.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "list": list == null ? [] : List<dynamic>.from(list!.map((x) => x.toJson())),
    };
}

class ProductReviewList {
    String? userName;
    String? userImage;
    String? rating;
    String? review;

    ProductReviewList({
        this.userName,
        this.userImage,
        this.rating,
        this.review,
    });

    ProductReviewList copyWith({
        String? userName,
        String? userImage,
        String? rating,
        String? review,
    }) => 
        ProductReviewList(
            userName: userName ?? this.userName,
            userImage: userImage ?? this.userImage,
            rating: rating ?? this.rating,
            review: review ?? this.review,
        );

    factory ProductReviewList.fromRawJson(String str) => ProductReviewList.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ProductReviewList.fromJson(Map<String, dynamic> json) => ProductReviewList(
        userName: json["userName"],
        userImage: json["userImage"],
        rating: json["rating"],
        review: json["review"],
    );

    Map<String, dynamic> toJson() => {
        "userName": userName,
        "userImage": userImage,
        "rating": rating,
        "review": review,
    };
}

class RatingAll {
    String? one;
    String? two;
    String? three;
    String? four;
    String? five;

    RatingAll({
        this.one,
        this.two,
        this.three,
        this.four,
        this.five,
    });

    RatingAll copyWith({
        String? one,
        String? two,
        String? three,
        String? four,
        String? five,
    }) => 
        RatingAll(
            one: one ?? this.one,
            two: two ?? this.two,
            three: three ?? this.three,
            four: four ?? this.four,
            five: five ?? this.five,
        );

    factory RatingAll.fromRawJson(String str) => RatingAll.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory RatingAll.fromJson(Map<String, dynamic> json) => RatingAll(
        one: json["one"],
        two: json["two"],
        three: json["three"],
        four: json["four"],
        five: json["five"],
    );

    Map<String, dynamic> toJson() => {
        "one": one,
        "two": two,
        "three": three,
        "four": four,
        "five": five,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
