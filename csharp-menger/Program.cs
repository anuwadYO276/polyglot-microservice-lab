using System.Text;

var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

// ===== LOG FUNCTION =====
void WriteLog(string message)
{
    var now = DateTime.Now;
    var today = now.ToString("yyyyMMdd");
    var logDir = $"/logs/{today}";

    if (!Directory.Exists(logDir))
    {
        Directory.CreateDirectory(logDir);
    }

    var logFile = Path.Combine(logDir, "log.txt");
    var timestamp = now.ToString("o"); // ISO format
    var logLine = $"[{timestamp}] {message}{Environment.NewLine}";

    File.AppendAllText(logFile, logLine, Encoding.UTF8);
}

// ===== START LOG =====
WriteLog(".NET server started");

// ===== MIDDLEWARE LOG =====
app.Use(async (context, next) =>
{
    var ip = context.Connection.RemoteIpAddress?.ToString() ?? "unknown";
    var method = context.Request.Method;
    var path = context.Request.Path;

    WriteLog($"Request from {ip} {method} {path}");

    await next();

    var status = context.Response.StatusCode;
    WriteLog($"Response status {status}");
});

// ===== ROUTE =====
app.MapGet("/", () =>
{
    WriteLog("GET / called");

    return new
    {
        csharp_menger = new
        {
            package_manager = ".NET",
            dependency_file = "menger.csproj",
            source_code = "Program.cs",
            runtime = ".NET runtime"
        }
    };
});

app.Run();