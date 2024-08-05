package com.sellon.hr.common.util;

import com.sellon.hr.common.Constants;
import com.sellon.hr.common.exception.CustomException;
import com.sellon.hr.service.impl.EmployeeServiceImpl;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.nio.file.*;

@Component
public class FileDeleteUtil {
    private final Logger LOGGER = (Logger) LoggerFactory.getLogger(EmployeeServiceImpl.class);

    public void deleteFile(String fileUrl, String folder) throws CustomException {
        String message = "";
        String projectPath = System.getProperty("user.dir") + "/src/main/resources/static/files/" + folder;
//        String projectPath = System.getProperty("user.dir") + "//sellon//" + folder;
        Path filePath = Paths.get(projectPath + "/" + fileUrl);
        //추가
//        Path path = Paths.get(projectPath + "/");

        try {
            //동일 기능
//            DirectoryStream<Path> newDirectoryStream = Files.newDirectoryStream(path, fileUrl.substring(0,35)+"*");
//            for(final Path newDirectoryStreamItem : newDirectoryStream){
//                LOGGER.info("fileUrl : {}", newDirectoryStreamItem);
//                Files.delete(newDirectoryStreamItem);
//            }

            Files.delete(filePath);
        } catch (NoSuchFileException e) {
            throw new CustomException(Constants.ExceptionClass.EMPLOYEE, HttpStatus.BAD_REQUEST, "FileDeleteUtil : NoSuchFileException");
        } catch (DirectoryNotEmptyException e) {
            throw new CustomException(Constants.ExceptionClass.EMPLOYEE, HttpStatus.BAD_REQUEST, "FileDeleteUtil : DirectoryNotEmpty");
        } catch (IOException e) {
            throw new CustomException(Constants.ExceptionClass.EMPLOYEE, HttpStatus.BAD_REQUEST, "FileDeleteUtil : IOException");
        } catch (Exception e) {
            throw e;
        }
    }

}
