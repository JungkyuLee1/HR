package com.sellon.hr.mapper;


import com.sellon.hr.dto.Code;
import com.sellon.hr.dto.Employee;
import com.sellon.hr.dto.RoleCount;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface EmployeeMapper {
    public List<Code> getEmpCodes();

    public List<Code> getCodeByType(String type);

    public List<Employee> getAllEmployee();

    public Employee getEmployeeById(String id);

    public List<RoleCount> getRoleCountForAll();

    public int saveEmployee(Employee employee);

    public int updateEmployee(Employee employee);

    public int deleteEmployeeById(String id);
}
