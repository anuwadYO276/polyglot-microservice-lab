import socket

HOST = "0.0.0.0"
PORT = 8093

server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server.bind((HOST, PORT))
server.listen(5)

print(f"Python server running on port {PORT}")

while True:
    conn, addr = server.accept()
    print("Connection received")

    json_data = """
{
"python-menger":{
"package_manager":"pip",
"dependency_file":"requirements.txt",
"source_code":"main.py",
"runtime":"Python interpreter"
}
}
"""

    response = (
        "HTTP/1.1 200 OK\r\n"
        "Content-Type: application/json\r\n"
        f"Content-Length: {len(json_data)}\r\n"
        "\r\n"
        f"{json_data}"
    )

    conn.sendall(response.encode())
    conn.close()