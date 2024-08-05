package com.sellon.hr.service.impl;

import com.sellon.hr.dto.ServiceLink;
import com.sellon.hr.mapper.ServiceLinkMapper;
import com.sellon.hr.service.ServiceLinkService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ServiceLinkServiceImpl implements ServiceLinkService {
    @Autowired
    private ServiceLinkMapper serviceLinkMapper;

    @Override
    public List<ServiceLink> getAllServiceLink() {
        List<ServiceLink> serviceLinks=serviceLinkMapper.getAllServiceLink();
        return serviceLinks;
    }
}
