import 'package:network_req/network_req.dart';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'dart:convert';

void main() async {

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

  // // Testing Registration API Model
  // var awesome = Awesome();
  // print('awesome: ${awesome.isAwesome}');
  // var apiModel =
  //     await UserRegistrationAPI().requestFunction('Judus', 'Password1#', 99);
  // print(apiModel.responseCode);
  // print(apiModel.msg);

  // // Testing Login API Model
  // var apiModel = await UserLoginAPI().requestFunction("Judus", "Password1#");
  // print(apiModel.response.responseCode);
  // print(apiModel.response.msg);
  // print(apiModel.data);
}
