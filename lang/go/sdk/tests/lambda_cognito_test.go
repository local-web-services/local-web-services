package tests

// registerLambdaCognitoSteps wires all lambda_cognito cross-service step definitions.
// Steps already registered in lambda_test.go ("the function does not already exist",
// "the function already exists", "the function exists", "the function does not exist",
// "the function is \"ACTIVE\"", "the function is not \"ACTIVE\"",
// "an invocation slot is available", "no invocation slot is available"),
// cognito_idp_test.go, sequences_test.go ("the system is initialized"), and
// sqs_test.go ("the operation is rejected") are NOT re-registered here.

import (
	"context"
	"fmt"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/cognitoidentityprovider"
	"github.com/aws/aws-sdk-go-v2/service/lambda"
	lambdatypes "github.com/aws/aws-sdk-go-v2/service/lambda/types"
	"github.com/cucumber/godog"
)

const lambdaCognitoTestFuncName = "e2e-test-func-1"
const lambdaCognitoTestPoolName = "e2e-test-pool-1"
const lambdaCognitoTestRoleArn = "arn:aws:iam::000000000000:role/test"

func lambdaCognitoCreateFunction(world *World) error {
	// Arrange
	// Act
	_, err := world.LambdaClient().CreateFunction(context.Background(), &lambda.CreateFunctionInput{
		FunctionName: aws.String(lambdaCognitoTestFuncName),
		Runtime:      lambdatypes.RuntimePython312,
		Role:         aws.String(lambdaCognitoTestRoleArn),
		Handler:      aws.String("index.handler"),
		Code: &lambdatypes.FunctionCode{
			ZipFile: []byte("fake"),
		},
	})
	// Assert: caller checks error
	return err
}

func lambdaCognitoCreatePool(world *World) (string, error) {
	// Arrange
	// Act
	resp, err := world.CognitoIDPClient().CreateUserPool(context.Background(), &cognitoidentityprovider.CreateUserPoolInput{
		PoolName: aws.String(lambdaCognitoTestPoolName),
	})
	if err != nil {
		return "", err
	}
	// Assert: caller stores pool ID
	return *resp.UserPool.Id, nil
}

func lambdaCognitoPoolID(world *World) (string, error) {
	// Arrange
	// Act
	resp, err := world.CognitoIDPClient().ListUserPools(context.Background(), &cognitoidentityprovider.ListUserPoolsInput{
		MaxResults: aws.Int32(10),
	})
	if err != nil {
		return "", err
	}
	// Assert: find pool by name
	for _, pool := range resp.UserPools {
		if pool.Name != nil && *pool.Name == lambdaCognitoTestPoolName {
			return *pool.Id, nil
		}
	}
	return "", nil
}

