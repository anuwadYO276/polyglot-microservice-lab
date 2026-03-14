use std::io::{Read, Write};
use std::net::TcpListener;

use serde::Serialize;

#[derive(Serialize)]
struct Service {
    package_manager: String,
    dependency_file: String,
    source_code: String,
    runtime: String,
}

#[derive(Serialize)]
struct Response {
    rust_menger: Service,
}

fn main() {
    let listener = TcpListener::bind("0.0.0.0:8087").unwrap();

    println!("Rust server running on port 8087");

    for stream in listener.incoming() {
        let mut stream = stream.unwrap();

        let mut buffer = [0; 1024];
        stream.read(&mut buffer).unwrap();

        println!("Connection received");

        let data = Response {
            rust_menger: Service {
                package_manager: "cargo".to_string(),
                dependency_file: "Cargo.toml".to_string(),
                source_code: "src/main.rs".to_string(),
                runtime: "OS executable file".to_string(),
            },
        };

        let json_data = serde_json::to_string(&data).unwrap();

        let response = format!(
            "HTTP/1.1 200 OK\r\nContent-Type: application/json\r\nContent-Length: {}\r\n\r\n{}",
            json_data.len(),
            json_data
        );

        stream.write_all(response.as_bytes()).unwrap();
    }
}