package com.sellon.hr.service;


import com.sellon.hr.common.exception.CustomException;
import com.sellon.hr.dto.Code;
import com.sellon.hr.dto.Employee;
import com.sellon.hr.dto.RoleCount;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface EmployeeService {
    public List<Code> getEmpCodes();

    public List<Code> getCodeByType(String type);

    public List<Employee> getAllEmployee();

    public Employee getEmployeeById(String id);

    public List<RoleCount> getRoleCountForAll();

    public String saveEmployee(Employee employee, List<MultipartFile> photos);

    public String updateEmployee(Employee employee, List<MultipartFile> photos) throws CustomException;

    public String deleteEmployeeById(String id);
}
