package com.sellon.hr.service;//package com.sellon.hr.service;

import com.sellon.hr.dto.Code;
import com.sellon.hr.dto.OperationCost;

import java.util.List;

public interface OperationCostService {
    public List<Code> getCostCodes();
    public List<OperationCost> getAllOperationCost();
    public OperationCost getOperationCostById(String id);
    public String saveOperationCost(OperationCost operationCost);
    public String updateOperationCost(String id, OperationCost operationCost);
    public String deleteOperationCostById(String id);
}

