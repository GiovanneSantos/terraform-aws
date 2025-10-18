package main

import (
	"net/http/httptest"
	"testing"
)

func TestHelloHandler(t *testing.T) {
	req := httptest.NewRequest("GET", "/", nil)
	w := httptest.NewRecorder()

	HelloHandler(w, req)

	if w.Body.String() != "Hello, GO API!" {
		t.Errorf("unexpected body: got %v", w.Body.String())
	}
}
