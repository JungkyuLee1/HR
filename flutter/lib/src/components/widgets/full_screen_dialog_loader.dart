// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:get/get.dart';
//
// class FullScreenDialogLoader {
//   static void showDialog() {
//     Get.dialog(
//         WillPopScope(
//           child: Center(
//             child: SpinKitThreeBounce(
//               color: Get.isDarkMode
//                   ? Colors.yellow
//                   : Colors.deepPurpleAccent,
//               size: 50,
//             ),
//           ),
//           onWillPop: () => Future.value(false),
//         ),
//         barrierDismissible: false,
//         barrierColor:
//         Theme.of(Get.context!).scaffoldBackgroundColor.withOpacity(.3),
//         useSafeArea: true);
//   }
//
//   //Close Dialog
//   static void cancelDialog() {
//     Get.back();
//   }
// }