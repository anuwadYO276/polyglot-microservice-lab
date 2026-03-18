package main

import (
	"fmt"
	"os"
	"time"

	"github.com/gin-gonic/gin"
)

// ===== LOG FUNCTION =====
func writeLog(message string) {
	today := time.Now().Format("20060102")
	logDir := fmt.Sprintf("/logs/%s", today)

	// สร้าง folder ถ้ายังไม่มี
	err := os.MkdirAll(logDir, os.ModePerm)
	if err != nil {
		fmt.Println("Create log dir error:", err)
		return
	}

	logFile := fmt.Sprintf("%s/log.txt", logDir)

	f, err := os.OpenFile(logFile, os.O_APPEND|os.O_CREATE|os.O_WRONLY, 0644)
	if err != nil {
		fmt.Println("Open log file error:", err)
		return
	}
	defer f.Close()

	timestamp := time.Now().Format(time.RFC3339)
	logLine := fmt.Sprintf("[%s] %s\n", timestamp, message)

	f.WriteString(logLine)
}

func main() {

	// ปิด default logger ของ Gin (ไม่งั้นจะซ้ำ)
	gin.SetMode(gin.ReleaseMode)
	r := gin.New()

	// ===== MIDDLEWARE LOG =====
	r.Use(func(c *gin.Context) {
		clientIP := c.ClientIP()
		method := c.Request.Method
		path := c.Request.URL.Path

		writeLog(fmt.Sprintf("Request from %s %s %s", clientIP, method, path))

		c.Next()

		status := c.Writer.Status()
		writeLog(fmt.Sprintf("Response status %d", status))
	})

	// ===== START LOG =====
	writeLog("Go Gin server started on port 8089")

	// ===== ROUTE =====
	r.GET("/", func(c *gin.Context) {

		writeLog("GET / called")

		c.JSON(200, gin.H{
			"go-menger": gin.H{
				"package_manager": "go modules",
				"dependency_file": "go.mod",
				"source_code": "main.go",
				"runtime": "OS executable file",
			},
		})
	})

	r.Run(":8089")
}