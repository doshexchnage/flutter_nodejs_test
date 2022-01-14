import 'package:network_req/src/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'models/weights.dart';

class WeightAPI {
  Future<WeightResponseModel> addWieghtRequestFunction(
      int userID, double weight) async {
    var requestBody = {};
    requestBody["userID"] = userID;
    requestBody["value"] = weight;

    final response = await http
        .post(Uri.parse("${authUrl}user/add_weight"),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(requestBody))
        .timeout(Duration(seconds: 30))
        .catchError((e) => throw ('$e'));

    if (response.statusCode == 201) {
      return WeightResponseModel(true, response.body);
    } else if (response.statusCode == 401) {
      return WeightResponseModel(false, response.body);
    } else {
      return WeightResponseModel(false, 'Invalid Request');
    }
  }

  Future<List<UserWeight>> getWieghtRequestFunction(int userID) async {
    final response = await http
        .get(Uri.parse("${authUrl}user/get_weight/$userID"),
            headers: {'userID': '$userID', 'Content-Type': 'application/json'})
        .timeout(Duration(seconds: 30))
        .catchError((e) => throw ('$e'));

    if (response.statusCode == 201) {
      var reqResposne = jsonDecode(response.body);
      List<UserWeight> weights = [];
      for (var item in reqResposne) {
        weights.add(UserWeight(
            id: item['id'],
            userID: item['userID'],
            date: DateTime.parse(item['date']),
            value: item['value'].toDouble()));
      }
      return weights;
    } else if (response.statusCode == 401) {
      throw (response.body);
    } else {
      throw ('Invalid Request');
    }
  }

  Future<WeightResponseModel> deleteWieghtRequestFunction(int weightID) async {
    final response = await http
        .delete(Uri.parse("${authUrl}user/delete_weight/$weightID"),
            headers: {'Content-Type': 'application/json'})
        .timeout(Duration(seconds: 30))
        .catchError((e) => throw ('$e'));

    if (response.statusCode == 201) {
      return WeightResponseModel(true, response.body);
    } else if (response.statusCode == 401) {
      return WeightResponseModel(false, response.body);
    } else {
      return WeightResponseModel(false, 'Invalid Request');
    }
  }
}
