class Weight {
  Weight({
    required this.time,
    required this.weight,
  });

  String time;
  String weight;

  factory Weight.fromJson(Map<String, dynamic> json) => Weight(
        time: json["time"],
        weight: json["weight"],
      );

  Map<String, dynamic> toJson() => {
        "time": time,
        "weight": weight,
      };
}
