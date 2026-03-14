<?php

require __DIR__ . '/../vendor/autoload.php';

use Slim\Factory\AppFactory;

$app = AppFactory::create();

$app->get('/', function ($request, $response) {

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

$app->run();