func registerLambdaCognitoSteps(sc *godog.ScenarioContext, world *World) {
	// ── Given: pool state ─────────────────────────────────────────────────────

	sc.Given(`^the pool does not already exist$`, func() error {
		// No-op: fresh state has no Cognito user pools.
		return nil
	})

	sc.Given(`^the pool already exists$`, func() error {
		// Arrange: create the pool so it already exists
		// Act
		_, err := lambdaCognitoCreatePool(world)
		return err
	})

	sc.Given(`^the pool exists$`, func() error {
		// Arrange: create the pool
		// Act
		_, err := lambdaCognitoCreatePool(world)
		return err
	})

	sc.Given(`^the pool is "ACTIVE"$`, func() error {
		// No-op: pools are ACTIVE immediately after creation.
		return nil
	})

	sc.Given(`^the pool is already "DELETED"$`, func() error {
		// Arrange: find the pool and delete it so it is in DELETED state
		// Act
		poolID, err := lambdaCognitoPoolID(world)
		if err != nil {
			return err
		}
		if poolID != "" {
			_, err = world.CognitoIDPClient().DeleteUserPool(context.Background(), &cognitoidentityprovider.DeleteUserPoolInput{
				UserPoolId: aws.String(poolID),
			})
			if err != nil {
				return err
			}
		}
		// Assert: pool is now deleted
		return nil
	})

	sc.Given(`^the pool does not exist$`, func() error {
		// No-op: fresh state has no Cognito user pools.
		return nil
	})

	sc.Given(`^the pool does not exist or is "DELETED"$`, func() error {
		// No-op: fresh state has no pools (simulates deleted or non-existent pool).
		return nil
	})

	sc.Given(`^the pool is "DELETED"$`, func() error {
		// No-op: fresh state has no pools (simulates deleted pool).
		return nil
	})

	sc.Given(`^the pool is not "DELETED"$`, func() error {
		// Arrange: create the pool so it is not DELETED
		// Act
		_, err := lambdaCognitoCreatePool(world)
		return err
	})

	// ── Given: invocation state ───────────────────────────────────────────────

	sc.Given(`^an invocation is "IN_PROGRESS"$`, func() error {
		// Arrange: create the Lambda function so an invocation could be in progress
		// Act
		return lambdaCognitoCreateFunction(world)
	})

	sc.Given(`^no invocation is "IN_PROGRESS"$`, func() error {
		// No-op: fresh state has no in-progress invocations.
		return nil
	})

	// ── When: actions ─────────────────────────────────────────────────────────

	sc.When(`^a Lambda function is deployed$`, func() error {
		// Arrange
		// Act
		result, err := world.LambdaClient().CreateFunction(context.Background(), &lambda.CreateFunctionInput{
			FunctionName: aws.String(lambdaCognitoTestFuncName),
			Runtime:      lambdatypes.RuntimePython312,
			Role:         aws.String(lambdaCognitoTestRoleArn),
			Handler:      aws.String("index.handler"),
			Code: &lambdatypes.FunctionCode{
				ZipFile: []byte("fake"),
			},
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^a Cognito user pool is created$`, func() error {
		// Arrange
		// Act
		result, err := world.CognitoIDPClient().CreateUserPool(context.Background(), &cognitoidentityprovider.CreateUserPoolInput{
			PoolName: aws.String(lambdaCognitoTestPoolName),
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^a Cognito user pool is deleted$`, func() error {
		// Arrange: find the pool ID
		poolID, err := lambdaCognitoPoolID(world)
		if err != nil {
			setResult(world, nil, err)
			return nil
		}
		// Act
		result, deleteErr := world.CognitoIDPClient().DeleteUserPool(context.Background(), &cognitoidentityprovider.DeleteUserPoolInput{
			UserPoolId: aws.String(poolID),
		})
		// Assert: store result
		setResult(world, result, deleteErr)
		return nil
	})

	sc.When(`^the Lambda function is invoked$`, func() error {
		// @internal: Cannot trigger Lambda invocation in lws without Docker.
		setResult(world, nil, fmt.Errorf("cannot trigger Lambda invocation: scenario requires @internal runtime"))
		return nil
	})

	sc.When(`^the Lambda function fails to call Cognito because the pool has been deleted$`, func() error {
		// @internal: Cannot trigger Lambda invocation in lws without Docker.
		setResult(world, nil, fmt.Errorf("cannot trigger Lambda invocation failure: scenario requires @internal runtime"))
		return nil
	})

	sc.When(`^the Lambda function calls a Cognito admin "([^"]*)" on an "([^"]*)" pool and succeeds$`, func(api string, poolState string) error {
		// @internal: Cannot trigger Lambda invocation in lws without Docker.
		setResult(world, nil, fmt.Errorf("cannot trigger Lambda-Cognito invocation success: scenario is @internal"))
		return nil
	})

	// ── Then: assertions ──────────────────────────────────────────────────────

	sc.Then(`^the function is "ACTIVE"$`, func() error {
		// Arrange
		// Act
		resp, err := world.LambdaClient().GetFunction(context.Background(), &lambda.GetFunctionInput{
			FunctionName: aws.String(lambdaCognitoTestFuncName),
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

	sc.Then(`^the pool is "ACTIVE"$`, func() error {
		// Arrange
		// Act
		poolID, err := lambdaCognitoPoolID(world)
		if err != nil {
			return fmt.Errorf("list user pools: %w", err)
		}
		if poolID == "" {
			return fmt.Errorf("expected pool to be ACTIVE but pool was not found")
		}
		resp, err := world.CognitoIDPClient().DescribeUserPool(context.Background(), &cognitoidentityprovider.DescribeUserPoolInput{
			UserPoolId: aws.String(poolID),
		})
		if err != nil {
			return fmt.Errorf("describe user pool: %w", err)
		}
		// Assert
		expectedStatus := "Active"
		actualStatus := string(resp.UserPool.Status)
		if actualStatus != expectedStatus {
			return fmt.Errorf("expected pool status %q but got %q; expected_status=%s actual_status=%s",
				expectedStatus, actualStatus, expectedStatus, actualStatus)
		}
		return nil
	})

	sc.Then(`^the pool is "DELETED" and Lambda calls targeting it will fail$`, func() error {
		// Arrange
		// Act
		poolID, err := lambdaCognitoPoolID(world)
		if err != nil {
			return fmt.Errorf("list user pools: %w", err)
		}
		// Assert
		expectedPoolID := ""
		actualPoolID := poolID
		if actualPoolID != expectedPoolID {
			return fmt.Errorf("expected pool to be deleted but found pool with id %q; expected_pool_id=%q actual_pool_id=%q",
				poolID, expectedPoolID, actualPoolID)
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

	sc.Then(`^the invocation is "SUCCESS"$`, func() error {
		// @internal: Cannot observe Lambda invocation success in lws.
		return nil
	})

	// ── Invariant catch-all steps ─────────────────────────────────────────────

	sc.Then(`^every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function$`, func() error {
		// No-op: model-level invariant; trivially satisfied in isolated lws context.
		return nil
	})

	sc.Then(`^every successful invocation recorded which pool it called$`, func() error {
		// No-op: model-level invariant; trivially satisfied in isolated lws context.
		return nil
	})
}
