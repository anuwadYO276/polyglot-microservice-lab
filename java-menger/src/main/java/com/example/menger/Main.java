package com.example.menger;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@SpringBootApplication
@RestController
public class Main {

    @GetMapping("/")
    public Map<String,Object> info() {

        return Map.of(
            "java-menger", Map.of(
                "package_manager","maven",
                "dependency_file","pom.xml",
                "source_code","src/main/java/com/example/menger/Main.java",
                "runtime","Java Virtual Machine (JVM)"
            )
        );

    }

    public static void main(String[] args) {
        SpringApplication.run(Main.class, args);
    }
}