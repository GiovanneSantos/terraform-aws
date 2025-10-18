package main

import (
	"net/http"
	"net/http/httptest"
	"testing"
)

func TestHelloHandler(t *testing.T) {
	req := httptest.NewRequest("GET", "/", nil)
	w := httptest.NewRecorder()

	HelloHandler(w, req)

	if w.Body.String() != "Hello, GO API!" {
		t.Errorf("expected 'Hello, GO API!', got '%s'", w.Body.String())
	}
}
