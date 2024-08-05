import 'package:intl/intl.dart';

class CostModel {
  String? id;
  String serviceName;
  String serviceKind;
  DateTime paymentDate;
  DateTime expiryDate;
  DateTime dueDate;
  String paymentInterval;
  String renewMethod;
  String amount;
  String paymentUnit;
  String paymentCard;
  String? email;
  String? remark;
  String activeYn;
  DateTime createdAt;
  String createdBy;
  DateTime? updatedAt;
  String? updatedBy;

  CostModel({
    this.id = "0",
    required this.serviceName,
    required this.serviceKind,
    required this.paymentDate,
    required this.expiryDate,
    required this.dueDate,
    required this.paymentInterval,
    required this.renewMethod,
    required this.amount,
    required this.paymentUnit,
    required this.paymentCard,
    this.email,
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

  factory CostModel.initial() {
    return CostModel(
        id: '',
        serviceName: '',
        serviceKind: '',
        paymentDate: DateTime.now(),
        expiryDate: DateTime.now(),
        dueDate: DateTime.now(),
        paymentInterval: 'MONTHLY',
        renewMethod: 'AUTO',
        amount: '0',
        paymentUnit: 'USD',
        paymentCard: '',
        activeYn: 'Y',
        createdAt: DateTime.now(),
        createdBy: '');
  }

  factory CostModel.fromJson(Map<String, dynamic> json) {
    return CostModel(
        id: json['id'] ?? '',
        serviceName: json['serviceName'],
        serviceKind: json['serviceKind'],
        paymentDate: DateTime.parse(json['paymentDate']),
        expiryDate: DateTime.parse(json['expiryDate']),
        dueDate: DateTime.parse(json['dueDate']),
        paymentInterval: json['paymentInterval'],
        renewMethod: json['renewMethod'],
        amount: json['amount'],
        paymentUnit: json['paymentUnit'],
        paymentCard: json['paymentCard'],
        email: json['email'] ?? '',
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
      'serviceName': serviceName,
      'serviceKind': serviceKind,
      'paymentDate': DateFormat('yyyy-MM-ddTHH:mm:ss').format(paymentDate),
      'expiryDate': DateFormat('yyyy-MM-ddTHH:mm:ss').format(expiryDate),
      'dueDate': DateFormat('yyyy-MM-ddTHH:mm:ss').format(dueDate),
      'paymentInterval': paymentInterval,
      'renewMethod': renewMethod,
      'amount': amount,
      'paymentUnit': paymentUnit,
      'paymentCard': paymentCard,
      'email': email,
      'remark': remark,
      'activeYn': activeYn,
      'createdAt': DateFormat('yyyy-MM-ddTHH:mm:ss').format(createdAt),
      'createdBy': createdBy,
      'updatedAt': DateFormat('yyyy-MM-ddTHH:mm:ss').format(updatedAt!),
      'updatedBy': updatedBy
    };
  }
}


enum MENUCost { DISPLAY, CREATE }
