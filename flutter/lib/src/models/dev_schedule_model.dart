import 'package:intl/intl.dart';

class DevScheduleModel {
  String? id;
  String title;
  String detail;
  String nation;
  String completeStatus;
  String devPeriodKind;
  String activeYn;
  DateTime createdAt;
  String createdBy;
  DateTime? updatedAt;
  String? updatedBy;

  DevScheduleModel(
      {this.id = '0',
      required this.title,
      required this.detail,
      required this.nation,
      required this.completeStatus,
      required this.devPeriodKind,
      required this.activeYn,
      required this.createdAt,
      required this.createdBy,
      DateTime? updatedAt,
      this.updatedBy})
      : this.updatedAt = updatedAt ??
            DateTime(
                DateTime.now().year, DateTime.now().month, DateTime.now().day);

  factory DevScheduleModel.initial() {
    return DevScheduleModel(
        id: '',
        title: '',
        detail: '',
        nation: 'ALL',
        completeStatus: '진행',
        devPeriodKind: '4주 내',
        activeYn: 'Y',
        createdAt: DateTime.now(),
        createdBy: '');
  }

  factory DevScheduleModel.fromJson(Map<String, dynamic> json) {
    return DevScheduleModel(
        id: json['id'] ?? '',
        title: json['title'],
        detail: json['detail'],
        nation: json['nation'],
        completeStatus: json['completeStatus'],
        devPeriodKind: json['devPeriodKind'],
        activeYn: json['activeYn'],
        createdAt: DateTime.parse(json['createdAt']),
        createdBy: json['createdBy'],
        updatedAt: json['updatedAt'] !=null ? DateTime.parse(json['updatedAt']) : null,
        updatedBy: json['updatedBy']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'detail': detail,
      'nation': nation,
      'completeStatus': completeStatus,
      'devPeriodKind': devPeriodKind,
      'activeYn': activeYn,
      'createdAt': DateFormat('yyyy-MM-ddTHH:mm:ss').format(createdAt),
      'createdBy': createdBy,
      'updatedAt': DateFormat('yyyy-MM-ddTHH:mm:ss').format(updatedAt!),
      'updatedBy': updatedBy
    };
  }
}

enum MENUDevSchedule { DISPLAY, CREATE }
enum StatusFlag {ALL, ONGOING, FINISH}
