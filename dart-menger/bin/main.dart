import 'dart:convert';
import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';

// ===== LOG FUNCTION =====
void writeLog(String message) {
  final now = DateTime.now();
  final today = "${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}";
  final logDir = "/logs/$today";

  // สร้าง folder ถ้ายังไม่มี
  final dir = Directory(logDir);
  if (!dir.existsSync()) {
    dir.createSync(recursive: true);
  }

  final logFile = File("$logDir/log.txt");
  final timestamp = now.toIso8601String();
  final logLine = "[$timestamp] $message\n";

  logFile.writeAsStringSync(logLine, mode: FileMode.append);
}

void main() async {

  final router = Router();

  // ===== ROUTE =====
  router.get('/', (Request request) {

    writeLog("GET / called");

    final data = {
      "dart-menger": {
        "package_manager": "pub",
        "dependency_file": "pubspec.yaml",
        "source_code": "bin/main.dart",
        "runtime": "Dart VM"
      }
    };

    return Response.ok(
      jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );
  });

  // ===== MIDDLEWARE LOG =====
  final handler = const Pipeline()
      .addMiddleware((innerHandler) {
        return (request) async {
          final ip = request.headers['x-forwarded-for'] ?? 'unknown';
          final method = request.method;
          final path = request.requestedUri.path;

          writeLog("Request from $ip $method $path");

          final response = await innerHandler(request);

          writeLog("Response status ${response.statusCode}");

          return response;
        };
      })
      .addHandler(router);

  // ===== START LOG =====
  writeLog("Dart Shelf server started on port 8091");

  final server = await io.serve(handler, '0.0.0.0', 8091);

  print("Dart Shelf server running on port ${server.port}");
}