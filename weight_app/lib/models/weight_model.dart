class Weights {
  int? id;
  int? userID;
  String? date;
  double? value;

  Weights(
      {required this.id,
      required this.userID,
      required this.date,
      required this.value});

  factory Weights.fromJson(Map<String, dynamic> json) => Weights(
      id: json['id'],
      userID: json['userID'],
      date: json['date'],
      value: json['value']);

  Map<String, dynamic> toJson() => {
    "id": id,
    "userID": userID,
    "date":date ,
    "value": value,
  } ;
  }
