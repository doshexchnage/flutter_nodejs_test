import 'package:network_req/src/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:crypto/crypto.dart';

class UserRegistrationResponse {
  UserRegistrationResponse(this.responseCode, this.msg);

  int responseCode;
  String msg;
}

class UserRegistrationAPI {
  Future<UserRegistrationResponse> requestFunction(
      String userName, String password, int age) async {
    var requestBody = {};
    requestBody["username"] = userName;
    requestBody["password"] = password;
    requestBody["age"] = age;

    final response = await http
        .post(Uri.parse("${authUrl}registration"),
            body:requestBody)
        .timeout(Duration(seconds: 30))
        .catchError((e) => throw ('Network Connection Error'));

    if (response.statusCode == 201) {
      var responseMsg = jsonDecode(response.body);
      print(responseMsg);

      return UserRegistrationResponse(201, responseMsg);
    } else if (response.statusCode == 401) {
      var responseMsg = jsonDecode(response.body)['detail'];
      return UserRegistrationResponse(401, responseMsg);
    } else {
      throw ('Invalid Request');
    }
  }
}
