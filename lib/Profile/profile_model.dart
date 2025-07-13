import 'dart:convert';


UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));
String userModelToJson(UserModel data) => json.encode(data.toJson());



class UserModel {
    String? responseText;
    int? responseCode;
    UserData? responseData;

    UserModel({
        this.responseText,
        this.responseCode,
        this.responseData,
    });

    UserModel copyWith({
        String? responseText,
        int? responseCode,
        UserData? responseData,
    }) => 
        UserModel(
            responseText: responseText ?? this.responseText,
            responseCode: responseCode ?? this.responseCode,
            responseData: responseData ?? this.responseData,
        );

    factory UserModel.fromRawJson(String str) => UserModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        responseText: json["responseText"],
        responseCode: json["responseCode"],
        responseData: json["responseData"] == null ? null : UserData.fromJson(json["responseData"]),
    );

    Map<String, dynamic> toJson() => {
        "responseText": responseText,
        "responseCode": responseCode,
        "responseData": responseData?.toJson(),
    };
}

class UserData {
    String? userId;
    String? firstName;
    String? isProductFeed;
    String? isNewsLetter;
    String? lastName;
    String? phone;
    String? email;
    String? profileImage;

    UserData({
        this.userId,
        this.firstName,
        this.isProductFeed,
        this.isNewsLetter,
        this.lastName,
        this.phone,
        this.email,
        this.profileImage,
    });

    UserData copyWith({
        String? userId,
        String? firstName,
        String? isProductFeed,
        String? isNewsLetter,
        String? lastName,
        String? phone,
        String? email,
        String? profileImage,
    }) => 
        UserData(
            userId: userId ?? this.userId,
            firstName: firstName ?? this.firstName,
            isProductFeed: isProductFeed ?? this.isProductFeed,
            isNewsLetter: isNewsLetter ?? this.isNewsLetter,
            lastName: lastName ?? this.lastName,
            phone: phone ?? this.phone,
            email: email ?? this.email,
            profileImage: profileImage ?? this.profileImage,
        );

    factory UserData.fromRawJson(String str) => UserData.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        userId: json["userId"],
        firstName: json["firstName"],
        isProductFeed: json["isProductFeed"],
        isNewsLetter: json["isNewsLetter"],
        lastName: json["lastName"],
        phone: json["phone"],
        email: json["email"],
        profileImage: json["profileImage"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "firstName": firstName,
        "isProductFeed": isProductFeed,
        "isNewsLetter": isNewsLetter,
        "lastName": lastName,
        "phone": phone,
        "email": email,
        "profileImage": profileImage,
    };
}
