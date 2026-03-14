using System.Net;
using System.Net.Sockets;
using System.Text;

int port = 8095;

TcpListener listener = new TcpListener(IPAddress.Any, port);
listener.Start();

Console.WriteLine($"C# server running on port {port}");

while (true)
{
    var client = listener.AcceptTcpClient();
    Console.WriteLine("Connection received");

    var stream = client.GetStream();

    string json = @"{
""csharp-menger"": {
""package_manager"": "".NET"",
""dependency_file"": ""menger.csproj"",
""source_code"": ""Program.cs"",
""runtime"": "".NET runtime""
}
}";

    string response =
        "HTTP/1.1 200 OK\r\n" +
        "Content-Type: application/json\r\n" +
        $"Content-Length: {Encoding.UTF8.GetByteCount(json)}\r\n\r\n" +
        json;

    byte[] data = Encoding.UTF8.GetBytes(response);
    stream.Write(data, 0, data.Length);

    client.Close();
}