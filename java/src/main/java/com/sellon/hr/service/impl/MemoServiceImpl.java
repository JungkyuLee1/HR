package com.sellon.hr.service.impl;

import com.sellon.hr.common.exception.CustomException;
import com.sellon.hr.dto.Expense;
import com.sellon.hr.dto.Memo;
import com.sellon.hr.mapper.MemoMapper;
import com.sellon.hr.service.MemoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MemoServiceImpl implements MemoService {

    @Autowired
    private MemoMapper memoMapper;

    @Override
    public Memo getMemo() {
        Memo memo=memoMapper.getMemo();
        return memo;
    }

    @Override
    public Memo getMemoById(String id) {
        Memo memo=memoMapper.getMemoById(id);
        return memo;
    }

    @Override
    public String saveMemo(Memo memo) {
        String message;
        int statusCode = memoMapper.saveMemo(memo);

        if (statusCode == 1) {
            message = "success";
        } else {
            message = "fail";
        }

        return message;
    }

    @Override
    public String updateMemo(String id, Memo memo) {
        String message;
        int statusCode = memoMapper.updateMemo(id, memo);

        if (statusCode == 1) {
            message = "success";
        } else {
            message = "fail";
        }

        return message;
    }
}
