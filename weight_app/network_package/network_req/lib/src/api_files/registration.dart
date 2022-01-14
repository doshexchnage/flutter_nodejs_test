import 'package:network_req/src/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:crypto/crypto.dart';

import 'models/registration.dart';



class UserRegistrationAPI {
  Future<UserRegistrationResponse> requestFunction(
      String userName, String password, int age) async {
    var requestBody = {};
    requestBody["username"] = userName;
    requestBody["password"] = md5.convert(utf8.encode(password)).toString();
    requestBody["age"] = age;

    final response = await http
        .post(Uri.parse("${authUrl}registration"),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(requestBody))
        .timeout(Duration(seconds: 30))
        .catchError((e) => throw ('$e'));

    if (response.statusCode == 201) {
      return UserRegistrationResponse(201, response.body);
    } else if (response.statusCode == 401) {
      return UserRegistrationResponse(401, response.body);
    } else {
      throw ('Invalid Request');
    }
  }
}
