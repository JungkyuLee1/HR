package com.sellon.hr.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class Expense {
    private String id;
    private String kind;
    private LocalDateTime inOutcomeDate;
    private String item;
    private int amount;
    private String unit;
    private String remark;
    private String activeYn;
    private LocalDateTime createdAt;
    private String createdBy;
    private LocalDateTime updatedAt;
    private String updatedBy;
}
