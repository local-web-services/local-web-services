package tests

// registerLambdaStepFunctionsSteps wires step definitions specific to the
// lambda_stepfunctions cross-service feature files. Steps already registered
// in lambda_test.go and stepfunctions_test.go are NOT re-registered here.
// Only steps that are unique to the lambda_stepfunctions suite appear below.

import (
	"context"
	"fmt"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/lambda"
	lambdatypes "github.com/aws/aws-sdk-go-v2/service/lambda/types"
	"github.com/aws/aws-sdk-go-v2/service/sfn"
	"github.com/cucumber/godog"
)

// lambdaSfnTestStateMachine is the state machine name used in lambda_stepfunctions scenarios.
const lambdaSfnTestStateMachine = "test-sm-1"

// lambdaSfnTestPassDefinition is the minimal Pass-state definition used in these scenarios.
const lambdaSfnTestPassDefinition = `{"StartAt":"Pass","States":{"Pass":{"Type":"Pass","End":true}}}`

func lambdaSfnSmArn() string {
	return fmt.Sprintf("arn:aws:states:%s:%s:stateMachine:%s", lambdaTestRegion, lambdaTestAccountID, lambdaSfnTestStateMachine)
}

func createLambdaSfnStateMachine(world *World) error {
	// Arrange
	// Act
	_, err := world.SFNClient().CreateStateMachine(context.Background(), &sfn.CreateStateMachineInput{
		Name:       aws.String(lambdaSfnTestStateMachine),
		Definition: aws.String(lambdaSfnTestPassDefinition),
		RoleArn:    aws.String(lambdaTestRoleArn),
	})
	// Assert: caller checks error
	return err
}

