package tests

import (
	"encoding/json"
	"fmt"

	"github.com/cucumber/godog"
	"github.com/local-web-services/local-web-services-go-core/lws"
)

func registerChaosSteps(sc *godog.ScenarioContext, world *World) {
	// Given
	sc.Given(`^chaos was enabled for "([^"]*)"$`, func(service string) error {
		return lws.ChaosEnable(world.managementPort, service)
	})

	sc.Given(`^chaos was configured for "([^"]*)" with full error rate$`, func(service string) error {
		return lws.ChaosSet(world.managementPort, service, 1.0, 0, 0)
	})

	sc.Given(`^chaos was configured for "([^"]*)" with 200ms latency$`, func(service string) error {
		return lws.ChaosSet(world.managementPort, service, 0, 200, 200)
	})

	sc.Given(`^chaos was cleaned up for "([^"]*)"$`, func(service string) error {
		return lws.ChaosDisable(world.managementPort, service)
	})

	// When
	sc.When(`^I enable chaos for "([^"]*)"$`, func(service string) error {
		err := lws.ChaosEnable(world.managementPort, service)
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: map[string]interface{}{"status": "enabled"}}
		}
		return nil
	})

	sc.When(`^I disable chaos for "([^"]*)"$`, func(service string) error {
		err := lws.ChaosDisable(world.managementPort, service)
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: map[string]interface{}{"status": "disabled"}}
		}
		return nil
	})

	sc.When(`^I set chaos for "([^"]*)" with error rate (\d+(?:\.\d+)?)$`, func(service string, errorRate float64) error {
		err := lws.ChaosSet(world.managementPort, service, errorRate, 0, 0)
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: map[string]interface{}{"status": "configured", "errorRate": errorRate}}
		}
		return nil
	})

	sc.When(`^I set chaos for "([^"]*)" with latency min (\d+) and max (\d+)$`, func(service string, latencyMin, latencyMax int) error {
		err := lws.ChaosSet(world.managementPort, service, 0, latencyMin, latencyMax)
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: map[string]interface{}{"status": "configured", "latencyMin": latencyMin, "latencyMax": latencyMax}}
		}
		return nil
	})

	sc.When(`^I request chaos status$`, func() error {
		result, err := lws.ChaosStatus(world.managementPort)
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	// Then
	sc.Then(`^chaos for "([^"]*)" will be enabled$`, func(service string) error {
		status, err := lws.ChaosStatus(world.managementPort)
		if err != nil {
			return err
		}
		svcStatus, ok := status[service].(map[string]interface{})
		if !ok {
			return fmt.Errorf("expected chaos status for %q but not found", service)
		}
		enabled, _ := svcStatus["enabled"].(bool)
		if !enabled {
			data, _ := json.Marshal(svcStatus)
			return fmt.Errorf("expected chaos to be enabled for %q, got: %s", service, string(data))
		}
		return nil
	})

	sc.Then(`^chaos for "([^"]*)" will be disabled$`, func(service string) error {
		status, err := lws.ChaosStatus(world.managementPort)
		if err != nil {
			return err
		}
		svcStatus, ok := status[service].(map[string]interface{})
		if !ok {
			// Not present means disabled
			return nil
		}
		enabled, _ := svcStatus["enabled"].(bool)
		if enabled {
			data, _ := json.Marshal(svcStatus)
			return fmt.Errorf("expected chaos to be disabled for %q, got: %s", service, string(data))
		}
		return nil
	})

	sc.Then(`^chaos for "([^"]*)" will have error rate (\d+(?:\.\d+)?)$`, func(service string, expectedErrorRate float64) error {
		status, err := lws.ChaosStatus(world.managementPort)
		if err != nil {
			return err
		}
		svcStatus, ok := status[service].(map[string]interface{})
		if !ok {
			return fmt.Errorf("expected chaos status for %q but not found", service)
		}
		actual, _ := svcStatus["error_rate"].(float64)
		if actual != expectedErrorRate {
			return fmt.Errorf("expected error_rate %v for %q, got %v", expectedErrorRate, service, actual)
		}
		return nil
	})

	sc.Then(`^chaos for "([^"]*)" will have latency min (\d+)$`, func(service string, expectedMin int) error {
		status, err := lws.ChaosStatus(world.managementPort)
		if err != nil {
			return err
		}
		svcStatus, ok := status[service].(map[string]interface{})
		if !ok {
			return fmt.Errorf("expected chaos status for %q but not found", service)
		}
		actual, _ := svcStatus["latency_min_ms"].(float64)
		if int(actual) != expectedMin {
			return fmt.Errorf("expected latency_min_ms %d for %q, got %v", expectedMin, service, actual)
		}
		return nil
	})

	sc.Then(`^chaos for "([^"]*)" will have latency max (\d+)$`, func(service string, expectedMax int) error {
		status, err := lws.ChaosStatus(world.managementPort)
		if err != nil {
			return err
		}
		svcStatus, ok := status[service].(map[string]interface{})
		if !ok {
			return fmt.Errorf("expected chaos status for %q but not found", service)
		}
		actual, _ := svcStatus["latency_max_ms"].(float64)
		if int(actual) != expectedMax {
			return fmt.Errorf("expected latency_max_ms %d for %q, got %v", expectedMax, service, actual)
		}
		return nil
	})

	sc.Then(`^the chaos status will contain "([^"]*)"$`, func(serviceName string) error {
		status, err := lws.ChaosStatus(world.managementPort)
		if err != nil {
			return err
		}
		if _, ok := status[serviceName]; !ok {
			keys := make([]string, 0, len(status))
			for k := range status {
				keys = append(keys, k)
			}
			return fmt.Errorf("expected chaos status to contain %q, got keys: %v", serviceName, keys)
		}
		return nil
	})
}
