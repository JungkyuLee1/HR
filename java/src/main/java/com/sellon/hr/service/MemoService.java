package com.sellon.hr.service;

import com.sellon.hr.common.exception.CustomException;
import com.sellon.hr.dto.Code;
import com.sellon.hr.dto.Employee;
import com.sellon.hr.dto.Memo;
import com.sellon.hr.dto.RoleCount;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface MemoService {
    public Memo getMemo();
    public Memo getMemoById(String id);
    public String saveMemo(Memo memo);
    public String updateMemo(String id, Memo memo);
}
