package com.sellon.hr.mapper;

import com.sellon.hr.dto.Code;
import com.sellon.hr.dto.DevSchedule;
import com.sellon.hr.dto.Expense;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface DevScheduleMapper {
    public List<Code> getDevCodes();
    public List<DevSchedule> getAllByTitleAndStatus(String title, String status);
    public DevSchedule getDevScheduleById(String id);
    public int saveDevSchedule(DevSchedule devSchedule);
    public int updateDevSchedule(String id, DevSchedule devSch);
    public int deleteDevScheduleById(String id);
}