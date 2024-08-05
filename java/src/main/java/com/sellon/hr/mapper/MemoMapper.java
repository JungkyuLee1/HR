package com.sellon.hr.mapper;

import com.sellon.hr.dto.Code;
import com.sellon.hr.dto.Employee;
import com.sellon.hr.dto.Memo;
import com.sellon.hr.dto.RoleCount;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface MemoMapper {

    public Memo getMemo();
    public Memo getMemoById(String id);
    public int saveMemo(Memo memo);
    public int updateMemo(String id, Memo memo);
}
