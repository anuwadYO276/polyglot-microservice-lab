const net = require("net");

const PORT = 8092;

const server = net.createServer((socket) => {
  console.log("Connection received");

  const json = JSON.stringify({
    "javascript-menger": {
      package_manager: "npm",
      dependency_file: "package.json",
      source_code: "src/index.js",
      runtime: "Node.js"
    }
  });

  const response =
    "HTTP/1.1 200 OK\r\n" +
    "Content-Type: application/json\r\n" +
    "Content-Length: " + Buffer.byteLength(json) + "\r\n\r\n" +
    json;

  socket.write(response);
  socket.end();
});

server.listen(PORT, "0.0.0.0", () => {
  console.log(`Node server running on port ${PORT}`);
});