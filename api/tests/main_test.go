package main

import (
	"net/http"         // <- necessário para http.HandlerFunc
	"net/http/httptest"
	"testing"
)

func TestHelloHandler(t *testing.T) {
	req := httptest.NewRequest("GET", "/", nil)
	w := httptest.NewRecorder()

	// Reutiliza a função inline do main
	handler := http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		w.Write([]byte("Hello, GO API!"))
	})

	handler.ServeHTTP(w, req)

	if w.Body.String() != "Hello, GO API!" {
		t.Errorf("unexpected body: got %v", w.Body.String())
	}
}
