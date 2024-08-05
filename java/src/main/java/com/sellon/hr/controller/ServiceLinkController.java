package com.sellon.hr.controller;

import com.sellon.hr.dto.ServiceLink;
import com.sellon.hr.service.ServiceLinkService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping(value = "/sellonhr/api/serviceLink")
public class ServiceLinkController {
    private final Logger LOGGER = (Logger) LoggerFactory.getLogger(ServiceLinkController.class);

    @Autowired
    private ServiceLinkService serviceLinkService;

    @GetMapping("/getAllServiceLink")
    public ResponseEntity<List<ServiceLink>> getAllServiceLink() {
        List<ServiceLink> serviceLinks = serviceLinkService.getAllServiceLink();

        return ResponseEntity.status(HttpStatus.OK).body(serviceLinks);
    }
}
