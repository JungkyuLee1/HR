import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr2024/src/controllers/app_controller.dart';
import 'package:hr2024/src/models/code_model.dart';
import 'package:hr2024/src/repositories/cost_repository.dart';

class CostDropDownMenuController extends GetxController {
  static CostDropDownMenuController get to => Get.find();

  var selectedServiceKind = ''.obs;
  var selectedPaymentInterval = ''.obs;
  var selectedRenewMethod = ''.obs;
  var selectedPaymentUnit = ''.obs;

  var codeList = <CodeModel>[];

  var serviceKinds = Rx<List<CodeModel>>([]);
  var paymentIntervals = Rx<List<CodeModel>>([]);
  var renewMethods = Rx<List<CodeModel>>([]);
  var paymentUnits = Rx<List<CodeModel>>([]);

  var lstServiceKindsDropDownMenuItem = Rx<List<DropdownMenuItem<String>>>([]);
  var lstPaymentIntervalsDropDownMenuItem =
      Rx<List<DropdownMenuItem<String>>>([]);
  var lstRenewMethodsDropDownMenuItem = Rx<List<DropdownMenuItem<String>>>([]);
  var lstPaymentUnitsDropDownMenuItem = Rx<List<DropdownMenuItem<String>>>([]);

  @override
  void onInit() {
    super.onInit();
    getCostCodes();
  }

  @override
  void onReady() {
    super.onReady();
    getCostCodes();
  }

  @override
  void dispose() {
    super.dispose();
  }

  //code 조회(공통비용)
  void getCostCodes() {
    try {
      CostRepository.to.getCostCodes().then((resp) {
        codeList = resp;

        getServiceKindsDropDownData();
        getPaymentIntervalsDropDownData();
        getRenewMethodsDropDownData();
        getPaymentUnitsDropDownData();
      });
    } catch (e) {
      rethrow;
    }
  }

  //Service 종류 선택
  void getServiceKindsDropDownData() {
    try {
      if (codeList.length > 0) {
        serviceKinds.value.clear();
        selectedServiceKind.value = 'CLOUD';

        serviceKinds.value.addAll(codeList
            .where((kind) => kind.type.contains('SERVICE KIND'))
            .toList());

        lstServiceKindsDropDownMenuItem.value = [];
        for (CodeModel serviceKind in serviceKinds.value) {
          lstServiceKindsDropDownMenuItem.value.add(DropdownMenuItem(
            child: Text(
              serviceKind.name,
              style: TextStyle(
                  fontSize: 14,
                  color: AppController.to.isAdmin.value
                      ? Colors.black
                      : Colors.black),
              textScaler: TextScaler.linear(1),
            ),
            value: serviceKind.name.toString(),
          ));
        }
        // print('lst: ${lstServiceKindsDropDownMenuItem.value.length}');
      }
    } catch (e) {
      Get.back();
    }
  }

  //지급 주기 선택(월별,년별,일시불)
  void getPaymentIntervalsDropDownData() {
    try {
      if (codeList.length > 0) {
        paymentIntervals.value.clear();
        selectedPaymentInterval.value = 'MONTHLY';

        paymentIntervals.value.addAll(codeList
            .where((interval) => interval.type.contains('PAYMENT INTERVAL'))
            .toList());

        lstPaymentIntervalsDropDownMenuItem.value = [];

        for (CodeModel paymentInterval in paymentIntervals.value) {
          lstPaymentIntervalsDropDownMenuItem.value.add(DropdownMenuItem(
            child: Text(
              paymentInterval.name,
              style: TextStyle(
                  fontSize: 14,
                  color: AppController.to.isAdmin.value
                      ? Colors.black
                      : Colors.black),
              textScaler: TextScaler.linear(1),
            ),
            value: paymentInterval.name.toString(),
          ));
        }
      }
    } catch (e) {
      Get.back();
    }
  }

  //갱신 주기 선택(자동,수동)
  void getRenewMethodsDropDownData() {
    try {
      if (codeList.length > 0) {
        renewMethods.value.clear();
        selectedRenewMethod.value = 'AUTO';

        renewMethods.value.addAll(codeList
            .where((method) => method.type.contains('RENEW METHOD'))
            .toList());

        lstRenewMethodsDropDownMenuItem.value = [];

        for (CodeModel renewMethod in renewMethods.value) {
          lstRenewMethodsDropDownMenuItem.value.add(DropdownMenuItem(
            child: Text(
              renewMethod.name,
              style: TextStyle(
                  fontSize: 14,
                  color: AppController.to.isAdmin.value
                      ? Colors.black
                      : Colors.black),
              textScaler: TextScaler.linear(1),
            ),
            value: renewMethod.name.toString(),
          ));
        }
      }
    } catch (e) {
      Get.back();
    }
  }

  //지급 단위(currency) 선택
  void getPaymentUnitsDropDownData() {
    try {
      if (codeList.length > 0) {
        paymentUnits.value.clear();
        selectedPaymentUnit.value = 'USD';

        paymentUnits.value.addAll(codeList
            .where((unit) => unit.type.contains('PAYMENT UNIT'))
            .toList());

        lstPaymentUnitsDropDownMenuItem.value = [];

        for (CodeModel paymentUnit in paymentUnits.value) {
          lstPaymentUnitsDropDownMenuItem.value.add(DropdownMenuItem(
            child: Text(
              paymentUnit.name,
              style: TextStyle(
                  fontSize: 14,
                  color: AppController.to.isAdmin.value
                      ? Colors.black
                      : Colors.black),
              textScaler: TextScaler.linear(1),
            ),
            value: paymentUnit.name.toString(),
          ));
        }
      }
    } catch (e) {
      Get.back();
    }
  }

  String? validateServiceKind(String value) {
    if (value == '0' || value == '종류') {
      return "종류을 선택하세요";
    }
  }
}
