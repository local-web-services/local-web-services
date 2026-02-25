package main

import (
	"os"
	"testing"

	"github.com/cucumber/godog"
)

func TestMain(m *testing.M) {
	opts := godog.Options{
		Format: "pretty",
		Paths:  []string{"features"},
	}
	status := godog.TestSuite{
		Name:                "order-processor",
		ScenarioInitializer: InitializeScenario,
		Options:             &opts,
	}.Run()
	os.Exit(status)
}
