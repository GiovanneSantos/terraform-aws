package main

import (
	"net/http"
	"net/http/httptest"
	"testing"
)

func TestHelloHandler(t *testing.T) {
	req := httptest.NewRequest("GET", "/", nil)
	rec := httptest.NewRecorder()

	helloHandler(rec, req)

	res := rec.Result()
	defer res.Body.Close()

	if res.StatusCode != http.StatusOK {
		t.Errorf("expected status 200, got %d", res.StatusCode)
	}

	expectedBody := "Helloss, GO API!"
	buf := make([]byte, len(expectedBody))
	res.Body.Read(buf)

	if string(buf) != expectedBody {
		t.Errorf("expected body %q, got %q", expectedBody, string(buf))
	}
}
