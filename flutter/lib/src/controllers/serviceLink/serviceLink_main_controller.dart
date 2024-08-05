import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hr2024/src/bindings/init_binding.dart';
import 'package:hr2024/src/components/custom_snackbar.dart';
import 'package:hr2024/src/models/service_link_model.dart';
import 'package:hr2024/src/repositories/serviceLink_repository.dart';

class ServiceLinkMainController extends GetxController {
  var text = ''.obs;
  var isMemoSaveLoading = false.obs;
  var isDataProcessing = false.obs;
  var serviceLinkData = Rx<ServiceLinkModel>(ServiceLinkModel.initial());
  var lstServiceLinkData = Rx<List<ServiceLinkModel>>([]);

  var smartContractUrl=''.obs;
  var hrCreditUrl=''.obs;
  var sellonCMSUrl=''.obs;
  var sellonWalletCMSUrl=''.obs;
  var babyBoomCMSUrl=''.obs;

  var sellonCMSId=''.obs;
  var sellonCMSPwd=''.obs;
  var sellonWalletCMSId=''.obs;
  var sellonWalletCMSPwd=''.obs;
  var babyBoomCMSId=''.obs;
  var babyBoomCMSPwd=''.obs;

  @override
  void onInit() {
    super.onInit();
    getAllServiceLink();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  //Service Link 전체 불러오기
  getAllServiceLink() async {
    try {
      isDataProcessing(true);

      //Indicator 를 보기위해 0.5초 기다림
      await Future.delayed(Duration(milliseconds: 500));
      ServiceLinkRepository.to.getAllServiceLink().then((resp) {
        lstServiceLinkData.value.clear();
        lstServiceLinkData.value.addAll(resp);
        isDataProcessing(false);

        assignService();

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

  //Service Link 할당(분리)
  assignService() async{
    final smartContractOne= lstServiceLinkData.value.where((serviceLink)=> serviceLink.task.contains('SMART CONTRACT')).toList();
    smartContractUrl.value=smartContractOne.first.url;

    final hrCreditUrlOne= lstServiceLinkData.value.where((serviceLink)=> serviceLink.task.contains('HR CREDIT')).toList();
    hrCreditUrl.value=hrCreditUrlOne.first.url;

    //Sellon SMS
    final sellonCMSUrlOne= lstServiceLinkData.value.where((serviceLink)=> serviceLink.task.contains('SELLON CMS')).toList();
    sellonCMSUrl.value=sellonCMSUrlOne.first.url;
    sellonCMSId.value=sellonCMSUrlOne.first.userName ?? '';
    sellonCMSPwd.value=sellonCMSUrlOne.first.pwd ?? '';

    final sellonWalletCMSUrlOne= lstServiceLinkData.value.where((serviceLink)=> serviceLink.task.contains('SELLON WALLET CMS')).toList();
    sellonWalletCMSUrl.value=sellonWalletCMSUrlOne.first.url;
    sellonWalletCMSId.value=sellonWalletCMSUrlOne.first.userName ?? '';
    sellonWalletCMSPwd.value=sellonWalletCMSUrlOne.first.pwd ?? '';

    final babyBoomCMSUrlOne= lstServiceLinkData.value.where((serviceLink)=> serviceLink.task.contains('BABYBOOM CMS')).toList();
    babyBoomCMSUrl.value=babyBoomCMSUrlOne.first.url;
    babyBoomCMSId.value=babyBoomCMSUrlOne.first.userName ?? '';
    babyBoomCMSPwd.value=babyBoomCMSUrlOne.first.pwd ?? '';
  }
  
  //Clipboard
  copyText(String txt) {
    Clipboard.setData(ClipboardData(text: txt));
  }

  pasteText() async {
    ClipboardData? clipboard = await Clipboard.getData('text/plain');
    text.value = clipboard!.text!;
  }

}
