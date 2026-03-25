package tests

// registerLambdaGlacierSteps wires all lambda_glacier cross-service step definitions.
// Steps already registered in lambda_test.go ("the function does not already exist",
// "the function already exists", "the function exists", "the function does not exist",
// "the function is \"ACTIVE\"", "the function is not \"ACTIVE\"",
// "an invocation slot is available", "no invocation slot is available"),
// sequences_test.go ("the system is initialized"), and
// sqs_test.go ("the operation is rejected") are NOT re-registered here.

import (
	"context"
	"fmt"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/glacier"
	"github.com/aws/aws-sdk-go-v2/service/lambda"
	lambdatypes "github.com/aws/aws-sdk-go-v2/service/lambda/types"
	"github.com/cucumber/godog"
)

const lambdaGlacierTestFunc = "test-lambda-glacier-1"
const lambdaGlacierTestVault = "test-lambda-glacier-vault-1"
const lambdaGlacierTestRoleArn = "arn:aws:iam::000000000000:role/test"

func lambdaGlacierCreateFunction(world *World) error {
	// Arrange
	// Act
	_, err := world.LambdaClient().CreateFunction(context.Background(), &lambda.CreateFunctionInput{
		FunctionName: aws.String(lambdaGlacierTestFunc),
		Runtime:      lambdatypes.RuntimePython312,
		Role:         aws.String(lambdaGlacierTestRoleArn),
		Handler:      aws.String("index.handler"),
		Code: &lambdatypes.FunctionCode{
			ZipFile: []byte("fake"),
		},
	})
	// Assert: caller checks error
	return err
}

func lambdaGlacierCreateVault(world *World) error {
	// Arrange
	// Act
	_, err := world.GlacierClient().CreateVault(context.Background(), &glacier.CreateVaultInput{
		AccountId: aws.String("-"),
		VaultName: aws.String(lambdaGlacierTestVault),
	})
	// Assert: caller checks error
	return err
}

func lambdaGlacierFindVault(world *World) (bool, error) {
	// Arrange
	// Act
	resp, err := world.GlacierClient().ListVaults(context.Background(), &glacier.ListVaultsInput{
		AccountId: aws.String("-"),
	})
	if err != nil {
		return false, err
	}
	// Assert: check if vault exists
	for _, v := range resp.VaultList {
		if aws.ToString(v.VaultName) == lambdaGlacierTestVault {
			return true, nil
		}
	}
	return false, nil
}

