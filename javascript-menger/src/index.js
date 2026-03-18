// const express = require("express");

// const app = express();
// const PORT = 8092;

// app.get("/", (req, res) => {
//   res.json({
//     "javascript-menger": {
//       package_manager: "npm",
//       dependency_file: "package.json",
//       source_code: "src/index.js",
//       runtime: "Node.js"
//     }
//   });
// });

// app.listen(PORT, "0.0.0.0", () => {
//   console.log(`Javascript server running on port ${PORT}`);
// });

const express = require("express");
const fs = require("fs");
const path = require("path");

const app = express();
const PORT = 8092;

// 🔥 function เขียน log
function writeLog(message) {
  const today = new Date().toISOString().slice(0, 10).replace(/-/g, "");
  const logDir = path.join("/logs", today);

  // สร้าง folder ถ้ายังไม่มี
  fs.mkdirSync(logDir, { recursive: true });

  const logFile = path.join(logDir, "log.txt");

  const time = new Date().toISOString();
  fs.appendFileSync(logFile, `[${time}] ${message}\n`);
}

// middleware log ทุก request
app.use((req, res, next) => {
  writeLog(`${req.method} ${req.url}`);
  next();
});

app.get("/", (req, res) => {
  writeLog("GET / called");

  res.json({
    "javascript-menger": {
      package_manager: "npm",
      dependency_file: "package.json",
      source_code: "src/index.js",
      runtime: "Node.js"
    }
  });
});

app.listen(PORT, "0.0.0.0", () => {
  writeLog(`Server started on port ${PORT}`);
  console.log(`Javascript server running on port ${PORT}`);
});