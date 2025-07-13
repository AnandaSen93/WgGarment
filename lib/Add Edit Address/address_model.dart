// To parse this JSON data, do
//
//     final cityModel = cityModelFromJson(jsonString);

import 'dart:convert';

CityModel cityModelFromJson(String str) => CityModel.fromJson(json.decode(str));

String cityModelToJson(CityModel data) => json.encode(data.toJson());

class CityModel {
    String? responseText;
    int? responseCode;
    List<StateModelData>? responseData;

    CityModel({
        this.responseText,
        this.responseCode,
        this.responseData,
    });

    factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
        responseText: json["responseText"],
        responseCode: json["responseCode"],
        responseData: json["responseData"] == null ? [] : List<StateModelData>.from(json["responseData"]!.map((x) => StateModelData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "responseText": responseText,
        "responseCode": responseCode,
        "responseData": responseData == null ? [] : List<dynamic>.from(responseData!.map((x) => x.toJson())),
    };
}

class StateModelData {
    String? stateId;
    String? countryId;
    String? stateName;
    String? stateCode;

    StateModelData({
        this.stateId,
        this.countryId,
        this.stateName,
        this.stateCode,
    });

    factory StateModelData.fromJson(Map<String, dynamic> json) => StateModelData(
        stateId: json["StateId"],
        countryId: json["countryId"],
        stateName: json["stateName"],
        stateCode: json["stateCode"],
    );

    Map<String, dynamic> toJson() => {
        "StateId": stateId,
        "countryId": countryId,
        "stateName": stateName,
        "stateCode": stateCode,
    };
}



// Country Model



CountryListModel countryListModelFromJson(String str) => CountryListModel.fromJson(json.decode(str));

String countryListModelToJson(CountryListModel data) => json.encode(data.toJson());

class CountryListModel {
    String? responseText;
    int? responseCode;
    List<CountryDetailsData>? responseData;

    CountryListModel({
        this.responseText,
        this.responseCode,
        this.responseData,
    });

    factory CountryListModel.fromJson(Map<String, dynamic> json) => CountryListModel(
        responseText: json["responseText"],
        responseCode: json["responseCode"],
        responseData: json["responseData"] == null ? [] : List<CountryDetailsData>.from(json["responseData"]!.map((x) => CountryDetailsData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "responseText": responseText,
        "responseCode": responseCode,
        "responseData": responseData == null ? [] : List<dynamic>.from(responseData!.map((x) => x.toJson())),
    };
}

class CountryDetailsData {
    String? countryId;
    String? countryName;
    String? countryCode;

    CountryDetailsData({
        this.countryId,
        this.countryName,
        this.countryCode,
    });

    factory CountryDetailsData.fromJson(Map<String, dynamic> json) => CountryDetailsData(
        countryId: json["countryId"],
        countryName: json["countryName"],
        countryCode: json["countryCode"],
    );

    Map<String, dynamic> toJson() => {
        "countryId": countryId,
        "countryName": countryName,
        "countryCode": countryCode,
    };
}
