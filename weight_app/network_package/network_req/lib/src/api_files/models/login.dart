class UserLoginResponse {
  UserLoginResponse(this.responseCode, this.msg);

  int responseCode;
  String msg;
}

class UserLoginResponseModel {
  UserLoginResponseModel(this.response, this.data);

  UserLoginResponse response;
  Map<String, dynamic> data;
}