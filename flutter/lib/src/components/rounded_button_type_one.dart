import 'package:flutter/material.dart';

class RoundedButtonTypeOne extends StatelessWidget {
  RoundedButtonTypeOne(
      {required this.width,
      required this.onTap,
      required this.buttonText,
      required this.icon,
      required this.isModified,
      Key? key})
      : super(key: key);

  final double width;
  final Function() onTap;
  final String buttonText;
  final Icon? icon;
  final bool isModified;

  // EmployeeRegisterController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: buttonText == '저장'
              ? isModified
                  ? Colors.orange
                  : Colors.grey
              : Colors.orange,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buttonText == 'Previous'
                  ? Row(
                      children: [
                        Container(child: icon != null ? icon : null),
                        Text(' '),
                      ],
                    )
                  : Container(),
              Text(
                buttonText,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              buttonText == 'Next'
                  ? Row(
                      children: [
                        Text('  '),
                        Container(child: icon != null ? icon : null),
                      ],
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
