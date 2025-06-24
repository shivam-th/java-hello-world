package com.example.java_hello_world;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class MyClass {

    @GetMapping("/")
    public String sayHello(){
        return "Hello World";
    }
}
