use std::fs::{OpenOptions, create_dir_all};
use std::io::{Read, Write};
use std::net::TcpListener;

use serde::Serialize;
use chrono::Local;

// ====== LOG FUNCTION ======
fn write_log(message: &str) {
    let today = Local::now().format("%Y%m%d").to_string();
    let log_dir = format!("/logs/{}", today);

    // สร้าง folder ถ้ายังไม่มี
    if let Err(e) = create_dir_all(&log_dir) {
        eprintln!("Create log dir error: {}", e);
        return;
    }

    let log_file = format!("{}/log.txt", log_dir);

    let mut file = match OpenOptions::new()
        .create(true)
        .append(true)
        .open(&log_file)
    {
        Ok(f) => f,
        Err(e) => {
            eprintln!("Open log file error: {}", e);
            return;
        }
    };

    let timestamp = Local::now().to_rfc3339();
    let log_line = format!("[{}] {}\n", timestamp, message);

    if let Err(e) = file.write_all(log_line.as_bytes()) {
        eprintln!("Write log error: {}", e);
    }
}

// ====== DATA STRUCT ======
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

// ====== MAIN ======
fn main() {
    let listener = TcpListener::bind("0.0.0.0:8087").unwrap();

    println!("Rust server running on port 8087");
    write_log("Server started on port 8087");

    for stream in listener.incoming() {
        let mut stream = match stream {
            Ok(s) => s,
            Err(e) => {
                write_log(&format!("Connection failed: {}", e));
                continue;
            }
        };

        write_log("Connection received");

        let mut buffer = [0; 1024];

        match stream.read(&mut buffer) {
            Ok(_) => {
                let request = String::from_utf8_lossy(&buffer);
                write_log(&format!("Request: {}", request));
            }
            Err(e) => {
                write_log(&format!("Read error: {}", e));
                continue;
            }
        }

        let data = Response {
            rust_menger: Service {
                package_manager: "cargo".to_string(),
                dependency_file: "Cargo.toml".to_string(),
                source_code: "src/main.rs".to_string(),
                runtime: "OS executable file".to_string(),
            },
        };

        let json_data = match serde_json::to_string(&data) {
            Ok(j) => j,
            Err(e) => {
                write_log(&format!("JSON serialize error: {}", e));
                continue;
            }
        };

        let response = format!(
            "HTTP/1.1 200 OK\r\nContent-Type: application/json\r\nContent-Length: {}\r\n\r\n{}",
            json_data.len(),
            json_data
        );

        if let Err(e) = stream.write_all(response.as_bytes()) {
            write_log(&format!("Write response error: {}", e));
        } else {
            write_log("Response sent");
        }
    }
}