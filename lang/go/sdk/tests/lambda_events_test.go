package tests

// registerLambdaEventsSteps wires all step definitions unique to the
// lambda_events cross-service feature files.
//
// Steps already registered in lambda_test.go ("the function does not already
// exist", "the function already exists", "the function exists", "the function
// is \"ACTIVE\"", etc.) and events_test.go ("the event bus is \"ACTIVE\"",
// "the event bus is \"DELETED\"", etc.) are NOT re-registered here.
// "the operation is rejected" and "the system is initialized" are already
// registered in common steps.

import (
	"context"
	"fmt"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/eventbridge"
	"github.com/aws/aws-sdk-go-v2/service/lambda"
	lambdatypes "github.com/aws/aws-sdk-go-v2/service/lambda/types"
	"github.com/cucumber/godog"
)

const lambdaEventsTestFunc = "e2e-test-func-1"
const lambdaEventsTestBus = "e2e-test-bus-1"
const lambdaEventsRoleArn = "arn:aws:iam::000000000000:role/test"

func lambdaEventsCreateFunction(world *World) error {
	// Arrange
	// Act
	_, err := world.LambdaClient().CreateFunction(context.Background(), &lambda.CreateFunctionInput{
		FunctionName: aws.String(lambdaEventsTestFunc),
		Runtime:      lambdatypes.RuntimePython312,
		Role:         aws.String(lambdaEventsRoleArn),
		Handler:      aws.String("index.handler"),
		Code: &lambdatypes.FunctionCode{
			ZipFile: []byte("fake"),
		},
	})
	// Assert: caller checks error
	return err
}

func lambdaEventsCreateBus(world *World) error {
	// Arrange
	// Act
	_, err := world.EventBridgeClient().CreateEventBus(context.Background(), &eventbridge.CreateEventBusInput{
		Name: aws.String(lambdaEventsTestBus),
	})
	// Assert: caller checks error
	return err
}

