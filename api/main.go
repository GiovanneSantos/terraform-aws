package main

import (
	"fmt"
	"net/http"
	"github.com/GiovanneSantos/terraform-aws/api"
)

func main() {
	http.HandleFunc("/", api.HelloHandler)
	fmt.Println("Server starting on port 8080...")
	http.ListenAndServe(":8080", nil)
}
