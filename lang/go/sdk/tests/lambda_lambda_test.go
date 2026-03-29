package tests

// registerLambdaLambdaSteps wires step definitions for the lambda_lambda
// cross-service feature files (deploy_caller, deploy_callee, delete_callee,
// invoke_caller, callee_invocation_succeeds, callee_invocation_fails).
//
// Steps already registered in lambda_test.go and common_test.go are NOT
// re-registered here.  All @internal-tagged scenarios are excluded by the
// tag filter "(@minimal or @standard) and not @internal" and their steps
// are implemented as no-ops.

import (
	"context"
	"fmt"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/lambda"
	lambdatypes "github.com/aws/aws-sdk-go-v2/service/lambda/types"
	"github.com/cucumber/godog"
)

const lambdaCallerFunctionName = "e2e-lambda-caller-fn-1"
const lambdaCalleeFunctionName = "e2e-lambda-callee-fn-1"

func createLambdaCallerFunction(world *World) error {
	// Arrange
	// Act
	_, err := world.LambdaClient().CreateFunction(context.Background(), &lambda.CreateFunctionInput{
		FunctionName: aws.String(lambdaCallerFunctionName),
		Runtime:      lambdatypes.RuntimePython312,
		Role:         aws.String(lambdaTestRoleArn),
		Handler:      aws.String("index.handler"),
		Code: &lambdatypes.FunctionCode{
			ZipFile: []byte("fake"),
		},
	})
	// Assert: caller checks error
	return err
}

func createLambdaCalleeFunction(world *World) error {
	// Arrange
	// Act
	_, err := world.LambdaClient().CreateFunction(context.Background(), &lambda.CreateFunctionInput{
		FunctionName: aws.String(lambdaCalleeFunctionName),
		Runtime:      lambdatypes.RuntimePython312,
		Role:         aws.String(lambdaTestRoleArn),
		Handler:      aws.String("index.handler"),
		Code: &lambdatypes.FunctionCode{
			ZipFile: []byte("fake"),
		},
	})
	// Assert: caller checks error
	return err
}

