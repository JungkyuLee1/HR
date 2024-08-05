import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr2024/src/bindings/init_binding.dart';
import 'package:hr2024/src/components/message_popup.dart';
import 'package:hr2024/src/controllers/cost/cost_addedit_controller.dart';
import 'package:hr2024/src/controllers/cost/cost_display_controller.dart';
import 'package:hr2024/src/controllers/cost/cost_main_controller.dart';
import 'package:hr2024/src/controllers/devSchedule/devSchedule_addedit_controller.dart';
import 'package:hr2024/src/controllers/devSchedule/devSchedule_display_controller.dart';
import 'package:hr2024/src/controllers/devSchedule/devSchedule_main_controller.dart';
import 'package:hr2024/src/controllers/employee/employee_addedit_controller.dart';
import 'package:hr2024/src/controllers/employee/employee_display_controller.dart';
import 'package:hr2024/src/controllers/employee/employee_main_controller.dart';
import 'package:hr2024/src/controllers/expense/expense_addedit_controller.dart';
import 'package:hr2024/src/controllers/expense/expense_display_controller.dart';
import 'package:hr2024/src/controllers/expense/expense_main_controller.dart';
import 'package:hr2024/src/models/cost_model.dart';
import 'package:hr2024/src/models/dev_schedule_model.dart';
import 'package:hr2024/src/models/expense_model.dart';
import 'package:hr2024/src/pages/DevSchedule/devSchedule_main_page.dart';
import 'package:hr2024/src/pages/cost/cost_main_page.dart';
import 'package:hr2024/src/pages/employee/employee_main_page.dart';
import 'package:hr2024/src/pages/expense/expense_main_page.dart';

import '../models/employee_model.dart';

enum PageName { EMPLOYEE, OPERATION_COST, EXPENSE, DEVSCHEDULE, SERVICELINK, MEMO }

class BottomNavController extends GetxController {
  static BottomNavController get to => Get.find();

  GlobalKey<NavigatorState> employeePageNavigationKey =
      GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> costPageNavigationKey = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> expensePageNavigationKey =
      GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> devScheduleNavigationKey =
      GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> memoNavigationKey = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> serviceLinkNavigationKey = GlobalKey<NavigatorState>();

  PageController pageController =
      PageController(initialPage: 0, keepPage: true);

  RxInt pageIndex = 0.obs;
  List<int> bottomHistory = [0];

  changeBottomNav(int value) {
    var page = PageName.values[value];

    switch (page) {
      case PageName.EMPLOYEE:
      case PageName.OPERATION_COST:
      case PageName.EXPENSE:
      case PageName.DEVSCHEDULE:
      case PageName.SERVICELINK:
      case PageName.MEMO:
        _changePage(value);
        break;
    }
  }

  _changePage(int value) async {
    pageIndex(value);

    //하단 직원정보(index:0) -> 경비지출(index:2)..로 index가 jump할때 Jump(0->1->2->3)할때까지 기다려주어야 함
    await Future.delayed(Duration(milliseconds: 800));
    pageController.animateToPage(pageIndex.value,
        duration: Duration(milliseconds: 800), curve: Curves.easeIn);

    //하단(AAA) '직원정보'를 Click시에만 경우에 따라 '직원조회' 화면을 close(기존 것)->open하기 위함
    //하단(AAA) '직원정보'만 'MENU.DISPLAY'를 가지기 때문
    if (value != 0) {
      EmployeeMainController.to.currentMenu.value = MENUEmployee.DISPLAY;
    }

    //AAA.하단 '직원 등록' Click 시 상단 '직원조회'가 선택 안되었을 경우 만 현재 열린 화면(직원조회) close(초기화) 후 open
    // if (value == 0 && EmployeeMainController.to.currentMenu != MENUEmployee.DISPLAY) {
    if (value == 0 &&
        (EmployeeMainController.to.currentMenu != MENUEmployee.DISPLAY ||
            EmployeeAddEditController.to.addEditFlag.value == 'edit')) {
      openEmployeeMainPage();
    } else if (value == 0) {
      //초기화(1행부터 보임)
      EmployeeDisplayController.to.buckGlobal = PageStorageBucket();
      EmployeeDisplayController.to.getAllEmployee();
    }

    //운영비용 click 시
    if (value == 1 &&
        (CostMainController.to.currentMenu != MENUCost.DISPLAY ||
            CostAddEditController.to.addEditCostFlag.value == 'edit')) {
      openCostMainPage();
    } else if (value == 1) {
      //초기화(1행부터 보임)
      CostDisplayController.to.buckGlobal = PageStorageBucket();
      // openCostMainPage();
      CostDisplayController.to.getAllCost();
    }

    //경비지출
    if (value == 2 &&
        (ExpenseMainController.to.currentMenu != MENUExpense.DISPLAY ||
            ExpenseAddEditController.to.addEditExpenseFlag.value == 'edit')) {
      openExpenseMainPage();
    } else if (value == 2) {
      ExpenseDisplayController.to.getAllByKind('IN');
      ExpenseDisplayController.to.getAllByKind('OUT');
    }

    //개발일정
    if (value == 3 &&
        (DevScheduleMainController.to.currentMenu != MENUDevSchedule.DISPLAY ||
            DevScheduleAddEditController.to.addEditDevScheduleFlag.value ==
                'edit')) {
      openDevScheduleMainPage();
    } else if (value == 3) {
      //초기화(1행부터 보임)
      DevScheduleDisplayController.to.buckGlobal = PageStorageBucket();
      DevScheduleDisplayController.to.getAllByTitleAndStatus('allData');
    }

    if (bottomHistory.last != value) {
      bottomHistory.add(value);
    }
  }

