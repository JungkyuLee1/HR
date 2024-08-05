package com.sellon.hr.controller;

import com.sellon.hr.dto.Code;
import com.sellon.hr.dto.Employee;
import com.sellon.hr.dto.RoleCount;
import com.sellon.hr.service.EmployeeService;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@RestController
@RequestMapping(value = "/sellonhr/api")
public class EmployeeController {
    private final Logger LOGGER = (Logger) LoggerFactory.getLogger(EmployeeController.class);

    @Autowired
    private EmployeeService employeeService;

    //Code 조회(직원정보)
    @GetMapping("/getEmpCodes")
    public ResponseEntity<List<Code>> getEmpCodes() {
        List<Code> codes = employeeService.getEmpCodes();

        return ResponseEntity.status(HttpStatus.OK).body(codes);
    }
//
    @GetMapping("/getCode/{type}")
    public ResponseEntity<List<Code>> getCodeByType(@PathVariable String type) {
        List<Code> codes = employeeService.getCodeByType(type);

        return ResponseEntity.status(HttpStatus.OK).body(codes);
    }

    @GetMapping("/getAllEmployee")
    public ResponseEntity<List<Employee>> getAllEmployee() {
        List<Employee> employees = employeeService.getAllEmployee();

        return ResponseEntity.status(HttpStatus.OK).body(employees);
    }

    //직원정보 조회
    @GetMapping("/getEmployeeById/{id}")
    public ResponseEntity<Employee> getEmployeeById(@PathVariable String id) {
        Employee employee = employeeService.getEmployeeById(id);

        return ResponseEntity.status(HttpStatus.OK).body(employee);
    }

    //Role별 인원수 count
    @GetMapping("/getRoleCountForAll")
    public ResponseEntity<List<RoleCount>> getRoleCountForAll() {
        List<RoleCount> roleCounts = employeeService.getRoleCountForAll();

        return ResponseEntity.status(HttpStatus.OK).body(roleCounts);
    }

    //직원정보 저장
    @PostMapping("/saveEmployee") //MultiValueMap
    public ResponseEntity<String> saveEmployee(@RequestParam(value = "jsonString") String employeeString, @RequestPart(value = "files") List<MultipartFile> photos) throws Exception, ParseException {
        //json-simple Library 활용 (1.String으로 받고 -> 2.Json object로 변환 후 -> 3.Dto로 최종 변환), Flutter(user model의 toJson() datetime->String 변환)

        JSONParser parser = new JSONParser();
        Object obj = parser.parse(employeeString);
        JSONObject jsonObj = (JSONObject) obj;
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss");
//        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:m  m:ss.SSS");
//        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSZ");

        Employee employee = new Employee(jsonObj.get("id").toString(), jsonObj.get("name").toString(), jsonObj.get("imageUrl").toString(), jsonObj.get("role").toString(), LocalDateTime.parse((CharSequence) jsonObj.get("entryDate"), formatter), jsonObj.get("hireType").toString() ,Double.parseDouble(jsonObj.get("career").toString()), Integer.parseInt(jsonObj.get("salary").toString()), jsonObj.get("unit").toString(), jsonObj.get("skill").toString(), jsonObj.get("hp").toString(), jsonObj.get("email").toString(), LocalDateTime.parse((CharSequence) jsonObj.get("birthDate"), formatter), jsonObj.get("marital").toString(), jsonObj.get("family").toString(), jsonObj.get("bank").toString(), jsonObj.get("bankAccount").toString(), jsonObj.get("remark").toString(), jsonObj.get("activeYn").toString(), LocalDateTime.parse((CharSequence) jsonObj.get("createdAt"), formatter), jsonObj.get("createdBy").toString(), LocalDateTime.parse((CharSequence) jsonObj.get("updatedAt"), formatter), jsonObj.get("updatedBy").toString());

        String message = employeeService.saveEmployee(employee, photos);
        return ResponseEntity.status(HttpStatus.OK).body(message);
    }
//
    //직원정보 수정
    @PostMapping("/updateEmployee")
    public ResponseEntity<String> updateEmployee(@RequestParam(value = "jsonString") String employeeString, @RequestPart(value = "files") List<MultipartFile> photos) throws Exception, ParseException {

        JSONParser parser = new JSONParser();
        Object obj = parser.parse(employeeString);
        JSONObject jsonObj = (JSONObject) obj;
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss");

//        LOGGER.info("id:{}", jsonObj.get("id"));
//        LOGGER.info("photo:{}", photos.get(0).getOriginalFilename());
//        LOGGER.info("employee.imageUrl:{}", jsonObj.get("imageUrl").toString());

        LOGGER.info("employee :{}", jsonObj);
        Employee employee = new Employee(jsonObj.get("id").toString(), jsonObj.get("name").toString(), jsonObj.get("imageUrl").toString(), jsonObj.get("role").toString(), LocalDateTime.parse((CharSequence) jsonObj.get("entryDate"), formatter), jsonObj.get("hireType").toString(), Double.parseDouble(jsonObj.get("career").toString()), Integer.parseInt(jsonObj.get("salary").toString()), jsonObj.get("unit").toString(), jsonObj.get("skill").toString(), jsonObj.get("hp").toString(), jsonObj.get("email").toString(), LocalDateTime.parse((CharSequence) jsonObj.get("birthDate"), formatter), jsonObj.get("marital").toString(), jsonObj.get("family").toString(), jsonObj.get("bank").toString(), jsonObj.get("bankAccount").toString(), jsonObj.get("remark").toString(), jsonObj.get("activeYn").toString(), LocalDateTime.parse((CharSequence) jsonObj.get("createdAt"), formatter), jsonObj.get("createdBy").toString(), LocalDateTime.parse((CharSequence) jsonObj.get("updatedAt"), formatter), jsonObj.get("updatedBy").toString());

        String message = employeeService.updateEmployee(employee, photos);
//        LOGGER.info("employeeMsg :{}", message);
        return ResponseEntity.status(HttpStatus.OK).body(message);
    }

