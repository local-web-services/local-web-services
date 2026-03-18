package tests

import (
	"context"
	"fmt"
	"net/http"
	"os"
	"testing"
	"time"

	"github.com/cucumber/godog"
	"github.com/local-web-services/local-web-services-go-core/lws"
)

func TestMain(m *testing.M) {
	var err error
	sharedServer, err = lws.StartServer(basePort)
	if err != nil {
		fmt.Printf("Failed to start server: %v\n", err)
		os.Exit(1)
	}

	// Wait for server to be ready
	if err := awaitReady(); err != nil {
		fmt.Printf("Server not ready: %v\n", err)
		sharedServer.Close()
		os.Exit(1)
	}

	opts := godog.Options{
		Format: "pretty",
		Paths: []string{
			"../../../../lang/specification/core/informal/dynamodb",
			"../../../../lang/specification/core/informal/sqs",
			"../../../../lang/specification/core/informal/s3api",
			"../../../../lang/specification/core/informal/sns",
			"../../../../lang/specification/core/informal/events",
			"../../../../lang/specification/core/informal/stepfunctions",
			"../../../../lang/specification/core/informal/ssm",
			"../../../../lang/specification/core/informal/secretsmanager",
			"../../../../lang/specification/core/informal/events_dynamodb",
			"../../../../lang/specification/core/informal/events_sns",
			"../../../../lang/specification/core/informal/events_sqs",
			"../../../../lang/specification/core/informal/events_stepfunctions",
			"../../../../lang/specification/core/informal/s3api_events",
			"../../../../lang/specification/core/informal/s3api_sns",
			"../../../../lang/specification/core/informal/s3api_sqs",
			"../../../../lang/specification/core/informal/secretsmanager_events",
			"../../../../lang/specification/core/informal/sns_sqs",
			"../../../../lang/specification/core/informal/ssm_events",
			"../../../../lang/specification/core/informal/stepfunctions_dynamodb",
			"../../../../lang/specification/core/informal/stepfunctions_events",
			"../../../../lang/specification/core/informal/stepfunctions_s3api",
			"../../../../lang/specification/core/informal/stepfunctions_secretsmanager",
			"../../../../lang/specification/core/informal/stepfunctions_sns",
			"../../../../lang/specification/core/informal/stepfunctions_sqs",
			"../../../../lang/specification/core/informal/stepfunctions_ssm",
		},
		Tags: "@minimal,@standard&&~@internal",
	}
	status := godog.TestSuite{
		Name:                "lws-go-core",
		ScenarioInitializer: InitializeScenario,
		Options:             &opts,
	}.Run()

	sharedServer.Close()
	os.Exit(status)
}

func awaitReady() error {
	url := fmt.Sprintf("http://127.0.0.1:%d/_ldk/status", basePort)
	deadline := time.Now().Add(10 * time.Second)
	for time.Now().Before(deadline) {
		resp, err := http.Get(url)
		if err == nil && resp.StatusCode == 200 {
			resp.Body.Close()
			return nil
		}
		if resp != nil {
			resp.Body.Close()
		}
		time.Sleep(100 * time.Millisecond)
	}
	return fmt.Errorf("server did not become ready within 10s")
}

func InitializeScenario(sc *godog.ScenarioContext) {
	world := newWorld()

	// Reset state before each scenario
	sc.Before(func(ctx context.Context, sc *godog.Scenario) (context.Context, error) {
		lws.Reset(basePort) //nolint:errcheck
		return ctx, nil
	})

	// Register all step definitions
	registerAllSteps(sc, world)
}
