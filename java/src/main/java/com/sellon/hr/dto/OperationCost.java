package com.sellon.hr.dto;//package com.sellon.hr.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class OperationCost {
    private String id;
    private String serviceName;
    private String serviceKind;
    private LocalDateTime paymentDate;
    private LocalDateTime expiryDate;
    private LocalDateTime dueDate;
    private String paymentInterval;
    private String renewMethod;
    private String amount;
    private String paymentUnit;
    private String paymentCard;
    private String email;
    private String remark;
    private String activeYn;
    private LocalDateTime createdAt;
    private String createdBy;
    private LocalDateTime updatedAt;
    private String updatedBy;
}