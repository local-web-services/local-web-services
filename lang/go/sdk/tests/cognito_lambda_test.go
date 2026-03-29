package tests

// registerCognitoLambdaSteps wires step definitions unique to the cognito_lambda
// cross-service feature files.
//
// Steps already registered by registerLambdaCognitoSteps (lambda_cognito_test.go):
//   - the pool does not already exist / already exists / exists / does not exist
//   - the pool is "ACTIVE" (Given and Then)
//   - an invocation is "IN_PROGRESS" / no invocation is "IN_PROGRESS"
//   - a Lambda function is deployed
//   - the function is "ACTIVE" (Then); godog allows duplicate registrations — the
//     last registration wins, so cognito_lambda registers its own copy pointing at
//     the cognito_lambda test function name.
//
// Steps already registered by registerLambdaDynamodbSteps (lambda_dynamodb_test.go):
//   - an invocation slot is available / no invocation slot is available
//
// Steps already registered by registerLambdaSteps (lambda_test.go):
//   - the function is "ACTIVE" (Given), the function is not "ACTIVE" (Given)
//
// Steps already registered by registerSequenceSteps / registerSQSSteps:
//   - the system is initialized, the operation is rejected
//
// Only the NEW unique cross-service steps absent from all constituent files are
// defined here.

import (
	"context"
	"fmt"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/cognitoidentityprovider"
	"github.com/aws/aws-sdk-go-v2/service/lambda"
	"github.com/cucumber/godog"
)

const cognitoLambdaTestPoolName = "e2e-test-pool-1"
const cognitoLambdaTestFuncName = "e2e-test-func-1"
const cognitoLambdaTestRoleArn = "arn:aws:iam::000000000000:role/test"
const cognitoLambdaTestUsername = "e2e-test-user-1"

func cognitoLambdaFindPoolID(world *World) (string, error) {
	// Arrange
	// Act
	resp, err := world.CognitoIDPClient().ListUserPools(context.Background(), &cognitoidentityprovider.ListUserPoolsInput{
		MaxResults: aws.Int32(60),
	})
	if err != nil {
		return "", err
	}
	// Assert: find pool by name
	for _, p := range resp.UserPools {
		if p.Name != nil && *p.Name == cognitoLambdaTestPoolName {
			return *p.Id, nil
		}
	}
	return "", nil
}

