use std::io::Write;
use std::net::TcpListener;

fn main() {
    let listener = TcpListener::bind("0.0.0.0:8087").unwrap();

    println!("Server running on port 8087");

    for stream in listener.incoming() {
        let mut stream = stream.unwrap();

        println!("Connection received");

        let json_data = r#"
        {
            "memo-rust": {
                "package_manager": "cargo",
                "dependency_file": "Cargo.toml",
                "source_code": "src/main.rs",
                "runtime": "OS executable file"
            }
        }
        "#;

        let response = format!(
            "HTTP/1.1 200 OK\r\nContent-Type: application/json\r\nContent-Length: {}\r\n\r\n{}",
            json_data.len(),
            json_data
        );

        stream.write_all(response.as_bytes()).unwrap();
    }
}