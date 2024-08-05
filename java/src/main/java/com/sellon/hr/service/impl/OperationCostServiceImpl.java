package com.sellon.hr.service.impl;//package com.sellon.hr.service.impl;

import com.sellon.hr.controller.OperationCostController;
import com.sellon.hr.dto.Code;
import com.sellon.hr.dto.OperationCost;
import com.sellon.hr.mapper.OperationCostMapper;
import com.sellon.hr.service.OperationCostService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OperationCostServiceImpl implements OperationCostService {
    private final Logger LOGGER = (Logger) LoggerFactory.getLogger(OperationCostController.class);

    @Autowired
    private OperationCostMapper operationCostMapper;

    @Override
    public List<Code> getCostCodes() {
        List<Code> codes = operationCostMapper.getCostCodes();
        return codes;
    }

    @Override
    public List<OperationCost> getAllOperationCost() {
        List<OperationCost> operationCosts = operationCostMapper.getAllOperationCost();
        return operationCosts;
    }

    @Override
    public OperationCost getOperationCostById(String id) {
        OperationCost operationCost = operationCostMapper.getOperationCostById(id);
        return operationCost;
    }

    @Override
    public String saveOperationCost(OperationCost operationCost) {
        String message;
        int statusCode = operationCostMapper.saveOperationCost(operationCost);

        if (statusCode == 1) {
            message = "success";
        } else {
            message = "fail";
        }

        return message;
    }

    @Override
    public String updateOperationCost(String id, OperationCost operationCost) {
        String message;
        int statusCode = operationCostMapper.updateOperationCost(id, operationCost);

//        LOGGER.info("updateOperationCost : {}", statusCode);

        if (statusCode == 1) {
            message = "success";
        } else {
            message = "fail";
        }
        return message;
    }

    @Override
    public String deleteOperationCostById(String id) {
        String message;
        int statusCode = operationCostMapper.deleteOperationCostById(id);

        if (statusCode == 1) {
            message = "deleted";
        } else {
            message = "fail";
        }
        return message;
    }
}
