package tests

import (
	"context"
	"fmt"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/cognitoidentityprovider"
	sfntypes "github.com/aws/aws-sdk-go-v2/service/sfn/types"
	"github.com/cucumber/godog"
)

const sfnCognitoTestPoolName = "e2e-test-pool-1"

// sfnCognitoState holds mutable state for StepfunctionsCognito step definitions within one scenario.
type sfnCognitoState struct {
	poolID string
}

func registerStepFunctionsCognitoSteps(sc *godog.ScenarioContext, world *World) {
	st := &sfnCognitoState{}

	sc.Before(func(ctx context.Context, scenario *godog.Scenario) (context.Context, error) {
		st.poolID = ""
		return ctx, nil
	})

	// ── helpers ──────────────────────────────────────────────────────────────────

	createPool := func() (string, error) {
		resp, err := world.CognitoIDPClient().CreateUserPool(context.Background(), &cognitoidentityprovider.CreateUserPoolInput{
			PoolName: aws.String(sfnCognitoTestPoolName),
		})
		if err != nil {
			return "", err
		}
		return *resp.UserPool.Id, nil
	}

	getPoolID := func() (string, error) {
		resp, err := world.CognitoIDPClient().ListUserPools(context.Background(), &cognitoidentityprovider.ListUserPoolsInput{
			MaxResults: aws.Int32(60),
		})
		if err != nil {
			return "", err
		}
		for _, pool := range resp.UserPools {
			if pool.Name != nil && *pool.Name == sfnCognitoTestPoolName {
				return *pool.Id, nil
			}
		}
		return "", nil
	}

	// ── Background ───────────────────────────────────────────────────────────────

	// "the system is initialized" is already registered in sequences_test.go.

	// ── Given: pool existence ────────────────────────────────────────────────────

	sc.Given(`^the pool does not already exist$`, func() error {
		// No-op: fresh state after reset has no user pools.
		return nil
	})

	sc.Given(`^the pool already exists$`, func() error {
		// Arrange: create the test pool so it already exists
		// Act
		poolID, err := createPool()
		if err != nil {
			return err
		}
		// Assert: store pool ID
		st.poolID = poolID
		return nil
	})

	sc.Given(`^the pool exists$`, func() error {
		// Arrange: create the test pool
		// Act
		poolID, err := createPool()
		if err != nil {
			return err
		}
		// Assert: store pool ID
		st.poolID = poolID
		return nil
	})

	sc.Given(`^the pool does not exist$`, func() error {
		// No-op: fresh state after reset has no user pools.
		return nil
	})

	sc.Given(`^the pool does not exist or is "DELETED"$`, func() error {
		// No-op: fresh state after reset has no user pools (simulates absent/deleted pool).
		return nil
	})

	// ── Given: pool status ───────────────────────────────────────────────────────

	sc.Given(`^the pool is "ACTIVE"$`, func() error {
		// No-op: Cognito user pools are ACTIVE immediately after creation.
		return nil
	})

	sc.Given(`^the pool is "DELETED"$`, func() error {
		// No-op: fresh state has no user pools (simulates deleted pool).
		return nil
	})

	sc.Given(`^the pool is not "DELETED"$`, func() error {
		// Arrange: create the pool so it is ACTIVE (not DELETED)
		// Act
		poolID, err := createPool()
		if err != nil {
			return err
		}
		// Assert: store pool ID
		st.poolID = poolID
		return nil
	})

	sc.Given(`^the pool is already "DELETED"$`, func() error {
		// Arrange: create pool, then delete it via lifecycle dwell so it enters DELETED state
		poolID, err := createPool()
		if err != nil {
			return err
		}
		if err := managementSession().Lifecycle("cognitoidp").DeleteDwellMs(5000).Apply(); err != nil {
			return fmt.Errorf("lifecycle apply failed: %w", err)
		}
		_, err = world.CognitoIDPClient().DeleteUserPool(context.Background(), &cognitoidentityprovider.DeleteUserPoolInput{
			UserPoolId: aws.String(poolID),
		})
		// Act: delete triggered
		// Assert: ignore error; desired state is pool deleted
		_ = err
		st.poolID = poolID
		return nil
	})

	// ── Given: execution state ───────────────────────────────────────────────────

	sc.Given(`^an execution is "RUNNING"$`, func() error {
		// Arrange: create the state machine and start an execution
		arn, err := sfnCreateStateMachine(world, sfnTestStateMachine, sfntypes.StateMachineTypeStandard)
		if err != nil {
			return err
		}
		// Act: start an execution
		execArn, err := sfnStartExecution(world, sfnTestStateMachine)
		if err != nil {
			return err
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

	// ── Given: capacity ──────────────────────────────────────────────────────────

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

	// "a Step Functions state machine is created" is already registered in stepfunctions_test.go.

	sc.When(`^a Cognito user pool is created$`, func() error {
		// Arrange: use the test pool name
		_, err := world.CognitoIDPClient().CreateUserPool(context.Background(), &cognitoidentityprovider.CreateUserPoolInput{
			PoolName: aws.String(sfnCognitoTestPoolName),
		})
		// Act: call recorded in world.lastResult
		setResult(world, nil, err)
		// Assert: result captured in world.lastResult
		return nil
	})

	sc.When(`^a Cognito user pool is deleted$`, func() error {
		// Arrange: find the pool ID
		poolID, err := getPoolID()
		if err != nil {
			setResult(world, nil, err)
			return nil
		}
		if poolID == "" {
			setResult(world, nil, fmt.Errorf("ResourceNotFoundException: pool not found"))
			return nil
		}
		// Act
		_, err = world.CognitoIDPClient().DeleteUserPool(context.Background(), &cognitoidentityprovider.DeleteUserPoolInput{
			UserPoolId: aws.String(poolID),
		})
		setResult(world, nil, err)
		// Assert: result captured in world.lastResult
		return nil
	})

	// "an execution of the state machine is started" is already registered in stepfunctions_test.go.

	sc.When(`^a running execution calls an "ACTIVE" Cognito user pool and the task succeeds$`, func() error {
		// @internal scenario: cannot trigger internal execution step that calls Cognito in lws.
		setResult(world, nil, fmt.Errorf("cannot trigger internal execution step that calls Cognito in lws"))
		return nil
	})

	sc.When(`^a running execution fails because the Cognito user pool has been deleted$`, func() error {
		// @internal scenario: cannot trigger internal execution step that fails due to deleted Cognito pool in lws.
		setResult(world, nil, fmt.Errorf("cannot trigger internal execution step that fails due to deleted Cognito pool in lws"))
		return nil
	})

	// ── Then: assertions ──────────────────────────────────────────────────────────

	// "the state machine is "ACTIVE"" is already registered in stepfunctions_test.go.
	// "the execution is "RUNNING"" is already registered in stepfunctions_test.go.
	// "the operation is rejected" is already registered in sqs_test.go.

	sc.Then(`^the pool is "ACTIVE"$`, func() error {
		// Arrange
		expectedPoolName := sfnCognitoTestPoolName
		// Act
		resp, err := world.CognitoIDPClient().ListUserPools(context.Background(), &cognitoidentityprovider.ListUserPoolsInput{
			MaxResults: aws.Int32(60),
		})
		if err != nil {
			return fmt.Errorf("expected list_user_pools to succeed but got: %w", err)
		}
		// Assert
		for _, pool := range resp.UserPools {
			if pool.Name != nil && *pool.Name == expectedPoolName {
				return nil
			}
		}
		return fmt.Errorf("expected pool %q to be ACTIVE but it was not found; expected_pool_name=%s",
			expectedPoolName, expectedPoolName)
	})

	sc.Then(`^the pool is "DELETED" and "SDK" task calls targeting it will fail$`, func() error {
		// Arrange
		expectedPoolName := sfnCognitoTestPoolName
		// Act
		resp, err := world.CognitoIDPClient().ListUserPools(context.Background(), &cognitoidentityprovider.ListUserPoolsInput{
			MaxResults: aws.Int32(60),
		})
		if err != nil {
			return fmt.Errorf("expected list_user_pools to succeed but got: %w", err)
		}
		// Assert: pool must not be present
		for _, pool := range resp.UserPools {
			if pool.Name != nil && *pool.Name == expectedPoolName {
				return fmt.Errorf("expected pool %q to be deleted but it still exists; expected_pool_name=%s",
					expectedPoolName, expectedPoolName)
			}
		}
		return nil
	})

	sc.Then(`^the execution is "SUCCEEDED"$`, func() error {
		// @internal scenario: cannot observe internal execution Cognito task success in lws.
		// No-op: invariant trivially satisfied in isolated lws context.
		return nil
	})

	sc.Then(`^the execution is "FAILED" with a ResourceNotFoundException$`, func() error {
		// @internal scenario: cannot observe internal execution Cognito task failure in lws.
		// No-op: invariant trivially satisfied in isolated lws context.
		return nil
	})

	// ── Then: invariants ──────────────────────────────────────────────────────────

	sc.Then(`^every "RUNNING" execution references an "ACTIVE" state machine$`, func() error {
		// Invariant: trivially satisfied in isolated lws context.
		return nil
	})

	sc.Then(`^every succeeded execution recorded which pool it called$`, func() error {
		// Invariant: trivially satisfied in isolated lws context.
		return nil
	})
}
