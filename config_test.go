package main

import "testing"

func TestLoad(t *testing.T) {
	var cfg config

	cfg.load()

	if len(cfg.Dependencies) == 0 {
		t.Error("Expected some dependencies defined in the config file.")
	}
}
