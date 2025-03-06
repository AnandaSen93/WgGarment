
import 'dart:convert';
import 'package:wg_garment/Product%20List/product_list_model.dart';


WishListModel wishListModelFromJson(String str) => WishListModel.fromJson(json.decode(str));
String wishListModelToJson(WishListModel data) => json.encode(data.toJson());

class WishListModel {
    String? responseText;
    int? responseCode;
    List<ProductListData>? responseData;

    WishListModel({
        this.responseText,
        this.responseCode,
        this.responseData,
    });

    WishListModel copyWith({
        String? responseText,
        int? responseCode,
        List<ProductListData>? responseData,
    }) => 
        WishListModel(
            responseText: responseText ?? this.responseText,
            responseCode: responseCode ?? this.responseCode,
            responseData: responseData ?? this.responseData,
        );

    factory WishListModel.fromRawJson(String str) => WishListModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory WishListModel.fromJson(Map<String, dynamic> json) => WishListModel(
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
