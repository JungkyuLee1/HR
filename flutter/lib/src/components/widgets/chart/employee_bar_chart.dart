import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr2024/src/controllers/employee/employee_chart_controller.dart';
import 'package:hr2024/src/models/employee_model.dart';

class EmployeeBarChart extends GetView<EmployeeChartController> {
  EmployeeBarChart({Key? key}) : super(key: key);

  int sequence = 0;

  //1
  BarTouchData get barTouchData => BarTouchData(
      enabled: false,
      touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(rod.toY.round().toString(),
                TextStyle(color: Colors.cyan, fontWeight: FontWeight.bold));
          }));

  //2-1
  Widget getTitles(double value, TitleMeta meta) {
    final style = TextStyle(
      color: Colors.blue,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );

    String text;
    // if (value > controller.chartEmployees.value.length) return Container();

    switch (value.toInt()) {
      case 0:
        text = controller.chartEmployees.value[0].name.toString();
        break;
      case 1:
        text = controller.chartEmployees.value[1].name.toString();
        break;
      case 2:
        text = controller.chartEmployees.value[2].name.toString();
        break;
      case 3:
        text = controller.chartEmployees.value[3].name.toString();
        break;
      case 4:
        text = controller.chartEmployees.value[4].name.toString();
        break;
      case 5:
        text = controller.chartEmployees.value[5].name.toString();
        break;
      case 6:
        text = controller.chartEmployees.value[6].name.toString();
        break;
      case 7:
        text = controller.chartEmployees.value[7].name.toString();
        break;
      case 8:
        text = controller.chartEmployees.value[8].name.toString();
        break;
      case 9:
        text = controller.chartEmployees.value[9].name.toString();
        break;
      case 10:
        text = controller.chartEmployees.value[10].name.toString();
        break;
      case 11:
        text = controller.chartEmployees.value[11].name.toString();
        break;
      case 12:
        text = controller.chartEmployees.value[12].name.toString();
        break;
      case 13:
        text = controller.chartEmployees.value[13].name.toString();
        break;
      case 14:
        text = controller.chartEmployees.value[14].name.toString();
        break;
      case 15:
        text = controller.chartEmployees.value[15].name.toString();
        break;
      case 16:
        text = controller.chartEmployees.value[16].name.toString();
        break;
      case 17:
        text = controller.chartEmployees.value[17].name.toString();
        break;
      case 18:
        text = controller.chartEmployees.value[18].name.toString();
        break;
      case 19:
        text = controller.chartEmployees.value[19].name.toString();
        break;
      case 20:
        text = controller.chartEmployees.value[20].name.toString();
        break;
      default:
        text = '';
        break;
    }

    return SideTitleWidget(
        child: Text(
          text.substring(0,2),
          style: style,
          textScaler: TextScaler.linear(1),
        ),
        axisSide: meta.axisSide,
        space: 4);
  }

  //2
  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
            sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 30,
          getTitlesWidget: getTitles,
        )),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  //3
  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  //4-1
  LinearGradient get _barsGradient => LinearGradient(colors: [
        Colors.blue,
        Colors.cyan,
      ], begin: Alignment.bottomCenter, end: Alignment.topCenter);

  //4
  List<BarChartGroupData> get barGroups {
    int seq = 0;
    List<BarChartGroupData> _barChartGroupData = [];

    //대상 인원 Setting
    for (EmployeeModel emp in controller.chartEmployees.value) {
      if (emp.name != null) {
        _barChartGroupData.add(BarChartGroupData(
          x: seq,
          barRods: [
            BarChartRodData(
                toY: emp.salary.toDouble() / 1000000, gradient: _barsGradient)
          ],
          showingTooltipIndicators: [0],
        ));
      }
      seq++;
    }
    return _barChartGroupData;
  }

  _BarChart() {
    return Expanded(
      child: BarChart(
        BarChartData(
          barTouchData: barTouchData,
          titlesData: titlesData,
          borderData: borderData,
          barGroups: barGroups,
          gridData: FlGridData(show: false),
          alignment: BarChartAlignment.spaceAround,
          maxY: 20,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(color: Colors.black),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 5,
            ),
            Expanded(
              child: Text(
                '직원별 급여 현황(백만,Rupiah)',
                style: TextStyle(fontSize: 16, color: Colors.white),
                textScaler: TextScaler.linear(1),
              ),
            ),
            _BarChart(),
            Text(
              "*개인별 급여는 '직원조회'에서 확인 가능",
              style: TextStyle(fontSize: 12, color: Colors.white),
              textScaler: TextScaler.linear(1),
            ),
            SizedBox(
              height: 5,
            )
          ],
        ),
      ),
    );
  }
}
