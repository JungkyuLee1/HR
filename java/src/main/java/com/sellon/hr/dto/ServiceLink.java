package com.sellon.hr.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class ServiceLink {
    private String id;
    private String task;
    private int seq;
    private String title;
    private String url;
    private String userName;
    private String pwd;
    private String content;
    private String remark;
    private String activeYn;
    private LocalDateTime createdAt;
    private String createdBy;
    private LocalDateTime updatedAt;
    private String updatedBy;
}
