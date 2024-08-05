package com.sellon.hr.mapper;

import com.sellon.hr.dto.Code;
import com.sellon.hr.dto.Expense;
import com.sellon.hr.dto.OperationCost;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ExpenseMapper {

    public List<Code> getUnitCode();

    public List<Expense> getAllByKind(String kinds);

    public Expense getExpenseById(String id);

    public int saveExpense(Expense expense);

    public int updateExpense(String id, Expense exp);

    public int deleteExpenseById(String id);
}
