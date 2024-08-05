import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr2024/src/components/custom_snackbar.dart';
import 'package:hr2024/src/components/rounded_button_type_one.dart';
import 'package:hr2024/src/controllers/memo/memo_main_controller.dart';
import 'package:hr2024/src/models/memo_model.dart';
import 'package:hr2024/src/pages/serviceLink/webview_open_page.dart';

class MemoMain extends GetView<MemoMainController> {
  const MemoMain({Key? key}) : super(key: key);

  //1.
  Title() {
    return Center(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('* '),
        Text(
          '기억해야 할 내용 적어두기',
          style: TextStyle(fontSize: 16, decoration: TextDecoration.underline),
          textScaler: TextScaler.linear(1),
        ),
      ],
    ));
  }

  //2
  Memo() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: TextField(
        controller: controller.memoController,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(width: 0, color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
                  BorderSide(width: 0, color: Colors.grey.withOpacity(0.3))),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
                  BorderSide(width: 1, color: Colors.grey.withOpacity(0.3))),
        ),
        maxLength: 500,
        maxLines: 15,
        onChanged: (val) {
          if (val.isNotEmpty && val.trim().length > 3) {
            controller.isModified.value = true;
          } else {
            controller.isModified.value = false;
          }
          controller.content.value = val;
        },
      ),
    );
  }

  //3-2
  _assignItemToSave() {
    controller.memoData(MemoModel(
        id: controller.memoData.value.id,
        content: controller.content.value,
        activeYn: 'Y',
        createdAt: controller.saveUpdateFlag.value == 'save'
            ? DateTime.now()
            : controller.memoData.value.createdAt,
        createdBy: controller.saveUpdateFlag.value == 'save'
            ? "creator"
            : controller.memoData.value.createdBy,
        updatedAt:
            controller.saveUpdateFlag.value == 'save' ? null : DateTime.now(),
        updatedBy: controller.saveUpdateFlag.value == 'save' ? "" : "updater"));
  }

  //3-1
  _save() async {
    controller.autoValidateMode.value = AutovalidateMode.always;

    //유효성 check
    final form = controller.formKey.currentState;
    if (form == null || !form.validate()) {
      controller.autoValidateMode.value = AutovalidateMode.disabled;
      return;
    }

    form.save();
    _assignItemToSave();
    var result;

    try {
      //최초 저장&수정 구분
      if (controller.saveUpdateFlag.value == 'save') {
        result = await controller.saveMemo();
      } else {
        result = await controller.updateMemo();
      }

      if (result == 'success') {
        CustomSnackBar.showSuccessSnackBar(title: '성공', message: '저장하였습니다!');

        //저장 버튼 disable 처리
        controller.isModified.value = false;
        controller.isMemoSave.value = false;
      } else {
        CustomSnackBar.showErrorSnackBar(title: '실패', message: '다시 시도하십시오!');
        controller.isMemoSave.value = false;
      }
    } catch (e) {
      CustomSnackBar.showErrorSnackBar(title: '에러', message: e.toString());
      controller.isMemoSave.value = false;
    }
  }

  //3
  Widget SaveButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
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
                        child: !controller.isMemoSaveLoading.value
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

  //0
  GoToSmartContract() {
    return GestureDetector(
      onTap: () async {
        Get.toNamed('/webViewSmartContract',
            arguments:
                'https://bscscan.com/token/0xb208063997db51de3f0988f8a87b0aff83a6213f');
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.cyan),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
          child: Text(
            'Smart Contract',
            textScaler: TextScaler.linear(1),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Obx(
        () => Scaffold(
          appBar: AppBar(
            title: Text('Memo',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textScaler: TextScaler.linear(1)),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 1,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: SingleChildScrollView(
              child: Form(
                key: controller.formKey,
                autovalidateMode: controller.autoValidateMode.value,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Title(),
                    Memo(),
                    SaveButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