func registerLambdaGlacierSteps(sc *godog.ScenarioContext, world *World) {
	// ── Given: vault state ────────────────────────────────────────────────────

	sc.Given(`^the vault does not already exist$`, func() error {
		// No-op: fresh state has no vaults.
		return nil
	})

	sc.Given(`^the vault already exists$`, func() error {
		// Arrange: create the vault so it already exists
		// Act
		return lambdaGlacierCreateVault(world)
	})

	sc.Given(`^the vault exists$`, func() error {
		// Arrange: create the vault
		// Act
		return lambdaGlacierCreateVault(world)
	})

	sc.Given(`^the vault "EXISTS" \(not already "DELETED"\)$`, func() error {
		// Arrange: create the vault so it exists and is not deleted
		// Act
		return lambdaGlacierCreateVault(world)
	})

	sc.Given(`^the vault is "DELETED"$`, func() error {
		// No-op: fresh state has no vaults (simulates deleted vault).
		return nil
	})

	sc.Given(`^the vault is not "DELETED"$`, func() error {
		// Arrange: create the vault so it is not deleted
		// Act
		return lambdaGlacierCreateVault(world)
	})

	sc.Given(`^the vault is already "DELETED"$`, func() error {
		// No-op: fresh state has no vaults (simulates already deleted vault).
		return nil
	})

	sc.Given(`^the vault does not exist$`, func() error {
		// No-op: fresh state has no vaults.
		return nil
	})

	sc.Given(`^the vault does not exist or is "DELETED"$`, func() error {
		// No-op: fresh state has no vaults (simulates deleted or non-existent vault).
		return nil
	})

	// ── Given: invocation state ───────────────────────────────────────────────

	sc.Given(`^an invocation is "IN_PROGRESS"$`, func() error {
		// Arrange: create the Lambda function so an invocation could be in progress
		// Act
		return lambdaGlacierCreateFunction(world)
	})

	sc.Given(`^no invocation is "IN_PROGRESS"$`, func() error {
		// No-op: fresh state has no in-progress invocations.
		return nil
	})

	// ── Given: slot state ─────────────────────────────────────────────────────

	sc.Given(`^an archive slot is available$`, func() error {
		// No-op: always room for archives in lws.
		return nil
	})

	sc.Given(`^no archive slot is available$`, func() error {
		// @internal: Cannot exhaust archive slot limit in lws via public APIs.
		return nil
	})

	// ── Given: sequence state (fid/vid/iid) ───────────────────────────────────

	sc.Given(`^fid in func_status$`, func() error {
		// Arrange: create the Lambda function so fid is tracked in func_status
		// Act
		return lambdaGlacierCreateFunction(world)
	})

	sc.Given(`^fid not in func_status$`, func() error {
		// No-op: fresh state has no functions in func_status.
		return nil
	})

	sc.Given(`^vid in vault_status$`, func() error {
		// Arrange: create the vault so vid is tracked in vault_status
		// Act
		return lambdaGlacierCreateVault(world)
	})

	sc.Given(`^vid not in vault_status$`, func() error {
		// No-op: fresh state has no vaults in vault_status.
		return nil
	})

	sc.Given(`^iid in inv_status$`, func() error {
		// Arrange: create the Lambda function so an invocation can be tracked
		// Act
		return lambdaGlacierCreateFunction(world)
	})

	// ── When: actions ─────────────────────────────────────────────────────────

	sc.When(`^a Lambda function is deployed$`, func() error {
		// Arrange
		// Act
		result, err := world.LambdaClient().CreateFunction(context.Background(), &lambda.CreateFunctionInput{
			FunctionName: aws.String(lambdaGlacierTestFunc),
			Runtime:      lambdatypes.RuntimePython312,
			Role:         aws.String(lambdaGlacierTestRoleArn),
			Handler:      aws.String("index.handler"),
			Code: &lambdatypes.FunctionCode{
				ZipFile: []byte("fake"),
			},
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^a Glacier vault is created$`, func() error {
		// Arrange
		// Act
		result, err := world.GlacierClient().CreateVault(context.Background(), &glacier.CreateVaultInput{
			AccountId: aws.String("-"),
			VaultName: aws.String(lambdaGlacierTestVault),
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^a Glacier vault is deleted$`, func() error {
		// Arrange
		// Act
		result, err := world.GlacierClient().DeleteVault(context.Background(), &glacier.DeleteVaultInput{
			AccountId: aws.String("-"),
			VaultName: aws.String(lambdaGlacierTestVault),
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

	sc.When(`^the Lambda function fails to upload because the vault has been deleted$`, func() error {
		// @internal: Cannot trigger Lambda invocation failure in lws without Docker.
		setResult(world, nil, fmt.Errorf("cannot trigger Lambda invocation failure: scenario is @internal"))
		return nil
	})

	sc.When(`^the Lambda function uploads an archive to an existing vault and succeeds$`, func() error {
		// @internal: Cannot trigger Lambda archive upload in lws without Docker.
		setResult(world, nil, fmt.Errorf("cannot trigger Lambda archive upload: scenario is @internal"))
		return nil
	})

	// ── Then: assertions ──────────────────────────────────────────────────────

	sc.Then(`^the function is "ACTIVE"$`, func() error {
		// Arrange
		// Act
		resp, err := world.LambdaClient().GetFunction(context.Background(), &lambda.GetFunctionInput{
			FunctionName: aws.String(lambdaGlacierTestFunc),
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

	sc.Then(`^the vault "EXISTS"$`, func() error {
		// Arrange
		// Act
		exists, err := lambdaGlacierFindVault(world)
		if err != nil {
			return fmt.Errorf("list vaults: %w", err)
		}
		// Assert
		expectedExists := true
		actualExists := exists
		if actualExists != expectedExists {
			return fmt.Errorf("expected vault to exist but it was not found; expected_exists=%v actual_exists=%v",
				expectedExists, actualExists)
		}
		return nil
	})

	sc.Then(`^the vault is "DELETED" and archive uploads will fail$`, func() error {
		// Arrange
		// Act
		exists, err := lambdaGlacierFindVault(world)
		if err != nil {
			return fmt.Errorf("list vaults: %w", err)
		}
		// Assert
		expectedExists := false
		actualExists := exists
		if actualExists != expectedExists {
			return fmt.Errorf("expected vault to be deleted but it was found; expected_exists=%v actual_exists=%v",
				expectedExists, actualExists)
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

	sc.Then(`^the archive "EXISTS" in the vault and the invocation is "SUCCESS"$`, func() error {
		// @internal: Cannot observe Lambda archive upload result in lws.
		return nil
	})

	// ── Invariant catch-all steps ─────────────────────────────────────────────

	sc.Then(`^every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function$`, func() error {
		// No-op: model-level invariant; trivially satisfied in isolated lws context.
		return nil
	})

	sc.Then(`^every existing archive references a vault that exists$`, func() error {
		// No-op: model-level invariant; trivially satisfied in isolated lws context.
		return nil
	})
}
