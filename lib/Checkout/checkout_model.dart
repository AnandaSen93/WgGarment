
import 'dart:convert';

CouponModel couponModelFromJson(String str) => CouponModel.fromJson(json.decode(str));

String couponModelToJson(CouponModel data) => json.encode(data.toJson());

class CouponModel {
    String? responseText;
    int? responseCode;
    String? responseData;

    CouponModel({
        this.responseText,
        this.responseCode,
        this.responseData,
    });

    factory CouponModel.fromJson(Map<String, dynamic> json) => CouponModel(
        responseText: json["responseText"],
        responseCode: json["responseCode"],
        responseData: json["responseData"],
    );

    Map<String, dynamic> toJson() => {
        "responseText": responseText,
        "responseCode": responseCode,
        "responseData": responseData,
    };
}