import 'package:flutter/material.dart';

class ImageData extends StatelessWidget {
  const ImageData(this.icon, {this.width = 30, Key? key}) : super(key: key);

  final String icon;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      icon,
      width: width,
    );
  }
}

class IconPath {
  static String get employeeOn => 'assets/images/employee.png';
  static String get regularCostOn => 'assets/images/regular_cost.png';
  static String get expenseOn => 'assets/images/expense.png';
  static String get devScheduleOn => 'assets/images/dev_schedule.jpg';
  static String get serviceLinkOn => 'assets/images/service.jpg';
}
