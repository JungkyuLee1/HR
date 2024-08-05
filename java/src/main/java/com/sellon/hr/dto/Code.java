package com.sellon.hr.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Code {
    private String type;
    private String code;
    private String name;
    private int seq;
}
