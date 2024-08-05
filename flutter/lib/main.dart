import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hr2024/src/bindings/init_binding.dart';
import 'package:hr2024/src/common/consonants.dart';
import 'package:hr2024/src/routes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  // debugRepaintRainbowEnabled=true;
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  //Nickname으로 권한을 check하기위한 SharedPreferences
  prefs = await SharedPreferences.getInstance();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: Get.key,
      title: 'Sellon HR',
      debugShowCheckedModeBanner: false,
      initialBinding: InitBinding(),
      initialRoute: Routes.INITIAL,
      getPages: Routes.routes,
    );
  }
}

// 0x95e4585c695eAdd7EEE572523EFFD2FdeE9e8a8f
