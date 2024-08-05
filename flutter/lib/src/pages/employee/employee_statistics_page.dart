import 'package:flutter/material.dart';
import 'package:hr2024/src/components/widgets/chart/employee_bar_chart.dart';
import 'package:hr2024/src/components/widgets/chart/employee_pie_chart.dart';


class EmployeeStatistics extends StatelessWidget {
  const EmployeeStatistics({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          EmployeeBarChart(),
          EmployeePieChart()
        ],
      ),
    );
  }
}