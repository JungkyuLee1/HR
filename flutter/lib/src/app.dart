import 'package:flutter/material.dart';
import 'package:hr2024/src/controllers/app_controller.dart';
import 'package:get/get.dart';

class App extends GetView<AppController> {
  const App({Key? key}) : super(key: key);

  //0. HR Logo
  Logo() {
    return Container(
      margin: EdgeInsets.only(
          top: Get.height * 0.1,
          left: Get.width * 0.26,
          bottom: Get.height * 0.03),
      height: Get.height * 0.3,
      width: Get.width * 0.5,
      alignment: Alignment.center,
      child: Image.asset(
        'assets/images/hr_logo.jpg',
        fit: BoxFit.cover,
      ),
    );
  }

  //1. Nickname
  NickName() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        controller: controller.nickNameController,
        style: TextStyle(fontSize: 17),
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          label: Text(
            'Nickname',
            textScaler: TextScaler.linear(1),
          ),
        ),
        onChanged: (value) {
          controller.nickName = value;
        },
      ),
    );
  }

  //2. TextInfo
  TextInfo() {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 10, top: 5, bottom: 15),
      child: Text(
        '*Nickname을 입력하세요',
        style: TextStyle(
          fontSize: 15,
        ),
        textScaler: TextScaler.linear(1),
      ),
    );
  }

  //3. Button
  Button() {
    return Obx(
      () => Stack(
        children: [
          GestureDetector(
            onTap: controller.isConnectLoading.value
                ? null
                : () async {
                    await controller.checkInternetConnection();

                    if (!controller.isConnectLoading.value &&
                        !controller.isExceptionError.value) {
                      await controller.delayTime();
                      controller.setNickName(controller.nickName!);
                      Get.toNamed('/hrMaster');
                    }
                  },
            child: Padding(
              padding: EdgeInsets.only(left: Get.width * 0.32, right: 0),
              child: Container(
                height: Get.height * 0.07,
                width: Get.width * 0.35,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.orange),
                child: Center(
                    child: Text(
                  'OK',
                  style: TextStyle(fontSize: 17, color: Colors.white),
                  textScaler: TextScaler.linear(1),
                )),
              ),
            ),
          ),
          Positioned(
              top: Get.height * 0.01,
              left: Get.width * 0.3,
              right: 0,
              bottom: Get.height * 0.01,
              child: Center(
                  child: Container(
                      height: 30,
                      width: 30,
                      child: !controller.isConnectLoading.value
                          ? !controller.isDelayLoading.value
                              ? Container()
                              : Container(
                                  child: CircularProgressIndicator(
                                  color: Colors.white,
                                ))
                          : Container(
                              child: CircularProgressIndicator(
                              color: Colors.white,
                            ))))),
        ],
      ),
    );
  }

  //4 Progress Message
  progressMessage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
      child: Container(
        alignment: Alignment.center,
        child: Text(
          '${controller.connectMessage.value}',
          style: controller.show.value
              ? TextStyle(
                  fontSize: 16,
                  color: controller.isExceptionError.value
                      ? Colors.red
                      : Colors.black)
              : TextStyle(color: Colors.transparent),
          textScaler: TextScaler.linear((1)),
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
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Logo(),
                NickName(),
                TextInfo(),
                Button(),
                progressMessage(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
