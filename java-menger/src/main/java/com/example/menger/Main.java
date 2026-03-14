package com.example.menger;

import java.io.OutputStream;
import java.net.ServerSocket;
import java.net.Socket;

public class Main {

    public static void main(String[] args) throws Exception {

        ServerSocket server = new ServerSocket(8088);

        System.out.println("Java server running on port 8088");

        while (true) {
            Socket socket = server.accept();
            System.out.println("Connection received");

            String json = "{ \"java-menger\": { " +
                    "\"package_manager\": \"maven\", " +
                    "\"dependency_file\": \"pom.xml\", " +
                    "\"source_code\": \"src/main/java/com/example/menger/Main.java\", " +
                    "\"runtime\": \"Java Virtual Machine\" }}";

            String response =
                    "HTTP/1.1 200 OK\r\n" +
                    "Content-Type: application/json\r\n" +
                    "Content-Length: " + json.length() + "\r\n\r\n" +
                    json;

            OutputStream out = socket.getOutputStream();
            out.write(response.getBytes());
            out.flush();

            socket.close();
        }
    }
}