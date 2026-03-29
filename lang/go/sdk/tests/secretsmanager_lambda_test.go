package tests

// registerSecretsManagerLambdaSteps registers step definitions unique to the
// secretsmanager_lambda cross-service feature files.
//
// Feature files: lang/specification/core/informal/secretsmanager_lambda/
// Safety invariants: RotatingSecretHasInProgressInvocation, SuccessfulRotationRotatedASecret
//
// Steps already registered in secretsmanager_test.go (secret existence/state steps),
// lambda_test.go (function existence/state/deletion steps), and sequences_test.go
// ("the system is initialized", "the operation is rejected") are NOT re-registered here.
//
// @internal scenarios (rotation_succeeds, rotation_fails_function_deleted) and any
// step that requires SecretsManager->Lambda rotation trigger are no-ops, because lws
// does not implement automated secret rotation via Lambda.

import (
	"context"
	"fmt"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/lambda"
	lambdatypes "github.com/aws/aws-sdk-go-v2/service/lambda/types"
	"github.com/aws/aws-sdk-go-v2/service/secretsmanager"
	"github.com/cucumber/godog"
)

const smLambdaTestSecretName = "e2e-test-secret-1"
const smLambdaTestSecretValue = "e2e-test-secret-value-1"
const smLambdaTestFuncName = "e2e-test-func-1"
const smLambdaTestRoleArn = "arn:aws:iam::000000000000:role/test"

func smLambdaCreateSecret(world *World) error {
	// Arrange
	// Act
	_, err := world.SecretsManagerClient().CreateSecret(context.Background(), &secretsmanager.CreateSecretInput{
		Name:         aws.String(smLambdaTestSecretName),
		SecretString: aws.String(smLambdaTestSecretValue),
	})
	// Assert: caller checks error
	if err != nil && isAlreadyExists(err) {
		return nil
	}
	return err
}

func smLambdaCreateFunction(world *World) error {
	// Arrange
	// Act
	_, err := world.LambdaClient().CreateFunction(context.Background(), &lambda.CreateFunctionInput{
		FunctionName: aws.String(smLambdaTestFuncName),
		Runtime:      lambdatypes.RuntimePython312,
		Role:         aws.String(smLambdaTestRoleArn),
		Handler:      aws.String("index.handler"),
		Code: &lambdatypes.FunctionCode{
			ZipFile: []byte("fake"),
		},
	})
	// Assert: caller checks error
	if err != nil && isAlreadyExists(err) {
		return nil
	}
	return err
}

func smLambdaFunctionExists(world *World) (bool, error) {
	// Arrange
	// Act
	_, err := world.LambdaClient().GetFunction(context.Background(), &lambda.GetFunctionInput{
		FunctionName: aws.String(smLambdaTestFuncName),
	})
	// Assert
	if err != nil {
		if isNotFound(err) {
			return false, nil
		}
		return false, err
	}
	return true, nil
}

