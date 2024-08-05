import 'package:flutter/material.dart';

class EmployeeAddHeader extends StatelessWidget {
  const EmployeeAddHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.red),
        child: Row(
          children: [
            IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back_ios)),
            Center(
                child: Text(
              '인사정보',
              style: TextStyle(fontSize: 14),
              textScaler: TextScaler.linear(1),
            ))
          ],
        ),
      ),
    );
  }
}
