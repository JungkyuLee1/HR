import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:get/get.dart';

class WebViewOpen extends StatefulWidget {
  WebViewOpen({Key? key}) : super(key: key);

  @override
  State<WebViewOpen> createState() => _WebViewOpenState();
}

class _WebViewOpenState extends State<WebViewOpen> {
  late final WebViewController _controller;
  var urlArg=Get.arguments;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Color(0x00000000))
      ..setNavigationDelegate(NavigationDelegate(onProgress: (int progress) {
        print('Webview is loading (progress : $progress');
      }, onPageStarted: (String url) {
        print('Page started loading : $url');
      }, onPageFinished: (String url) {
        print('Page finished loading : $url');
      }, onWebResourceError: (WebResourceError error) {
        print(
            'Page resource error : \ncode : ${error.errorCode}\ndescription : ${error.description}\n'
                'errorType : ${error.errorType}\n isForMainFrame : ${error.isForMainFrame}');
      }, onNavigationRequest: (NavigationRequest request) {
        if (request.url.startsWith('https://www.youtube.com/')) {
          return NavigationDecision.prevent;
        }
        return NavigationDecision.navigate;
      }))
      ..loadRequest(Uri.parse(
          urlArg));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(
        controller: _controller,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.back();
          },
          shape: CircleBorder(),
          backgroundColor: Colors.orange,
          child: Icon(Icons.close)),
    );
  }
}








// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:get/get.dart';
//
// class WebViewSmartContract extends StatefulWidget {
//   WebViewSmartContract({Key? key}) : super(key: key);
//
//   @override
//   State<WebViewSmartContract> createState() => _WebViewSmartContractState();
// }
//
// class _WebViewSmartContractState extends State<WebViewSmartContract> {
//   late final WebViewController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _controller = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setBackgroundColor(Color(0x00000000))
//       ..setNavigationDelegate(NavigationDelegate(onProgress: (int progress) {
//         print('Webview is loading (progress : $progress');
//       }, onPageStarted: (String url) {
//         print('Page started loading : $url');
//       }, onPageFinished: (String url) {
//         print('Page finished loading : $url');
//       }, onWebResourceError: (WebResourceError error) {
//         print(
//             'Page resource error : \ncode : ${error.errorCode}\ndescription : ${error.description}\n'
//             'errorType : ${error.errorType}\n isForMainFrame : ${error.isForMainFrame}');
//       }, onNavigationRequest: (NavigationRequest request) {
//         if (request.url.startsWith('https://www.youtube.com/')) {
//           return NavigationDecision.prevent;
//         }
//         return NavigationDecision.navigate;
//       }))
//       ..loadRequest(Uri.parse(
//           'https://bscscan.com/token/0xb208063997db51de3f0988f8a87b0aff83a6213f'));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: WebViewWidget(
//         controller: _controller,
//       ),
//       floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             Get.back();
//           },
//           shape: CircleBorder(),
//           backgroundColor: Colors.orange,
//           child: Icon(Icons.close)),
//     );
//   }
// }
