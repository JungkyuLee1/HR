import 'package:get/get.dart';
import 'package:hr2024/src/controllers/employee/employee_display_controller.dart';
import 'package:hr2024/src/models/employee_model.dart';
import 'package:hr2024/src/models/role_count_model.dart';
import 'package:hr2024/src/repositories/employee_repository.dart';

class EmployeeChartController extends GetxController{

  EmployeeDisplayController employeeDisplayController = Get.find();
  var chartEmployees =Rx<List<EmployeeModel>>([]);
  var lstRoleCount =Rx<List<RoleCountModel>>([]);
  var totalCount=0.obs;

  @override
  void onInit() {
    super.onInit();

    chartEmployees=employeeDisplayController.lstEmployee;
    getRoleCountForAll();
  }

  getRoleCountForAll() async{
    lstRoleCount.value=await EmployeeRepository.to.getRoleCountForAll();

    totalCount.refresh();

    for(RoleCountModel roleCntModel in lstRoleCount.value){
      totalCount.value+=roleCntModel.cnt;
    }
  }
}