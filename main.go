package main

import (
	"net/http"
	"os"
	"github.com/gin-gonic/gin"
)

type Requisicao struct {
	Operador string  `json:"operador"`
	Op1      float64 `json:"op1"`
	Op2      float64 `json:"op2"`
}

func main() {
	gin.SetMode(gin.ReleaseMode)
	r := gin.Default()

	r.POST("/calcular", func(c *gin.Context) {
		var req Requisicao
		if err := c.ShouldBindJSON(&req); err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"erro": err.Error()})
			return
		}

		var res float64
		switch req.Operador {
		case "soma": res = req.Op1 + req.Op2
		case "subtracao": res = req.Op1 - req.Op2
		case "multiplicacao": res = req.Op1 * req.Op2
		case "divisao":
			if req.Op2 != 0 {
				res = req.Op1 / req.Op2
			} else {
				c.JSON(http.StatusBadRequest, gin.H{"erro": "Divisao por zero"})
				return
			}
		}

		host, _ := os.Hostname()
		c.JSON(http.StatusOK, gin.H{
			"container_host": host,
			"resultado":      res,
		})
	})

	r.Run(":8080")
}
