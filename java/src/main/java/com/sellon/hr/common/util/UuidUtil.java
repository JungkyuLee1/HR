package com.sellon.hr.common.util;

import org.springframework.stereotype.Component;

import java.util.UUID;

@Component
public class UuidUtil {
    public String getUUID() {
        return UUID.randomUUID().toString();
    }
}