    //직원정보 삭제(active_yn='N')
    @DeleteMapping("/delete/{id}")
    public ResponseEntity<String> deleteEmployeeById(@PathVariable("id") String id) {
        String message = employeeService.deleteEmployeeById(id);

        return ResponseEntity.status(HttpStatus.OK).body(message);
    }
//
    //직원 사진 조회
    @GetMapping("/getProfileImage")
    public ResponseEntity<Resource> getProfileImage(@RequestParam("fileName") String fileName) {
//        String path = System.getPropertyrty("user.dir") + "/src/main/resources/static/files/";
        String path = System.getProperty("user.dir") + "//sellon//";
        String folder = "photo/";

        Resource resource = new FileSystemResource(path + folder + fileName);
        if (!resource.exists()) {
            return new ResponseEntity<Resource>(HttpStatus.NOT_FOUND);
        }

        //Header 없이도 가능 (Header 없으면 client에서 파일 깨짐 현상)
        HttpHeaders header = new HttpHeaders();
        Path filePath = null;
        try {
            filePath = Paths.get(path + folder + fileName);
            header.add("Content-type", Files.probeContentType(filePath));
        } catch (IOException e) {
            e.printStackTrace();
            ;
        }

        return new ResponseEntity<Resource>(resource, header, HttpStatus.OK);
//        return new ResponseEntity<Resource>(resource, HttpStatus.OK);
    }
//
//
//
//    //직원정보 저장 (test only)
//    @PostMapping("/saveEmployee")
//    public ResponseEntity<String> saveEmployee(@RequestParam Map<String, String> info, @RequestPart(value = "photos") List<MultipartFile> photos) throws  Exception, ParseException {
////        LOGGER.info("info : {}", info);
//        LOGGER.info("fileSize : {}", photos.size());
//
//
////        Employee employee = new Employee();
////        String message = employeeService.saveEmployee(employee, photos);
//
//        return ResponseEntity.status(HttpStatus.OK).body("message");
//    }
}
