package main_test  // diferente de main

import (
	"net/http/httptest"
	"testing"

	"github.com/GiovanneSantos/terraform-aws/api" // importa o pacote da API
)

func TestHelloHandler(t *testing.T) {
	req := httptest.NewRequest("GET", "/", nil)
	w := httptest.NewRecorder()

	api.HelloHandler(w, req)

	if w.Body.String() != "Hello, GO API!" {
		t.Errorf("unexpected body: got %v", w.Body.String())
	}
}
