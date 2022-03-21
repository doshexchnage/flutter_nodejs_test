class User {
  final String? name;
  final String? email;
  final String? password;
  final String? confirm_password;

  const User(
      {required this.name,
      required this.email,
      required this.password,
      required this.confirm_password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      password: json['password'],
      confirm_password: json['confirm_password'],
    );
  }
}
