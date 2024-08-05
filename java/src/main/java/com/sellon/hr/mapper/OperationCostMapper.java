package com.sellon.hr.mapper;//package com.sellon.hr.mapper;

import com.sellon.hr.dto.Code;
import com.sellon.hr.dto.OperationCost;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface OperationCostMapper {
    public List<Code> getCostCodes();

    public List<OperationCost> getAllOperationCost();

    public OperationCost getOperationCostById(String id);

    public int saveOperationCost(OperationCost operationCost);

    public int updateOperationCost(String id, OperationCost opCost);
    public int deleteOperationCostById(String id);
}
