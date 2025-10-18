package main

import (
    "testing"
    "github.com/GiovanneSantos/terraform-aws/api"
)

func TestHelloHandler(t *testing.T) {
    req := httptest.NewRequest("GET", "/", nil)
    w := httptest.NewRecorder()

    api.HelloHandler(w, req)

    if w.Body.String() != "Hello, GO API!" {
        t.Errorf("unexpected body: got %v", w.Body.String())
    }
}
