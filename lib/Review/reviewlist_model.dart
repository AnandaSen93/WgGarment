// To parse this JSON data, do
//
//     final reviewListModel = reviewListModelFromJson(jsonString);

import 'dart:convert';

ReviewListModel reviewListModelFromJson(String str) => ReviewListModel.fromJson(json.decode(str));

String reviewListModelToJson(ReviewListModel data) => json.encode(data.toJson());

class ReviewListModel {
    String? responseText;
    int? responseCode;
    List<ReviewDetails>? responseData;

    ReviewListModel({
        this.responseText,
        this.responseCode,
        this.responseData,
    });

    factory ReviewListModel.fromJson(Map<String, dynamic> json) => ReviewListModel(
        responseText: json["responseText"],
        responseCode: json["responseCode"],
        responseData: json["responseData"] == null ? [] : List<ReviewDetails>.from(json["responseData"]!.map((x) => ReviewDetails.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "responseText": responseText,
        "responseCode": responseCode,
        "responseData": responseData == null ? [] : List<dynamic>.from(responseData!.map((x) => x.toJson())),
    };
}

class ReviewDetails {
    String? userName;
    String? userImage;
    String? rating;
    String? review;

    ReviewDetails({
        this.userName,
        this.userImage,
        this.rating,
        this.review,
    });

    factory ReviewDetails.fromJson(Map<String, dynamic> json) => ReviewDetails(
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
