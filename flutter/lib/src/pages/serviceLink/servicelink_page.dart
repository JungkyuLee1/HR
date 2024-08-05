import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr2024/src/controllers/serviceLink/serviceLink_main_controller.dart';

class ServiceLinkMain extends GetView<ServiceLinkMainController> {
  ServiceLinkMain({super.key});

  // String smartContractUrl =
  //     'https://bscscan.com/token/0xb208063997db51de3f0988f8a87b0aff83a6213f#readContract';
  // String hrCreditUrl =
  //     'https://docs.google.com/spreadsheets/d/1wurghfAq1a_iwF4uk__mKDkWLLL4jfuU1efFlSFPt_0/edit#gid=0';
  // String sellonCMSUrl = 'https://cms-idmaster.sellon.net/a/login';
  // String sellonWalletCMSUrl =
  //     'https://prd-bcbe.sellon.net/adminsgsellonwallet/login';
  // String babyBoomCMSUrl = 'https://bbt.babyboomtoken.com/babybooomcms/login';
  // String sellonCMSId = 'mimind', sellonCMSPwd = 'keepworking2024';
  // String sellonWalletCMSId = 'adminsw@sellon.net', sellonWalletCMSPwd = 'qwerty123';
  // String babyBoomCMSId = 'support@babyboomtoken.com',
  //     babyBoomCMSPwd = 'B@byb0o0m\$eLlOn2024';

  UsernamePasswordInfo(String userName, String passwd) {
    return Container(
      margin: EdgeInsets.only(left: 16),
      child: Wrap(
        children: [
          Text(
            ' (ID&Pwd : $userName / $passwd)',
            style: TextStyle(fontSize: 14),
            textScaler: TextScaler.linear(1),
          )
        ],
      ),
    );
  }

  //c-2
  CopyButton(String title, String item) {
    return GestureDetector(
      onTap: () => controller.copyText(item),
      child: Container(
        margin: EdgeInsets.only(left: 17, top: 5),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 3),
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
        child: Text(
          title,
          style: TextStyle(fontSize: 14),
          textScaler: TextScaler.linear(1),
        ),
      ),
    );
  }

  //c-1
  MakeLink(String title, String targetUrl) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          textScaler: TextScaler.linear(1),
        ),
        SizedBox(
          height: 2,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                  onTap: () {
                    Get.toNamed('/webViewOpen', arguments: targetUrl);
                  },
                  child: Text(
                    targetUrl,
                    style: TextStyle(
                        fontSize: 14, decoration: TextDecoration.underline),
                    textScaler: TextScaler.linear(1),
                  )),
              SizedBox(
                height: 3,
              ),
            ],
          ),
        )
      ],
    );
  }

  //0
  SmartContractAndHrCredit() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MakeLink('1.Smart Contract(BBT)', controller.smartContractUrl.value),
        CopyButton('Copy', controller.smartContractUrl.value),
        SizedBox(
          height: 15,
        ),
        MakeLink('2.직원별 Credit 현황', controller.hrCreditUrl.value),
        CopyButton('Copy', controller.hrCreditUrl.value),
      ],
    );
  }

  //1.
  CMS() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MakeLink('3.Sellon CMS', controller.sellonCMSUrl.value),
        UsernamePasswordInfo(
            controller.sellonCMSId.value, controller.sellonCMSPwd.value),
        Row(
          children: [
            CopyButton('Copy Url', controller.sellonCMSUrl.value),
            CopyButton('ID', controller.sellonCMSId.value),
            CopyButton('PWD', controller.sellonCMSPwd.value),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        MakeLink('4.Sellon Wallet CMS', controller.sellonWalletCMSUrl.value),
        UsernamePasswordInfo(controller.sellonWalletCMSId.value,
            controller.sellonWalletCMSPwd.value),
        Row(
          children: [
            CopyButton('Copy Url', controller.sellonWalletCMSUrl.value),
            CopyButton('ID', controller.sellonWalletCMSId.value),
            CopyButton('PWD', controller.sellonWalletCMSPwd.value),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        MakeLink('5.BabyBoom CMS', controller.babyBoomCMSUrl.value),
        UsernamePasswordInfo(
            controller.babyBoomCMSId.value, controller.babyBoomCMSPwd.value),
        Row(
          children: [
            CopyButton('Copy Url', controller.babyBoomCMSUrl.value),
            CopyButton('ID', controller.babyBoomCMSId.value),
            CopyButton('PWD', controller.babyBoomCMSPwd.value),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
            title: Text(
              '업무 Link',
              style:
                  TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textScaler: TextScaler.linear(1),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 1),
        body: RefreshIndicator(
          onRefresh: () => controller.getAllServiceLink(),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 20, bottom: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SmartContractAndHrCredit(),
                  SizedBox(
                    height: 20,
                  ),
                  CMS(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
