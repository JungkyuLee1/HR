import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr2024/src/components/custom_snackbar.dart';
import 'package:hr2024/src/components/message_popup.dart';
import 'package:hr2024/src/components/rounded_button_type_one.dart';
import 'package:hr2024/src/components/widgets/devSchedule_input_textform.dart';
import 'package:hr2024/src/components/widgets/menu_divider.dart';
import 'package:hr2024/src/controllers/app_controller.dart';
import 'package:hr2024/src/controllers/bottom_nav_controller.dart';
import 'package:hr2024/src/controllers/devSchedule/devSchedule_addedit_controller.dart';
import 'package:hr2024/src/models/dev_schedule_model.dart';

class DevScheduleAddEdit extends GetView<DevScheduleAddEditController> {
  const DevScheduleAddEdit({Key? key}) : super(key: key);

  //1
  Widget HeaderForEdit() {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
              onPressed: () {
                //Back 아이콘 클릭 시 '개발일정(하단 아이콘)'->'일정조회' 화면 open
                BottomNavController.to.openDevScheduleMainPage();
              },
              icon: Icon(
                Icons.arrow_back_ios,
                size: 22,
              )),
          Expanded(
            child: Text(
              '항목 정보',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
              textScaler: TextScaler.linear(1),
            ),
          ),
          controller.addEditDevScheduleFlag.value == 'add'
              ? Spacer(flex: 1)
              : IconButton(
                  onPressed: !AppController.to.isAdmin.value
                      ? null
                      : () async {
                          Get.dialog(MessagePopUp('삭제', '삭제하시겠습니까?',
                              okCallback: () async {
                            final result =
                                await controller.deleteDevScheduleById(
                                    controller.devSchedule.value.id.toString());
                            Get.back();

                            if (result == 'deleted') {
                              CustomSnackBar.showSuccessSnackBar(
                                  title: '성공', message: '삭제 완료!');

                              // controller.isDevScheduleSave.value = false;
                              //저장 후 '개발일정(하단 아이콘)'->'일정조회' 화면 open
                              BottomNavController.to.openDevScheduleMainPage();
                            } else {
                              CustomSnackBar.showErrorSnackBar(
                                  title: '실패', message: '다시 시도하십시오!');
                              //저장 버튼 diable
                              controller.isModified.value = false;
                              // controller.isDevScheduleSave.value = false;
                            }
                          }, cancelCallback: Get.back));
                        },
                  icon: Icon(Icons.delete_forever))
        ],
      ),
    );
  }

  //2.
  //1.Title
  Widget Title() {
    return Padding(
      padding: const EdgeInsets.only(top: 13, bottom: 6),
      child: Center(
          child: Text(
        '개발일정 등록',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        textScaler: TextScaler.linear(1),
      )),
    );
  }

  //3.
  DevSchedulePart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            // width: Get.width*0.9,
            child: DevScheduleInputTextForm(
                controller.titleController, '제목', '제목을 입력하세요', 'title',
                icon: null)),
        Container(
            // width: Get.width*0.9,
            child: DevScheduleInputTextForm(
                controller.detailController, '상세 설명', '상세 설명을 입력하세요', 'detail',
                icon: null)),
        Container(
          width: Get.width * 0.4,
          height: Get.width * 0.1,
          child: Obx(
            () => DropdownButtonFormField(
              isDense: true,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (val) {},
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular((8)),
                    borderSide: BorderSide(width: 0, style: BorderStyle.none),
                  )),
              items: controller.lstNationDropDownMenuItem.value,
              value: controller.selectedNationName.value,
              onChanged: !AppController.to.isAdmin.value
                  ? null
                  : (selectedValue) {
                      controller.selectedNationName.value =
                          selectedValue.toString();
                      //저장 버튼 on
                      controller.isModified.value = true;
                    },
            ),
          ),
        ),
      ],
    );
  }

  //4-1.
  CompleteStatus() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          '*완료 여부',
          textScaler: TextScaler.linear(1),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Radio(
                value: 'onGoing',
                groupValue: controller.selectedCompleteStatus.value,
                onChanged: !AppController.to.isAdmin.value
                    ? null
                    : (val) {
                        controller.changeCompleteStatusRadio(val);
                        //저장 버튼 on
                        controller.isModified.value = true;
                      }),
            controller.isProgressProcessing.value
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Text(
                    '${controller.progresses.value.length > 0 ? controller.progresses.value[0].name : null}',
                    textScaler: TextScaler.linear(1),
                  ),
            SizedBox(
              width: 20,
            ),
            Radio(
                value: 'completed',
                groupValue: controller.selectedCompleteStatus.value,
                onChanged: !AppController.to.isAdmin.value
                    ? null
                    : (val) {
                        controller.changeCompleteStatusRadio(val);
                        controller.isModified.value = true;
                      }),
            controller.isProgressProcessing.value
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Text(
                    '${controller.progresses.value.length > 0 ? controller.progresses.value[1].name : null}',
                    textScaler: TextScaler.linear(1),
                  )
          ],
        ),
      ],
    );
  }

  //4-2
  DevPeriodStatus() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          '*개발 기간',
          textScaler: TextScaler.linear(1),
        ),
        Row(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Radio(
                value: 'urgent',
                groupValue: controller.selectedDevPeriodStatus.value,
                onChanged: !AppController.to.isAdmin.value
                    ? null
                    : (val) {
                        controller.changePeriodStatusRadio(val);
                        controller.isModified.value = true;
                      }),
            controller.isDevPeriodProcessing.value
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Text(
                    '${controller.devPeriods.value.length > 0 ? controller.devPeriods.value[0].name : null}',
                    textScaler: TextScaler.linear(1),
                  ),
            SizedBox(
              width: 7,
            ),
            Radio(
                value: 'four',
                groupValue: controller.selectedDevPeriodStatus.value,
                onChanged: !AppController.to.isAdmin.value
                    ? null
                    : (val) {
                        controller.changePeriodStatusRadio(val);
                        controller.isModified.value = true;
                      }),
            controller.isDevPeriodProcessing.value
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Text(
                    '${controller.devPeriods.value.length > 0 ? controller.devPeriods.value[1].name : null}',
                    textScaler: TextScaler.linear(1),
                  ),
            SizedBox(
              width: 7,
            ),
            Radio(
                value: 'next',
                groupValue: controller.selectedDevPeriodStatus.value,
                onChanged: !AppController.to.isAdmin.value
                    ? null
                    : (val) {
                        controller.changePeriodStatusRadio(val);
                        controller.isModified.value = true;
                      }),
            controller.isDevPeriodProcessing.value
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Text(
                    '${controller.devPeriods.value.length > 0 ? controller.devPeriods.value[2].name : null}',
                    textScaler: TextScaler.linear(1),
                  )
          ],
        ),
      ],
    );
  }

  //4.RadioButtonPart
  RadioButtonPart() {
    return Column(
      children: [
        CompleteStatus(),
        SizedBox(
          height: 5,
        ),
        DevPeriodStatus(),
      ],
    );
  }

  //5-1-1 저장 전 model로 전환
  _assignItemToSave() {
    controller.devSchedule(DevScheduleModel(
        id: controller.devSchedule.value.id,
        title: controller.title.value,
        detail: controller.detail.value,
        nation: controller.selectedNationName.value,
        completeStatus: controller.selectedCompleteStatusValue,
        devPeriodKind: controller.selectedDevPeriodStatusValue,
        activeYn: 'Y',
        createdAt: controller.addEditDevScheduleFlag.value == 'add'
            ? DateTime.now()
            : controller.devSchedule.value.createdAt,
        createdBy: controller.addEditDevScheduleFlag.value == 'add'
            ? "creator"
            : controller.devSchedule.value.createdBy,
        updatedAt: controller.addEditDevScheduleFlag.value == 'add'
            ? null
            : DateTime.now(),
        updatedBy:
            controller.addEditDevScheduleFlag.value == 'add' ? "" : "updater"));
  }

  //5-1.
  _save() async {
    controller.autoValidateMode.value = AutovalidateMode.always;
    // //유효성 check
    final form = controller.formKey.currentState;
    if (form == null || !form.validate()) {
      controller.autoValidateMode.value = AutovalidateMode.disabled;
      return;
    }

    form.save();
    _assignItemToSave();
    var result;

    try {
      if (controller.addEditDevScheduleFlag.value == 'add') {
        result = await controller.saveDevSchedule();
      } else {
        result = await controller.updateDevSchedule();
      }

      if (result == 'success') {
        CustomSnackBar.showSuccessSnackBar(
            title: '성공',
            message: controller.addEditDevScheduleFlag.value == 'add'
                ? '저장 완료!'
                : '수정 완료!');

        //저장 버튼 disable 처리
        controller.isModified.value = false;
        //저장 후 '운영비용(하단 아이콘)'->'비용조회' 화면 open

        BottomNavController.to.openDevScheduleMainPage();
      } else {
        CustomSnackBar.showErrorSnackBar(title: '실패', message: '다시 시도하십시오!');
        // controller.isDevScheduleSave.value = false;
      }
    } catch (e) {
      CustomSnackBar.showErrorSnackBar(title: '에러', message: e.toString());
      // controller.isDevScheduleSave.value = false;
    }
  }

  //5.
  Widget SaveButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Container(
        child: Stack(
          children: [
            RoundedButtonTypeOne(
              width: Get.width,
              onTap: controller.isModified.value ? _save : () {},
              buttonText: '저장',
              icon: null,
              isModified: controller.isModified.value,
            ),
            Positioned(
                height: 25,
                right: 0,
                left: 0,
                bottom: 8,
                child: Center(
                    child: Container(
                        height: 30,
                        width: 30,
                        child: !controller.isDevScheduleSaveLoading.value
                            ? Container()
                            : Center(
                                child: CircularProgressIndicator(
                                color: Colors.white,
                              ))))),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Obx(
          () => Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      controller.addEditDevScheduleFlag.value == 'edit'
                          ? SizedBox(height: 19)
                          : Container(),
                      controller.addEditDevScheduleFlag.value == 'edit'
                          ? HeaderForEdit()
                          : Container(),
                      controller.addEditDevScheduleFlag.value == 'edit'
                          ? SizedBox(height: 19)
                          : Container(),
                      controller.addEditDevScheduleFlag.value == 'edit'
                          ? MenuDivider(width: Get.width)
                          : Container(),
                      Title(),
                      MenuDivider(width: Get.width * 0.29),
                      SizedBox(
                        height: 20,
                      ),
                      DevSchedulePart(),
                      SizedBox(
                        height: 13,
                      ),
                      RadioButtonPart(),
                      SaveButton(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
