class UserLogin {
  UserLogin(
      {this.userID,
      this.userName,
      this.age});

  int? userID;
  String? userName;
  int? age;

  factory UserLogin.fromJson(Map<String, dynamic> json) => UserLogin(
      userID: json["id"],
      userName: json["firstname"],
      age: json["lastname"]);

  Map<String, dynamic> toJson() => {
        "userID": userID,
        "userName": userName,
        "age": age
      };
}