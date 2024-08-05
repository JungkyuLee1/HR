import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageDialogPopup extends StatelessWidget {
  const MessageDialogPopup(this.title, this.message,
      {this.okCallback, this.cancelCallback, Key? key})
      : super(key: key);

  final String? title;
  final String? message;
  final Function()? okCallback;
  final Function()? cancelCallback;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      // type: MaterialType.transparency,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: Get.size.width*0.7,
            padding: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Text(
                  title!,
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                SizedBox(height: 10,),
                Text(
                  message!,
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: okCallback,
                      child: Text('OK'),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      onPressed: cancelCallback,
                      child: Text('Cancel'),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
