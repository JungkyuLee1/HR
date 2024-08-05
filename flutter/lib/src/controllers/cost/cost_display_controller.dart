import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hr2024/src/components/custom_snackbar.dart';
import 'package:hr2024/src/models/cost_model.dart';
import 'package:hr2024/src/repositories/cost_repository.dart';

class CostDisplayController extends GetxController {
  static CostDisplayController get to => Get.find();

  PageStorageBucket buckGlobal = PageStorageBucket();
  var cost = Rx<CostModel>(CostModel.initial());
  var lstOperationCost = Rx<List<CostModel>>([]);
  var isCostQueryLoading = true.obs;
  var isDataProcessing = false.obs;

  @override
  void onInit() {
    super.onInit();
    getAllCost();
  }

  //운영비용 전체조회
  Future<void> getAllCost() async {
    try {
      isDataProcessing(true);

      //CircularProgressIndicator 1초간 보여주기 위함
      await Future.delayed(Duration(milliseconds: 500));
      CostRepository.to.getAllCost().then((resp) {
        isDataProcessing(false);
        lstOperationCost.value.clear();
        lstOperationCost.value.addAll(resp);
      }, onError: (err) {
        isDataProcessing(false);
        CustomSnackBar.showErrorSnackBar(title: '에러', message: 'Internet 접속이 불완전 합니다.\n다시 시도하여 주십시오');
        // CustomSnackBar.showErrorSnackBar(title: '에러', message: err.toString());

      });
    } catch (e) {
      isDataProcessing(false);
      CustomSnackBar.showErrorSnackBar(title: '예외', message: '서비스가 원할하지 않습니다.\n다시 시도하여 주십시오');
      // CustomSnackBar.showErrorSnackBar(title: '예외', message: e.toString());
    }

    // //매우 중요(Data 가져올때까지 기다림 (FutureBuilder : 모든 Data Call 할때까지 기다렸다가 한꺼번에 뿌림)
    // await Future.delayed(Duration(seconds: 2));
    // return lstOperationCost.value;
  }

//운영비용 건별 조회
  void getOperationCostById(String id) {
    try {
      isCostQueryLoading.value = true;
      CostRepository.to.getCostById(id).then((resp) {
        cost.value = resp;
        isCostQueryLoading.value = false;
      }, onError: (err) {
        CustomSnackBar.showErrorSnackBar(title: '에러', message: 'Internet 접속이 불완전 합니다.\n다시 시도하여 주십시오');
        // CustomSnackBar.showErrorSnackBar(title: '에러', message: err.toString());
        isCostQueryLoading.value = false;
      });
    } catch (e) {
      // isDataProcessing(false);
      isCostQueryLoading.value = false;
      CustomSnackBar.showErrorSnackBar(title: '예외', message: '서비스가 원할하지 않습니다.\n다시 시도하여 주십시오');
      // CustomSnackBar.showErrorSnackBar(title: '예외', message: e.toString());
    }
  }
}
