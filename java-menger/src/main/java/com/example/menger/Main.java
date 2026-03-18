package com.example.menger;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import jakarta.annotation.PostConstruct;
import jakarta.servlet.http.HttpServletRequest;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Map;

@SpringBootApplication
@RestController
public class Main {

    // ===== LOG FUNCTION =====
    private void writeLog(String message) {
        String today = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));
        String logDir = "/logs/" + today;

        File dir = new File(logDir);
        if (!dir.exists()) {
            dir.mkdirs();
        }

        String logFile = logDir + "/log.txt";
        String timestamp = LocalDateTime.now().toString();
        String logLine = "[" + timestamp + "] " + message + "\n";

        try (FileWriter fw = new FileWriter(logFile, true)) {
            fw.write(logLine);
        } catch (IOException e) {
            System.out.println("Log error: " + e.getMessage());
        }
    }

    // ===== START LOG =====
    @PostConstruct
    public void init() {
        writeLog("Java Spring Boot server started");
    }

    // ===== ROUTE =====
    @GetMapping("/")
    public Map<String,Object> info(HttpServletRequest request) {

        String ip = request.getRemoteAddr();
        writeLog("Request from " + ip + " GET /");

        Map<String, Object> response = Map.of(
            "java-menger", Map.of(
                "package_manager","maven",
                "dependency_file","pom.xml",
                "source_code","src/main/java/com/example/menger/Main.java",
                "runtime","Java Virtual Machine (JVM)"
            )
        );

        writeLog("Response status 200");

        return response;
    }

    public static void main(String[] args) {
        SpringApplication.run(Main.class, args);
    }
}