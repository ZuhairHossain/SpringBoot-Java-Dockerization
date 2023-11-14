package com.example;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class DemoController {
    
    @GetMapping("/greeting")
    public String greeting() {
        return "hello world\n";
    }
 
     @GetMapping("/")
    public String index() {
        return "Java-Tracing\n";
    }
}
