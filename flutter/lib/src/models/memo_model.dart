import 'package:intl/intl.dart';

class MemoModel {
  String? id;
  String content;
  String activeYn;
  DateTime createdAt;
  String createdBy;
  DateTime? updatedAt;
  String? updatedBy;

  MemoModel(
      {this.id = '0',
        required this.content,
        required this.activeYn,
        required this.createdAt,
        required this.createdBy,
        DateTime? updatedAt,
        this.updatedBy})
      : this.updatedAt = updatedAt ??
      DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day);

  factory MemoModel.initial() {
    return MemoModel(
        id: '',
        content: '',
        activeYn: 'Y',
        createdAt: DateTime.now(),
        createdBy: '');
  }

  factory MemoModel.fromJson(Map<String, dynamic> json) {
    return MemoModel(
        id: json['id'] ?? '',
        content: json['content'],
        activeYn: json['activeYn'],
        createdAt: DateTime.parse(json['createdAt']),
        createdBy: json['createdBy'],
        updatedAt: json['updatedAt'] !=null ? DateTime.parse(json['updatedAt']) : null,
        updatedBy: json['updatedBy']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'activeYn': activeYn,
      'createdAt': DateFormat('yyyy-MM-ddTHH:mm:ss').format(createdAt),
      'createdBy': createdBy,
      'updatedAt': DateFormat('yyyy-MM-ddTHH:mm:ss').format(updatedAt!),
      'updatedBy': updatedBy
    };
  }
}