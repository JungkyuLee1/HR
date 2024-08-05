import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr2024/src/controllers/app_controller.dart';
import 'package:hr2024/src/controllers/bottom_nav_controller.dart';
import 'package:hr2024/src/controllers/cost/cost_addedit_controller.dart';
import 'package:hr2024/src/controllers/cost/cost_display_controller.dart';
import 'package:hr2024/src/controllers/cost/cost_dropdown_menu_controller.dart';
import 'package:hr2024/src/controllers/cost/cost_main_controller.dart';
import 'package:hr2024/src/controllers/devSchedule/devSchedule_addedit_controller.dart';
import 'package:hr2024/src/controllers/devSchedule/devSchedule_display_controller.dart';
import 'package:hr2024/src/controllers/devSchedule/devSchedule_main_controller.dart';
import 'package:hr2024/src/controllers/employee/employee_addedit_controller.dart';
import 'package:hr2024/src/controllers/employee/employee_display_controller.dart';
import 'package:hr2024/src/controllers/employee/employee_dropdownmenu_controller.dart';
import 'package:hr2024/src/controllers/employee/employee_chart_controller.dart';
import 'package:hr2024/src/controllers/expense/expense_addedit_controller.dart';
import 'package:hr2024/src/controllers/expense/expense_display_controller.dart';
import 'package:hr2024/src/controllers/expense/expense_main_controller.dart';
import 'package:hr2024/src/controllers/memo/memo_main_controller.dart';
import 'package:hr2024/src/controllers/serviceLink/serviceLink_main_controller.dart';
import 'package:hr2024/src/repositories/cost_repository.dart';
import 'package:hr2024/src/repositories/devSchedule_repository.dart';
import 'package:hr2024/src/repositories/employee_repository.dart';
import 'package:hr2024/src/repositories/expense_repository.dart';
import 'package:hr2024/src/repositories/memo_repository.dart';
import 'package:hr2024/src/repositories/serviceLink_repository.dart';

class InitBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AppController());
    Get.put(BottomNavController(), permanent: true);
  }

  // static hrMasterBinding(){
  //   // Get.put(BottomNavController(), permanent: true);
  //   print('hrmasterbinding');
  //   Get.put(EmployeeMainController());
  // }

  // static appBinding(){
  //   Get.put(AppController());
  // }

  //직원정보
  static employeeRegisterBinding() {
    // Get.lazyPut(() => EmployeeMainController());
    Get.put(EmployeeDisplayController());
    Get.put(EmployeeAddEditController());
    Get.lazyPut(() => EmployeeDropDownMenuController());

    Get.lazyPut(() => EmployeeRepository());
    Get.lazyPut(() => EmployeeChartController());
  }

  //고정비용
  static costRegisterBinding() {
    Get.lazyPut(() => CostMainController());
    Get.lazyPut(() => CostRepository());
    Get.lazyPut(() => CostDropDownMenuController());
    Get.lazyPut(() => CostDisplayController());
    Get.lazyPut(() => CostAddEditController());
  }

  static expenseRegisterBinding() {
    Get.lazyPut(() => ExpenseMainController());
    Get.put(ExpenseRepository());
    Get.lazyPut(() => ExpenseRepository());
    Get.lazyPut(() => ExpenseAddEditController());
    Get.lazyPut(() => ExpenseDisplayController());
  }

  static devScheduleRegisterBinding() {
    Get.lazyPut(() => DevScheduleMainController());
    Get.lazyPut(() => DevScheduleRepository());
    Get.lazyPut(() => DevScheduleDisplayController());
    Get.lazyPut(() => DevScheduleAddEditController());
  }

  static serviceLinkBinding() {
    Get.lazyPut(() => ServiceLinkMainController());
    Get.lazyPut(() => ServiceLinkRepository());
  }

  static memoWritingBinding() {
    Get.lazyPut(() => MemoMainController());
    Get.lazyPut(() => MemoRepository());
  }
}
