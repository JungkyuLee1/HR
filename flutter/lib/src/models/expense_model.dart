import 'package:intl/intl.dart';

class ExpenseModel {
  String? id;
  String kind;
  DateTime inOutcomeDate;
  String item;
  int amount;
  String unit;
  String? remark;
  String activeYn;
  DateTime createdAt;
  String createdBy;
  DateTime? updatedAt;
  String? updatedBy;

  ExpenseModel({
    this.id = "0",
    required this.kind,
    required this.inOutcomeDate,
    required this.item,
    required this.amount,
    required this.unit,
    this.remark,
    required this.activeYn,
    required this.createdAt,
    required this.createdBy,
    DateTime? updatedAt,
    this.updatedBy,
  }) : this.updatedAt = updatedAt ??
      DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
      );

  factory ExpenseModel.initial() {
    return ExpenseModel(
        id: '',
        kind: '',
        inOutcomeDate: DateTime.now(),
        item: '',
        amount: 0,
        unit: 'IDR',
        remark: '',
        activeYn: 'Y',
        createdAt: DateTime.now(),
        createdBy: '');
  }

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
        id: json['id'] ?? '',
        kind: json['kind'],
        inOutcomeDate: DateTime.parse(json['inOutcomeDate']),
        item: json['item'],
        amount: json['amount'],
        // amount: int.parse(json['amount']),
        unit: json['unit'],
        remark: json['remark'] ?? '',
        activeYn: json['activeYn'],
        createdAt: DateTime.parse(json['createdAt']),
        createdBy: json['createdBy'],
        updatedAt: json['updatedAt'] !=null ? DateTime.parse(json['updatedAt']) : null,
        updatedBy: json['updatedBy']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'kind': kind,
      'inOutcomeDate': DateFormat('yyyy-MM-ddTHH:mm:ss').format(inOutcomeDate),
      'item': item,
      'amount': amount,
      'unit': unit,
      'remark': remark,
      'activeYn': activeYn,
      'createdAt': DateFormat('yyyy-MM-ddTHH:mm:ss').format(createdAt),
      'createdBy': createdBy,
      'updatedAt': DateFormat('yyyy-MM-ddTHH:mm:ss').format(updatedAt!),
      'updatedBy': updatedBy
    };
  }
}

enum MENUExpense { DISPLAY, CREATE }
