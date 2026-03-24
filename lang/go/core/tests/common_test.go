package tests

import (
	"encoding/json"
	"fmt"
	"strings"
	"time"

	"github.com/cucumber/godog"
)

func registerAllSteps(sc *godog.ScenarioContext, world *World) {
	registerCommonSteps(sc, world)
	registerAbstractSteps(sc, world)
	registerAbstractIntegrationSteps(sc, world)
	registerSQSSteps(sc, world)
	registerDynamoDBSteps(sc, world)
	registerS3Steps(sc, world)
	registerSNSSteps(sc, world)
	registerEventBridgeSteps(sc, world)
	registerStepFunctionsSteps(sc, world)
	registerSSMSteps(sc, world)
	registerSecretsManagerSteps(sc, world)
	registerOrganizationsSteps(sc, world)
	registerChaosSteps(sc, world)
	registerIAMSteps(sc, world)
	registerCapacitySteps(sc, world)
	registerPendingSteps(sc, world)
}

func registerCommonSteps(sc *godog.ScenarioContext, world *World) {
	sc.Then(`^the command will succeed$`, func() error {
		if !world.lastResult.Success {
			return fmt.Errorf("expected success but got failure: %v", world.lastResult.Error)
		}
		return nil
	})

	sc.Then(`^the command will fail$`, func() error {
		if world.lastResult.Success {
			return fmt.Errorf("expected failure but command succeeded")
		}
		return nil
	})

	sc.Then(`^the output will contain "([^"]*)"$`, func(expected string) error {
		actualOutput, _ := json.Marshal(world.lastResult.Output)
		if !strings.Contains(string(actualOutput), expected) {
			return fmt.Errorf("expected output to contain %q but got: %s", expected, string(actualOutput))
		}
		return nil
	})

	sc.Then(`^the output will contain an IAM access denied error$`, func() error {
		actualOutput, _ := json.Marshal(world.lastResult.Output)
		s := string(actualOutput)
		hasAccessDenied := strings.Contains(s, "AccessDeniedException") ||
			strings.Contains(s, "AccessDenied") ||
			strings.Contains(s, "access denied") ||
			strings.Contains(s, "NotAuthorizedException") ||
			(!world.lastResult.Success && strings.Contains(s, "403"))
		if !hasAccessDenied {
			return fmt.Errorf("expected IAM access denied error but got: %s", s)
		}
		return nil
	})

	sc.Then(`^the output will not contain an IAM access denied error$`, func() error {
		actualOutput, _ := json.Marshal(world.lastResult.Output)
		s := string(actualOutput)
		hasAccessDenied := strings.Contains(s, "AccessDeniedException") ||
			(strings.Contains(s, "AccessDenied") && !strings.Contains(s, "NotAccessDenied"))
		if hasAccessDenied {
			return fmt.Errorf("expected no IAM access denied error but got: %s", s)
		}
		return nil
	})

	sc.Then(`^the output will contain a JSON chaos error$`, func() error {
		actualOutput, _ := json.Marshal(world.lastResult.Output)
		s := string(actualOutput)
		hasChaosMark := strings.Contains(s, "__type") ||
			strings.Contains(s, "InternalFailure") ||
			strings.Contains(s, "ServiceUnavailable") ||
			strings.Contains(s, "chaos") ||
			!world.lastResult.Success
		if !hasChaosMark {
			return fmt.Errorf("expected JSON chaos error but got: %s", s)
		}
		return nil
	})

	sc.Then(`^the output will contain an XML chaos error$`, func() error {
		actualOutput, _ := json.Marshal(world.lastResult.Output)
		s := string(actualOutput)
		hasChaosMark := strings.Contains(s, "ErrorResponse") ||
			strings.Contains(s, "Error") ||
			strings.Contains(s, "InternalError") ||
			strings.Contains(s, "ServiceUnavailable") ||
			!world.lastResult.Success
		if !hasChaosMark {
			return fmt.Errorf("expected XML chaos error but got: %s", s)
		}
		return nil
	})

	sc.Then(`^the output will contain an S3 XML chaos error$`, func() error {
		actualOutput, _ := json.Marshal(world.lastResult.Output)
		s := string(actualOutput)
		hasChaosMark := strings.Contains(s, "Error") ||
			strings.Contains(s, "InternalError") ||
			strings.Contains(s, "ServiceUnavailable") ||
			!world.lastResult.Success
		if !hasChaosMark {
			return fmt.Errorf("expected S3 XML chaos error but got: %s", s)
		}
		return nil
	})

	sc.Then(`^the call will have taken at least (\d+) milliseconds$`, func(minMs int) error {
		if world.timedResult.ElapsedMs < int64(minMs) {
			return fmt.Errorf("expected call to take at least %dms but took %dms", minMs, world.timedResult.ElapsedMs)
		}
		return nil
	})

	_ = time.Now // avoid unused import
}
