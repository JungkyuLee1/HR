package com.sellon.hr.service.impl;

import com.sellon.hr.dto.Code;
import com.sellon.hr.dto.DevSchedule;
import com.sellon.hr.mapper.DevScheduleMapper;
import com.sellon.hr.service.DevScheduleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DevScheduleServiceImpl implements DevScheduleService {

    @Autowired
    private DevScheduleMapper devScheduleMapper;

    @Override
    public List<Code> getDevCodes() {
        List<Code> codes = devScheduleMapper.getDevCodes();
        return codes;
    }

    @Override
    public List<DevSchedule> getAllByTitleAndStatus(String title, String status) {
        List<DevSchedule> devSchedules = devScheduleMapper.getAllByTitleAndStatus(title, status);
        return devSchedules;
    }

    @Override
    public DevSchedule getDevScheduleById(String id) {
        DevSchedule devSchedule = devScheduleMapper.getDevScheduleById(id);
        return devSchedule;
    }

    @Override
    public String saveDevSchedule(DevSchedule devSchedule) {
        String message;
        int statusCode = devScheduleMapper.saveDevSchedule(devSchedule);

        if (statusCode == 1) {
            message = "success";
        } else {
            message = "fail";
        }

        return message;
    }

    @Override
    public String updateDevSchedule(String id, DevSchedule devSchedule) {
        String message;
        int statusCode = devScheduleMapper.updateDevSchedule(id, devSchedule);

        if (statusCode == 1) {
            message = "success";
        } else {
            message = "fail";
        }
        return message;
    }

    @Override
    public String deleteDevScheduleById(String id) {
        String message;
        int statusCode = devScheduleMapper.deleteDevScheduleById(id);

        if (statusCode == 1) {
            message = "deleted";
        } else {
            message = "fail";
        }
        return message;
    }
}
