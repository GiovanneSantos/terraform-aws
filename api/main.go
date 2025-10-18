package main

import (
	"fmt"
	"net/http"
)

func main() {
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		w.Write([]byte("Hello, GO API!"))
	})

	fmt.Println("Server starting on port 8080...")
	http.ListenAndServe(":8080", nil)
}
