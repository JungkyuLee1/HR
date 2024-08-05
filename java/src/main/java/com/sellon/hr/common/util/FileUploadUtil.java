package com.sellon.hr.common.util;

import com.sellon.hr.dto.Photo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

@Component
public class FileUploadUtil {
    private final Logger LOGGER = (Logger) LoggerFactory.getLogger(FileUploadUtil.class);

    @Autowired
    private UuidUtil uuidUtil;

    //사진 업로드
    public ArrayList<Photo> uploadFiles(String uuid, List<MultipartFile> files, String folder) throws Exception {
//        String projectPath = System.getProperty("user.dir") + "/src/main/resources/static/files/" + folder;
        String projectPath = System.getProperty("user.dir") + "//sellon//"+folder;

        int seq = 0;
        ArrayList<Photo> photos = new ArrayList<>();

        try {
            for (MultipartFile file : files) {
                seq++;
                String fileName = file.getOriginalFilename();
                String fileUrl = uuid + "_" +  seq + "_"+ fileName;

                File saveFile = new File(projectPath, fileUrl);
                file.transferTo(saveFile);

                Photo photo = new Photo();
                photo.setId(uuid);
                photo.setPhotoName(fileName);
                photo.setPhotoUrl(fileUrl);

                photos.add(photo);
            }
        } catch (Exception e) {
            LOGGER.info("HR Exception : {}", e.toString());
        }
        return photos;
    }
}
