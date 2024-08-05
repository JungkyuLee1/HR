package com.sellon.hr.service.impl;

import com.sellon.hr.common.exception.CustomException;
import com.sellon.hr.common.util.FileDeleteUtil;
import com.sellon.hr.common.util.FileUploadUtil;
import com.sellon.hr.common.util.UuidUtil;
import com.sellon.hr.dto.Code;
import com.sellon.hr.dto.Employee;
import com.sellon.hr.dto.Photo;
import com.sellon.hr.dto.RoleCount;
import com.sellon.hr.mapper.EmployeeMapper;
import com.sellon.hr.service.EmployeeService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Service
public class EmployeeServiceImpl implements EmployeeService {

    private final Logger LOGGER = (Logger) LoggerFactory.getLogger(EmployeeServiceImpl.class);
    @Autowired
    private EmployeeMapper empMapper;

    @Autowired
    private FileUploadUtil fileUploadUtil;

    @Autowired
    private FileDeleteUtil fileDeleteUtil;

    @Autowired
    private UuidUtil uuidUtil;

    //Code 불러오기

    @Override
    public List<Code> getEmpCodes() {
        List<Code> codes = empMapper.getEmpCodes();
        return codes;
    }

    @Override
    public List<Code> getCodeByType(String type) {
        List<Code> codes = empMapper.getCodeByType(type);
        return codes;
    }

    @Override
    public List<Employee> getAllEmployee() {
        List<Employee> employees = empMapper.getAllEmployee();
        return employees;
    }

    //직원정보 조회
    @Override
    public Employee getEmployeeById(String id) {
        Employee employee = empMapper.getEmployeeById(id);
        return employee;
    }

    @Override
    public List<RoleCount> getRoleCountForAll() {
        List<RoleCount> roleCounts = empMapper.getRoleCountForAll();
        return roleCounts;
    }

    //직원정보 저장(사진포함)
    @Transactional(rollbackFor = Exception.class)
    @Override
    public String saveEmployee(Employee employee, List<MultipartFile> files) {
        String fileName = files.get(0).getOriginalFilename();
        String photoUrl = "";
        String uuid = "";
        String message;

        //1.id 생성
        uuid = uuidUtil.getUUID();
        //2.File Upload (Mobile에서 empty file을 생성하여 넘김-첨부 Photo가 없는 경우)
        if (!fileName.equals("empty")) {
            try {
                List<Photo> photos = fileUploadUtil.uploadFiles(uuid, files, "photo");
                photoUrl = photos.get(0).getPhotoUrl();
            } catch (Exception e) {
                LOGGER.info("Exception(FileUpload) : {}", e.toString());
            }
        }

        //3.id setting
        employee.setId(uuid);
        employee.setImageUrl(photoUrl);

        //3.직원 세부정보 입력
        int statusCode = empMapper.saveEmployee(employee);
        if (statusCode == 1) {
            message = "success";
        } else {
            message = "fail";
        }
        return message;
    }

    //직원정보 수정
    @Transactional(rollbackFor = Exception.class)
    @Override
    public String updateEmployee(Employee employee, List<MultipartFile> files) throws CustomException {
        String fileName = files.get(0).getOriginalFilename();
        String photoUrl = "";
        String message;

//        LOGGER.info("files.length(update) : {}", files.size());
//        LOGGER.info("employee.getImageUrl()(update) : {}", employee.getImageUrl());
        //신규 사진 선택 & 기존의 파일(Mobile에서 imageUrl 받아온 상태)이 있으면 삭제
        if (!fileName.equals("empty") && !fileName.isEmpty() && (!employee.getImageUrl().isEmpty() && employee.getImageUrl() !=null)){
            try {
                //File (기존 것) 삭제 처리
                fileDeleteUtil.deleteFile(employee.getImageUrl(), "photo");
            } catch (CustomException e) {
                throw e;
            }
        }


        //1.File Upload (Mobile에서 empty file을 생성하여 넘김-첨부 Photo가 없는 경우)
        if (!fileName.equals("empty") && !fileName.isEmpty()) {
            try {
                List<Photo> photos = fileUploadUtil.uploadFiles(employee.getId(), files, "photo");
                photoUrl = photos.get(0).getPhotoUrl();
            } catch (Exception e) {
                LOGGER.info("Exception(FileUpload) : {}", e.toString());
            }
        }

        //2.변경 된 photoUrl setting(첨부된 파일이 없으면 imageUrl==""이므로 Table update도 없음)
        employee.setImageUrl(photoUrl);

        //3.직원 세부정보 입력
        int statusCode = empMapper.updateEmployee(employee);
        if (statusCode == 1) {
            message = "success";
        } else {
            message = "fail";
        }
        return message;
    }

    //직원정보 삭제
    @Override
    public String deleteEmployeeById(String id) {
        String message;

        int statusCode = empMapper.deleteEmployeeById(id);
        if (statusCode > 0) {
            message = "deleted";
        } else {
            message = "fail";
        }
        return message;
    }
}


