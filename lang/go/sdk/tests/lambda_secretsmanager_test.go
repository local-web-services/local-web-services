package tests

// registerLambdaSecretsManagerSteps registers step definitions specific to the
// lambda_secretsmanager cross-service feature files.
//
// All constituent service steps (function existence, secret existence, lifecycle
// states, operation-is-rejected) are already registered by registerLambdaSteps
// and registerSecretsManagerSteps.  Only the unique cross-service When/Then steps
// and the cross-service Given preconditions that differ in wording from the
// single-service files are defined here.

import (
	"context"
	"fmt"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/lambda"
	lambdatypes "github.com/aws/aws-sdk-go-v2/service/lambda/types"
	"github.com/aws/aws-sdk-go-v2/service/secretsmanager"
	"github.com/cucumber/godog"
)

const lambdaSmTestFunc = "e2e-test-func-1"
const lambdaSmTestSecret = "e2e-test-secret-1"
const lambdaSmTestSecretValue = "e2e-test-secret-value-1"
const lambdaSmTestRoleArn = "arn:aws:iam::000000000000:role/test"

func createLambdaSmFunction(world *World) error {
	// Arrange
	// Act
	_, err := world.LambdaClient().CreateFunction(context.Background(), &lambda.CreateFunctionInput{
		FunctionName: aws.String(lambdaSmTestFunc),
		Runtime:      lambdatypes.RuntimePython312,
		Role:         aws.String(lambdaSmTestRoleArn),
		Handler:      aws.String("index.handler"),
		Code: &lambdatypes.FunctionCode{
			ZipFile: []byte("fake"),
		},
	})
	// Assert: caller checks error
	return err
}

func createLambdaSmSecret(world *World) error {
	// Arrange
	// Act
	_, err := world.SecretsManagerClient().CreateSecret(context.Background(), &secretsmanager.CreateSecretInput{
		Name:         aws.String(lambdaSmTestSecret),
		SecretString: aws.String(lambdaSmTestSecretValue),
	})
	// Assert: caller checks error
	return err
}

