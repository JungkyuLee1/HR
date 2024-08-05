// class CodeModel {
//   String code;
//   String name;
//   int seq;
//
//   CodeModel({required this.code, required this.name, required this.seq});
//
//   factory CodeModel.fromJson(Map<String, dynamic> json) {
//     return CodeModel(code: json['code'], name: json['name'], seq: json['seq']);
//   }
//
//   Map<String, dynamic> toJson() {
//     return {'code': code, 'name': name, 'seq': seq};
//   }
// }

class CodeModel {
  String type;
  String code;
  String name;
  int seq;

  CodeModel({required this.type, required this.code, required this.name, required this.seq});

  factory CodeModel.fromJson(Map<String, dynamic> json) {
    return CodeModel(type: json['type'], code: json['code'], name: json['name'], seq: json['seq']);
  }

  Map<String, dynamic> toJson() {
    return {'type': type,'code': code, 'name': name, 'seq': seq};
  }
}

//Flutter,PHP,etc..
// class RoleModel {
//   int? code;
//   String name;
//   int seq;
//
//   RoleModel({this.code=0, required this.name, required this.seq});
//
//   factory RoleModel.fromJson(Map<String, dynamic> json) {
//     return RoleModel(code: json['code'], name: json['name'], seq: json['seq']);
//   }
//
//   Map<String, dynamic> toJson() {
//     return {'code': code, 'name': name, 'seq': seq};
//   }
// }
//
// //IDR&WON
// class UnitModel {
//   int? code;
//   String name;
//   int seq;
//
//   UnitModel({this.code=0, required this.name, required this.seq});
//
//   factory UnitModel.fromJson(Map<String, dynamic> json) {
//     return UnitModel(
//         code: json['code'], name: json['name'], seq: json['seq']);
//   }
//
//   Map<String, dynamic> toJson() {
//     return {'code': code, 'name': name, 'seq': seq};
//   }
// }
//
// //미혼&기혼
// class MaritalModel {
//   int? code;
//   String name;
//   int seq;
//
//   MaritalModel(
//       {this.code=0, required this.name, required this.seq});
//
//   factory MaritalModel.fromJson(Map<String, dynamic> json) {
//     return MaritalModel(
//         code: json['code'], name: json['name'], seq: json['seq']);
//   }
//
//   Map<String, dynamic> toJson() {
//     return {'code': code, 'name': name, 'seq': seq};
//   }
// }
