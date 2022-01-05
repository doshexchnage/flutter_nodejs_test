import 'package:network_req/network_req.dart';

void main() async {
  // var awesome = Awesome();
  // print('awesome: ${awesome.isAwesome}');
  var apiModel =
      await UserRegistrationAPI().requestFunction('User One', 'Password1#', 19);
  print(apiModel.responseCode);
  print(apiModel.msg);
}
