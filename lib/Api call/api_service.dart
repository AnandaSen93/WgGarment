import 'dart:convert';
import 'package:wg_garment/Api%20call/api_constant.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  // Future<LoginModel?> loginWithModel( String email, String password)async{

  //   try{
  //     var url = Uri.parse("https://reqres.in/api/login");
  //     var response = await http.post(url, body: {
  //       "email": email,
  //       "password": password
  //     });

  //     if(response.statusCode == 200){
  //       LoginModel model = LoginModel.fromJson(jsonDecode(response.body));
  //       return model;
  //     }
  //   }catch (e){
  //     print(e);
  //   }
  //   return null;
  // }

  Future<dynamic> postApiCall(Map<String, dynamic> params) async {
    try {
      final mainUrl = '${ApiConstant.baseUrl}${ApiConstant.loginUrl}';

      var url = Uri.parse(mainUrl);
      // var response = await http.post(url, body: jsonEncode(body));

      print("URL: ${mainUrl}");
      print("Params: ${params}");

      var request = http.MultipartRequest('POST', url);

      // Convert data to Map<String, String>
      params.forEach((key, value) {
        request.fields[key] = value.toString();
      });
      // request.fields.addAll(params);
      // request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();

      print("StatusCode: ${response.statusCode}");
      print("Response: ${response}");
      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final jsonMap = jsonDecode(responseBody);
        print("Response: ${responseBody}");
        // Map JSON to the ApiResponse model
        return responseBody;
      }
    } catch (e) {
      print(e);
    }
  }


  
}

class ApiConstants {}
