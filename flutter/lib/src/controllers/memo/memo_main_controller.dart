import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hr2024/src/components/custom_snackbar.dart';
import 'package:hr2024/src/models/memo_model.dart';
import 'package:hr2024/src/repositories/memo_repository.dart';

class MemoMainController extends GetxController {
  static MemoMainController get to => Get.find();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var autoValidateMode = AutovalidateMode.disabled.obs;
  late TextEditingController memoController;
  var isMemoSaveLoading = false.obs;
  var isDataProcessing = false.obs;
  var isMemoSave=false.obs;
  var isModified = false.obs;
  var saveUpdateFlag='save'.obs;
  var memoData = Rx<MemoModel>(MemoModel.initial());
  var content=''.obs;

  @override
  void onInit() {
    super.onInit();
    memoController = TextEditingController();
    getMemo();
  }

  @override
  void dispose() {
    super.dispose();
    memoController.dispose();
  }

  //Memo(전체 1건) 불러오기
  getMemo() async {
    try {
      isDataProcessing(true);

      //Indicator 를 보기위해 0.5초 기다림
      await Future.delayed(Duration(milliseconds: 500));
      MemoRepository.to
          .getMemo()
          .then((resp) {

        memoData.value = resp;
        memoController=TextEditingController(text: memoData.value.content);

        //불러올 때 Content(내용)가 ''이면 최초 저장 처리
        if(memoData.value.content.isEmpty){
          saveUpdateFlag.value='save';
        }else{
          saveUpdateFlag.value='update';
        }
        isDataProcessing(false);
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
  }

  //메모 저장
  Future<String> saveMemo() async {
    var result;

    try {
      isMemoSave.value = true;
      isMemoSaveLoading.value = true;

      result =
      await MemoRepository.to.saveMemo(memoData.value);
      isMemoSave.value = false;
      isMemoSaveLoading.value = false;
    } catch (e) {
      isMemoSave.value = false;
      isMemoSaveLoading.value = false;
      rethrow;
    }
    return result;
  }

  //메모 수정
  Future<String> updateMemo() async {
    var result;

    try {
      isMemoSave.value = true;
      isMemoSaveLoading.value = true;

      await Future.delayed(Duration(seconds: 1));
      result =
      await MemoRepository.to.updateMemo(memoData.value);
      isMemoSaveLoading.value = false;
    } catch (e) {
      isMemoSave.value = false;
      isMemoSaveLoading.value = false;
      rethrow;
    }
    return result;
  }
}