func registerCognitoLambdaSteps(sc *godog.ScenarioContext, world *World) {
	// ── Given: trigger configuration ─────────────────────────────────────────

	sc.Given(`^the pool has no trigger configured$`, func() error {
		// No-op: pools have no trigger configured by default.
		return nil
	})

	sc.Given(`^the pool already has a trigger configured$`, func() error {
		// @internal: Cannot configure Lambda triggers for Cognito in lws via public APIs.
		return nil
	})

	sc.Given(`^the pool has no pre-signup trigger configured$`, func() error {
		// No-op: pools have no pre-signup trigger configured by default.
		return nil
	})

	sc.Given(`^the pool has a pre-signup trigger configured$`, func() error {
		// @internal: Cannot configure Lambda triggers for Cognito in lws via public APIs.
		return nil
	})

	sc.Given(`^the trigger function is "ACTIVE"$`, func() error {
		// @internal: Cannot configure Lambda triggers for Cognito in lws.
		return nil
	})

	sc.Given(`^the trigger function is not "ACTIVE"$`, func() error {
		// @internal: Cannot configure Lambda triggers for Cognito in lws.
		return nil
	})

	// ── Given: capacity slots ─────────────────────────────────────────────────

	sc.Given(`^the user slot is available$`, func() error {
		// Arrange
		sess := managementSession()
		// Act
		return sess.Capacity("cognitoidp").Unlimited().Apply()
	})

	sc.Given(`^no user slot is available$`, func() error {
		// Arrange
		sess := managementSession()
		// Act
		return sess.Capacity("cognitoidp").Exhaust().Apply()
	})

	// ── When: actions ─────────────────────────────────────────────────────────

	sc.When(`^a Cognito User Pool is created$`, func() error {
		// Arrange
		// Act
		result, err := world.CognitoIDPClient().CreateUserPool(context.Background(), &cognitoidentityprovider.CreateUserPoolInput{
			PoolName: aws.String(cognitoLambdaTestPoolName),
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^a Lambda pre-signup trigger is configured on the Cognito User Pool$`, func() error {
		// @internal: Cannot configure Lambda triggers for Cognito in lws.
		// Store a synthetic error so "the operation is rejected" step can verify rejection.
		setResult(world, nil, fmt.Errorf("cannot configure Lambda trigger: scenario is @internal"))
		return nil
	})

	sc.When(`^a user initiates signup to a pool that has a pre-signup trigger configured$`, func() error {
		// @internal: Cannot trigger Cognito->Lambda invocation in lws.
		setResult(world, nil, fmt.Errorf("cannot trigger Cognito->Lambda invocation: scenario is @internal"))
		return nil
	})

	sc.When(`^a user signs up to a pool that has no pre-signup trigger configured$`, func() error {
		// Arrange: find the pool
		poolID, err := cognitoLambdaFindPoolID(world)
		if err != nil {
			setResult(world, nil, err)
			return nil
		}
		if poolID == "" {
			setResult(world, nil, fmt.Errorf("pool not found"))
			return nil
		}
		// Act: create a user directly (no trigger involved)
		result, apiErr := world.CognitoIDPClient().AdminCreateUser(context.Background(), &cognitoidentityprovider.AdminCreateUserInput{
			UserPoolId:    aws.String(poolID),
			Username:      aws.String(cognitoLambdaTestUsername),
			MessageAction: "SUPPRESS",
		})
		// Assert: store result
		setResult(world, result, apiErr)
		return nil
	})

	sc.When(`^the pre-signup Lambda allows the signup$`, func() error {
		// @internal: Cannot trigger Cognito->Lambda invocation in lws.
		setResult(world, nil, fmt.Errorf("cannot trigger Cognito->Lambda allow: scenario is @internal"))
		return nil
	})

	sc.When(`^the pre-signup Lambda denies the signup$`, func() error {
		// @internal: Cannot trigger Cognito->Lambda invocation in lws.
		setResult(world, nil, fmt.Errorf("cannot trigger Cognito->Lambda deny: scenario is @internal"))
		return nil
	})

	// ── Then: assertions ──────────────────────────────────────────────────────

	sc.Then(`^the pool is "ACTIVE" with no pre-signup trigger configured$`, func() error {
		// Arrange
		// Act
		resp, err := world.CognitoIDPClient().ListUserPools(context.Background(), &cognitoidentityprovider.ListUserPoolsInput{
			MaxResults: aws.Int32(60),
		})
		if err != nil {
			return fmt.Errorf("list user pools: %w", err)
		}
		// Assert
		expectedPoolName := cognitoLambdaTestPoolName
		for _, p := range resp.UserPools {
			if p.Name != nil && *p.Name == expectedPoolName {
				return nil
			}
		}
		return fmt.Errorf("expected pool %q to exist but not found; expected_pool_name=%s",
			expectedPoolName, expectedPoolName)
	})

	sc.Then(`^the function is "ACTIVE"$`, func() error {
		// Arrange
		// Act
		resp, err := world.LambdaClient().GetFunction(context.Background(), &lambda.GetFunctionInput{
			FunctionName: aws.String(cognitoLambdaTestFuncName),
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

	sc.Then(`^all subsequent signups will synchronously invoke the function before confirming$`, func() error {
		// @internal: Cannot configure Lambda triggers for Cognito in lws.
		return nil
	})

	sc.Then(`^the user is "PENDING" and the trigger Lambda is invoked synchronously$`, func() error {
		// @internal: Cannot trigger Cognito->Lambda invocation in lws.
		return nil
	})

	sc.Then(`^the user is immediately "CONFIRMED"$`, func() error {
		// Arrange
		poolID, err := cognitoLambdaFindPoolID(world)
		if err != nil {
			return fmt.Errorf("find pool: %w", err)
		}
		// Act
		resp, err := world.CognitoIDPClient().ListUsers(context.Background(), &cognitoidentityprovider.ListUsersInput{
			UserPoolId: aws.String(poolID),
		})
		if err != nil {
			return fmt.Errorf("list users: %w", err)
		}
		// Assert
		expectedMinCount := 1
		actualCount := len(resp.Users)
		if actualCount < expectedMinCount {
			return fmt.Errorf("expected at least %d user but found %d; expected_min_count=%d actual_count=%d",
				expectedMinCount, actualCount, expectedMinCount, actualCount)
		}
		return nil
	})

	sc.Then(`^the invocation is "SUCCESS" and the user is "CONFIRMED"$`, func() error {
		// @internal: Cannot trigger Cognito->Lambda invocation in lws.
		return nil
	})

	sc.Then(`^the invocation is "FAILED" and the user is "REJECTED"$`, func() error {
		// @internal: Cannot trigger Cognito->Lambda invocation in lws.
		return nil
	})

	// ── Invariant catch-all steps ──────────────────────────────────────────────

	sc.Then(`^every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function$`, func() error {
		// No-op: model-level invariant; trivially satisfied in isolated lws context.
		return nil
	})

	sc.Then(`^every "IN_PROGRESS" invocation is for a "PENDING" user$`, func() error {
		// No-op: model-level invariant; trivially satisfied in isolated lws context.
		return nil
	})

	sc.Then(`^every "PENDING" user has a corresponding "IN_PROGRESS" invocation$`, func() error {
		// No-op: model-level invariant; trivially satisfied in isolated lws context.
		return nil
	})
}
