package com.sellon.hr.mapper;

import com.sellon.hr.dto.ServiceLink;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ServiceLinkMapper {
    public List<ServiceLink> getAllServiceLink();
}
