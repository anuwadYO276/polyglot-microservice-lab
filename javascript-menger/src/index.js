const express = require("express");

const app = express();
const PORT = 8092;

app.get("/", (req, res) => {
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
  console.log(`Javascript server running on port ${PORT}`);
});