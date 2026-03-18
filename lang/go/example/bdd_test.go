package main

import (
	"context"
	"fmt"
	"os"
	"testing"

	"github.com/cucumber/godog"
	"github.com/local-web-services/local-web-services-go-sdk/lws"
)

var sharedSession *lws.Session

func TestMain(m *testing.M) {
	var err error
	sharedSession, err = lws.NewShared()
	if err != nil {
		fmt.Printf("Failed to start session: %v\n", err)
		os.Exit(1)
	}

	opts := godog.Options{
		Format: "pretty",
		Paths:  []string{"../../specification/example/features"},
	}
	status := godog.TestSuite{
		Name:                "order-processor",
		ScenarioInitializer: InitializeScenario,
		Options:             &opts,
	}.Run()

	sharedSession.Close()
	os.Exit(status)
}

func InitializeScenario(sc *godog.ScenarioContext) {
	ctx := &testContext{}

	sc.Before(func(goCtx context.Context, sc *godog.Scenario) (context.Context, error) {
		sharedSession.Reset() //nolint:errcheck
		ctx.reset()
		return goCtx, nil
	})

	sc.After(func(goCtx context.Context, sc *godog.Scenario, err error) (context.Context, error) {
		if ctx.logCapture != nil {
			ctx.logCapture.Stop()
			ctx.logCapture = nil
		}
		return goCtx, nil
	})

	InitializeSteps(sc, ctx)
}
