import 'dart:convert';

import 'package:wg_garment/Home/home_model.dart';


CategoryModel categoryModelFromJson(String str) => CategoryModel.fromJson(json.decode(str));
String categoryModelToJson(CategoryModel data) => json.encode(data.toJson()); 

class CategoryModel {
    String? responseText;
    int? responseCode;
    List<CategoryData>? responseData;

    CategoryModel({
        this.responseText,
        this.responseCode,
        this.responseData,
    });

    factory CategoryModel.fromRawJson(String str) => CategoryModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        responseText: json["responseText"],
        responseCode: json["responseCode"],
        responseData: json["responseData"] == null ? [] : List<CategoryData>.from(json["responseData"]!.map((x) => CategoryData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "responseText": responseText,
        "responseCode": responseCode,
        "responseData": responseData == null ? [] : List<dynamic>.from(responseData!.map((x) => x.toJson())),
    };
}

class CategoryData {
    String? categoryId;
    String? categoryImage;
    String? categoryName;
    List<SubCategory>? subCategory;

    CategoryData({
        this.categoryId,
        this.categoryImage,
        this.categoryName,
        this.subCategory,
    });

    factory CategoryData.fromRawJson(String str) => CategoryData.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory CategoryData.fromJson(Map<String, dynamic> json) => CategoryData(
        categoryId: json["categoryId"],
        categoryImage: json["categoryImage"],
        categoryName: json["categoryName"],
        subCategory: json["subCategory"] == null ? [] : List<SubCategory>.from(json["subCategory"]!.map((x) => SubCategory.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "categoryId": categoryId,
        "categoryImage": categoryImage,
        "categoryName": categoryName,
        "subCategory": subCategory == null ? [] : List<dynamic>.from(subCategory!.map((x) => x.toJson())),
    };
}

