package main

import (
	"fmt"
	"net"
)

func main() {

	listener, err := net.Listen("tcp", "0.0.0.0:8089")
	if err != nil {
		panic(err)
	}

	fmt.Println("Go server running on port 8089")

	for {
		conn, err := listener.Accept()
		if err != nil {
			continue
		}

		fmt.Println("Connection received")

		json := `{
"go-menger":{
"package_manager":"go modules",
"dependency_file":"go.mod",
"source_code":"main.go",
"runtime":"OS executable file"
}
}`

		response := fmt.Sprintf(
			"HTTP/1.1 200 OK\r\nContent-Type: application/json\r\nContent-Length: %d\r\n\r\n%s",
			len(json),
			json,
		)

		conn.Write([]byte(response))
		conn.Close()
	}
}