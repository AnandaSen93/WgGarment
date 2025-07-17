// To parse this JSON data, do
//
//     final SlugResponseModel = slugResponseModelFromJson(jsonString);

import 'dart:convert';

SlugResponseModel slugResponseModelFromJson(String str) => SlugResponseModel.fromJson(json.decode(str));

String slugResponseModelToJson(SlugResponseModel data) => json.encode(data.toJson());

class SlugResponseModel {
    String? responseText;
    int? responseCode;
    SlugResponseData? responseData;

    SlugResponseModel({
        this.responseText,
        this.responseCode,
        this.responseData,
    });

    factory SlugResponseModel.fromJson(Map<String, dynamic> json) => SlugResponseModel(
        responseText: json["responseText"],
        responseCode: json["responseCode"],
        responseData: json["responseData"] == null ? null : SlugResponseData.fromJson(json["responseData"]),
    );

    Map<String, dynamic> toJson() => {
        "responseText": responseText,
        "responseCode": responseCode,
        "responseData": responseData?.toJson(),
    };
}

class SlugResponseData {
    String? slugId;
    String? title;
    String? description;
    String? metaTitle;
    String? metaDescription;
    String? metaKeyword;

    SlugResponseData({
        this.slugId,
        this.title,
        this.description,
        this.metaTitle,
        this.metaDescription,
        this.metaKeyword,
    });

    factory SlugResponseData.fromJson(Map<String, dynamic> json) => SlugResponseData(
        slugId: json["slugId"],
        title: json["title"],
        description: json["description"],
        metaTitle: json["metaTitle"],
        metaDescription: json["metaDescription"],
        metaKeyword: json["metaKeyword"],
    );

    Map<String, dynamic> toJson() => {
        "slugId": slugId,
        "title": title,
        "description": description,
        "metaTitle": metaTitle,
        "metaDescription": metaDescription,
        "metaKeyword": metaKeyword,
    };
}
