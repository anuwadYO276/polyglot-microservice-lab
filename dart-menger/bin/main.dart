import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';

void main() async {

  final router = Router();

  router.get('/', (Request request) {

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

  final server = await io.serve(router, '0.0.0.0', 8091);

  print("Dart Shelf server running on port ${server.port}");
}