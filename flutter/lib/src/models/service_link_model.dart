import 'package:intl/intl.dart';

class ServiceLinkModel {
  String? id;
  String task;
  int seq;
  String title;
  String url;
  String? userName;
  String? pwd;
  String? content;
  String? remark;
  String activeYn;
  DateTime createdAt;
  String createdBy;
  DateTime? updatedAt;
  String? updatedBy;

  ServiceLinkModel(
      {this.id = '0',
        required this.task,
        required this.seq,
        required this.title,
        required this.url,
        this.userName,
        this.pwd,
        this.content,
        this.remark,
        required this.activeYn,
        required this.createdAt,
        required this.createdBy,
        DateTime? updatedAt,
        this.updatedBy})
      : this.updatedAt = updatedAt ??
      DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day);

  factory ServiceLinkModel.initial() {
    return ServiceLinkModel(
        id: '',
        task: '',
        seq: 1,
        title: '',
        url: '',
        activeYn: 'Y',
        createdAt: DateTime.now(),
        createdBy: '');
  }

  factory ServiceLinkModel.fromJson(Map<String, dynamic> json) {
    return ServiceLinkModel(
        id: json['id'] ?? '',
        task: json['task'] ?? '',
        seq: json['seq'] ?? 0,
        title: json['title'] ?? '',
        url: json['url'] ?? '',
        userName: json['userName'] ?? '',
        pwd: json['pwd'] ?? '',
        content: json['content'] ?? '',
        remark: json['remark'] ?? '',
        activeYn: json['activeYn'] ?? 'Y',
        createdAt: DateTime.parse(json['createdAt']),
        createdBy: json['createdBy'] ?? 'jackie lee',
        updatedAt: json['updatedAt'] !=null ? DateTime.parse(json['updatedAt']) : null,
        updatedBy: json['updatedBy'] ?? 'jackie') ;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'task': task,
      'seq': seq,
      'title': title,
      'url': url,
      'userName': userName,
      'pwd': pwd,
      'content': content,
      'remark': remark,
      'activeYn': activeYn,
      'createdAt': DateFormat('yyyy-MM-ddTHH:mm:ss').format(createdAt),
      'createdBy': createdBy,
      'updatedAt': DateFormat('yyyy-MM-ddTHH:mm:ss').format(updatedAt!),
      'updatedBy': updatedBy
    };
  }
}


