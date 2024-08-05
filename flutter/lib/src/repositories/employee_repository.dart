import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:hr2024/src/api/api.dart';
import 'package:hr2024/src/models/code_model.dart';
import 'package:hr2024/src/models/employee_model.dart';
import 'package:hr2024/src/models/role_count_model.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:async/async.dart';
import 'package:path/path.dart' as path;

class EmployeeRepository extends GetConnect {
  static EmployeeRepository get to => Get.find();

  String rtnMsg = "";

  @override
  void onInit() {
    super.onInit();
  }

  //code 조회(직원정보)
  Future<List<CodeModel>> getEmpCodes() async {
    try {
      final response = await get(Api.baseUrl + '/getEmpCodes');

      if (response.status.hasError) {
        return Future.error(response.statusText!);
      } else {
        var jsonData = response.body;
        final result = jsonData
            .map<CodeModel>((code) => CodeModel.fromJson(code))
            .toList();

        return result;
      }
    } catch (e) {
      rethrow;
    }
  }

  //유형별 code 조회
  Future<List<CodeModel>> getCodeByType(String type) async {
    try {
      final response = await get(Api.baseUrl + '/getCode/$type');

      if (response.status.hasError) {
        return Future.error(response.statusText!);
      } else {
        var jsonData = response.body;
        final result = jsonData
            .map<CodeModel>((code) => CodeModel.fromJson(code))
            .toList();

        return result;
      }
    } catch (e) {
      rethrow;
    }
  }

  //전체 직원조회
  Future<List<EmployeeModel>> getAllEmployee() async {
    try {
      final response = await get(Api.baseUrl + '/getAllEmployee');

      if (response.status.hasError) {
        return Future.error(response.statusText!);
      } else {
        var jsonData = response.body;
        final result = jsonData
            .map<EmployeeModel>((employee) => EmployeeModel.fromJson(employee))
            .toList();

        return result;
      }
    } catch (e) {
      rethrow;
      // return Future.error(e.toString());
    }
  }

  //직원정보 ID로 조회
  Future<EmployeeModel> getEmployeeById(String id) async {
    try {
      final response = await get(Api.baseUrl + '/getEmployeeById/$id');

      if (response.status.hasError) {
        return Future.error(response.statusText!);
      } else {
        var jsonData = response.body;

        final result = EmployeeModel.fromJson(jsonData);
        return result;
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  //Role별 인원수 조회
  Future<List<RoleCountModel>> getRoleCountForAll() async {
    try {
      final response = await get(Api.baseUrl + '/getRoleCountForAll');

      if (response.status.hasError) {
        return Future.error(response.statusText!);
      } else {
        var jsonData = response.body;
        final result = jsonData
            .map<RoleCountModel>(
                (roleCntData) => RoleCountModel.fromJson(roleCntData))
            .toList();

        return result;
      }
    } catch (e) {
      rethrow;
      // return Future.error(e.toString());
    }
  }

  String getMimeType(String path) {
    String extension = path.substring(path.lastIndexOf(".") + 1);
    return extension.toLowerCase();
  }

  //직원정보 저장
  Future<String> saveEmployee(EmployeeModel employee, List<File>? files) async {
    try {
      var url = Uri.parse(Api.baseUrl + '/saveEmployee');
      var request = http.MultipartRequest('POST', url);
      var headers = {
        'Content-Type': 'application/x-www-form-urlencoded',
        'connection': 'keep-alive',
        'accept': '*/*'
      };
      request.headers.addAll(headers);

      //파일 전송
      if (files == null || files.length == 0) {
        request.files.add(http.MultipartFile.fromBytes('files', [],
            contentType: MediaType('image', 'png'), filename: 'empty'));
      } else {
        for (int i = 0; i < files.length; i++) {
          var stream =
              new http.ByteStream(DelegatingStream.typed(files[i].openRead()));

          String filePath = files[i].path;
          String baseName = path.basename(
              filePath.substring(0, filePath.lastIndexOf(".") + 1) +
                  getMimeType(filePath));

          var length = files[i].lengthSync();
          final multipartFiles = new http.MultipartFile('files', stream, length,
              filename: baseName);

          request.files.add(multipartFiles);
        }
      }
      //내용 전송
      String jsonStringSet = jsonEncode(employee.toJson());
      request.fields['jsonString'] = jsonStringSet;

      // print('request.fields-add : ${request.fields}');

      var response = await request.send();
      // String videoMsg = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        //저장 성공 시 flag 변경
        return 'success';
      } else {
        return 'fail';
      }
    } catch (e) {
      rethrow;
      // return Future.error(e.toString());
    }
  }

  //직원정보 수정
  Future<String> updateEmployee(
      EmployeeModel employee, List<File>? files) async {
    try {
      var url = Uri.parse(Api.baseUrl + '/updateEmployee');
      var request = http.MultipartRequest('POST', url);
      var headers = {
        'Content-Type': 'application/x-www-form-urlencoded',
        'connection': 'keep-alive',
        'accept': '*/*'
      };
      request.headers.addAll(headers);

      //파일 전송
      if (files == null || files.length == 0) {
        request.files.add(http.MultipartFile.fromBytes('files', [],
            contentType: MediaType('image', 'png'), filename: 'empty'));
      } else {
        for (int i = 0; i < files.length; i++) {
          var stream =
              new http.ByteStream(DelegatingStream.typed(files[i].openRead()));

          String filePath = files[i].path;
          String baseName = path.basename(
              filePath.substring(0, filePath.lastIndexOf(".") + 1) +
                  getMimeType(filePath));

          var length = files[i].lengthSync();
          final multipartFiles = new http.MultipartFile('files', stream, length,
              filename: baseName);

          request.files.add(multipartFiles);
        }
      }
      //내용 전송
      String jsonStringSet = jsonEncode(employee.toJson());
      request.fields['jsonString'] = jsonStringSet;

      // print('request.fields[Update] : ${request.fields}');

      var response = await request.send();
      // String videoMsg = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        //저장 성공 시 flag 변경
        return 'success';
      } else {
        return 'fail';
      }
    } catch (e) {
      rethrow;
      // return Future.error(e.toString());
    }
  }

  //직원정보 삭제
  Future<String> deleteEmployeeById(String id) async {
    try {
      final response = await delete(Api.baseUrl + '/delete/$id',
          contentType: 'application/json');

      if (response.status.hasError) {
        return Future.error(response.statusText!);
      } else {
        var result = response.body;
        //result : deleted, fail
        return result;
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }

// //삭제
// Future<String> deleteTask(int taskId) async {
//   try {
//     final response = await delete("/todoApp/api/deleteTask/$taskId",
//         contentType: 'application/json');
//
//     if (response.status.hasError) {
//       return Future.error(response.statusText!);
//     } else {
//       var result = response.body;
//
//       if (result > 0) {
//         rtnMessage = "success";
//       } else {
//         rtnMessage = "fail";
//       }
//       return rtnMessage;
//     }
//   } catch (e) {
//     return Future.error(e.toString());
//   }
// }
}
