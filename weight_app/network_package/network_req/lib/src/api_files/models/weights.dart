class WeightResponseModel {
  WeightResponseModel(this.responseCode, this.msg);

  int responseCode;
  String msg;
}

class UserWeight {
  int? id;
  int? userID;
  DateTime? date;
  double? value;

  UserWeight({this.id, this.userID, this.date, this.value});

  UserWeight.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userID = json['userID'];
    date = DateTime.parse(json['date']);
    value = double.parse(json['value'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userID'] = userID;
    data['date'] = date.toString();
    data['value'] = value;
    return data;
  }
}
