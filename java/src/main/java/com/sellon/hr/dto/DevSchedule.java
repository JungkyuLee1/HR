package com.sellon.hr.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class DevSchedule {
    private String id;
    private String title;
    private String detail;
    private String nation;
    private String completeStatus;
    private String devPeriodKind;
    private String activeYn;
    private LocalDateTime createdAt;
    private String createdBy;
    private LocalDateTime updatedAt;
    private String updatedBy;
}