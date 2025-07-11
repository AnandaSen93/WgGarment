// To parse this JSON data, do
//
//     final addressListModel = addressListModelFromJson(jsonString);

import 'dart:convert';

AddressListModel addressListModelFromJson(String str) => AddressListModel.fromJson(json.decode(str));

String addressListModelToJson(AddressListModel data) => json.encode(data.toJson());

class AddressListModel {
    String? responseText;
    int? responseCode;
    List<AddressDetailsData>? responseData;

    AddressListModel({
        this.responseText,
        this.responseCode,
        this.responseData,
    });

    factory AddressListModel.fromJson(Map<String, dynamic> json) => AddressListModel(
        responseText: json["responseText"],
        responseCode: json["responseCode"],
        responseData: json["responseData"] == null ? [] : List<AddressDetailsData>.from(json["responseData"]!.map((x) => AddressDetailsData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "responseText": responseText,
        "responseCode": responseCode,
        "responseData": responseData == null ? [] : List<dynamic>.from(responseData!.map((x) => x.toJson())),
    };
}

class AddressDetailsData {
    String? addressId;
    String? firstName;
    String? lastName;
    String? company;
    String? houseOne;
    String? houseTwo;
    String? pincode;
    String? state;
    String? stateId;
    String? country;
    String? countryId;
    String? city;
    String? isDefault;

    AddressDetailsData({
        this.addressId,
        this.firstName,
        this.lastName,
        this.company,
        this.houseOne,
        this.houseTwo,
        this.pincode,
        this.state,
        this.stateId,
        this.country,
        this.countryId,
        this.city,
        this.isDefault,
    });

    factory AddressDetailsData.fromJson(Map<String, dynamic> json) => AddressDetailsData(
        addressId: json["addressId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        company: json["company"],
        houseOne: json["houseOne"],
        houseTwo: json["houseTwo"],
        pincode: json["pincode"],
        state: json["state"],
        stateId: json["stateId"],
        country: json["country"],
        countryId: json["countryId"],
        city: json["city"],
        isDefault: json["isDefault"],
    );

    Map<String, dynamic> toJson() => {
        "addressId": addressId,
        "firstName": firstName,
        "lastName": lastName,
        "company": company,
        "houseOne": houseOne,
        "houseTwo": houseTwo,
        "pincode": pincode,
        "state": state,
        "stateId": stateId,
        "country": country,
        "countryId": countryId,
        "city": city,
        "isDefault": isDefault,
    };
}
