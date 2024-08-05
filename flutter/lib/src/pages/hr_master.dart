import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr2024/src/components/image_data.dart';
import 'package:hr2024/src/controllers/app_controller.dart';
import 'package:hr2024/src/controllers/bottom_nav_controller.dart';
import 'package:hr2024/src/pages/DevSchedule/devSchedule_main_page.dart';
import 'package:hr2024/src/pages/cost/cost_main_page.dart';
import 'package:hr2024/src/pages/employee/employee_main_page.dart';
import 'package:hr2024/src/pages/expense/expense_main_page.dart';
import 'package:hr2024/src/pages/memo/memo_main_page.dart';
import 'package:hr2024/src/pages/serviceLink/servicelink_page.dart';

class HrMaster extends GetView<BottomNavController> {
  const HrMaster({Key? key}) : super(key: key);

  _bottomNavBar(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      // showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedFontSize: 12,
      selectedItemColor: Colors.red,
      // selectedIconTheme: IconThemeData(color: Colors.red),
      elevation: 0,
      currentIndex: controller.pageIndex.value,
      onTap: controller.changeBottomNav,
      items: [
        BottomNavigationBarItem(
            icon: ImageData(
              IconPath.employeeOn,
              width: 41,
            ),
            label: '직원정보'),
        BottomNavigationBarItem(
          icon: ImageData(
            IconPath.regularCostOn,
            width: 28,
          ),
          label: '고정비용',
        ),
        BottomNavigationBarItem(
            icon: ImageData(
              IconPath.expenseOn,
              width: 30,
            ),
            label: '경비지출'),
        BottomNavigationBarItem(
            icon: ImageData(
              IconPath.devScheduleOn,
              width: 30,
            ),
            label: '개발일정'),
        BottomNavigationBarItem(
            icon: ImageData(
              IconPath.serviceLinkOn,
              width: 30,
            ),
            label: '업무Link'),
        BottomNavigationBarItem(
            icon: Container(
              height: 30,
              width: 30,
              decoration:
                  BoxDecoration(color: Colors.red, shape: BoxShape.circle),
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 1),
                  height: 30,
                  width: 30,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                  child: Text(
                    '메모',
                    style: TextStyle(fontSize: 12, color: Colors.red),
                    textScaler: TextScaler.linear((1)),
                  )),
            ),
            label: '')
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (value) async {
        if (value) {
          return;
        }
        await controller.willPopAction();
      },
      child: Obx(
        () => Scaffold(
          body: PageView(
            controller: controller.pageController,
            onPageChanged: (page) {
              controller.changeBottomNav(page);
            },
            children: [
              //중첩라우팅(하단 BottomNavIcon 보이기 위함)
              Navigator(
                key: controller.employeePageNavigationKey,
                onGenerateRoute: (routeSetting) {
                  return MaterialPageRoute(
                      builder: (context) => EmployeeMain());
                },
              ),
              Navigator(
                key: controller.costPageNavigationKey,
                onGenerateRoute: (routeSetting) {
                  return MaterialPageRoute(builder: (context) => CostMain());
                },
              ),
              Navigator(
                key: controller.expensePageNavigationKey,
                onGenerateRoute: (routeSetting) {
                  return MaterialPageRoute(builder: (context) => ExpenseMain());
                },
              ),
              Navigator(
                key: controller.devScheduleNavigationKey,
                onGenerateRoute: (routeSetting) {
                  return MaterialPageRoute(
                      builder: (context) => DevScheduleMain());
                },
              ),
              Navigator(
                key: controller.serviceLinkNavigationKey,
                onGenerateRoute: (routeSetting) {
                  return MaterialPageRoute(
                      builder: (context) => ServiceLinkMain());
                },
              ),
              Navigator(
                key: controller.memoNavigationKey,
                onGenerateRoute: (routeSetting) {
                  return MaterialPageRoute(builder: (context) => MemoMain());
                },
              )
            ],
          ),
          bottomNavigationBar: _bottomNavBar(context),
        ),
      ),
    );
  }
}
