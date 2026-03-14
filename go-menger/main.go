package main

import (
	"github.com/gin-gonic/gin"
)

func main() {

	r := gin.Default()

	r.GET("/", func(c *gin.Context) {

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