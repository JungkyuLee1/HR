package com.sellon.hr.service;

import com.sellon.hr.dto.Code;
import com.sellon.hr.dto.Expense;

import java.util.List;

public interface ExpenseService {
    public List<Code> getUnitCode();
    public List<Expense> getAllByKind(String kind);
    public Expense getExpenseById(String id);
    public String saveExpense(Expense expense);
    public String updateExpense(String id, Expense expense);
    public String deleteExpenseById(String id);
}
