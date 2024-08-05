import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr2024/src/components/widgets/chart/indicator.dart';
import 'package:hr2024/src/controllers/employee/employee_chart_controller.dart';

class EmployeePieChart extends GetView<EmployeeChartController> {
  EmployeePieChart({Key? key}) : super(key: key);

  int touchedIndex = -1;

  pieChartSectionData(Color color, double value, String title, double radius,
      double fontSize, List<Shadow> shadows) {
    return PieChartSectionData(
        color: color,
        value: value,
        title: title,
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          shadows: shadows,
        ));
  }

  //1-1 (역할 10개까지 가능)
  List<PieChartSectionData> showingSections() {
    return List.generate(controller.lstRoleCount.value.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      switch (i) {
        case 0:
          return pieChartSectionData(
              Colors.blue,
              (controller.lstRoleCount.value[i].cnt /
                      controller.totalCount.value *
                      100)
                  .toDouble(),
              controller.lstRoleCount.value[i].cnt.toString(),
              radius,
              fontSize,
              shadows);
        case 1:
          return pieChartSectionData(
              Colors.orange,
              (controller.lstRoleCount.value[i].cnt /
                      controller.totalCount.value *
                      100)
                  .toDouble(),
              controller.lstRoleCount.value[i].cnt.toString(),
              radius,
              fontSize,
              shadows);

        case 2:
          return pieChartSectionData(
              Colors.yellow,
              (controller.lstRoleCount.value[i].cnt /
                      controller.totalCount.value *
                      100)
                  .toDouble(),
              controller.lstRoleCount.value[i].cnt.toString(),
              radius,
              fontSize,
              shadows);

        case 3:
          return pieChartSectionData(
              Colors.green,
              (controller.lstRoleCount.value[i].cnt /
                      controller.totalCount.value *
                      100)
                  .toDouble(),
              controller.lstRoleCount.value[i].cnt.toString(),
              radius,
              fontSize,
              shadows);

        case 4:
          return pieChartSectionData(
              Colors.red,
              (controller.lstRoleCount.value[i].cnt /
                      controller.totalCount.value *
                      100)
                  .toDouble(),
              controller.lstRoleCount.value[i].cnt.toString(),
              radius,
              fontSize,
              shadows);

        case 5:
          return pieChartSectionData(
              Colors.cyan,
              (controller.lstRoleCount.value[i].cnt /
                      controller.totalCount.value *
                      100)
                  .toDouble(),
              controller.lstRoleCount.value[i].cnt.toString(),
              radius,
              fontSize,
              shadows);

        case 6:
          return pieChartSectionData(
              Colors.purple,
              (controller.lstRoleCount.value[i].cnt /
                      controller.totalCount.value *
                      100)
                  .toDouble(),
              controller.lstRoleCount.value[i].cnt.toString(),
              radius,
              fontSize,
              shadows);

        case 7:
          return pieChartSectionData(
              Colors.indigoAccent,
              (controller.lstRoleCount.value[i].cnt /
                      controller.totalCount.value *
                      100)
                  .toDouble(),
              controller.lstRoleCount.value[i].cnt.toString(),
              radius,
              fontSize,
              shadows);

        case 8:
          return pieChartSectionData(
              Colors.grey,
              (controller.lstRoleCount.value[i].cnt /
                      controller.totalCount.value *
                      100)
                  .toDouble(),
              controller.lstRoleCount.value[i].cnt.toString(),
              radius,
              fontSize,
              shadows);

        case 9:
          return pieChartSectionData(
              Colors.greenAccent,
              (controller.lstRoleCount.value[i].cnt /
                      controller.totalCount.value *
                      100)
                  .toDouble(),
              controller.lstRoleCount.value[i].cnt.toString(),
              radius,
              fontSize,
              shadows);

        case 10:
          return pieChartSectionData(
              Colors.yellowAccent,
              (controller.lstRoleCount.value[i].cnt /
                      controller.totalCount.value *
                      100)
                  .toDouble(),
              controller.lstRoleCount.value[i].cnt.toString(),
              radius,
              fontSize,
              shadows);

        default:
          throw Error();
      }
    });
  }

  //1-2
  _Indicators({required Color color, required text}) {
    return Indicator(
      color: color,
      text: text,
      isSquare: true,
    );
  }

  //1
  _PieChart() {
    return AspectRatio(
      aspectRatio: 2 / 1,
      child: Row(
        children: [
          Expanded(
              child: AspectRatio(
            aspectRatio: 1,
            child: PieChart(PieChartData(
              pieTouchData: PieTouchData(
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {
                //setState()
                if (!event.isInterestedForInteractions ||
                    pieTouchResponse == null ||
                    pieTouchResponse.touchedSection == null) {
                  touchedIndex = -1;
                  return;
                }
                touchedIndex =
                    pieTouchResponse.touchedSection!.touchedSectionIndex;
              }),
              borderData: FlBorderData(show: false),
              sectionsSpace: 2,
              centerSpaceRadius: 40,
              sections: showingSections(),
            )),
          )),
          SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                    List.generate(controller.lstRoleCount.value.length, (i) {
                  return _Indicators(
                    color: i == 0
                        ? Colors.blue
                        : i == 1
                            ? Colors.orange
                            : i == 2
                                ? Colors.yellow
                                : i == 3
                                    ? Colors.green
                                    : i == 4
                                        ? Colors.red
                                        : i == 5
                                            ? Colors.cyan
                                            : i == 6
                                                ? Colors.purple
                                                : i == 7
                                                    ? Colors.indigoAccent
                                                    : i == 8
                                                        ? Colors.grey
                                                        : i == 9
                                                            ? Colors.greenAccent
                                                            : Colors
                                                                .yellowAccent,
                    text: controller.lstRoleCount.value[i].role,
                  );
                })),
          ),
          SizedBox(
            width: 28,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(
        () => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 6,
              ),
              Text(
                '역할별 인원(총원: ${controller.totalCount.toString()}명)',
                style: TextStyle(fontSize: 16, color: Colors.black),
                textScaler: TextScaler.linear(1),
              ),
              SizedBox(
                height: 22,
              ),
              _PieChart(),
            ],
          ),
        ),
      ),
    );
  }
}
