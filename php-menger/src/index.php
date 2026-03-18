<?php

require __DIR__ . '/../vendor/autoload.php';

use Slim\Factory\AppFactory;

$app = AppFactory::create();


// ===== LOG FUNCTION =====
function write_log($message) {
    $today = date("Ymd");
    $logDir = "/logs/" . $today;

    // สร้าง folder ถ้ายังไม่มี
    if (!is_dir($logDir)) {
        mkdir($logDir, 0777, true);
    }

    $logFile = $logDir . "/log.txt";
    $timestamp = date("c"); // ISO format

    $logLine = "[" . $timestamp . "] " . $message . PHP_EOL;

    file_put_contents($logFile, $logLine, FILE_APPEND);
}


// ===== MIDDLEWARE LOG =====
$app->add(function ($request, $handler) {
    $method = $request->getMethod();
    $uri = $request->getUri()->getPath();
    $ip = $_SERVER['REMOTE_ADDR'] ?? 'unknown';

    write_log("Request from {$ip} {$method} {$uri}");

    $response = $handler->handle($request);

    write_log("Response status " . $response->getStatusCode());

    return $response;
});


// ===== ROUTE =====
$app->get('/', function ($request, $response) {

    write_log("GET / called");

    $data = [
        "php-menger" => [
            "package_manager" => "composer",
            "dependency_file" => "composer.json",
            "source_code" => "src/index.php",
            "runtime" => "PHP interpreter"
        ]
    ];

    $response->getBody()->write(json_encode($data));

    return $response->withHeader('Content-Type', 'application/json');
});


// ===== START LOG =====
write_log("PHP Slim server started");

$app->run();