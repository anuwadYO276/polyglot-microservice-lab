import 'dart:io';

void main() async {
  final server = await ServerSocket.bind('0.0.0.0', 8091);

  print("Dart server running on port 8091");

  await for (Socket socket in server) {
    print("Connection received");

    final json = '''
{
"dart-menger":{
"package_manager":"pub",
"dependency_file":"pubspec.yaml",
"source_code":"bin/main.dart",
"runtime":"Dart VM"
}
}
''';

    final response =
        "HTTP/1.1 200 OK\r\n"
        "Content-Type: application/json\r\n"
        "Content-Length: ${json.length}\r\n"
        "\r\n"
        "$json";

    socket.write(response);
    await socket.flush();
    await socket.close();
  }
}