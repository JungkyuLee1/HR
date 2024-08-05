package com.sellon.hr.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDateTime;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Employee {
    private String id;
    private String name;
    private String imageUrl;
    private String role;
    private LocalDateTime entryDate;
    private String hireType;
    private double career;
    private int salary;
    private String unit;
    private String skill;
    private String hp;
    private String email;
    private LocalDateTime birthDate;
    private String marital;
    private String family;
    private String bank;
    private String bankAccount;
    private String remark;
    private String activeYn;
    private LocalDateTime createdAt;
    private String createdBy;
    private LocalDateTime updatedAt;
    private String updatedBy;
}
