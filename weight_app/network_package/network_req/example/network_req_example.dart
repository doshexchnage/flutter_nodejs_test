import 'package:network_req/network_req.dart';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'dart:convert';

void main() async {

  //   // Testing Registration API Model
  // var apiModel =
  //     await UserRegistrationAPI().requestFunction('MeAlpha', 'Password1#', 99);
  // print(apiModel.responseCode);
  // print(apiModel.msg);

  // Testing Login API Model
  var apiModel2 = await UserLoginAPI().requestFunction("MeAlpha", "Password1#");
  print(apiModel2.response.responseCode);
  print(apiModel2.response.msg);
  print(apiModel2.data);
}
  // // Testing Weight API Model
  // var apiModel = WeightAPI();

  // // Add weight
  // print("== Add Weight==");
  // try {
  //   var data =
  //       await apiModel.addWieghtRequestFunction(5, Random().nextInt(300) + 1);
  //   print(data.responseCode);
  //   print(data.msg);
  // } catch (e) {
  //   print(e);
  // }

  // // Get User Weight
  // print("== Get User Weights ==");
  // try {
  //   var data = await apiModel.getWieghtRequestFunction(5);
  //   for (var element in data) {
  //     print("ID: ${element.id}");
  //     print("Weight: ${element.id}");
  //     print("Date: ${element.date}");
  //     print("Value: ${element.value}");
  //     print("====");
  //   }
  // } catch (e) {
  //   print(e);
  // }

  // // Delete Weight
  // print("== Delete Weight ==");
  // try {
  //   var data = await apiModel.deleteWieghtRequestFunction(4);
  //   print(data.responseCode);
  //   print(data.msg);
  // } catch (e) {
  //   print(e);
  // }


