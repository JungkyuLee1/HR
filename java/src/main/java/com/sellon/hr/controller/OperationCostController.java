package com.sellon.hr.controller;//package com.sellon.hr.controller;

import com.sellon.hr.common.util.UuidUtil;
import com.sellon.hr.dto.Code;
import com.sellon.hr.dto.OperationCost;
import com.sellon.hr.service.OperationCostService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping(value = "/sellonhr/api/operationCost")
public class OperationCostController {
    private final Logger LOGGER = (Logger) LoggerFactory.getLogger(OperationCostController.class);

    @Autowired
    private OperationCostService operationCostService;

    @Autowired
    private UuidUtil uuidUtil;

    //Code 조회(운영 공통비용 정보)
    @GetMapping("/getCostCodes")
    public ResponseEntity<List<Code>> getCostCodes() {
        List<Code> codes = operationCostService.getCostCodes();

        return ResponseEntity.status(HttpStatus.OK).body(codes);
    }

    //운영 공통비용 전체 조회
    @GetMapping("/getAll")
    public ResponseEntity<List<OperationCost>> getAllOperationCost() {
        List<OperationCost> operationCosts = operationCostService.getAllOperationCost();

        return ResponseEntity.status(HttpStatus.OK).body(operationCosts);
    }

    //운영 공통비용 건별 조회
    @GetMapping("/getById/{id}")
    public ResponseEntity<OperationCost> getOperationCostById(@PathVariable String id) {
        OperationCost operationCost = operationCostService.getOperationCostById(id);

        return ResponseEntity.status(HttpStatus.OK).body(operationCost);
    }


    //운영 공통비용 저장
    @PostMapping("/save")
    public ResponseEntity<String> saveOperationCost(@RequestBody OperationCost operationCost) {
        //id 생성 및 setting
        String uuid = uuidUtil.getUUID();
        operationCost.setId(uuid);

        String message = operationCostService.saveOperationCost(operationCost);

        return ResponseEntity.status(HttpStatus.OK).body(message);
    }

    //운영 공통비용 수정
    @PatchMapping("/update/{id}")
    public ResponseEntity<String> updateOperationCost(@PathVariable("id") String id, @RequestBody OperationCost operationCost) {
        String message = operationCostService.updateOperationCost(id, operationCost);

        return ResponseEntity.status(HttpStatus.OK).body(message);
    }

    //운영 공통비용 삭제(active_yn='N')
    @DeleteMapping("/delete/{id}")
    public ResponseEntity<String> deleteOperationCostById(@PathVariable("id") String id) {
        String message = operationCostService.deleteOperationCostById(id);

        return ResponseEntity.status(HttpStatus.OK).body(message);
    }
}