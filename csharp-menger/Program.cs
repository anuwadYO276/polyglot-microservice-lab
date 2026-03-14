var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

app.MapGet("/", () => new
{
    csharp_menger = new
    {
        package_manager = ".NET",
        dependency_file = "menger.csproj",
        source_code = "Program.cs",
        runtime = ".NET runtime"
    }
});

app.Run();