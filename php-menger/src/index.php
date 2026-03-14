<?php

$port = 8094;

$socket = stream_socket_server("tcp://0.0.0.0:$port", $errno, $errstr);

if (!$socket) {
    echo "Error: $errstr ($errno)\n";
    exit(1);
}

echo "PHP server running on port $port\n";

while ($conn = stream_socket_accept($socket)) {

    echo "Connection received\n";

    $json = json_encode([
        "php-menger" => [
            "package_manager" => "composer",
            "dependency_file" => "composer.json",
            "source_code" => "src/index.php",
            "runtime" => "PHP interpreter"
        ]
    ]);

    $response =
        "HTTP/1.1 200 OK\r\n" .
        "Content-Type: application/json\r\n" .
        "Content-Length: " . strlen($json) . "\r\n\r\n" .
        $json;

    fwrite($conn, $response);
    fclose($conn);
}