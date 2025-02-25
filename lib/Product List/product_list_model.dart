import 'dart:convert';

class ProductListModel {
    String? responseText;
    int? responseCode;
    List<ProductListData>? responseData;

    ProductListModel({
        this.responseText,
        this.responseCode,
        this.responseData,
    });

    ProductListModel copyWith({
        String? responseText,
        int? responseCode,
        List<ProductListData>? responseData,
    }) => 
        ProductListModel(
            responseText: responseText ?? this.responseText,
            responseCode: responseCode ?? this.responseCode,
            responseData: responseData ?? this.responseData,
        );

    factory ProductListModel.fromRawJson(String str) => ProductListModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ProductListModel.fromJson(Map<String, dynamic> json) => ProductListModel(
        responseText: json["responseText"],
        responseCode: json["responseCode"],
        responseData: json["responseData"] == null ? [] : List<ProductListData>.from(json["responseData"]!.map((x) => ProductListData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "responseText": responseText,
        "responseCode": responseCode,
        "responseData": responseData == null ? [] : List<dynamic>.from(responseData!.map((x) => x.toJson())),
    };
}

class ProductListData {
    String? productId;
    String? isWishlist;
    String? productImage;
    String? productOffPercentage;
    String? productShortDescription;
    String? productName;
    String? productOriginalPrice;
    String? productSellPrice;
    List<ColorList>? colorList;
    List<SizeList>? sizeList;

    ProductListData({
        this.productId,
        this.isWishlist,
        this.productImage,
        this.productOffPercentage,
        this.productShortDescription,
        this.productName,
        this.productOriginalPrice,
        this.productSellPrice,
        this.colorList,
        this.sizeList,
    });

    ProductListData copyWith({
        String? productId,
        String? isWishlist,
        String? productImage,
        String? productOffPercentage,
        String? productShortDescription,
        String? productName,
        String? productOriginalPrice,
        String? productSellPrice,
        List<ColorList>? colorList,
        List<SizeList>? sizeList,
    }) => 
        ProductListData(
            productId: productId ?? this.productId,
            isWishlist: isWishlist ?? this.isWishlist,
            productImage: productImage ?? this.productImage,
            productOffPercentage: productOffPercentage ?? this.productOffPercentage,
            productShortDescription: productShortDescription ?? this.productShortDescription,
            productName: productName ?? this.productName,
            productOriginalPrice: productOriginalPrice ?? this.productOriginalPrice,
            productSellPrice: productSellPrice ?? this.productSellPrice,
            colorList: colorList ?? this.colorList,
            sizeList: sizeList ?? this.sizeList,
        );

    factory ProductListData.fromRawJson(String str) => ProductListData.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ProductListData.fromJson(Map<String, dynamic> json) => ProductListData(
        productId: json["productId"],
        isWishlist: json["isWishlist"],
        productImage: json["productImage"],
        productOffPercentage: json["productOffPercentage"],
        productShortDescription: json["productShortDescription"],
        productName: json["productName"],
        productOriginalPrice: json["productOriginalPrice"],
        productSellPrice: json["productSellPrice"],
        colorList: json["colorList"] == null ? [] : List<ColorList>.from(json["colorList"]!.map((x) => ColorList.fromJson(x))),
        sizeList: json["sizeList"] == null ? [] : List<SizeList>.from(json["sizeList"]!.map((x) => SizeList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "productId": productId,
        "isWishlist": isWishlist,
        "productImage": productImage,
        "productOffPercentage": productOffPercentage,
        "productShortDescription": productShortDescription,
        "productName": productName,
        "productOriginalPrice": productOriginalPrice,
        "productSellPrice": productSellPrice,
        "colorList": colorList == null ? [] : List<dynamic>.from(colorList!.map((x) => x.toJson())),
        "sizeList": sizeList == null ? [] : List<dynamic>.from(sizeList!.map((x) => x.toJson())),
    };
}

class ColorList {
    String? code;
    String? name;
    String? valueId;
    String? priceAddOn;

    ColorList({
        this.code,
        this.name,
        this.valueId,
        this.priceAddOn,
    });

    ColorList copyWith({
        String? code,
        String? name,
        String? valueId,
        String? priceAddOn,
    }) => 
        ColorList(
            code: code ?? this.code,
            name: name ?? this.name,
            valueId: valueId ?? this.valueId,
            priceAddOn: priceAddOn ?? this.priceAddOn,
        );

    factory ColorList.fromRawJson(String str) => ColorList.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ColorList.fromJson(Map<String, dynamic> json) => ColorList(
        code: json["code"],
        name: json["name"],
        valueId: json["valueId"],
        priceAddOn: json["priceAddOn"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "valueId": valueId,
        "priceAddOn": priceAddOn,
    };
}

class SizeList {
    String? sizeCode;
    String? sizeId;
    String? priceAddOn;

    SizeList({
        this.sizeCode,
        this.sizeId,
        this.priceAddOn,
    });

    SizeList copyWith({
        String? sizeCode,
        String? sizeId,
        String? priceAddOn,
    }) => 
        SizeList(
            sizeCode: sizeCode ?? this.sizeCode,
            sizeId: sizeId ?? this.sizeId,
            priceAddOn: priceAddOn ?? this.priceAddOn,
        );

    factory SizeList.fromRawJson(String str) => SizeList.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory SizeList.fromJson(Map<String, dynamic> json) => SizeList(
        sizeCode: json["sizeCode"],
        sizeId: json["sizeId"],
        priceAddOn: json["priceAddOn"],
    );

    Map<String, dynamic> toJson() => {
        "sizeCode": sizeCode,
        "sizeId": sizeId,
        "priceAddOn": priceAddOn,
    };
}
