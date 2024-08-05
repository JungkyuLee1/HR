package com.sellon.hr.controller;

import com.sellon.hr.common.util.UuidUtil;
import com.sellon.hr.dto.Memo;
import com.sellon.hr.service.MemoService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping(value = "/sellonhr/api/memo")
public class MemoController {
    private final Logger LOGGER = (Logger) LoggerFactory.getLogger(MemoController.class);

    @Autowired
    private MemoService memoService;

    @Autowired
    private UuidUtil uuidUtil;

    //전체 조회(전체가 1건 임)
    @GetMapping("/getMemo")
    public ResponseEntity<Memo> getMemo() {
        Memo memo = memoService.getMemo();

        return ResponseEntity.status(HttpStatus.OK).body(memo);
    }

    //    Id로 조회
    @GetMapping("/getMemoById/{id}")
    public ResponseEntity<Memo> getMemoById(@PathVariable("id") String id) {
        Memo memo = memoService.getMemoById(id);

        return ResponseEntity.status(HttpStatus.OK).body(memo);
    }

    //저장
    @PostMapping("/save")
    public ResponseEntity<String> saveMemo(@RequestBody Memo memo) {
        //id 생성 및 setting
        String uuid = uuidUtil.getUUID();
        memo.setId(uuid);

        String message = memoService.saveMemo(memo);
        return ResponseEntity.status(HttpStatus.OK).body(message);
    }

    //수정
    @PatchMapping("/update/{id}")
    public ResponseEntity<String> updateMemo(@PathVariable("id") String id, @RequestBody Memo memo) {
        String message = memoService.updateMemo(id, memo);

        return ResponseEntity.status(HttpStatus.OK).body(message);
    }
}