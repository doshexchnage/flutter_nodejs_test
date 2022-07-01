class User {
  User({
    this.name,
    required this.email,
    required this.token,
  });

  String? name;
  String email;
  String token;

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        email: json["email"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "token": token,
      };
}
