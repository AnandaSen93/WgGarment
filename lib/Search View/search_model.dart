// To parse this JSON data, do
//
//     final searchListModel = searchListModelFromJson(jsonString);

import 'dart:convert';
import 'package:wg_garment/Product%20List/product_list_model.dart';

SearchListModel searchListModelFromJson(String str) => SearchListModel.fromJson(json.decode(str));

String searchListModelToJson(SearchListModel data) => json.encode(data.toJson());

class SearchListModel {
    String? responseText;
    int? responseCode;
    List<ProductListData>? responseData;

    SearchListModel({
        this.responseText,
        this.responseCode,
        this.responseData,
    });

    factory SearchListModel.fromJson(Map<String, dynamic> json) => SearchListModel(
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