  //직원정보(하단 아이콘) 클릭 시 '직원조회' 화면 open목적
  openEmployeeMainPage() async {
    //매우중요(conTxt를 EmployeeMainPage에서 가져오는 시간 동안 기다림)
    await Future.delayed(Duration(milliseconds: 500));

    //중첩 Routing
    Navigator.pushAndRemoveUntil(
        EmployeeMainController.to.conTxt,
        MaterialPageRoute(builder: (context) => EmployeeMain()),
        (route) => false);

    //느림 (화면 전환 시 등록화면이 (오랜시간) 보이는 단점 있음)
    // Future.delayed(Duration(milliseconds: 500)).then((value) =>
    //     Navigator.pushAndRemoveUntil(
    //         EmployeeMainController.to.conTxt,
    //         MaterialPageRoute(builder: (context) => EmployeeMain()),
    //         (route) => false));

    InitBinding.employeeRegisterBinding();

    //입력->저장 후 조회화면 refresh 목적
    EmployeeDisplayController.to.getAllEmployee();

    EmployeeMainController.to.changeMenu(MENUEmployee.DISPLAY);
    EmployeeAddEditController.to.initializeFieldsAfterSave();
    EmployeeAddEditController.to.addEditFlag.value = 'add';
    EmployeeAddEditController.to.isModified.value = false;
    EmployeeAddEditController.to.autoValidateMode.value =
        AutovalidateMode.disabled;
  }

  //운영비용(하단 아이콘) 클릭 시 '비용조회' 화면 open목적
  openCostMainPage() async {
    //매우중요(conTxt를 CostMainPage에서 가져오는 시간 동안 기다림)
    await Future.delayed(Duration(milliseconds: 500));

    //중첩 Routing
    Navigator.pushAndRemoveUntil(CostMainController.to.conTxt,
        MaterialPageRoute(builder: (context) => CostMain()), (route) => false);
    InitBinding.costRegisterBinding();

    //입력->저장 후 조회화면 refresh 목적
    CostDisplayController.to.getAllCost();
    CostMainController.to.changeMenu(MENUCost.DISPLAY);
    CostAddEditController.to.initializeFieldsAfterSave();
    CostAddEditController.to.addEditCostFlag.value = 'add';
    CostAddEditController.to.isModified.value = false;
    CostAddEditController.to.autoValidateMode.value = AutovalidateMode.disabled;
  }

  //경비지출(하단 아이콘) 클릭 시 '입출조회' 화면 open 목적
  openExpenseMainPage() async {
    //매우중요(conTxt를 ExpenseMainPage에서 가져오는 시간 동안 기다림)
    await Future.delayed(Duration(milliseconds: 500));

    //중첩 Routing
    Navigator.pushAndRemoveUntil(
        ExpenseMainController.to.conTxt,
        MaterialPageRoute(builder: (context) => ExpenseMain()),
        (route) => false);

    InitBinding.expenseRegisterBinding();
    //입력->저장 후 조회화면 refresh 목적
    // ExpenseDisplayController.to.getAllByKind('IN & OUT');
    ExpenseDisplayController.to.getAllByKind('IN');
    ExpenseDisplayController.to.getAllByKind('OUT');

    ExpenseMainController.to.changeMenu(MENUExpense.DISPLAY);
    ExpenseAddEditController.to.initializeFieldsAfterSave();
    ExpenseAddEditController.to.addEditExpenseFlag.value = 'add';
    ExpenseAddEditController.to.isModified.value = false;
    ExpenseAddEditController.to.autoValidateMode.value =
        AutovalidateMode.disabled;
  }

  //개발일정(하단 아이콘) 클릭 시 '일정조회' 화면 open 목적
  openDevScheduleMainPage() async {
    //매우중요(conTxt를 DevScheduleMainPage 에서 가져오는 시간 동안 기다림)
    await Future.delayed(Duration(milliseconds: 500));

    //중첩 Routing
    Navigator.pushAndRemoveUntil(
        DevScheduleMainController.to.conTxt,
        MaterialPageRoute(builder: (context) => DevScheduleMain()),
        (route) => false);
    InitBinding.devScheduleRegisterBinding();

    //입력->저장 후 조회화면 refresh 목적
    DevScheduleDisplayController.to.getAllByTitleAndStatus('allData');
    DevScheduleMainController.to.changeMenu(MENUDevSchedule.DISPLAY);
    DevScheduleAddEditController.to.initializeFieldsAfterSave();
    DevScheduleAddEditController.to.addEditDevScheduleFlag.value = 'add';
    DevScheduleAddEditController.to.isModified.value = false;
    DevScheduleAddEditController.to.autoValidateMode.value =
        AutovalidateMode.disabled;
  }

  Future<bool> willPopAction() async {
    // if (bottomHistory.length == 1) {
      Get.dialog(MessagePopUp(
        '확인',
        'Do you want to exit ?',
        okCallback: () {
          // Get.deleteAll();
          exit(0);
        },
        cancelCallback: () {
          Get.back();
        },
      ));
      return true;
    // } else {
    //   bottomHistory.removeLast();
    //   var index = bottomHistory.last;
    //   // changeBottomNav(index);
    //   return false;
    // }
  }
}
