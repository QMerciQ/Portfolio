package com.leadlink.crm.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
@Slf4j
public class HomeWebController {

    @GetMapping({"/", "/index.html"})
    public String showHome(){
        return "index";
    }

    @GetMapping({"/signin"})
    public String showSignin(){
        return "signin";
    }

    @GetMapping({"/signup"})
    public String showSignup(){
        return "signup";
    }

}
