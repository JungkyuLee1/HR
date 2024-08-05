package com.sellon.hr.service.impl;

import com.sellon.hr.dto.Code;
import com.sellon.hr.dto.Expense;
import com.sellon.hr.dto.OperationCost;
import com.sellon.hr.mapper.ExpenseMapper;
import com.sellon.hr.service.ExpenseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ExpenseServiceImpl implements ExpenseService {

    @Autowired
    private ExpenseMapper expenseMapper;


    @Override
    public List<Code> getUnitCode() {
        List<Code> codes = expenseMapper.getUnitCode();
        return codes;
    }

    @Override
    public List<Expense> getAllByKind(String kind) {
        List<Expense> expenses = expenseMapper.getAllByKind(kind);

        return expenses;
    }

    @Override
    public Expense getExpenseById(String id) {
        Expense expense = expenseMapper.getExpenseById(id);
        return expense;
    }

    @Override
    public String saveExpense(Expense expense) {
        String message;
        int statusCode = expenseMapper.saveExpense(expense);

        if (statusCode == 1) {
            message = "success";
        } else {
            message = "fail";
        }
        return message;
    }

    @Override
    public String updateExpense(String id, Expense expense) {
        String message;
        int statusCode = expenseMapper.updateExpense(id, expense);

        if (statusCode == 1) {
            message = "success";
        } else {
            message = "fail";
        }

        return message;
    }

    @Override
    public String deleteExpenseById(String id) {
        String message;
        int statusCode = expenseMapper.deleteExpenseById(id);

        if (statusCode == 1) {
            message = "deleted";
        } else {
            message = "fail";
        }
        return message;
    }
}
