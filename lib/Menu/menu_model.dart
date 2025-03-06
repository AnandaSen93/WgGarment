import 'dart:convert';

CountModel countDataModelFromJson(String str) => CountModel.fromJson(json.decode(str));
String countDataModelToJson(CountModel data) => json.encode(data.toJson());


class CountModel {
    String? responseText;
    int? responseCode;
    String? cartCount;
    String? notificationCount;

    CountModel({
        this.responseText,
        this.responseCode,
        this.cartCount,
        this.notificationCount,
    });

    CountModel copyWith({
        String? responseText,
        int? responseCode,
        String? cartCount,
        String? notificationCount,
    }) => 
        CountModel(
            responseText: responseText ?? this.responseText,
            responseCode: responseCode ?? this.responseCode,
            cartCount: cartCount ?? this.cartCount,
            notificationCount: notificationCount ?? this.notificationCount,
        );

    factory CountModel.fromRawJson(String str) => CountModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory CountModel.fromJson(Map<String, dynamic> json) => CountModel(
        responseText: json["responseText"],
        responseCode: json["responseCode"],
        cartCount: json["cartCount"],
        notificationCount: json["notificationCount"],
    );

    Map<String, dynamic> toJson() => {
        "responseText": responseText,
        "responseCode": responseCode,
        "cartCount": cartCount,
        "notificationCount": notificationCount,
    };
}