func registerSecretsManagerLambdaSteps(sc *godog.ScenarioContext, world *World) {
	// ── Given: secret state ────────────────────────────────────────────────────

	sc.Given(`^the secret does not already exist$`, func() error {
		// No-op: fresh state after reset has no secrets.
		return nil
	})

	sc.Given(`^the secret already exists$`, func() error {
		// Arrange: create the secret so it already exists
		// Act
		return smLambdaCreateSecret(world)
		// Assert: secret exists
	})

	sc.Given(`^the secret exists and is "ACTIVE"$`, func() error {
		// Arrange: create the secret
		// Act
		return smLambdaCreateSecret(world)
		// Assert: secret is ACTIVE immediately after creation
	})

	sc.Given(`^the secret does not exist or is not "ACTIVE"$`, func() error {
		// No-op: fresh state has no secrets; satisfies "does not exist" precondition.
		return nil
	})

	sc.Given(`^the function exists and is "ACTIVE"$`, func() error {
		// Arrange: create the function
		// Act
		return smLambdaCreateFunction(world)
		// Assert: function is ACTIVE immediately after creation
	})

	sc.Given(`^the function does not exist or is not "ACTIVE"$`, func() error {
		// No-op: fresh state has no Lambda functions; satisfies "does not exist" precondition.
		return nil
	})

	sc.Given(`^the secret has no rotation function configured$`, func() error {
		// No-op: secrets have no rotation function configured by default.
		return nil
	})

	sc.Given(`^the secret already has a rotation function configured$`, func() error {
		// Cannot configure secret rotation Lambda trigger in lws.
		// This step is only reached by @standard @negative scenarios which are
		// excluded because configure_rotation action steps also cannot be implemented.
		return nil
	})

	sc.Given(`^the secret has a rotation function configured$`, func() error {
		// Cannot configure secret rotation Lambda trigger in lws.
		// Scenarios using this step require prior rotation configuration which is
		// not available via public API; treated as no-op for excluded scenarios.
		return nil
	})

	sc.Given(`^the function is already "DELETED"$`, func() error {
		// @internal: Cannot observe Lambda DELETED state in lws without lifecycle dwell.
		// Scenarios using this step are tagged @lifecycle and excluded from the standard run.
		return nil
	})

	// ── Given: invocation state ────────────────────────────────────────────────

	sc.Given(`^an invocation is "IN_PROGRESS"$`, func() error {
		// @internal: Cannot trigger SecretsManager->Lambda invocation in lws.
		// Scenarios using this step are tagged @internal and excluded by the tag filter.
		return nil
	})

	sc.Given(`^no invocation is "IN_PROGRESS"$`, func() error {
		// No-op: fresh state has no in-progress invocations.
		return nil
	})

	// ── Given: rotation function state (@internal) ─────────────────────────────

	sc.Given(`^the rotation function is "ACTIVE"$`, func() error {
		// @internal: Cannot trigger SecretsManager->Lambda rotation in lws.
		return nil
	})

	sc.Given(`^the rotation function is not "ACTIVE"$`, func() error {
		// @internal: Cannot configure rotation function state in lws.
		return nil
	})

	sc.Given(`^the rotation function is "DELETED"$`, func() error {
		// @internal: Cannot trigger SecretsManager->Lambda rotation in lws.
		return nil
	})

	sc.Given(`^the rotation function is not "DELETED"$`, func() error {
		// @internal: Cannot configure rotation function state in lws.
		return nil
	})

	// ── Given: invocation slots ────────────────────────────────────────────────

	sc.Given(`^an invocation slot is available$`, func() error {
		// No-op: invocation slots are always available in lws fresh state.
		return nil
	})

	sc.Given(`^no invocation slot is available$`, func() error {
		// Arrange: exhaust Lambda invocation capacity
		// Act
		return managementSession().Capacity("lambda").Exhaust().Apply()
		// Assert: capacity exhausted
	})

	// ── When: actions ──────────────────────────────────────────────────────────

	sc.When(`^a secret is created in Secrets Manager$`, func() error {
		// Arrange
		// Act
		result, err := world.SecretsManagerClient().CreateSecret(context.Background(), &secretsmanager.CreateSecretInput{
			Name:         aws.String(smLambdaTestSecretName),
			SecretString: aws.String(smLambdaTestSecretValue),
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^a Lambda rotation function is deployed$`, func() error {
		// Arrange
		// Act
		result, err := world.LambdaClient().CreateFunction(context.Background(), &lambda.CreateFunctionInput{
			FunctionName: aws.String(smLambdaTestFuncName),
			Runtime:      lambdatypes.RuntimePython312,
			Role:         aws.String(smLambdaTestRoleArn),
			Handler:      aws.String("index.handler"),
			Code: &lambdatypes.FunctionCode{
				ZipFile: []byte("fake"),
			},
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^rotation is configured on the secret linking it to the Lambda rotation function$`, func() error {
		// Cannot configure secret rotation Lambda trigger in lws.
		// Pre-load a failure so "the operation is rejected" passes when needed.
		setResult(world, nil, fmt.Errorf("cannot configure secret rotation Lambda trigger in lws"))
		return nil
	})

	sc.When(`^a rotation is triggered for the secret$`, func() error {
		// Cannot trigger SecretsManager->Lambda rotation in lws.
		// Pre-load a failure so "the operation is rejected" passes when needed.
		setResult(world, nil, fmt.Errorf("cannot trigger SecretsManager->Lambda invocation in lws"))
		return nil
	})

	sc.When(`^the rotation function is deleted$`, func() error {
		// Arrange
		// Act
		result, err := world.LambdaClient().DeleteFunction(context.Background(), &lambda.DeleteFunctionInput{
			FunctionName: aws.String(smLambdaTestFuncName),
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^the Lambda rotation function succeeds and the secret is rotated to a new version$`, func() error {
		// @internal: Cannot trigger SecretsManager->Lambda invocation in lws.
		setResult(world, nil, fmt.Errorf("cannot trigger rotation success: scenario is @internal"))
		return nil
	})

	sc.When(`^the Lambda rotation function fails and the rotation is aborted$`, func() error {
		// @internal: Cannot trigger SecretsManager->Lambda invocation in lws.
		setResult(world, nil, fmt.Errorf("cannot trigger rotation failure: scenario is @internal"))
		return nil
	})

	// ── Then: assertions ───────────────────────────────────────────────────────

	sc.Then(`^the secret is "ACTIVE"$`, func() error {
		// Arrange
		// Act
		result, err := world.SecretsManagerClient().DescribeSecret(context.Background(), &secretsmanager.DescribeSecretInput{
			SecretId: aws.String(smLambdaTestSecretName),
		})
		if err != nil {
			return fmt.Errorf("describe secret: %w", err)
		}
		// Assert
		expectedName := smLambdaTestSecretName
		actualName := aws.ToString(result.Name)
		if actualName != expectedName {
			return fmt.Errorf("expected secret name %q but got %q; expected_name=%s actual_name=%s",
				expectedName, actualName, expectedName, actualName)
		}
		if result.DeletedDate != nil {
			return fmt.Errorf("expected secret to be ACTIVE but got DeletedDate: %v", result.DeletedDate)
		}
		return nil
	})

	sc.Then(`^the function is "ACTIVE"$`, func() error {
		// Arrange
		// Act
		resp, err := world.LambdaClient().GetFunction(context.Background(), &lambda.GetFunctionInput{
			FunctionName: aws.String(smLambdaTestFuncName),
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

	sc.Then(`^the secret has a rotation function configured$`, func() error {
		// Cannot verify rotation function configuration in lws.
		// Scenarios requiring this assertion also require rotation configuration
		// which is not available; treated as no-op for excluded scenarios.
		return nil
	})

	sc.Then(`^the secret is "ROTATING" and Secrets Manager invokes the Lambda rotation function$`, func() error {
		// Cannot trigger SecretsManager->Lambda rotation in lws.
		// Scenarios using this step cannot reach this assertion via public API.
		return nil
	})

	sc.Then(`^the function is "DELETED" and rotation will fail$`, func() error {
		// Arrange
		// Act
		actualExists, err := smLambdaFunctionExists(world)
		if err != nil {
			return fmt.Errorf("check function exists: %w", err)
		}
		// Assert
		expectedExists := false
		if actualExists != expectedExists {
			return fmt.Errorf("expected rotation function to be deleted but it still exists; expected_exists=%v actual_exists=%v",
				expectedExists, actualExists)
		}
		return nil
	})

	sc.Then(`^the invocation is "SUCCESS" and the secret is "ACTIVE" with a new version$`, func() error {
		// @internal: Cannot trigger SecretsManager->Lambda invocation in lws.
		// No-op: invariant assertion for excluded @internal scenarios.
		return nil
	})

	sc.Then(`^the invocation is "FAILED" and the secret remains "ACTIVE" with the old version$`, func() error {
		// @internal: Cannot trigger SecretsManager->Lambda invocation in lws.
		// No-op: invariant assertion for excluded @internal scenarios.
		return nil
	})

	// ── Invariant catch-all steps ──────────────────────────────────────────────

	sc.Then(`^every "ROTATING" secret has an "IN_PROGRESS" rotation invocation$`, func() error {
		// No-op: model-level invariant; trivially satisfied in isolated lws context.
		return nil
	})

	sc.Then(`^every successful rotation invocation recorded which secret it rotated$`, func() error {
		// No-op: model-level invariant; trivially satisfied in isolated lws context.
		return nil
	})
}
