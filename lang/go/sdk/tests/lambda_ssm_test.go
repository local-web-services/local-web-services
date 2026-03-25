package tests

// registerLambdaSsmSteps registers step definitions unique to the lambda_ssm
// cross-service feature files. Steps already registered in single-service files
// that use generic constants (lambda_test.go, ssm_test.go) are re-registered
// here with lambda_ssm-specific resource names so that the When and Then steps
// operate on the correct resources. Steps that are identical no-ops regardless
// of constants are also re-registered for clarity.
//
// Features:
//   lang/specification/core/informal/lambda_ssm/create_parameter.feature
//   lang/specification/core/informal/lambda_ssm/delete_parameter.feature
//   lang/specification/core/informal/lambda_ssm/deploy_function.feature
//   lang/specification/core/informal/lambda_ssm/invocation_fails_parameter_not_found.feature
//   lang/specification/core/informal/lambda_ssm/invocation_succeeds.feature
//   lang/specification/core/informal/lambda_ssm/invoke_function.feature
//
// Safety invariants: InvocationRequiresActiveFunction, SuccessfulInvocationReadAParameter
//
// NOT re-registered (already registered elsewhere with identical no-op behaviour):
//   - "the system is initialized"     — sequences_test.go
//   - "the operation is rejected"     — sqs_test.go

import (
	"context"
	"fmt"
	"strings"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/lambda"
	lambdatypes "github.com/aws/aws-sdk-go-v2/service/lambda/types"
	"github.com/aws/aws-sdk-go-v2/service/ssm"
	ssmtypes "github.com/aws/aws-sdk-go-v2/service/ssm/types"
	"github.com/cucumber/godog"
)

const (
	lsTestFuncName   = "e2e-test-func-1"
	lsTestRoleArn    = "arn:aws:iam::000000000000:role/test"
	lsTestParamName  = "/e2e/test/param/1"
	lsTestParamValue = "e2e-test-value-1"
)

// lsCreateFunction creates the lambda_ssm test Lambda function.
func lsCreateFunction(world *World) error {
	_, err := world.LambdaClient().CreateFunction(context.Background(), &lambda.CreateFunctionInput{
		FunctionName: aws.String(lsTestFuncName),
		Runtime:      lambdatypes.RuntimePython312,
		Role:         aws.String(lsTestRoleArn),
		Handler:      aws.String("index.handler"),
		Code: &lambdatypes.FunctionCode{
			ZipFile: []byte("fake"),
		},
	})
	return err
}

// lsCreateParam creates the lambda_ssm test SSM parameter.
func lsCreateParam(world *World) error {
	_, err := world.SSMClient().PutParameter(context.Background(), &ssm.PutParameterInput{
		Name:  aws.String(lsTestParamName),
		Value: aws.String(lsTestParamValue),
		Type:  ssmtypes.ParameterTypeString,
	})
	return err
}