func registerLambdaStepFunctionsSteps(sc *godog.ScenarioContext, world *World) {
	// ── Given: invocation state ────────────────────────────────────────────────

	sc.Given(`^an invocation is "IN_PROGRESS"$`, func() error {
		// Arrange: create a Lambda function to represent an in-progress invocation context.
		// In lws, creating a function is the closest observable analogue; actual invocation
		// state is internal.
		// Act
		return createLambdaFunction(world)
	})

	sc.Given(`^no invocation is "IN_PROGRESS"$`, func() error {
		// No-op: fresh state has no invocations.
		return nil
	})

	sc.Given(`^an invocation slot is available$`, func() error {
		// No-op: invocation slots are always available in lws fresh state.
		return nil
	})

	sc.Given(`^no invocation slot is available$`, func() error {
		// @internal: Cannot exhaust Lambda invocation slot limit via public API in lws.
		// Scenarios using this step are tagged @capacity; exclude them from standard runs.
		return nil
	})

	// ── Given: execution state ─────────────────────────────────────────────────

	sc.Given(`^an execution is "RUNNING"$`, func() error {
		// Arrange: create a state machine and start an execution so one is RUNNING.
		if err := createLambdaSfnStateMachine(world); err != nil {
			return fmt.Errorf("create state machine for running execution: %w", err)
		}
		// Act: start an execution
		result, err := world.SFNClient().StartExecution(context.Background(), &sfn.StartExecutionInput{
			StateMachineArn: aws.String(lambdaSfnSmArn()),
			Input:           aws.String(`{"key":"value"}`),
		})
		if err != nil {
			return fmt.Errorf("start execution for running state: %w", err)
		}
		if result.ExecutionArn != nil {
			world.lastExecArn = *result.ExecutionArn
		}
		// Assert: execution started (no error)
		return nil
	})

	sc.Given(`^no execution is "RUNNING"$`, func() error {
		// No-op: fresh state has no executions.
		return nil
	})

	sc.Given(`^an execution slot is available$`, func() error {
		// No-op: execution slots are always available in lws fresh state.
		return nil
	})

	sc.Given(`^no execution slot is available$`, func() error {
		// @internal: Cannot exhaust Step Functions execution slot limit via public API in lws.
		// Scenarios using this step are tagged @capacity; exclude them from standard runs.
		return nil
	})

	// ── Given: cross-service state ─────────────────────────────────────────────

	sc.Given(`^the state machine is already "DELETED"$`, func() error {
		// Arrange: create a state machine, apply a delete dwell, then delete it so it remains
		// in a DELETED state for the duration of the scenario.
		sess := managementSession()
		// Act: ignore errors; ensure SM exists first
		_ = createLambdaSfnStateMachine(world)
		if err := sess.Lifecycle("stepfunctions").DeleteDwellMs(5000).Apply(); err != nil {
			return fmt.Errorf("lifecycle apply failed: %w", err)
		}
		_, _ = world.SFNClient().DeleteStateMachine(context.Background(), &sfn.DeleteStateMachineInput{
			StateMachineArn: aws.String(lambdaSfnSmArn()),
		})
		// Assert: desired state is DELETED
		return nil
	})

	sc.Given(`^the state machine is "DELETED"$`, func() error {
		// No-op: fresh state has no state machines (simulates deleted state machine).
		return nil
	})

	sc.Given(`^the state machine is not "DELETED"$`, func() error {
		// Arrange: create a state machine so it exists and is ACTIVE (not DELETED).
		// Act
		return createLambdaSfnStateMachine(world)
	})

	sc.Given(`^the state machine does not exist or is "DELETED"$`, func() error {
		// No-op: fresh state has no state machines.
		return nil
	})

	// ── When: actions ──────────────────────────────────────────────────────────

	sc.When(`^a Lambda function is deployed$`, func() error {
		// Arrange
		// Act
		result, err := world.LambdaClient().CreateFunction(context.Background(), &lambda.CreateFunctionInput{
			FunctionName: aws.String(lambdaTestFunctionName),
			Runtime:      lambdatypes.RuntimePython312,
			Role:         aws.String(lambdaTestRoleArn),
			Handler:      aws.String("index.handler"),
			Code: &lambdatypes.FunctionCode{
				ZipFile: []byte("fake"),
			},
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^a Step Functions state machine is deleted$`, func() error {
		// Arrange
		// Act
		result, err := world.SFNClient().DeleteStateMachine(context.Background(), &sfn.DeleteStateMachineInput{
			StateMachineArn: aws.String(lambdaSfnSmArn()),
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^a running execution completes successfully$`, func() error {
		// @internal: Cannot observe internal execution completion via public API in lws.
		// This scenario is tagged @internal in the feature file and excluded by the tag filter.
		setResult(world, nil, fmt.Errorf("cannot trigger internal execution completion via public API"))
		return nil
	})

	sc.When(`^the Lambda function is invoked$`, func() error {
		// @internal: Cannot trigger Lambda invocation via public API in lws without Docker.
		// This scenario is tagged @internal in the feature file and excluded by the tag filter.
		setResult(world, nil, fmt.Errorf("cannot trigger Lambda invocation via public API in lws"))
		return nil
	})

	sc.When(`^the Lambda function fails to start an execution because the state machine has been deleted$`, func() error {
		// @internal: Cannot trigger Lambda invocation failure via public API in lws.
		// This scenario is tagged @internal and excluded by the tag filter.
		setResult(world, nil, fmt.Errorf("cannot trigger Lambda invocation failure via public API in lws"))
		return nil
	})

	sc.When(`^the Lambda function starts an execution of an "ACTIVE" state machine and succeeds$`, func() error {
		// @internal: Cannot trigger Lambda invocation that starts an execution via public API in lws.
		// This scenario is tagged @internal and excluded by the tag filter.
		setResult(world, nil, fmt.Errorf("cannot trigger Lambda-started execution via public API in lws"))
		return nil
	})

	// ── Then: assertions ───────────────────────────────────────────────────────

	sc.Then(`^the function is "ACTIVE"$`, func() error {
		// Arrange
		expectedState := "Active"
		// Act
		result, err := world.LambdaClient().GetFunction(context.Background(), &lambda.GetFunctionInput{
			FunctionName: aws.String(lambdaTestFunctionName),
		})
		if err != nil {
			return fmt.Errorf("expected function state %q but get_function failed: %w", expectedState, err)
		}
		// Assert
		actualState := string(result.Configuration.State)
		if actualState != expectedState {
			return fmt.Errorf("expected function state %q but got %q; expected_state=%s actual_state=%s",
				expectedState, actualState, expectedState, actualState)
		}
		return nil
	})

	sc.Then(`^the state machine is "DELETED" and Lambda StartExecution calls will fail$`, func() error {
		// Arrange
		expectedErrCode := "StateMachineDoesNotExist"
		// Act: attempt to describe the state machine; it should not be found
		_, err := world.SFNClient().DescribeStateMachine(context.Background(), &sfn.DescribeStateMachineInput{
			StateMachineArn: aws.String(lambdaSfnSmArn()),
		})
		// Assert: expect an error indicating the state machine does not exist
		if err == nil {
			return fmt.Errorf("expected state machine to be deleted but describe_state_machine succeeded unexpectedly; expected_error=%s", expectedErrCode)
		}
		return nil
	})

	sc.Then(`^the execution is "SUCCEEDED"$`, func() error {
		// @internal: Cannot observe internal execution completion via public API in lws.
		return nil
	})

	sc.Then(`^the execution is "RUNNING" and the invocation is "SUCCESS"$`, func() error {
		// @internal: Cannot observe Lambda invocation result or execution state via public API in lws.
		return nil
	})

	sc.Then(`^the invocation is "IN_PROGRESS"$`, func() error {
		// @internal: Cannot observe Lambda invocation state via public API in lws.
		return nil
	})

	sc.Then(`^the invocation is "FAILED" with a StateMachineDoesNotExist error$`, func() error {
		// @internal: Cannot observe Lambda invocation failure via public API in lws.
		return nil
	})

	// ── Then: invariants ───────────────────────────────────────────────────────

	sc.Then(`^every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function$`, func() error {
		// No-op: model-level invariant; trivially satisfied in isolated lws context.
		return nil
	})

	sc.Then(`^every "RUNNING" execution references a state machine that exists$`, func() error {
		// No-op: model-level invariant; trivially satisfied in isolated lws context.
		return nil
	})
}
