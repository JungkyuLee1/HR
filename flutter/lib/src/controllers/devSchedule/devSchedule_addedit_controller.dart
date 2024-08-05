import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr2024/src/controllers/app_controller.dart';
import 'package:hr2024/src/models/code_model.dart';
import 'package:hr2024/src/models/dev_schedule_model.dart';
import 'package:hr2024/src/repositories/devSchedule_repository.dart';

class DevScheduleAddEditController extends GetxController {
  static DevScheduleAddEditController get to => Get.find();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var autoValidateMode = AutovalidateMode.disabled.obs;

  late TextEditingController titleController;
  late TextEditingController detailController;

  var addEditDevScheduleFlag = 'add'.obs;
  var devSchedule = Rx<DevScheduleModel>(DevScheduleModel.initial());

  //Field 수정이 되어야만 저장 버튼 on처리
  var isModified = false.obs;

  //저장 버튼 클릭 후 처리중에는 CircularProgressIndicator()로 보여주기 위한 flag
  var isDevPeriodSaveLoading = false.obs;

  // var isDevScheduleSave = false.obs;
  var isDevScheduleSaveLoading = false.obs;
  var title = ''.obs;
  var detail = ''.obs;

  var selectedNationName = ''.obs;
  var codeList = <CodeModel>[];
  var nations = Rx<List<CodeModel>>([]);
  var lstNationDropDownMenuItem = Rx<List<DropdownMenuItem<String>>>([]);
  var progresses = Rx<List<CodeModel>>([]);
  var devPeriods = Rx<List<CodeModel>>([]);

  var selectedCompleteStatus = 'onGoing'.obs;
  String selectedCompleteStatusValue = '진행 중';

  var selectedDevPeriodStatus = 'urgent'.obs;
  String selectedDevPeriodStatusValue = '매우 시급';

  var isProgressProcessing = false.obs;
  var isDevPeriodProcessing = false.obs;

  @override
  void onInit() {
    super.onInit();

    titleController = TextEditingController();
    detailController = TextEditingController();
    getEmpCodes();
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    detailController.dispose();
  }

  //code 조회(개발일정)
  void getEmpCodes() {
    try {
      DevScheduleRepository.to.getDevCodes().then((resp) {
        codeList = resp;

        getNationDropDownData();
        getProgressCode();
        getDevPeriodCode();
      });
    } catch (e) {
      rethrow;
    }
  }

  //대상국가 선택
  void getNationDropDownData() {
    try {
      if (codeList.length > 0) {
        nations.value.clear();
        selectedNationName.value = 'ALL';

        nations.value.addAll(codeList
            .where((nation) => nation.type.contains('NATION'))
            .toList());

        lstNationDropDownMenuItem.value = [];

        for (CodeModel nation in nations.value) {
          lstNationDropDownMenuItem.value.add(DropdownMenuItem(
            child: Text(
              nation.name,
              style: TextStyle(
                  fontSize: 14,
                  color: AppController.to.isAdmin.value
                      ? Colors.black
                      : Colors.black),
              textScaler: TextScaler.linear(1),
            ),
            value: nation.name.toString(),
          ));
        }
      }
    } catch (e) {
      Get.back();
    }
  }

  //Progress code(완료, 진행 중)
  void getProgressCode() async {
    try {
      if (codeList.length > 0) {
        progresses.value.clear();
        isProgressProcessing.value = true;

        progresses.value.addAll(codeList
            .where((progress) => progress.type.contains('PROGRESS'))
            .toList());

        isProgressProcessing.value = false;
      }
    } catch (e) {
      isProgressProcessing.value = false;
      Get.back();
    }
  }

//DevPeriod code(매우시급,4주내,다음버전)
  void getDevPeriodCode() async {
    try {
      if (codeList.length > 0) {
        devPeriods.value.clear();
        isDevPeriodProcessing.value = true;

        devPeriods.value.addAll(codeList
            .where((period) => period.type.contains('DEVPERIOD'))
            .toList());

        isDevPeriodProcessing.value = false;
      }
    } catch (e) {
      isDevPeriodProcessing.value = false;
      Get.back();
    }
  }

  //Radio button(완료 여부) 선택 반영
  void changeCompleteStatusRadio(value) {
    if (value == 'completed') {
      selectedCompleteStatus.value = 'completed';
      selectedCompleteStatusValue = '완료';
    } else {
      selectedCompleteStatus.value = 'onGoing';
      selectedCompleteStatusValue = '진행 중';
    }
  }

  //Radio button(개발기간) 선택 반영
  void changePeriodStatusRadio(value) {
    if (value == 'urgent') {
      selectedDevPeriodStatus.value = 'urgent';
      selectedDevPeriodStatusValue = '매우 시급';
    } else if (value == 'four') {
      selectedDevPeriodStatus.value = 'four';
      selectedDevPeriodStatusValue = '4주 내';
    } else {
      selectedDevPeriodStatus.value = 'next';
      selectedDevPeriodStatusValue = '다음 버전';
    }
  }

  //개발일정 저장
  Future<String> saveDevSchedule() async {
    var result;

    try {
      // isDevScheduleSave.value = true;
      isDevScheduleSaveLoading.value = true;

      result =
          await DevScheduleRepository.to.saveDevSchedule(devSchedule.value);
      // isDevScheduleSave.value = false;
      isDevScheduleSaveLoading.value = false;
    } catch (e) {
      // isDevScheduleSave.value = false;
      isDevScheduleSaveLoading.value = false;
      rethrow;
    }
    return result;
  }

  //개발일정 수정
  Future<String> updateDevSchedule() async {
    var result;

    try {
      // isDevScheduleSave.value = true;
      isDevScheduleSaveLoading.value = true;

      await Future.delayed(Duration(seconds: 1));
      result =
          await DevScheduleRepository.to.updateDevSchedule(devSchedule.value);
      isDevScheduleSaveLoading.value = false;
    } catch (e) {
      // isDevScheduleSave.value = false;
      isDevScheduleSaveLoading.value = false;
      rethrow;
    }
    return result;
  }

  //개발일정 삭제
  Future<String> deleteDevScheduleById(String id) async {
    var result;

    try {
      // isDevScheduleSave.value = true;
      isDevScheduleSaveLoading.value = true;

      // await Future.delayed(Duration(seconds: 1));
      result = await DevScheduleRepository.to.deleteDevScheduleById(id);
      isDevScheduleSaveLoading.value = false;
    } catch (e) {
      // isDevScheduleSave.value = false;
      isDevScheduleSaveLoading.value = false;
      rethrow;
    }
    return result;
  }

  //저장 후 변수 초기화
  initializeFieldsAfterSave() {
    titleController = TextEditingController();
    detailController = TextEditingController();
    selectedNationName.value = 'ALL';
    selectedCompleteStatus.value = 'onGoing';
    selectedDevPeriodStatus.value = 'urgent';
  }

  //해당 운영비용 조회 시 비용정보 세팅(Edit 경우)
  setDevScheduleDataForEdit() {
    titleController = TextEditingController(text: devSchedule.value.title);
    detailController = TextEditingController(text: devSchedule.value.detail);
    selectedNationName.value = devSchedule.value.nation;
    selectedCompleteStatus.value =
        devSchedule.value.completeStatus == '진행 중' ? 'onGoing' : 'completed';
    selectedDevPeriodStatus.value = devSchedule.value.devPeriodKind == '매우 시급'
        ? 'urgent'
        : devSchedule.value.devPeriodKind == '4주 내'
            ? 'four'
            : 'next';
  }
}
