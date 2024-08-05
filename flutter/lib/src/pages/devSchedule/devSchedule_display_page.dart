import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr2024/src/controllers/devSchedule/devSchedule_addedit_controller.dart';
import 'package:hr2024/src/controllers/devSchedule/devSchedule_display_controller.dart';
import 'package:hr2024/src/models/dev_schedule_model.dart';
import 'package:hr2024/src/pages/DevSchedule/devSchedule_addedit_page.dart';

class DevScheduleDisplay extends GetView<DevScheduleDisplayController> {
  DevScheduleDisplay({Key? key}) : super(key: key);

  TextStyle textStyle = TextStyle(fontSize: 14, color: Colors.white);

//1.
  HeaderAndSearch() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '개발 진행상태',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textScaler: TextScaler.linear(1),
            ),
            Text(
              '${controller.onGoingItemCount.value}개 항목 진행 중..',
              style: TextStyle(fontSize: 14, color: Colors.red),
              textScaler: TextScaler.linear(1),
            )
          ],
        ),
        SizedBox(
          height: 12,
        ),
        Container(
          height: 45,
          child: TextField(
              controller: controller.searchTermController,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(2),
                  filled: true,
                  fillColor: Colors.grey[200],
                  prefixIcon: Icon(Icons.search),
                  hintText: '제목 검색',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none)),
              maxLines: 1,
              style: TextStyle(fontSize: 15),
              onChanged: (String? newSearchTerm) {
                controller.onSearchChanged(newSearchTerm);
              }),
        ),
      ],
    );
  }

  //2-2.
  Color textColor(StatusFlag status) {
    return controller.currentStatusFlag.value == status
        ? Colors.orange
        : Colors.grey;
  }

  FontWeight textFontWeight(StatusFlag status) {
    return controller.currentStatusFlag.value == status
        ? FontWeight.bold
        : FontWeight.normal;
  }

  //2-1.
  StatusOne(String text, StatusFlag status, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(left: 20, top: 20, bottom: 11, right: 20),
        child: Text(
          text,
          style: TextStyle(
              fontSize: 16,
              color: textColor(status),
              fontWeight: textFontWeight(status)),
          textScaler: TextScaler.linear(1),
        ),
      ),
    );
  }

//2.전체, 진행중, 완료 구분
  ProgressStatus() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        StatusOne('전체', StatusFlag.ALL, () {
          controller.changeStatusFlag(StatusFlag.ALL);
          controller.getAllByTitleAndStatus(controller.searchTerm.value);
        }),
        StatusOne('진행 중', StatusFlag.ONGOING, () {
          controller.changeStatusFlag(StatusFlag.ONGOING);
          controller.getAllByTitleAndStatus(controller.searchTerm.value);
        }),
        StatusOne('완료', StatusFlag.FINISH, () {
          controller.changeStatusFlag(StatusFlag.FINISH);
          controller.getAllByTitleAndStatus(controller.searchTerm.value);
        }),
      ],
    );
  }

  //3-1(Title 상세)
  TitleOne(
      String tNo, String tTitle, String tDesc, String tNation, String tPeriod) {
    return Container(
      decoration: BoxDecoration(color: Colors.black),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
              margin: EdgeInsets.only(left: 2),
              width: Get.width * 0.06,
              child: Text(
                tNo,
                style: textStyle,
                textAlign: TextAlign.center,
                textScaler: TextScaler.linear(1),
              )),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 1),
              width: Get.width * 0.25,
              child: Text(
                tTitle,
                style: textStyle,
                textAlign: TextAlign.center,
                textScaler: TextScaler.linear(1),
              )),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 1),
              width: Get.width * 0.26,
              child: Text(
                tDesc,
                style: textStyle,
                textAlign: TextAlign.center,
                textScaler: TextScaler.linear(1),
              )),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 1),
              width: Get.width * 0.09,
              child: Text(
                tNation,
                style: textStyle,
                textAlign: TextAlign.center,
                textScaler: TextScaler.linear(1),
              )),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 1),
              width: Get.width * 0.18,
              child: Text(
                tPeriod,
                style: textStyle,
                textAlign: TextAlign.center,
                textScaler: TextScaler.linear(1),
              )),
        ],
      ),
    );
  }

  //3.
  Title() {
    return TitleOne('No', '제목', '내용', '국가', '기한');
  }

  //4-1.
  DevScheduleDataOne(
      BuildContext context, int index, DevScheduleModel devSchedule) {
    return GestureDetector(
      onTap: () {
        //해당 개발일정 선택 시 1.'edit' 2.선택 건 devSchedule obs에 할당 3.각 field에 개발일정 정보 setting
        DevScheduleAddEditController.to.addEditDevScheduleFlag.value = 'edit';
        DevScheduleAddEditController.to.devSchedule.value = devSchedule;
        DevScheduleAddEditController.to.setDevScheduleDataForEdit();

        Navigator.push(context,
            MaterialPageRoute(builder: (context) => DevScheduleAddEdit()));
      },
      child: Column(
        children: [
          Row(
            children: [
              Container(
                  margin: EdgeInsets.only(left: 3, right: 2),
                  width: Get.width * 0.06,
                  child: CircleAvatar(
                    child: Text(
                      '${index + 1}'.toString(),
                      textScaler: TextScaler.linear(1),
                    ),
                    radius: 13,
                  )),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 1),
                  width: Get.width * 0.25,
                  child: Text(
                    '${devSchedule.title}',
                    textAlign: TextAlign.start,
                    textScaler: TextScaler.linear(1),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 1),
                  width: Get.width * 0.26,
                  child: Text(
                    '${devSchedule.detail}',
                    textAlign: TextAlign.start,
                    textScaler: TextScaler.linear(1),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 1),
                  width: Get.width * 0.09,
                  child: Text(
                    '${devSchedule.nation}',
                    textAlign: TextAlign.center,
                    textScaler: TextScaler.linear(1),
                  )),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 1),
                  width: Get.width * 0.18,
                  child: Text(
                    '${devSchedule.devPeriodKind}',
                    textAlign: TextAlign.center,
                    textScaler: TextScaler.linear(1),
                  )),
            ],
          ),
          Divider(
            indent: 10,
            endIndent: 10,
            color: Colors.grey[200],
          )
        ],
      ),
    );
  }

  //4.
  DevScheduleData() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.grey),
      ),
      child: controller.isDataProcessing.value
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () => controller.getAllByTitleAndStatus('allData'),
              child: ListView.builder(
                key: PageStorageKey(UniqueKey),
                  itemCount: controller.lstDevSchedule.value.length,
                  itemBuilder: (context, index) {
                    final schedule = controller.lstDevSchedule.value[index];

                    return DevScheduleDataOne(context, index, schedule);
                  }),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Obx(
        () => Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                HeaderAndSearch(),
                ProgressStatus(),
                Title(),
                PageStorage(
                    bucket: controller.buckGlobal,
                    child: Expanded(child: DevScheduleData())),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
