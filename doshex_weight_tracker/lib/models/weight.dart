class Weight {
  final String current_weight;
  final String created_at;
  // final String? updatedAt;

  const Weight({required this.current_weight, required this.created_at});

  factory Weight.fromJson(Map<String, dynamic> json) {
    return Weight(
      current_weight: json['current_weight'],
      created_at: json['created_at'],
    );
  }
}
