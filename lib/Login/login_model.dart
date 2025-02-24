// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());


class LoginModel {
    String? responseText;
    int? responseCode;
    ResponseData? responseData;

    LoginModel({
        this.responseText,
        this.responseCode,
        this.responseData,
    });

    factory LoginModel.fromRawJson(String str) => LoginModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        responseText: json["responseText"],
        responseCode: json["responseCode"],
        responseData: json["responseData"] == null ? null : ResponseData.fromJson(json["responseData"]),
    );

    Map<String, dynamic> toJson() => {
        "responseText": responseText,
        "responseCode": responseCode,
        "responseData": responseData?.toJson(),
    };
}

class ResponseData {
    String? userId;
    String? firstName;
    String? lastName;
    String? phone;
    String? email;
    String? profileImage;
    String? isEmailVerify;
    String? newsLetter;

    ResponseData({
        this.userId,
        this.firstName,
        this.lastName,
        this.phone,
        this.email,
        this.profileImage,
        this.isEmailVerify,
        this.newsLetter,
    });

    factory ResponseData.fromRawJson(String str) => ResponseData.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ResponseData.fromJson(Map<String, dynamic> json) => ResponseData(
        userId: json["userId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        phone: json["phone"],
        email: json["email"],
        profileImage: json["profileImage"],
        isEmailVerify: json["isEmailVerify"],
        newsLetter: json["newsLetter"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "firstName": firstName,
        "lastName": lastName,
        "phone": phone,
        "email": email,
        "profileImage": profileImage,
        "isEmailVerify": isEmailVerify,
        "newsLetter": newsLetter,
    };
}




// class LoginModel {
//     String? responseText;
//     int? responseCode;
//     ResponseData? responseData;

//     LoginModel({
//         this.responseText,
//         this.responseCode,
//         this.responseData,
//     });

//     LoginModel copyWith({
//         String? responseText,
//         int? responseCode,
//         ResponseData? responseData,
//     }) => 
//         LoginModel(
//             responseText: responseText ?? this.responseText,
//             responseCode: responseCode ?? this.responseCode,
//             responseData: responseData ?? this.responseData,
//         );

//     factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
//         responseText: json["responseText"],
//         responseCode: json["responseCode"],
//         responseData: json.containsKey("responseData") && json["responseData"] != null
//       ? ResponseData.fromJson(json["responseData"])
//       : ResponseData(),
//     );



//     Map<String, dynamic> toJson() => {
//         "responseText": responseText,
//         "responseCode": responseCode,
//         "responseData": responseData?.toJson(),
//     };
// }

// class ResponseData {
//     String? userId;
//     String? firstName;
//     String? lastName;
//     String? phone;
//     String? email;
//     String? profileImage;
//     String? isEmailVerify;
//     String? newsLetter;

//     ResponseData({
//         this.userId,
//         this.firstName,
//         this.lastName,
//         this.phone,
//         this.email,
//         this.profileImage,
//         this.isEmailVerify,
//         this.newsLetter,
//     });

//     ResponseData copyWith({
//         String? userId,
//         String? firstName,
//         String? lastName,
//         String? phone,
//         String? email,
//         String? profileImage,
//         String? isEmailVerify,
//         String? newsLetter,
//     }) => 
//         ResponseData(
//             userId: userId ?? this.userId,
//             firstName: firstName ?? this.firstName,
//             lastName: lastName ?? this.lastName,
//             phone: phone ?? this.phone,
//             email: email ?? this.email,
//             profileImage: profileImage ?? this.profileImage,
//             isEmailVerify: isEmailVerify ?? this.isEmailVerify,
//             newsLetter: newsLetter ?? this.newsLetter,
//         );

//     factory ResponseData.fromJson(Map<String, dynamic> json) => ResponseData(
//         userId: json["userId"],
//         firstName: json["firstName"],
//         lastName: json["lastName"],
//         phone: json["phone"],
//         email: json["email"],
//         profileImage: json["profileImage"],
//         isEmailVerify: json["isEmailVerify"],
//         newsLetter: json["newsLetter"],
//     );

//     Map<String, dynamic> toJson() => {
//         "userId": userId,
//         "firstName": firstName,
//         "lastName": lastName,
//         "phone": phone,
//         "email": email,
//         "profileImage": profileImage,
//         "isEmailVerify": isEmailVerify,
//         "newsLetter": newsLetter,
//     };
// }
