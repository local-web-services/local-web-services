package tests

import (
	"context"
	"fmt"
	"net/http"
	"os"
	"testing"
	"time"

	"github.com/cucumber/godog"
	core "github.com/local-web-services/local-web-services-go-core/lws"
)

func TestMain(m *testing.M) {
	var err error
	sharedServer, err = core.StartServer(basePort)
	if err != nil {
		fmt.Printf("Failed to start server: %v\n", err)
		os.Exit(1)
	}

	if err := awaitReady(); err != nil {
		fmt.Printf("Server not ready: %v\n", err)
		sharedServer.Close()
		os.Exit(1)
	}

	opts := godog.Options{
		Format: "pretty",
		Paths:  []string{"../../../../lang/specification/sdk/features"},
	}
	status := godog.TestSuite{
		Name:                "lws-go-sdk",
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
		resp, err := http.Get(url) //nolint:noctx
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

	sc.Before(func(ctx context.Context, sc *godog.Scenario) (context.Context, error) {
		core.Reset(basePort) //nolint:errcheck
		world.reset()
		return ctx, nil
	})

	sc.After(func(ctx context.Context, sc *godog.Scenario, err error) (context.Context, error) {
		world.cleanup()
		return ctx, nil
	})

	registerAllSteps(sc, world)
}
