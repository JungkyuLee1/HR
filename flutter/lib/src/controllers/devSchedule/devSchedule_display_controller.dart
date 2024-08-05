import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:hr2024/src/components/custom_snackbar.dart';
import 'package:hr2024/src/models/dev_schedule_model.dart';
import 'package:get/get.dart';
import 'package:hr2024/src/repositories/devSchedule_repository.dart';

class DevScheduleDisplayController extends GetxController {
  static DevScheduleDisplayController get to => Get.find();

  PageStorageBucket buckGlobal = PageStorageBucket();
  var devSchedule = Rx<DevScheduleModel>(DevScheduleModel.initial());
  var lstDevSchedule = Rx<List<DevScheduleModel>>([]);

  // var isDevScheduleQueryLoading = false.obs;
  var isDataProcessing = false.obs;
  var currentStatusFlag = StatusFlag.ALL.obs;
  var searchStatus = 'allStatus'.obs;
  var searchTerm = ''.obs;
  var onGoingDevSchedules = Rx<List<DevScheduleModel>>([]);
  var onGoingItemCount = 0.obs;
  TextEditingController searchTermController = TextEditingController();
  Timer? _denounce;

  @override
  void onInit() {
    super.onInit();
    getAllByTitleAndStatus('allData');
  }

  @override
  void dispose() {
    super.dispose();
    searchTermController.dispose();
    _denounce?.cancel();
  }

  //진행상태 변경
  changeStatusFlag(StatusFlag status) {
    currentStatusFlag.value = status;
  }

  //검색을 위한 status 로 변경
  changeStatusToSearchStatus() {
    if (currentStatusFlag.value == StatusFlag.ALL) {
      searchStatus.value = 'allStatus';
    } else if (currentStatusFlag.value == StatusFlag.ONGOING) {
      searchStatus.value = '진행 중';
    } else if (currentStatusFlag.value == StatusFlag.FINISH) {
      searchStatus.value = '완료';
    }
  }

  //1-1.전체 조회(검색 조건)
  onSearchChanged(String? newSearchTerm) {
    if (_denounce?.isActive ?? false) _denounce?.cancel();

    _denounce = Timer(Duration(milliseconds: 500), () {
      if (newSearchTerm != null || newSearchTerm!.trim().isNotEmpty) {
        searchTerm.value = newSearchTerm.trim();

        if (newSearchTerm.isEmpty) {
          searchTerm.value = 'allData';
        }

        getAllByTitleAndStatus(searchTerm.value);
      }
    });
  }

  //1.전체 조회(검색 조건)
  getAllByTitleAndStatus(String title) async {
    try {
      isDataProcessing(true);
      //검색을 위한 status 로 변경
      changeStatusToSearchStatus();

      //Indicator 를 보기위해 0.5초 기다림
      await Future.delayed(Duration(milliseconds: 500));
      DevScheduleRepository.to
          .getAllByTitleAndStatus(title, searchStatus.value)
          .then((resp) {
        lstDevSchedule.value.clear();
        lstDevSchedule.value.addAll(resp);

        isDataProcessing(false);

        //'진행 중'인 항목 개수 가져오기
        if (currentStatusFlag.value == StatusFlag.ALL &&
            searchTerm.value.isEmpty) {
          onGoingDevSchedules.value.clear();
          onGoingDevSchedules.value.addAll(lstDevSchedule.value
              .where((dev) => dev.completeStatus.contains('진행 중'))
              .toList());

          onGoingItemCount.value = onGoingDevSchedules.value.length;
        }
      }, onError: (err) {
        isDataProcessing(false);
        CustomSnackBar.showErrorSnackBar(
            title: '에러', message: 'Internet 접속이 불완전 합니다.\n다시 시도하여 주십시오');
        // CustomSnackBar.showErrorSnackBar(title: '에러', message: err.toString());
      });
    } catch (e) {
      isDataProcessing(false);
      CustomSnackBar.showErrorSnackBar(
          title: '예외', message: '서비스가 원할하지 않습니다.\n다시 시도하여 주십시오');
      // CustomSnackBar.showErrorSnackBar(title: '예외', message: e.toString());
    }
  }
}
