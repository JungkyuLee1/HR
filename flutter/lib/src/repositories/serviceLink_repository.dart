import 'package:get/get.dart';
import 'package:hr2024/src/models/service_link_model.dart';

import '../api/api.dart';

class ServiceLinkRepository extends GetConnect {
  static ServiceLinkRepository get to => Get.find();

  //등록 Data를 한번에 모두 가져옴
  Future<List<ServiceLinkModel>> getAllServiceLink() async {
    try {
      final response =
          await get(Api.baseUrl + '/serviceLink/getAllServiceLink');



      if (response.status.hasError) {
        return Future.error(response.statusText!);
      } else {
        var jsonData = response.body;

        final result = jsonData
            .map<ServiceLinkModel>((link) => ServiceLinkModel.fromJson(link))
            .toList();

        return result;
      }
    } catch (e) {
      rethrow;
      // return Future.error(e.toString());
    }
  }
}
