package com.sellon.hr.controller;


import com.sellon.hr.common.util.UuidUtil;
import com.sellon.hr.dto.Code;
import com.sellon.hr.dto.DevSchedule;
import com.sellon.hr.service.DevScheduleService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping(value = "/sellonhr/api/devSchedule")
public class DevScheduleController {
    private final Logger LOGGER = (Logger) LoggerFactory.getLogger(DevScheduleController.class);
    @Autowired
    private DevScheduleService devScheduleService;

    @Autowired
    private UuidUtil uuidUtil;

    //Code 조회(DevSchedule 용 only)
    @GetMapping("/getDevCodes")
    public ResponseEntity<List<Code>> getDevCodes() {
        List<Code> devCodes = devScheduleService.getDevCodes();

        return ResponseEntity.status(HttpStatus.OK).body(devCodes);
    }

    //Title로 조회(전체 건 조회 포함)
    @GetMapping("/getAllByTitleAndStatus")
    public ResponseEntity<List<DevSchedule>> getAllByTitleAndStatus(@RequestParam String titleParam,  @RequestParam String statusParam) {
        String title = "", status="";

        //전체 조회 할 경우 Mobile에서 "allData"로 Parameter를 넘김(LIKE %%)
        if (titleParam.equals("allData")) {
            title = "";
        } else {
            title = titleParam;
        }

        //전체 조회 할 경우 Mobile에서 "allStatus"로 Parameter를 넘김(LIKE %%)
        if(statusParam.equals("allStatus")){
            status = "";
        }else{
            status = statusParam;
        }

        List<DevSchedule> devSchedules = devScheduleService.getAllByTitleAndStatus(title, status);

        return ResponseEntity.status(HttpStatus.OK).body(devSchedules);
    }

    //Id로 조회
    @GetMapping("/getDevScheduleById/{id}")
    public ResponseEntity<DevSchedule> getDevScheduleById(@PathVariable("id") String id) {
        DevSchedule devSchedule = devScheduleService.getDevScheduleById(id);

        return ResponseEntity.status(HttpStatus.OK).body(devSchedule);
    }

    //저장
    @PostMapping("/save")
    public ResponseEntity<String> saveDevSchedule(@RequestBody DevSchedule devSchedule) {
        //id 생성 및 setting
        String uuid = uuidUtil.getUUID();
        devSchedule.setId(uuid);

        String message = devScheduleService.saveDevSchedule(devSchedule);
        return ResponseEntity.status(HttpStatus.OK).body(message);
    }

    //수정
    @PatchMapping("/update/{id}")
    public ResponseEntity<String> updateDevSchedule(@PathVariable("id") String id, @RequestBody DevSchedule devSchedule) {
        String message = devScheduleService.updateDevSchedule(id, devSchedule);

        return ResponseEntity.status(HttpStatus.OK).body(message);
    }

    //삭제
    @DeleteMapping("/delete/{id}")
    public ResponseEntity<String> deleteDevScheduleById(@PathVariable("id") String id) {
        String message = devScheduleService.deleteDevScheduleById(id);

        return ResponseEntity.status(HttpStatus.OK).body(message);
    }
}