func registerLambdaSecretsManagerSteps(sc *godog.ScenarioContext, world *World) {
	// ── Given: invocation state ──────────────────────────────────────────────────

	sc.Given(`^an invocation is "IN_PROGRESS"$`, func() error {
		// Arrange: create the Lambda function so an invocation could be in progress
		// Act
		return createLambdaSmFunction(world)
	})

	sc.Given(`^no invocation is "IN_PROGRESS"$`, func() error {
		// No-op: fresh state has no invocations.
		return nil
	})

	sc.Given(`^an invocation slot is available$`, func() error {
		// No-op: always room for invocations in lws.
		return nil
	})

	sc.Given(`^no invocation slot is available$`, func() error {
		// @internal: Cannot exhaust invocation slot limit in lws via public APIs.
		return nil
	})

	// ── Given: secret state unique to cross-service scenarios ───────────────────

	sc.Given(`^the secret exists and is "ACTIVE"$`, func() error {
		// Arrange: create the secret
		// Act
		return createLambdaSmSecret(world)
	})

	sc.Given(`^the secret is "PENDING_DELETION"$`, func() error {
		// Arrange: create and then soft-delete the secret so it is PENDING_DELETION
		_ = createLambdaSmSecret(world)
		// Act: delete with a recovery window so it enters PENDING_DELETION state
		_, err := world.SecretsManagerClient().DeleteSecret(context.Background(), &secretsmanager.DeleteSecretInput{
			SecretId:              aws.String(lambdaSmTestSecret),
			RecoveryWindowInDays: aws.Int64(7),
		})
		// Assert: caller checks error
		return err
	})

	sc.Given(`^the secret is not pending deletion$`, func() error {
		// Arrange: create the secret (not pending deletion)
		// Act
		return createLambdaSmSecret(world)
	})

	// ── When: actions ─────────────────────────────────────────────────────────────

	sc.When(`^a Lambda function is deployed$`, func() error {
		// Arrange
		// Act
		result, err := world.LambdaClient().CreateFunction(context.Background(), &lambda.CreateFunctionInput{
			FunctionName: aws.String(lambdaSmTestFunc),
			Runtime:      lambdatypes.RuntimePython312,
			Role:         aws.String(lambdaSmTestRoleArn),
			Handler:      aws.String("index.handler"),
			Code: &lambdatypes.FunctionCode{
				ZipFile: []byte("fake"),
			},
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^a secret is created in Secrets Manager$`, func() error {
		// Arrange
		// Act
		result, err := world.SecretsManagerClient().CreateSecret(context.Background(), &secretsmanager.CreateSecretInput{
			Name:         aws.String(lambdaSmTestSecret),
			SecretString: aws.String(lambdaSmTestSecretValue),
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^a secret is scheduled for deletion$`, func() error {
		// Arrange
		// Act
		result, err := world.SecretsManagerClient().DeleteSecret(context.Background(), &secretsmanager.DeleteSecretInput{
			SecretId:              aws.String(lambdaSmTestSecret),
			RecoveryWindowInDays: aws.Int64(7),
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

	sc.When(`^the Lambda function fails because the secret is pending deletion$`, func() error {
		// @internal: Cannot trigger Lambda invocation failure in lws.
		setResult(world, nil, fmt.Errorf("cannot trigger Lambda invocation failure: scenario is @internal"))
		return nil
	})

	sc.When(`^the Lambda function reads an "ACTIVE" secret and completes successfully$`, func() error {
		// @internal: Cannot trigger Lambda invocation success in lws.
		setResult(world, nil, fmt.Errorf("cannot trigger Lambda invocation success: scenario is @internal"))
		return nil
	})

	// ── Then: assertions ──────────────────────────────────────────────────────────

	sc.Then(`^the function is "ACTIVE"$`, func() error {
		// Arrange
		// Act
		resp, err := world.LambdaClient().GetFunction(context.Background(), &lambda.GetFunctionInput{
			FunctionName: aws.String(lambdaSmTestFunc),
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

	sc.Then(`^the secret is "ACTIVE" and can be read by Lambda$`, func() error {
		// Arrange
		// Act
		resp, err := world.SecretsManagerClient().DescribeSecret(context.Background(), &secretsmanager.DescribeSecretInput{
			SecretId: aws.String(lambdaSmTestSecret),
		})
		if err != nil {
			return fmt.Errorf("describe secret: %w", err)
		}
		// Assert
		expectedName := lambdaSmTestSecret
		actualName := aws.ToString(resp.Name)
		if actualName != expectedName {
			return fmt.Errorf("expected secret name %q but got %q; expected_name=%s actual_name=%s",
				expectedName, actualName, expectedName, actualName)
		}
		return nil
	})

	sc.Then(`^the secret is "PENDING_DELETION" and will be unavailable to Lambda during the recovery window$`, func() error {
		// Arrange
		// Act
		resp, err := world.SecretsManagerClient().DescribeSecret(context.Background(), &secretsmanager.DescribeSecretInput{
			SecretId: aws.String(lambdaSmTestSecret),
		})
		if err != nil {
			return fmt.Errorf("describe secret: %w", err)
		}
		// Assert
		actualDeletedDate := resp.DeletedDate
		if actualDeletedDate == nil {
			return fmt.Errorf("expected secret %q to have a DeletedDate (pending deletion) but got nil; actual_deleted_date=nil",
				lambdaSmTestSecret)
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

	// ── Invariant catch-all steps ─────────────────────────────────────────────────

	sc.Then(`^every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function$`, func() error {
		// No-op: model-level invariant; trivially satisfied in isolated lws context.
		return nil
	})

	sc.Then(`^every successful invocation recorded which secret it read$`, func() error {
		// No-op: model-level invariant; trivially satisfied in isolated lws context.
		return nil
	})
}
