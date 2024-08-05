import 'dart:core';

import 'package:intl/intl.dart';

class EmployeeModel {
  String? id;
  String name;
  String? imageUrl;
  String role;
  DateTime entryDate;
  String hireType;
  double career;
  int salary;
  String unit;
  String skill;
  String hp;
  String email;
  DateTime birthDate;
  String marital;
  String? family;
  String? bank;
  String? bankAccount;
  String? remark;
  String activeYn;
  DateTime createdAt;
  String? createdBy;
  DateTime? updatedAt;
  String? updatedBy;

  EmployeeModel({
    this.id = "0",
    required this.name,
    this.imageUrl = "image Url",
    required this.role,
    DateTime? entryDate,
    required this.hireType,
    required this.career,
    required this.salary,
    required this.unit,
    required this.skill,
    required this.hp,
    required this.email,
    DateTime? birthDate,
    required this.marital,
    this.family,
    this.bank,
    this.bankAccount,
    this.remark,
    required this.activeYn,
    DateTime? createdAt,
    this.createdBy,
    DateTime? updatedAt,
    this.updatedBy,
  })  : this.entryDate = entryDate ??
            DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
            ),
        this.birthDate = birthDate ??
            DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
            ),
        this.createdAt = createdAt ??
            DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
            ),
        this.updatedAt = updatedAt ??
            DateTime(
                DateTime.now().year, DateTime.now().month, DateTime.now().day);

  factory EmployeeModel.initial() {
    return EmployeeModel(
      id: '',
      name: '',
      imageUrl: '',
      role: '역할',
      entryDate: DateTime.now(),
      hireType: '정규직',
      career: 0.0,
      salary: 0,
      unit: 'IDR',
      skill: '',
      hp: '',
      email: '',
      birthDate: DateTime.now(),
      marital: '미혼',
      family: '',
      bank: '',
      bankAccount: '',
      remark: '',
      activeYn: 'Y',
      createdAt: DateTime.now(),
      createdBy:'',
      updatedAt: DateTime.now(),
      updatedBy:''
    );
  }

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
        id: json['id'] ?? "",
        name: json['name'],
        imageUrl: json['imageUrl'],
        role: json['role'],
        entryDate: DateTime.parse(json['entryDate']),
        hireType: json['hireType'],
        career: json['career'],
        salary: json['salary'],
        unit: json['unit'],
        skill: json['skill'],
        hp: json['hp'],
        email: json['email'],
        birthDate: DateTime.parse(json['birthDate']),
        marital: json['marital'],
        family: json['family'],
        bank: json['bank'],
        bankAccount: json['bankAccount'],
        remark: json['remark'],
        activeYn: json['activeYn'],
        createdAt: DateTime.parse(json['createdAt']),
        createdBy: json['createdBy'],
        updatedAt: json['updatedAt'] !=null ? DateTime.parse(json['updatedAt']) : null,
        updatedBy: json['updatedBy']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'role': role,
      'entryDate': DateFormat('yyyy-MM-ddTHH:mm:ss').format(entryDate),
      'hireType' : hireType,
      'career': career,
      'salary': salary,
      'unit': unit,
      'skill': skill,
      'hp': hp,
      'email': email,
      'birthDate': DateFormat('yyyy-MM-ddTHH:mm:ss').format(birthDate),
      'marital': marital,
      'family': family,
      'bank': bank,
      'bankAccount': bankAccount,
      'remark': remark,
      'activeYn': activeYn,
      'createdAt': DateFormat('yyyy-MM-ddTHH:mm:ss').format(createdAt),
      'createdBy': createdBy,
      'updatedAt': DateFormat('yyyy-MM-ddTHH:mm:ss').format(updatedAt!),
      'updatedBy': updatedBy
    };
  }

// @override
// String toString() {
//   return '{name: $name,role: $role,entryDate: $entryDate,'
//       'career: $career,salary: $salary,unit: $unit,skill: $skill,'
//       'hp: $hp, email: $email,birthDate: $birthDate,marital: $marital,'
//       'family: $family,bank: $bank,bankAccount: $bankAccount,remark: $remark, activeYn: $activeYn}';
// }
}


enum MENUEmployee { DISPLAY, CREATE, STATISTICS }
