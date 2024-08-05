package com.sellon.hr.controller;//package com.sellon.hr.controller;

import com.sellon.hr.dto.Code;
import com.sellon.hr.common.util.UuidUtil;
import com.sellon.hr.dto.Expense;
import com.sellon.hr.service.ExpenseService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping(value = "/sellonhr/api/expense")
public class ExpenseController {
    private final Logger LOGGER = (Logger) LoggerFactory.getLogger(OperationCostController.class);

    @Autowired
    private UuidUtil uuidUtil;

    @Autowired
    private ExpenseService expenseService;

    @GetMapping("/getUnitCode")
    public ResponseEntity<List<Code>> getUnitCode() {
        List<Code> codes = expenseService.getUnitCode();

        return ResponseEntity.status(HttpStatus.OK).body(codes);
    }

    //수입&지출내역 종류별 조회
    @GetMapping("/getAllByKind/{kind}")
    public ResponseEntity<List<Expense>> getAllByKind(@PathVariable("kind") String kind) {
        List<Expense> incomeOutcomes = expenseService.getAllByKind(kind);

        return ResponseEntity.status(HttpStatus.OK).body(incomeOutcomes);
    }

    //수입&지출내역 건별 조회
    @GetMapping("/getExpenseById/{id}")
    public ResponseEntity<Expense> getExpenseById(@PathVariable String id) {
        Expense expense = expenseService.getExpenseById(id);

        return ResponseEntity.status(HttpStatus.OK).body(expense);
    }

    //수입&지출내역 저장
    @PostMapping("/save")
    public ResponseEntity<String> saveExpense(@RequestBody Expense incomeOutcome) {
        //id 생성 및 setting
        String uuid = uuidUtil.getUUID();
        incomeOutcome.setId(uuid);

        String message = expenseService.saveExpense(incomeOutcome);

        return ResponseEntity.status(HttpStatus.OK).body(message);
    }

    //수입&지출내역 수정
    @PatchMapping("/update/{id}")
    public ResponseEntity<String> updateExpense(@PathVariable("id") String id, @RequestBody Expense expense) {
        String message = expenseService.updateExpense(id, expense);

        return ResponseEntity.status(HttpStatus.OK).body(message);
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity<String> deleteExpenseById(@PathVariable("id") String id) {
        String message = expenseService.deleteExpenseById(id);

        return ResponseEntity.status(HttpStatus.OK).body(message);
    }
}
