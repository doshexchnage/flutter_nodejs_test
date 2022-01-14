import 'package:network_req/src/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:crypto/crypto.dart';

import 'models/login.dart';

class UserLoginAPI {
  Future<UserLoginResponseModel> requestFunction(
      String userName, String password) async {
    var requestBody = {};
    requestBody["username"] = userName;
    requestBody["password"] = md5.convert(utf8.encode(password)).toString();

    final response = await http
        .post(Uri.parse("${authUrl}login"),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(requestBody))
        .timeout(Duration(seconds: 30))
        .catchError((e) => throw ('$e'));

    if (response.statusCode == 201) {
      var reqResponse = jsonDecode(response.body);
    

      return UserLoginResponseModel(
          UserLoginResponse(201, reqResponse["message"]), {
        "userId": reqResponse["userId"],
        "username": reqResponse["username"],
        "age": reqResponse["age"]
      });
    } else if (response.statusCode == 401) {
      var responseMsg = response.body;
      return UserLoginResponseModel(UserLoginResponse(401, responseMsg), null);
    } else {
      throw ('Invalid Request');
    }
  }
}