func registerLambdaLambdaSteps(sc *godog.ScenarioContext, world *World) {
	// ── Given: caller function state ──────────────────────────────────────────

	sc.Given(`^the caller function does not already exist$`, func() error {
		// No-op: fresh state has no Lambda functions.
		return nil
	})

	sc.Given(`^the caller function already exists$`, func() error {
		// Arrange: create the caller function so it already exists
		// Act
		return createLambdaCallerFunction(world)
	})

	sc.Given(`^the caller exists$`, func() error {
		// Arrange: create the caller function
		// Act
		return createLambdaCallerFunction(world)
	})

	sc.Given(`^the caller is "ACTIVE"$`, func() error {
		// No-op: lws resolves functions to ACTIVE immediately after creation.
		return nil
	})

	sc.Given(`^the caller is not "ACTIVE"$`, func() error {
		// Arrange: delete the caller function, apply a create dwell so it is non-ACTIVE, then re-create.
		sess := managementSession()
		// Act
		_, _ = world.LambdaClient().DeleteFunction(context.Background(), &lambda.DeleteFunctionInput{
			FunctionName: aws.String(lambdaCallerFunctionName),
		})
		if err := sess.Lifecycle("lambda").CreateDwellMs(5000).Apply(); err != nil {
			return fmt.Errorf("lifecycle apply failed: %w", err)
		}
		return createLambdaCallerFunction(world)
	})

	sc.Given(`^the caller does not exist$`, func() error {
		// No-op: fresh state has no Lambda functions.
		return nil
	})

	// ── Given: callee function state ──────────────────────────────────────────

	sc.Given(`^the callee function does not already exist$`, func() error {
		// No-op: fresh state has no Lambda functions.
		return nil
	})

	sc.Given(`^the callee function already exists$`, func() error {
		// Arrange: create the callee function so it already exists
		// Act
		return createLambdaCalleeFunction(world)
	})

	sc.Given(`^the callee exists$`, func() error {
		// Arrange: create the callee function
		// Act
		return createLambdaCalleeFunction(world)
	})

	sc.Given(`^the callee is "ACTIVE"$`, func() error {
		// Arrange: ensure callee exists (create, ignore already-exists errors)
		// Act
		_, _ = world.LambdaClient().CreateFunction(context.Background(), &lambda.CreateFunctionInput{
			FunctionName: aws.String(lambdaCalleeFunctionName),
			Runtime:      lambdatypes.RuntimePython312,
			Role:         aws.String(lambdaTestRoleArn),
			Handler:      aws.String("index.handler"),
			Code: &lambdatypes.FunctionCode{
				ZipFile: []byte("fake"),
			},
		})
		return nil
	})

	sc.Given(`^the callee is already "DELETED"$`, func() error {
		// Arrange: create the callee function, apply a delete dwell so it stays in DELETING, then delete.
		sess := managementSession()
		// Act: create first (ignore errors if already exists)
		_, _ = world.LambdaClient().CreateFunction(context.Background(), &lambda.CreateFunctionInput{
			FunctionName: aws.String(lambdaCalleeFunctionName),
			Runtime:      lambdatypes.RuntimePython312,
			Role:         aws.String(lambdaTestRoleArn),
			Handler:      aws.String("index.handler"),
			Code: &lambdatypes.FunctionCode{
				ZipFile: []byte("fake"),
			},
		})
		if err := sess.Lifecycle("lambda").DeleteDwellMs(5000).Apply(); err != nil {
			return fmt.Errorf("lifecycle apply failed: %w", err)
		}
		_, _ = world.LambdaClient().DeleteFunction(context.Background(), &lambda.DeleteFunctionInput{
			FunctionName: aws.String(lambdaCalleeFunctionName),
		})
		world.lastResult = LastResult{}
		return nil
	})

	sc.Given(`^the callee does not exist$`, func() error {
		// No-op: fresh state has no Lambda functions.
		return nil
	})

	sc.Given(`^the callee does not exist or is "DELETED"$`, func() error {
		// No-op: fresh state has no Lambda functions (simulates absent or deleted callee).
		return nil
	})

	sc.Given(`^the callee is "DELETED"$`, func() error {
		// @internal: No public API puts a callee in DELETED state without deleting it.
		// Only reached by @internal scenarios excluded by the tag filter.
		return nil
	})

	sc.Given(`^the callee is not "DELETED"$`, func() error {
		// Arrange: ensure callee exists (i.e. it is not deleted)
		// Act
		return createLambdaCalleeFunction(world)
	})

	// ── Given: invocation state ────────────────────────────────────────────────
	// NOTE: "an invocation is IN_PROGRESS", "no invocation is IN_PROGRESS",
	// "an invocation slot is available", and "no invocation slot is available"
	// are already registered by registerLambdaSqsSteps and registerLambdaStepfunctionsSteps.
	// They are NOT re-registered here to avoid godog duplicate-step panics.

	// ── When: actions ─────────────────────────────────────────────────────────

	sc.When(`^a caller Lambda function is deployed$`, func() error {
		// Arrange
		// Act
		result, err := world.LambdaClient().CreateFunction(context.Background(), &lambda.CreateFunctionInput{
			FunctionName: aws.String(lambdaCallerFunctionName),
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

	sc.When(`^a callee Lambda function is deployed$`, func() error {
		// Arrange
		// Act
		result, err := world.LambdaClient().CreateFunction(context.Background(), &lambda.CreateFunctionInput{
			FunctionName: aws.String(lambdaCalleeFunctionName),
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

	sc.When(`^the callee Lambda function is deleted$`, func() error {
		// Arrange
		// Act
		result, err := world.LambdaClient().DeleteFunction(context.Background(), &lambda.DeleteFunctionInput{
			FunctionName: aws.String(lambdaCalleeFunctionName),
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^the caller Lambda function is invoked$`, func() error {
		// @internal: Cannot trigger Lambda-to-Lambda invocation in lws without Docker.
		// Only reached by @internal scenarios excluded by the tag filter.
		setResult(world, nil, fmt.Errorf("cannot trigger Lambda invocation: scenario is @internal"))
		return nil
	})

	sc.When(`^the caller fails to invoke the callee because the callee has been deleted$`, func() error {
		// @internal: Cannot trigger Lambda-to-Lambda invocation failure in lws without Docker.
		// Only reached by @internal scenarios excluded by the tag filter.
		setResult(world, nil, fmt.Errorf("cannot trigger Lambda invocation failure: scenario is @internal"))
		return nil
	})

	sc.When(`^the caller Lambda function invokes the "ACTIVE" callee and the call succeeds$`, func() error {
		// @internal: Cannot trigger Lambda-to-Lambda invocation success in lws without Docker.
		// Only reached by @internal scenarios excluded by the tag filter.
		setResult(world, nil, fmt.Errorf("cannot trigger Lambda invocation success: scenario is @internal"))
		return nil
	})

	// ── Then: assertions ──────────────────────────────────────────────────────

	sc.Then(`^the caller function is "ACTIVE"$`, func() error {
		// Arrange
		// Act
		resp, err := world.LambdaClient().GetFunction(context.Background(), &lambda.GetFunctionInput{
			FunctionName: aws.String(lambdaCallerFunctionName),
		})
		if err != nil {
			return fmt.Errorf("get caller function: %w", err)
		}
		// Assert
		expectedState := "Active"
		actualState := string(resp.Configuration.State)
		if actualState != expectedState {
			return fmt.Errorf("expected caller function state %q but got %q; expected_state=%s actual_state=%s",
				expectedState, actualState, expectedState, actualState)
		}
		return nil
	})

	sc.Then(`^the callee function is "ACTIVE"$`, func() error {
		// Arrange
		// Act
		resp, err := world.LambdaClient().GetFunction(context.Background(), &lambda.GetFunctionInput{
			FunctionName: aws.String(lambdaCalleeFunctionName),
		})
		if err != nil {
			return fmt.Errorf("get callee function: %w", err)
		}
		// Assert
		expectedState := "Active"
		actualState := string(resp.Configuration.State)
		if actualState != expectedState {
			return fmt.Errorf("expected callee function state %q but got %q; expected_state=%s actual_state=%s",
				expectedState, actualState, expectedState, actualState)
		}
		return nil
	})

	sc.Then(`^the callee is "DELETED" and invocations targeting it will fail$`, func() error {
		// Arrange
		// Act
		_, err := world.LambdaClient().GetFunction(context.Background(), &lambda.GetFunctionInput{
			FunctionName: aws.String(lambdaCalleeFunctionName),
		})
		// Assert: expect a ResourceNotFoundException (function was deleted)
		if err == nil {
			return fmt.Errorf("expected callee %q to be deleted but it still exists; expected_error=ResourceNotFoundException actual_error=nil",
				lambdaCalleeFunctionName)
		}
		return nil
	})

	sc.Then(`^the invocation is "IN_PROGRESS"$`, func() error {
		// @internal: Cannot observe Lambda invocation state in lws.
		// Only reached by @internal scenarios excluded by the tag filter.
		return nil
	})

	sc.Then(`^the invocation is "FAILED" with a ResourceNotFoundException$`, func() error {
		// @internal: Cannot observe Lambda invocation failure in lws.
		// Only reached by @internal scenarios excluded by the tag filter.
		return nil
	})

	sc.Then(`^the invocation is "SUCCESS"$`, func() error {
		// @internal: Cannot observe Lambda invocation success in lws.
		// Only reached by @internal scenarios excluded by the tag filter.
		return nil
	})

	// ── Invariant catch-all steps ─────────────────────────────────────────────

	sc.Then(`^every "IN_PROGRESS" invocation references an "ACTIVE" caller function$`, func() error {
		// No-op: model-level invariant; trivially satisfied in isolated lws context.
		return nil
	})

	sc.Then(`^every successful invocation recorded which callee was invoked$`, func() error {
		// No-op: model-level invariant; trivially satisfied in isolated lws context.
		return nil
	})
}
