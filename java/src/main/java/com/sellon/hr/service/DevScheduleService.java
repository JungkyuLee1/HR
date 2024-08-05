package com.sellon.hr.service;

import com.sellon.hr.dto.Code;
import com.sellon.hr.dto.DevSchedule;

import java.util.List;

public interface DevScheduleService {

    public List<Code> getDevCodes();
    public List<DevSchedule> getAllByTitleAndStatus(String title, String status);
    public DevSchedule getDevScheduleById(String id);
    public String saveDevSchedule(DevSchedule devSchedule);
    public String updateDevSchedule(String id, DevSchedule devSchedule);
    public String deleteDevScheduleById(String id);
}
