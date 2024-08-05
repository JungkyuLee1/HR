class RoleCountModel {
  String role;
  int cnt;

  RoleCountModel({required this.role, required this.cnt});

  factory RoleCountModel.fromJson(Map<String, dynamic> json) {
    return RoleCountModel(role: json['role'], cnt: json['cnt']);
  }

  Map<String, dynamic> toJson() {
    return {'role': role, 'cnt': cnt};
  }
}
