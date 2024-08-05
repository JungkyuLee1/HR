import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr2024/src/api/api.dart';
import 'package:hr2024/src/common/util.dart';
import 'package:hr2024/src/controllers/employee/employee_addedit_controller.dart';
import 'package:hr2024/src/controllers/employee/employee_display_controller.dart';
import 'package:hr2024/src/models/employee_model.dart';
import 'package:hr2024/src/pages/employee/employee_addedit_page.dart';

class EmployeeDisplay extends GetView<EmployeeDisplayController> {
  const EmployeeDisplay({Key? key}) : super(key: key);

  _AppBar() {
    return AppBar(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 2),
            child: Text(
              '전체 직원',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textScaler: TextScaler.linear(1),
            ),
          ),
          Text(
            '총원: ${controller.lstEmployee.value.length}명,  총급여:${controller.salaryTotal.value / 1000000} (백만, IDR)',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            textScaler: TextScaler.linear(1),
          ),
          Divider(
            height: 20,
            thickness: 2,
            indent: 12,
            endIndent: 12,
          )
        ],
      ),
      centerTitle: true,
      // backgroundColor: Colors.white,
    );
  }

  //1.직원 Data
  Widget EmployeeOne(
    BuildContext context,
    int index,
    EmployeeModel employee,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: GestureDetector(
        onTap: () async {
          //해당 직원 선택 시 1.'edit' 2.선택 건 employee obs에 할당 3.각 field에 직원정보 setting
          EmployeeAddEditController.to.addEditFlag.value = 'edit';
          EmployeeAddEditController.to.employee.value = employee;
          EmployeeAddEditController.to.setEmployeeDataForEdit();

          Navigator.push(context,
              MaterialPageRoute(builder: (context) => EmployeeAddEdit()));
        },
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey.shade300,
              child: Text(
                '${index + 1}',
                textScaler: TextScaler.linear(1),
              ),
              radius: 15,
            ),
            SizedBox(
              width: 10,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: 90,
                width: 90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: employee.imageUrl == '' || employee.imageUrl == null
                    ? Image.asset(
                        'assets/images/person.jpeg',
                        fit: BoxFit.cover,
                      )
                    : CachedNetworkImage(
                        imageUrl: Api.baseUrl +
                            '/getProfileImage?fileName=${employee.imageUrl}',
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Container(
                          color: Colors.grey[200],
                          child: Center(
                            child: CircularProgressIndicator(
                              value: downloadProgress.progress,
                              color: Colors.black26,
                              strokeWidth: 2,
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        fit: BoxFit.cover,
                      ),

                // progressIndicatorBuilder를 쓰는 것 보다 placeholder를 쓰면 약간 더 느림
                // : CachedNetworkImage(
                //     imageUrl: Api.baseUrl +
                //         '/getProfileImage?fileName=${employee.imageUrl}',
                //     placeholder: (context, url) => Container(
                //         color: Colors.grey[200],
                //         child: Center(
                //           child: CircularProgressIndicator(),
                //         )),
                //     errorWidget: (context, url, error) => Icon(Icons.error),
                //     fit: BoxFit.cover,
                //   ),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  employee.name.length > 18
                      ? employee.name.substring(0, 18)
                      : employee.name.substring(0, employee.name.length),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  textScaler: TextScaler.linear(1),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    employee.role,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                    textScaler: TextScaler.linear(1),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '${commaConvert(employee.salary.toString())}',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                      textScaler: TextScaler.linear(1),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      employee.unit,
                      style: TextStyle(fontSize: 15),
                      textScaler: TextScaler.linear(1),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

//0
  EmployeeBody() {
    return controller.isDataProcessing.value == true
        ? Center(
            child: CircularProgressIndicator(),
          )
        : RefreshIndicator(
            onRefresh: () => controller.getAllEmployee(),
            child: ListView.builder(
                key: PageStorageKey(UniqueKey),
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: controller.lstEmployee.value.length,
                itemBuilder: (context, index) {
                  final employee = controller.lstEmployee.value[index];

                  return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: EmployeeOne(context, index, employee));
                }),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Scaffold(
            backgroundColor: Colors.grey[100],
            appBar: _AppBar(),
            body: PageStorage(
                bucket: controller.buckGlobal, child: EmployeeBody()),
          ),
        ));
  }
}