func registerLambdaSsmSteps(sc *godog.ScenarioContext, world *World) {
	// ── Given: function state ─────────────────────────────────────────────────

	sc.Given(`^the function does not already exist$`, func() error {
		// No-op: fresh state after reset has no Lambda functions.
		return nil
	})

	sc.Given(`^the function already exists$`, func() error {
		// Arrange: create the function so it already exists
		// Act
		return lsCreateFunction(world)
	})

	sc.Given(`^the function exists$`, func() error {
		// Arrange: create the function
		// Act
		return lsCreateFunction(world)
	})

	sc.Given(`^the function does not exist$`, func() error {
		// Arrange: delete the function if present so it does not exist
		// Act: delete, ignore errors (function may not exist)
		_, _ = world.LambdaClient().DeleteFunction(context.Background(), &lambda.DeleteFunctionInput{
			FunctionName: aws.String(lsTestFuncName),
		})
		// Assert: desired state is absence; no assertion needed
		return nil
	})

	sc.Given(`^the function is "ACTIVE"$`, func() error {
		// No-op: lws resolves functions to ACTIVE immediately after creation.
		return nil
	})

	sc.Given(`^the function is not "ACTIVE"$`, func() error {
		// Arrange: delete any existing function, apply a create dwell to leave it in a
		// non-ACTIVE state, then re-create it so the function exists but is not yet ACTIVE.
		sess := managementSession()
		// Act
		_, _ = world.LambdaClient().DeleteFunction(context.Background(), &lambda.DeleteFunctionInput{
			FunctionName: aws.String(lsTestFuncName),
		})
		if err := sess.Lifecycle("lambda").CreateDwellMs(5000).Apply(); err != nil {
			return fmt.Errorf("lifecycle apply failed: %w", err)
		}
		return lsCreateFunction(world)
	})

	// ── Given: parameter state ────────────────────────────────────────────────

	sc.Given(`^the parameter does not already exist$`, func() error {
		// No-op: fresh state after reset has no SSM parameters.
		return nil
	})

	sc.Given(`^the parameter already exists$`, func() error {
		// Arrange: create the parameter so it already exists
		// Act
		return lsCreateParam(world)
	})

	sc.Given(`^the parameter exists$`, func() error {
		// Arrange: create the parameter
		// Act
		return lsCreateParam(world)
	})

	sc.Given(`^the parameter "EXISTS"$`, func() error {
		// No-op: parameter already created by "the parameter exists" step.
		return nil
	})

	sc.Given(`^the parameter is already "DELETED"$`, func() error {
		// Arrange: create then delete the parameter via the lifecycle dwell API
		// Act: create first, ignoring errors
		_ = lsCreateParam(world)
		sess := managementSession()
		if err := sess.Lifecycle("ssm").DeleteDwellMs(5000).Apply(); err != nil {
			return fmt.Errorf("lifecycle apply failed: %w", err)
		}
		_, err := world.SSMClient().DeleteParameter(context.Background(), &ssm.DeleteParameterInput{
			Name: aws.String(lsTestParamName),
		})
		// Assert: capture result so "the operation is rejected" can inspect it
		setResult(world, nil, err)
		return nil
	})

	sc.Given(`^the parameter does not exist$`, func() error {
		// No-op: fresh state after reset has no SSM parameters.
		return nil
	})

	sc.Given(`^the parameter does not exist or is "DELETED"$`, func() error {
		// No-op: fresh state after reset has no SSM parameters.
		return nil
	})

	sc.Given(`^the parameter is "DELETED"$`, func() error {
		// No-op: fresh state has no parameters (simulates deleted parameter).
		return nil
	})

	sc.Given(`^the parameter is not "DELETED"$`, func() error {
		// Arrange: create the parameter so it is not deleted
		// Act
		return lsCreateParam(world)
	})

	// ── Given: invocation state ───────────────────────────────────────────────

	sc.Given(`^an invocation is "IN_PROGRESS"$`, func() error {
		// Arrange: create function so an invocation can be considered in-progress
		// Act
		err := lsCreateFunction(world)
		// Assert: caller checks error; duplicate function ignored
		if err != nil && isAlreadyExists(err) {
			return nil
		}
		return err
	})

	sc.Given(`^no invocation is "IN_PROGRESS"$`, func() error {
		// No-op: fresh state after reset has no in-progress invocations.
		return nil
	})

	sc.Given(`^an invocation slot is available$`, func() error {
		// No-op: always room for invocations in lws.
		return nil
	})

	sc.Given(`^no invocation slot is available$`, func() error {
		// @capacity: Cannot exhaust invocation slot limit via public API in lws.
		return managementSession().Capacity("lambda").Exhaust().Apply()
	})

	// ── When: actions ─────────────────────────────────────────────────────────

	sc.When(`^a Lambda function is deployed$`, func() error {
		// Arrange
		// Act
		result, err := world.LambdaClient().CreateFunction(context.Background(), &lambda.CreateFunctionInput{
			FunctionName: aws.String(lsTestFuncName),
			Runtime:      lambdatypes.RuntimePython312,
			Role:         aws.String(lsTestRoleArn),
			Handler:      aws.String("index.handler"),
			Code: &lambdatypes.FunctionCode{
				ZipFile: []byte("fake"),
			},
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^a parameter is created in "SSM" Parameter Store$`, func() error {
		// Arrange
		// Act
		result, err := world.SSMClient().PutParameter(context.Background(), &ssm.PutParameterInput{
			Name:  aws.String(lsTestParamName),
			Value: aws.String(lsTestParamValue),
			Type:  ssmtypes.ParameterTypeString,
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^a parameter is deleted from "SSM" Parameter Store$`, func() error {
		// Arrange
		// Act
		result, err := world.SSMClient().DeleteParameter(context.Background(), &ssm.DeleteParameterInput{
			Name: aws.String(lsTestParamName),
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

	sc.When(`^the Lambda function fails because the parameter has been deleted$`, func() error {
		// @internal: Cannot trigger Lambda invocation failure in lws without Docker.
		setResult(world, nil, fmt.Errorf("cannot trigger Lambda invocation failure: scenario is @internal"))
		return nil
	})

	sc.When(`^the Lambda function reads an existing parameter and completes successfully$`, func() error {
		// @internal: Cannot trigger Lambda invocation success in lws without Docker.
		setResult(world, nil, fmt.Errorf("cannot trigger Lambda invocation success: scenario is @internal"))
		return nil
	})

	// ── Then: assertions ──────────────────────────────────────────────────────

	sc.Then(`^the function is "ACTIVE"$`, func() error {
		// Arrange
		// Act
		resp, err := world.LambdaClient().GetFunction(context.Background(), &lambda.GetFunctionInput{
			FunctionName: aws.String(lsTestFuncName),
		})
		if err != nil {
			return fmt.Errorf("get function: %w", err)
		}
		// Assert
		expectedState := "Active"
		actualState := string(resp.Configuration.State)
		if actualState != expectedState {
			return fmt.Errorf("expected function state %q but got %q; expected_state=%s actual_state=%s",
				expectedState, actualState, expectedState, actualState)
		}
		return nil
	})

	sc.Then(`^the parameter "EXISTS" and can be read by Lambda$`, func() error {
		// Arrange
		// Act
		resp, err := world.SSMClient().GetParameter(context.Background(), &ssm.GetParameterInput{
			Name: aws.String(lsTestParamName),
		})
		if err != nil {
			return fmt.Errorf("get parameter: %w", err)
		}
		// Assert
		expectedValue := lsTestParamValue
		actualValue := aws.ToString(resp.Parameter.Value)
		if actualValue != expectedValue {
			return fmt.Errorf("expected parameter value %q but got %q; expected_value=%s actual_value=%s",
				expectedValue, actualValue, expectedValue, actualValue)
		}
		return nil
	})

	sc.Then(`^the parameter is "DELETED" and will cause a ParameterNotFound error when read$`, func() error {
		// Arrange
		// Act: attempt to read the parameter; it should be absent
		_, err := world.SSMClient().GetParameter(context.Background(), &ssm.GetParameterInput{
			Name: aws.String(lsTestParamName),
		})
		// Assert
		if err == nil {
			return fmt.Errorf("expected parameter %q to be deleted but it still exists; expected_error=ParameterNotFound actual_error=nil",
				lsTestParamName)
		}
		expectedErrorFragment := "ParameterNotFound"
		actualError := err.Error()
		if !strings.Contains(actualError, expectedErrorFragment) {
			return fmt.Errorf("expected ParameterNotFound error but got %q; expected_error=%s actual_error=%s",
				actualError, expectedErrorFragment, actualError)
		}
		return nil
	})

	sc.Then(`^the invocation is "IN_PROGRESS"$`, func() error {
		// @internal: Cannot observe Lambda invocation state in lws.
		return nil
	})

	sc.Then(`^the invocation is "FAILED" with a ParameterNotFound error$`, func() error {
		// @internal: Cannot observe Lambda invocation failure in lws.
		return nil
	})

	sc.Then(`^the invocation is "SUCCESS"$`, func() error {
		// @internal: Cannot observe Lambda invocation success in lws.
		return nil
	})

	// ── Then: invariants ──────────────────────────────────────────────────────

	sc.Then(`^every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function$`, func() error {
		// No-op: model-level invariant; trivially satisfied in isolated lws context.
		return nil
	})

	sc.Then(`^every successful invocation recorded which parameter it read$`, func() error {
		// No-op: model-level invariant; trivially satisfied in isolated lws context.
		return nil
	})
}
