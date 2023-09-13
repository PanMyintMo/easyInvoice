class Ward {
  final int id;
  final int state_id;
  final String ward_name;
  final String created_at;
  final String? updated_at;

  Ward({
    required this.id,
    required this.state_id,
    required this.ward_name,
    required this.created_at,
    this.updated_at,
  });

  factory Ward.fromJson(Map<String, dynamic> json) {
    return Ward(
      id: json['id'],
      state_id: json['state_id'],
      ward_name: json['ward_name'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
    );
  }
}