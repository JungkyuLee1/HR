import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hr2024/src/common/consonants.dart';

class AppController extends GetxController {
  static AppController get to => Get.find();

  late TextEditingController nickNameController;
  String? nickName;
  var isAdmin = false.obs;
  var isDelayLoading = false.obs;
  var isConnectLoading = false.obs;
  var isExceptionError = false.obs;
  var connectMessage = 'Accessing..'.obs;
  var show = true.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();

    getNickName();
    nickNameController = TextEditingController(text: nickName);
    checkInternetConnection();
    timer();
  }

  //1
  getNickName() {
    nickName = prefs?.getString('name');

    if (nickName == null || nickName!.trim().isEmpty) {
      nickName = 'Sellon';
    }
  }

  //2
  setNickName(String nick) async {
    String nickName = nick.trim().toLowerCase();
    await prefs!.setString('name', nickName);

    if (nickName == 'superman') {
      isAdmin.value = true;
    } else {
      isAdmin.value = false;
    }
  }

  //Button click시 Loading indicator 보여줌
  delayTime() async {
    isDelayLoading.value = true;
    await Future.delayed(Duration(milliseconds: 500));
  }

  checkInternetConnection() async {
    try {
      isConnectLoading.value = true;
      isExceptionError.value = false;
      connectMessage.value = 'Accessing';

      final result = await InternetAddress.lookup('sellon.store');

      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        connectMessage.value = '';
      }
      isConnectLoading.value = false;
    } on SocketException catch (_) {
      isConnectLoading.value = false;
      isExceptionError.value = true;
      connectMessage.value = 'Please check internet connection !!';
    }
  }

  //timer (for message blink)
  timer() {
    _timer = Timer.periodic(Duration(milliseconds: 800), (_) {
      show.value = !show.value;
    });
  }

  @override
  void dispose() {
    super.dispose();
    nickNameController.dispose();
  }
}