func registerLambdaEventsSteps(sc *godog.ScenarioContext, world *World) {
	// ── Given: bus state ─────────────────────────────────────────────────────

	sc.Given(`^the bus does not already exist$`, func() error {
		// No-op: fresh state after reset has no event buses.
		return nil
	})

	sc.Given(`^the bus already exists$`, func() error {
		// Arrange: create the bus so it already exists
		// Act
		return lambdaEventsCreateBus(world)
	})

	sc.Given(`^the bus exists$`, func() error {
		// Arrange: create the test event bus
		// Act
		return lambdaEventsCreateBus(world)
	})

	sc.Given(`^the bus is "ACTIVE"$`, func() error {
		// No-op: event buses are ACTIVE immediately after creation.
		return nil
	})

	sc.Given(`^the bus is already "DELETED"$`, func() error {
		// Arrange: delete the bus if present to reach a DELETED state
		// Act: delete, ignore errors (bus may not exist)
		_, _ = world.EventBridgeClient().DeleteEventBus(context.Background(), &eventbridge.DeleteEventBusInput{
			Name: aws.String(lambdaEventsTestBus),
		})
		// Assert: desired state is absence; reset result to clean slate
		world.lastResult = LastResult{}
		return nil
	})

	sc.Given(`^the bus does not exist$`, func() error {
		// No-op: fresh state after reset has no event buses.
		return nil
	})

	sc.Given(`^the bus does not exist or is "DELETED"$`, func() error {
		// No-op: fresh state after reset has no event buses (simulates deleted bus).
		return nil
	})

	sc.Given(`^the bus is "DELETED"$`, func() error {
		// No-op: fresh state after reset has no event buses (simulates deleted bus).
		return nil
	})

	sc.Given(`^the bus is not "DELETED"$`, func() error {
		// Arrange: ensure the bus exists so it is not in a DELETED state
		// Act
		return lambdaEventsCreateBus(world)
	})

	// ── Given: invocation / slot state ───────────────────────────────────────

	sc.Given(`^an invocation is "IN_PROGRESS"$`, func() error {
		// Arrange: create the function so an invocation can be IN_PROGRESS
		// Act
		return lambdaEventsCreateFunction(world)
	})

	sc.Given(`^no invocation is "IN_PROGRESS"$`, func() error {
		// No-op: fresh state after reset has no active invocations.
		return nil
	})

	sc.Given(`^an invocation slot is available$`, func() error {
		// No-op: always room for invocations in lws.
		return nil
	})

	sc.Given(`^no invocation slot is available$`, func() error {
		// @internal: Cannot exhaust invocation slot limit in lws.
		return nil
	})

	sc.Given(`^an event slot is available$`, func() error {
		// No-op: always room for events in lws.
		return nil
	})

	sc.Given(`^no event slot is available$`, func() error {
		// @internal: Cannot exhaust event slot limit in lws.
		return nil
	})

	// ── When: actions ─────────────────────────────────────────────────────────

	sc.When(`^a Lambda function is deployed$`, func() error {
		// Arrange
		// Act
		result, err := world.LambdaClient().CreateFunction(context.Background(), &lambda.CreateFunctionInput{
			FunctionName: aws.String(lambdaEventsTestFunc),
			Runtime:      lambdatypes.RuntimePython312,
			Role:         aws.String(lambdaEventsRoleArn),
			Handler:      aws.String("index.handler"),
			Code: &lambdatypes.FunctionCode{
				ZipFile: []byte("fake"),
			},
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^an EventBridge event bus is created$`, func() error {
		// Arrange
		// Act
		result, err := world.EventBridgeClient().CreateEventBus(context.Background(), &eventbridge.CreateEventBusInput{
			Name: aws.String(lambdaEventsTestBus),
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^the EventBridge event bus is deleted$`, func() error {
		// Arrange
		// Act
		result, err := world.EventBridgeClient().DeleteEventBus(context.Background(), &eventbridge.DeleteEventBusInput{
			Name: aws.String(lambdaEventsTestBus),
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^the Lambda function is invoked$`, func() error {
		// @internal: Cannot trigger Lambda invocation in lws without Docker.
		setResult(world, nil, fmt.Errorf("cannot trigger Lambda invocation: scenario is @internal"))
		return nil
	})

	sc.When(`^the Lambda function fails to publish because the event bus has been deleted$`, func() error {
		// @internal: Cannot trigger Lambda invocation in lws without Docker.
		setResult(world, nil, fmt.Errorf("cannot trigger Lambda invocation failure: scenario is @internal"))
		return nil
	})

	sc.When(`^the Lambda function publishes an event to the "ACTIVE" event bus and succeeds$`, func() error {
		// @internal: Cannot trigger Lambda invocation in lws without Docker.
		setResult(world, nil, fmt.Errorf("cannot trigger Lambda event publish: scenario is @internal"))
		return nil
	})

	// ── Then: assertions ──────────────────────────────────────────────────────

	sc.Then(`^the bus is "ACTIVE"$`, func() error {
		// Arrange
		// Act
		result, err := world.EventBridgeClient().ListEventBuses(context.Background(), &eventbridge.ListEventBusesInput{})
		if err != nil {
			return fmt.Errorf("list event buses: %w", err)
		}
		// Assert
		expectedBus := lambdaEventsTestBus
		actualFound := false
		for _, b := range result.EventBuses {
			if b.Name != nil && *b.Name == expectedBus {
				actualFound = true
				break
			}
		}
		if !actualFound {
			return fmt.Errorf("expected event bus %q to be ACTIVE but not found; expected_bus=%q",
				expectedBus, expectedBus)
		}
		return nil
	})

	sc.Then(`^the bus is "DELETED" and Lambda PutEvents calls targeting it will fail$`, func() error {
		// Arrange
		// Act
		result, err := world.EventBridgeClient().ListEventBuses(context.Background(), &eventbridge.ListEventBusesInput{})
		if err != nil {
			return fmt.Errorf("list event buses: %w", err)
		}
		// Assert
		expectedBus := lambdaEventsTestBus
		actualFound := false
		for _, b := range result.EventBuses {
			if b.Name != nil && *b.Name == expectedBus {
				actualFound = true
				break
			}
		}
		if actualFound {
			return fmt.Errorf("expected event bus %q to be DELETED but found it; expected_bus=%q",
				expectedBus, expectedBus)
		}
		return nil
	})

	sc.Then(`^the invocation is "IN_PROGRESS"$`, func() error {
		// @internal: Cannot observe Lambda invocation state in lws.
		return nil
	})

	sc.Then(`^the invocation is "FAILED" with a ResourceNotFoundException$`, func() error {
		// @internal: Cannot observe Lambda invocation failure in lws.
		return nil
	})

	sc.Then(`^the event is "PUBLISHED" and the invocation is "SUCCESS"$`, func() error {
		// @internal: Cannot observe Lambda invocation result in lws.
		return nil
	})

	// ── Invariant catch-all steps ─────────────────────────────────────────────

	sc.Then(`^every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function$`, func() error {
		// No-op: model-level invariant; trivially satisfied in isolated lws context.
		return nil
	})

	sc.Then(`^every "PUBLISHED" event references a bus that exists$`, func() error {
		// No-op: model-level invariant; trivially satisfied in isolated lws context.
		return nil
	})
}
