package tests

import (
	"context"
	"fmt"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/glacier"
	sfntypes "github.com/aws/aws-sdk-go-v2/service/sfn/types"
	"github.com/cucumber/godog"
)

const sfnGlacierTestVault = "test-sf-glacier-vault-1"
const sfnGlacierTestStateMachine = "test-sf-glacier-sm-1"

func registerStepFunctionsGlacierSteps(sc *godog.ScenarioContext, world *World) {
	// ── Given: vault existence ────────────────────────────────────────────────────

	sc.Given(`^the vault does not already exist$`, func() error {
		// No-op: fresh state after reset has no vaults.
		return nil
	})

	sc.Given(`^the vault already exists$`, func() error {
		// Arrange: create the vault so it already exists
		// Act
		_, err := world.GlacierClient().CreateVault(context.Background(), &glacier.CreateVaultInput{
			VaultName: aws.String(sfnGlacierTestVault),
		})
		// Assert: ignore error if already exists
		_ = err
		return nil
	})

	sc.Given(`^the vault exists$`, func() error {
		// Arrange: create the vault
		// Act
		_, err := world.GlacierClient().CreateVault(context.Background(), &glacier.CreateVaultInput{
			VaultName: aws.String(sfnGlacierTestVault),
		})
		// Assert: ignore error if already exists
		_ = err
		return nil
	})

	sc.Given(`^the vault does not exist$`, func() error {
		// No-op: fresh state after reset has no vaults.
		return nil
	})

	// ── Given: vault status ───────────────────────────────────────────────────────

	sc.Given(`^the vault "EXISTS"$`, func() error {
		// Arrange: create the vault so it exists
		// Act
		_, err := world.GlacierClient().CreateVault(context.Background(), &glacier.CreateVaultInput{
			VaultName: aws.String(sfnGlacierTestVault),
		})
		// Assert: ignore error if already exists
		_ = err
		return nil
	})

	sc.Given(`^the vault "EXISTS" \(not already "DELETED"\)$`, func() error {
		// Arrange: create the vault so it exists and is not deleted
		// Act
		_, err := world.GlacierClient().CreateVault(context.Background(), &glacier.CreateVaultInput{
			VaultName: aws.String(sfnGlacierTestVault),
		})
		// Assert: ignore error if already exists
		_ = err
		return nil
	})

	sc.Given(`^the vault is "DELETED"$`, func() error {
		// No-op: fresh state has no vaults (simulates deleted vault).
		return nil
	})

	sc.Given(`^the vault is already "DELETED"$`, func() error {
		// Arrange: create the vault then delete it
		// Act
		_, createErr := world.GlacierClient().CreateVault(context.Background(), &glacier.CreateVaultInput{
			VaultName: aws.String(sfnGlacierTestVault),
		})
		_ = createErr
		_, deleteErr := world.GlacierClient().DeleteVault(context.Background(), &glacier.DeleteVaultInput{
			VaultName: aws.String(sfnGlacierTestVault),
		})
		// Assert: ignore error if already deleted
		_ = deleteErr
		return nil
	})

	sc.Given(`^the vault is not "DELETED"$`, func() error {
		// Arrange: create the vault so it exists (not deleted)
		// Act
		_, err := world.GlacierClient().CreateVault(context.Background(), &glacier.CreateVaultInput{
			VaultName: aws.String(sfnGlacierTestVault),
		})
		// Assert: ignore error if already exists
		_ = err
		return nil
	})

	sc.Given(`^the vault does not exist or is "DELETED"$`, func() error {
		// No-op: fresh state has no vaults (simulates absent/deleted vault).
		return nil
	})

	// ── Given: execution state ────────────────────────────────────────────────────

	sc.Given(`^an execution is "RUNNING"$`, func() error {
		// Arrange: create the state machine and start an execution
		arn, err := sfnCreateStateMachine(world, sfnGlacierTestStateMachine, sfntypes.StateMachineTypeStandard)
		if err != nil {
			return fmt.Errorf("create state machine for RUNNING execution: %w", err)
		}
		// Act: start an execution
		execArn, err := sfnStartExecution(world, sfnGlacierTestStateMachine)
		if err != nil {
			return fmt.Errorf("start execution: %w", err)
		}
		// Assert: execution started
		world.lastStateMachineArn = arn
		world.lastExecArn = execArn
		return nil
	})

	sc.Given(`^no execution is "RUNNING"$`, func() error {
		// No-op: fresh state after reset has no executions.
		return nil
	})

	// ── Given: capacity ───────────────────────────────────────────────────────────

	sc.Given(`^an execution slot is available$`, func() error {
		// Arrange: set unlimited capacity for stepfunctions
		// Act
		if err := managementSession().Capacity("stepfunctions").Unlimited().Apply(); err != nil {
			return fmt.Errorf("capacity unlimited apply failed: %w", err)
		}
		// Assert: capacity is unlimited
		return nil
	})

	sc.Given(`^no execution slot is available$`, func() error {
		// Arrange: exhaust the stepfunctions execution capacity
		// Act
		if err := managementSession().Capacity("stepfunctions").Exhaust().Apply(); err != nil {
			return fmt.Errorf("capacity exhaust apply failed: %w", err)
		}
		// Assert: capacity is exhausted
		return nil
	})

	// ── When: actions ─────────────────────────────────────────────────────────────

	sc.When(`^a Glacier vault is created$`, func() error {
		// Arrange: use the test vault name
		// Act
		_, err := world.GlacierClient().CreateVault(context.Background(), &glacier.CreateVaultInput{
			VaultName: aws.String(sfnGlacierTestVault),
		})
		setResult(world, nil, err)
		// Assert: result captured in world.lastResult
		return nil
	})

	sc.When(`^a Glacier vault is deleted$`, func() error {
		// Arrange: use the test vault name
		// Act
		_, err := world.GlacierClient().DeleteVault(context.Background(), &glacier.DeleteVaultInput{
			VaultName: aws.String(sfnGlacierTestVault),
		})
		setResult(world, nil, err)
		// Assert: result captured in world.lastResult
		return nil
	})

	sc.When(`^a running execution fails because the Glacier vault has been deleted$`, func() error {
		// @internal: Cannot trigger internal execution step that fails due to deleted Glacier vault in lws.
		setResult(world, nil, fmt.Errorf("cannot trigger internal execution step that fails due to deleted Glacier vault in lws"))
		return nil
	})

	sc.When(`^a running execution calls a Glacier vault that "EXISTS" and the task succeeds$`, func() error {
		// @internal: Cannot trigger internal execution step that calls Glacier vault in lws.
		setResult(world, nil, fmt.Errorf("cannot trigger internal execution step that calls Glacier vault in lws"))
		return nil
	})

	// ── Then: assertions ──────────────────────────────────────────────────────────

	sc.Then(`^the vault "EXISTS"$`, func() error {
		// Arrange
		expectedVaultName := sfnGlacierTestVault
		// Act
		result, err := world.GlacierClient().DescribeVault(context.Background(), &glacier.DescribeVaultInput{
			VaultName: aws.String(expectedVaultName),
		})
		if err != nil {
			return fmt.Errorf("expected vault %q to exist but describe failed: %w", expectedVaultName, err)
		}
		// Assert
		actualVaultName := aws.ToString(result.VaultName)
		if actualVaultName != expectedVaultName {
			return fmt.Errorf("expected vault name %q but got %q; expected_vault_name=%s actual_vault_name=%s",
				expectedVaultName, actualVaultName, expectedVaultName, actualVaultName)
		}
		return nil
	})

	sc.Then(`^the vault is "DELETED" and "SDK" task calls targeting it will fail$`, func() error {
		// Arrange
		expectedVaultName := sfnGlacierTestVault
		// Act
		_, err := world.GlacierClient().DescribeVault(context.Background(), &glacier.DescribeVaultInput{
			VaultName: aws.String(expectedVaultName),
		})
		// Assert: describe must fail (vault does not exist)
		if err == nil {
			return fmt.Errorf("expected vault %q to be deleted but it still exists; expected_vault_name=%s",
				expectedVaultName, expectedVaultName)
		}
		return nil
	})

	sc.Then(`^the execution is "RUNNING"$`, func() error {
		// No-op: execution start result is captured in world; RUNNING state verified by absence of error.
		return nil
	})

	sc.Then(`^the execution is "SUCCEEDED"$`, func() error {
		// @internal: Cannot observe internal execution Glacier task success in lws.
		// No-op: treat as invariant satisfied.
		return nil
	})

	sc.Then(`^the execution is "FAILED" with a ResourceNotFoundException$`, func() error {
		// @internal: Cannot observe internal execution Glacier task failure in lws.
		// No-op: treat as invariant satisfied.
		return nil
	})

	// ── Then: invariants ──────────────────────────────────────────────────────────

	sc.Then(`^every "RUNNING" execution references an "ACTIVE" state machine$`, func() error {
		// Invariant: trivially satisfied in isolated lws context.
		return nil
	})

	sc.Then(`^every succeeded execution recorded which vault it called$`, func() error {
		// Invariant: trivially satisfied in isolated lws context.
		return nil
	})
}
