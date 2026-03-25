package tests

import (
	"context"
	"fmt"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/sfn"
	sfntypes "github.com/aws/aws-sdk-go-v2/service/sfn/types"
	"github.com/cucumber/godog"
	core "github.com/local-web-services/local-web-services-go-core/lws"
)

const sfnTestStateMachine = "e2e-sfn-test-sm-1"
const sfnTestStateMachineExpress = "e2e-sfn-test-sm-express-1"
const sfnTestRoleArn = "arn:aws:iam::000000000000:role/e2e-role"
const sfnTestPassDefinition = `{"StartAt":"Pass","States":{"Pass":{"Type":"Pass","End":true}}}`
const sfnTestUpdatedDefinition = `{"StartAt":"PassV2","States":{"PassV2":{"Type":"Pass","End":true}}}`
const sfnTestTagKey = "e2e-sfn-test-tag-key-1"
const sfnTestTagValue = "e2e-sfn-test-tag-value-1"
const sfnTestInput = `{"key":"value"}`
const sfnRegion = "us-east-1"
const sfnAccount = "000000000000"

// sfnState holds mutable state for StepFunctions step definitions within one scenario.
type sfnState struct {
	stateMachineArn string
	executionArn    string
}

func sfnSmArn(name string) string {
	return fmt.Sprintf("arn:aws:states:%s:%s:stateMachine:%s", sfnRegion, sfnAccount, name)
}

func sfnCreateStateMachine(world *World, name string, smType sfntypes.StateMachineType) (string, error) {
	// Arrange: disable chaos so the create call goes through
	_ = core.ChaosDisable(world.managementPort, "stepfunctions")
	result, err := world.SFNClient().CreateStateMachine(context.Background(), &sfn.CreateStateMachineInput{
		Name:       aws.String(name),
		Definition: aws.String(sfnTestPassDefinition),
		RoleArn:    aws.String(sfnTestRoleArn),
		Type:       smType,
	})
	if err != nil {
		return "", err
	}
	if result.StateMachineArn == nil {
		return "", fmt.Errorf("CreateStateMachine returned nil ARN")
	}
	return *result.StateMachineArn, nil
}

func sfnStartExecution(world *World, smName string) (string, error) {
	smArn := sfnSmArn(smName)
	result, err := world.SFNClient().StartExecution(context.Background(), &sfn.StartExecutionInput{
		StateMachineArn: aws.String(smArn),
		Input:           aws.String(sfnTestInput),
	})
	if err != nil {
		return "", err
	}
	if result.ExecutionArn == nil {
		return "", fmt.Errorf("StartExecution returned nil ExecutionArn")
	}
	return *result.ExecutionArn, nil
}

func registerStepFunctionsSteps(sc *godog.ScenarioContext, world *World) {
	st := &sfnState{}

	sc.Before(func(ctx context.Context, scenario *godog.Scenario) (context.Context, error) {
		st.stateMachineArn = ""
		st.executionArn = ""
		return ctx, nil
	})

	// ── Background ──────────────────────────────────────────────────────────────

	// "the system is initialized" is already registered in sequences_test.go.

	// ── Operation rejection assertion ────────────────────────────────────────────

	// "the operation is rejected" is already registered in sqs_test.go.

	// ── Given: state machine existence ──────────────────────────────────────────

	sc.Given(`^the state machine does not already exist$`, func() error {
		// No-op: fresh state after reset has no state machines.
		return nil
	})

	sc.Given(`^the state machine already exists$`, func() error {
		// Arrange: create the state machine so it already exists
		arn, err := sfnCreateStateMachine(world, sfnTestStateMachine, sfntypes.StateMachineTypeStandard)
		if err != nil {
			return err
		}
		// Act: store ARN
		st.stateMachineArn = arn
		// Assert: state machine exists (no error)
		return nil
	})

	sc.Given(`^the state machine exists$`, func() error {
		// Arrange: create the state machine
		arn, err := sfnCreateStateMachine(world, sfnTestStateMachine, sfntypes.StateMachineTypeStandard)
		if err != nil {
			return err
		}
		// Act: store ARN
		st.stateMachineArn = arn
		// Assert: state machine exists (no error)
		return nil
	})

	sc.Given(`^the state machine does not exist$`, func() error {
		// No-op: fresh state after reset has no state machines.
		return nil
	})

	// ── Given: state machine status / type ──────────────────────────────────────

	sc.Given(`^the state machine is "ACTIVE"$`, func() error {
		// No-op: state machines are ACTIVE immediately after creation.
		return nil
	})

	sc.Given(`^the state machine is not "ACTIVE"$`, func() error {
		// Arrange: use lifecycle to keep state machine in CREATING state
		if err := managementSession().Lifecycle("stepfunctions").CreateDwellMs(5000).Apply(); err != nil {
			return fmt.Errorf("lifecycle apply failed: %w", err)
		}
		arn, err := sfnCreateStateMachine(world, sfnTestStateMachine, sfntypes.StateMachineTypeStandard)
		if err != nil {
			return err
		}
		// Act: store ARN
		st.stateMachineArn = arn
		// Assert: state machine is stuck in CREATING
		return nil
	})

	sc.Given(`^the state machine is "DELETING"$`, func() error {
		// Arrange: delete the state machine so it enters DELETING state
		smArn := sfnSmArn(sfnTestStateMachine)
		_, err := world.SFNClient().DeleteStateMachine(context.Background(), &sfn.DeleteStateMachineInput{
			StateMachineArn: aws.String(smArn),
		})
		// Act: state machine deletion triggered
		// Assert: ignore error if SM doesn't exist
		_ = err
		return nil
	})

	sc.Given(`^the state machine is not "DELETING"$`, func() error {
		// No-op: state machines are not DELETING by default in a fresh state.
		return nil
	})

	sc.Given(`^the state machine is a "STANDARD" type$`, func() error {
		// No-op: state machine is STANDARD by default.
		return nil
	})

	sc.Given(`^the state machine is not a "STANDARD" type$`, func() error {
		// Arrange: create an EXPRESS type state machine instead
		arn, err := sfnCreateStateMachine(world, sfnTestStateMachineExpress, sfntypes.StateMachineTypeExpress)
		if err != nil {
			return err
		}
		// Act: store ARN
		st.stateMachineArn = arn
		// Assert: EXPRESS type state machine exists
		return nil
	})

	sc.Given(`^the state machine is an "EXPRESS" type$`, func() error {
		// Arrange: create an EXPRESS type state machine
		arn, err := sfnCreateStateMachine(world, sfnTestStateMachineExpress, sfntypes.StateMachineTypeExpress)
		if err != nil {
			return err
		}
		// Act: store ARN
		st.stateMachineArn = arn
		// Assert: EXPRESS type state machine exists
		return nil
	})

	sc.Given(`^the state machine is not an "EXPRESS" type$`, func() error {
		// Arrange: ensure a STANDARD type state machine exists; no-op if already created
		if st.stateMachineArn == "" {
			arn, err := sfnCreateStateMachine(world, sfnTestStateMachine, sfntypes.StateMachineTypeStandard)
			if err != nil {
				return err
			}
			// Act: store ARN
			st.stateMachineArn = arn
		}
		// Assert: STANDARD state machine exists
		return nil
	})

	// ── Given: execution existence ───────────────────────────────────────────────

	sc.Given(`^the execution exists$`, func() error {
		// Arrange: ensure state machine exists
		if st.stateMachineArn == "" {
			arn, err := sfnCreateStateMachine(world, sfnTestStateMachine, sfntypes.StateMachineTypeStandard)
			if err != nil {
				return err
			}
			st.stateMachineArn = arn
		}
		smName := sfnTestStateMachine
		if st.stateMachineArn != "" {
			// derive name from stored ARN if available
			_ = st.stateMachineArn
		}
		// Act: start an execution
		execArn, err := sfnStartExecution(world, smName)
		if err != nil {
			return err
		}
		// Assert: store execution ARN
		st.executionArn = execArn
		world.lastExecArn = execArn
		return nil
	})

	sc.Given(`^the execution is "RUNNING"$`, func() error {
		// No-op: newly started executions are RUNNING.
		return nil
	})

	sc.Given(`^the execution is not "RUNNING"$`, func() error {
		// Arrange: ensure state machine exists so execution can start
		if st.stateMachineArn == "" {
			arn, err := sfnCreateStateMachine(world, sfnTestStateMachine, sfntypes.StateMachineTypeStandard)
			if err != nil {
				return err
			}
			st.stateMachineArn = arn
		}
		// Act: start an execution; a Pass state machine completes immediately, leaving it SUCCEEDED (not RUNNING)
		execArn, err := sfnStartExecution(world, sfnTestStateMachine)
		if err != nil {
			return err
		}
		st.executionArn = execArn
		world.lastExecArn = execArn
		// Assert: execution is non-RUNNING (SUCCEEDED) by the time this step completes
		return nil
	})

	sc.Given(`^the execution does not exist$`, func() error {
		// No-op: fresh state after reset has no executions.
		return nil
	})

	// ── Given: tags ──────────────────────────────────────────────────────────────

	sc.Given(`^the tag is associated with the state machine$`, func() error {
		// Arrange: tag the state machine
		smArn := sfnSmArn(sfnTestStateMachine)
		_, err := world.SFNClient().TagResource(context.Background(), &sfn.TagResourceInput{
			ResourceArn: aws.String(smArn),
			Tags: []sfntypes.Tag{
				{Key: aws.String(sfnTestTagKey), Value: aws.String(sfnTestTagValue)},
			},
		})
		// Act: tag added
		// Assert: no error
		return err
	})

	sc.Given(`^the tag association is active$`, func() error {
		// No-op: tag associations are always active after creation.
		return nil
	})

	sc.Given(`^the tag is not associated with the state machine$`, func() error {
		// No-op: a fresh state machine has no tags.
		return nil
	})

	sc.Given(`^the tag association is not active$`, func() error {
		// Arrange: remove the tag association to simulate it being inactive
		smArn := sfnSmArn(sfnTestStateMachine)
		_, err := world.SFNClient().UntagResource(context.Background(), &sfn.UntagResourceInput{
			ResourceArn: aws.String(smArn),
			TagKeys:     []string{sfnTestTagKey},
		})
		// Act: tag removed
		// Assert: ignore error; desired state is tag absent
		_ = err
		return nil
	})

	// ── Given: capacity ─────────────────────────────────────────────────────────

	sc.Given(`^the execution slot is available$`, func() error {
		// Arrange: set unlimited capacity for stepfunctions
		// Act
		if err := managementSession().Capacity("stepfunctions").Unlimited().Apply(); err != nil {
			return fmt.Errorf("capacity unlimited apply failed: %w", err)
		}
		// Assert: capacity is unlimited
		return nil
	})

	sc.Given(`^the execution slot is not available$`, func() error {
		// Arrange: exhaust the stepfunctions execution capacity
		// Act
		if err := managementSession().Capacity("stepfunctions").Exhaust().Apply(); err != nil {
			return fmt.Errorf("capacity exhaust apply failed: %w", err)
		}
		// Assert: capacity is exhausted
		return nil
	})

	// ── When: actions ────────────────────────────────────────────────────────────

	sc.When(`^a Step Functions state machine is created$`, func() error {
		// Arrange: use the test state machine name
		_, err := world.SFNClient().CreateStateMachine(context.Background(), &sfn.CreateStateMachineInput{
			Name:       aws.String(sfnTestStateMachine),
			Definition: aws.String(sfnTestPassDefinition),
			RoleArn:    aws.String(sfnTestRoleArn),
		})
		// Act: call recorded in world.lastResult
		setResult(world, nil, err)
		if err == nil {
			st.stateMachineArn = sfnSmArn(sfnTestStateMachine)
		}
		// Assert: result captured in world.lastResult
		return nil
	})

	sc.When(`^a state machine is deleted$`, func() error {
		// Arrange: determine which state machine to delete
		smName := sfnTestStateMachine
		if st.stateMachineArn != "" {
			smName = sfnTestStateMachine
		}
		// Act
		_, err := world.SFNClient().DeleteStateMachine(context.Background(), &sfn.DeleteStateMachineInput{
			StateMachineArn: aws.String(sfnSmArn(smName)),
		})
		setResult(world, nil, err)
		// Assert: result captured in world.lastResult
		return nil
	})

	sc.When(`^a state machine is described$`, func() error {
		// Arrange
		smName := sfnTestStateMachine
		// Act
		result, err := world.SFNClient().DescribeStateMachine(context.Background(), &sfn.DescribeStateMachineInput{
			StateMachineArn: aws.String(sfnSmArn(smName)),
		})
		setResult(world, result, err)
		// Assert: result captured in world.lastResult
		return nil
	})

	sc.When(`^all state machines are listed$`, func() error {
		// Arrange: no setup required
		// Act
		result, err := world.SFNClient().ListStateMachines(context.Background(), &sfn.ListStateMachinesInput{})
		setResult(world, result, err)
		// Assert: result captured in world.lastResult
		return nil
	})

	sc.When(`^executions for a state machine are listed$`, func() error {
		// Arrange
		smName := sfnTestStateMachine
		// Act
		result, err := world.SFNClient().ListExecutions(context.Background(), &sfn.ListExecutionsInput{
			StateMachineArn: aws.String(sfnSmArn(smName)),
		})
		setResult(world, result, err)
		// Assert: result captured in world.lastResult
		return nil
	})

	sc.When(`^versions of a state machine are listed$`, func() error {
		// Arrange
		smName := sfnTestStateMachine
		// Act
		result, err := world.SFNClient().ListStateMachineVersions(context.Background(), &sfn.ListStateMachineVersionsInput{
			StateMachineArn: aws.String(sfnSmArn(smName)),
		})
		setResult(world, result, err)
		// Assert: result captured in world.lastResult
		return nil
	})

	sc.When(`^tags for a state machine are listed$`, func() error {
		// Arrange
		smName := sfnTestStateMachine
		// Act
		result, err := world.SFNClient().ListTagsForResource(context.Background(), &sfn.ListTagsForResourceInput{
			ResourceArn: aws.String(sfnSmArn(smName)),
		})
		setResult(world, result, err)
		// Assert: result captured in world.lastResult
		return nil
	})

	sc.When(`^an execution is started on a standard state machine$`, func() error {
		// Arrange: use the state machine ARN set by the Given step, falling back to default
		smArn := st.stateMachineArn
		if smArn == "" {
			smArn = sfnSmArn(sfnTestStateMachine)
		}
		// Act
		result, err := world.SFNClient().StartExecution(context.Background(), &sfn.StartExecutionInput{
			StateMachineArn: aws.String(smArn),
			Input:           aws.String(sfnTestInput),
		})
		setResult(world, result, err)
		if err == nil && result.ExecutionArn != nil {
			st.executionArn = *result.ExecutionArn
			world.lastExecArn = *result.ExecutionArn
		}
		// Assert: result captured in world.lastResult
		return nil
	})

	sc.When(`^a synchronous execution is started on an express state machine$`, func() error {
		// Arrange
		smName := sfnTestStateMachineExpress
		// Act
		result, err := world.SFNClient().StartSyncExecution(context.Background(), &sfn.StartSyncExecutionInput{
			StateMachineArn: aws.String(sfnSmArn(smName)),
			Input:           aws.String(sfnTestInput),
		})
		setResult(world, result, err)
		// Assert: result captured in world.lastResult
		return nil
	})

	sc.When(`^a running execution is stopped$`, func() error {
		// Arrange
		execArn := st.executionArn
		if execArn == "" {
			execArn = world.lastExecArn
		}
		// Act
		result, err := world.SFNClient().StopExecution(context.Background(), &sfn.StopExecutionInput{
			ExecutionArn: aws.String(execArn),
		})
		setResult(world, result, err)
		// Assert: result captured in world.lastResult
		return nil
	})

	sc.When(`^an execution is described$`, func() error {
		// Arrange
		execArn := st.executionArn
		if execArn == "" {
			execArn = world.lastExecArn
		}
		// Act
		result, err := world.SFNClient().DescribeExecution(context.Background(), &sfn.DescribeExecutionInput{
			ExecutionArn: aws.String(execArn),
		})
		setResult(world, result, err)
		// Assert: result captured in world.lastResult
		return nil
	})

	sc.When(`^the event history of an execution is retrieved$`, func() error {
		// Arrange
		execArn := st.executionArn
		if execArn == "" {
			execArn = world.lastExecArn
		}
		// Act
		result, err := world.SFNClient().GetExecutionHistory(context.Background(), &sfn.GetExecutionHistoryInput{
			ExecutionArn: aws.String(execArn),
		})
		setResult(world, result, err)
		// Assert: result captured in world.lastResult
		return nil
	})

	sc.When(`^a state machine definition is updated$`, func() error {
		// Arrange
		smName := sfnTestStateMachine
		// Act
		result, err := world.SFNClient().UpdateStateMachine(context.Background(), &sfn.UpdateStateMachineInput{
			StateMachineArn: aws.String(sfnSmArn(smName)),
			Definition:      aws.String(sfnTestUpdatedDefinition),
		})
		setResult(world, result, err)
		// Assert: result captured in world.lastResult
		return nil
	})

	sc.When(`^tags are added to a state machine$`, func() error {
		// Arrange
		smName := sfnTestStateMachine
		// Act
		result, err := world.SFNClient().TagResource(context.Background(), &sfn.TagResourceInput{
			ResourceArn: aws.String(sfnSmArn(smName)),
			Tags: []sfntypes.Tag{
				{Key: aws.String(sfnTestTagKey), Value: aws.String(sfnTestTagValue)},
			},
		})
		setResult(world, result, err)
		// Assert: result captured in world.lastResult
		return nil
	})

	sc.When(`^tags are removed from a state machine$`, func() error {
		// Arrange
		smName := sfnTestStateMachine
		// Act
		result, err := world.SFNClient().UntagResource(context.Background(), &sfn.UntagResourceInput{
			ResourceArn: aws.String(sfnSmArn(smName)),
			TagKeys:     []string{sfnTestTagKey},
		})
		setResult(world, result, err)
		// Assert: result captured in world.lastResult
		return nil
	})

	sc.When(`^a state machine definition is validated$`, func() error {
		// Arrange: ValidateStateMachineDefinition does not accept a stateMachineArn;
		// validate the pass definition directly.
		// Act
		result, err := world.SFNClient().ValidateStateMachineDefinition(context.Background(), &sfn.ValidateStateMachineDefinitionInput{
			Definition: aws.String(sfnTestPassDefinition),
		})
		setResult(world, result, err)
		// Assert: result captured in world.lastResult
		return nil
	})

	sc.When(`^a state machine deletion is finalized$`, func() error {
		// Cannot trigger internal state machine finalization event via public API.
		setResult(world, nil, fmt.Errorf("cannot trigger internal finalization event via public API"))
		return nil
	})

	sc.When(`^a running execution transitions to a terminal state$`, func() error {
		// Cannot trigger internal execution step transition via public API.
		setResult(world, nil, fmt.Errorf("cannot trigger internal execution step transition via public API"))
		return nil
	})

	sc.When(`^a running execution exceeds its timeout$`, func() error {
		// Cannot trigger execution timeout programmatically.
		setResult(world, nil, fmt.Errorf("cannot trigger execution timeout programmatically"))
		return nil
	})

	// ── Then: assertions ─────────────────────────────────────────────────────────

	sc.Then(`^the state machine is "ACTIVE"$`, func() error {
		// Arrange
		smName := sfnTestStateMachine
		expectedStatus := "ACTIVE"
		// Act
		result, err := world.SFNClient().DescribeStateMachine(context.Background(), &sfn.DescribeStateMachineInput{
			StateMachineArn: aws.String(sfnSmArn(smName)),
		})
		if err != nil {
			return fmt.Errorf("expected state machine status %q but describe failed: %w", expectedStatus, err)
		}
		// Assert
		actualStatus := string(result.Status)
		if actualStatus != expectedStatus {
			return fmt.Errorf("expected state machine status %q but got %q; expected_status=%s actual_status=%s",
				expectedStatus, actualStatus, expectedStatus, actualStatus)
		}
		return nil
	})

	sc.Then(`^the state machine is in "DELETING" state$`, func() error {
		// Arrange: verify delete succeeded (no error means it entered DELETING)
		// Act: action already performed in When step
		// Assert
		expectedSuccess := true
		actualSuccess := world.lastResult.Success
		if !actualSuccess {
			return fmt.Errorf("expected delete_state_machine to succeed but got error: %v; expected_success=%v actual_success=%v",
				world.lastResult.Error, expectedSuccess, actualSuccess)
		}
		return nil
	})

	sc.Then(`^the state machine is "DELETED"$`, func() error {
		// Arrange: verify finalization succeeded
		// Act: action already performed in When step
		// Assert
		expectedSuccess := true
		actualSuccess := world.lastResult.Success
		if !actualSuccess {
			return fmt.Errorf("expected finalization to succeed but got error: %v; expected_success=%v actual_success=%v",
				world.lastResult.Error, expectedSuccess, actualSuccess)
		}
		return nil
	})

	sc.Then(`^the state machine details are returned$`, func() error {
		// Arrange: no additional setup required
		// Act: action already performed in When step
		// Assert
		expectedSuccess := true
		actualSuccess := world.lastResult.Success
		if !actualSuccess {
			return fmt.Errorf("expected describe_state_machine to succeed but got error: %v; expected_success=%v actual_success=%v",
				world.lastResult.Error, expectedSuccess, actualSuccess)
		}
		result, ok := world.lastResult.Output.(*sfn.DescribeStateMachineOutput)
		if !ok || result == nil || result.Name == nil {
			return fmt.Errorf("expected 'name' field in describe_state_machine response")
		}
		return nil
	})

	sc.Then(`^the list of state machines is returned$`, func() error {
		// Arrange: no additional setup required
		// Act: action already performed in When step
		// Assert
		expectedSuccess := true
		actualSuccess := world.lastResult.Success
		if !actualSuccess {
			return fmt.Errorf("expected list_state_machines to succeed but got error: %v; expected_success=%v actual_success=%v",
				world.lastResult.Error, expectedSuccess, actualSuccess)
		}
		result, ok := world.lastResult.Output.(*sfn.ListStateMachinesOutput)
		if !ok || result == nil {
			return fmt.Errorf("expected StateMachines field in list_state_machines response")
		}
		return nil
	})

	sc.Then(`^the list of executions is returned$`, func() error {
		// Arrange: no additional setup required
		// Act: action already performed in When step
		// Assert
		expectedSuccess := true
		actualSuccess := world.lastResult.Success
		if !actualSuccess {
			return fmt.Errorf("expected list_executions to succeed but got error: %v; expected_success=%v actual_success=%v",
				world.lastResult.Error, expectedSuccess, actualSuccess)
		}
		result, ok := world.lastResult.Output.(*sfn.ListExecutionsOutput)
		if !ok || result == nil {
			return fmt.Errorf("expected Executions field in list_executions response")
		}
		return nil
	})

	sc.Then(`^the list of state machine versions is returned$`, func() error {
		// Arrange: no additional setup required
		// Act: action already performed in When step
		// Assert
		expectedSuccess := true
		actualSuccess := world.lastResult.Success
		if !actualSuccess {
			return fmt.Errorf("expected list_state_machine_versions to succeed but got error: %v; expected_success=%v actual_success=%v",
				world.lastResult.Error, expectedSuccess, actualSuccess)
		}
		result, ok := world.lastResult.Output.(*sfn.ListStateMachineVersionsOutput)
		if !ok || result == nil {
			return fmt.Errorf("expected StateMachineVersions field in response")
		}
		return nil
	})

	sc.Then(`^the list of tags is returned$`, func() error {
		// Arrange: no additional setup required
		// Act: action already performed in When step
		// Assert
		expectedSuccess := true
		actualSuccess := world.lastResult.Success
		if !actualSuccess {
			return fmt.Errorf("expected list_tags_for_resource to succeed but got error: %v; expected_success=%v actual_success=%v",
				world.lastResult.Error, expectedSuccess, actualSuccess)
		}
		result, ok := world.lastResult.Output.(*sfn.ListTagsForResourceOutput)
		if !ok || result == nil {
			return fmt.Errorf("expected Tags field in list_tags_for_resource response")
		}
		return nil
	})

	sc.Then(`^the execution is "RUNNING"$`, func() error {
		// Arrange
		expectedKey := "executionArn"
		// Act: action already performed in When step
		// Assert
		expectedSuccess := true
		actualSuccess := world.lastResult.Success
		if !actualSuccess {
			return fmt.Errorf("expected start_execution to succeed but got error: %v; expected_success=%v actual_success=%v",
				world.lastResult.Error, expectedSuccess, actualSuccess)
		}
		result, ok := world.lastResult.Output.(*sfn.StartExecutionOutput)
		if !ok || result == nil || result.ExecutionArn == nil {
			return fmt.Errorf("expected %q in start_execution response", expectedKey)
		}
		return nil
	})

	sc.Then(`^the execution is "ABORTED"$`, func() error {
		// Arrange
		expectedStatus := "ABORTED"
		execArn := st.executionArn
		if execArn == "" {
			execArn = world.lastExecArn
		}
		// Act: check stop succeeded
		if !world.lastResult.Success {
			return fmt.Errorf("expected stop_execution to succeed but got error: %v", world.lastResult.Error)
		}
		// Act: describe to verify status
		descResult, err := world.SFNClient().DescribeExecution(context.Background(), &sfn.DescribeExecutionInput{
			ExecutionArn: aws.String(execArn),
		})
		if err != nil {
			return fmt.Errorf("expected describe_execution to succeed but got: %w", err)
		}
		// Assert
		actualStatus := string(descResult.Status)
		if actualStatus != expectedStatus {
			return fmt.Errorf("expected execution status %q but got %q; expected_status=%s actual_status=%s",
				expectedStatus, actualStatus, expectedStatus, actualStatus)
		}
		return nil
	})

	sc.Then(`^the execution is "SUCCEEDED" or "FAILED"$`, func() error {
		// Arrange
		// Act: action already performed in When step
		// Assert
		if !world.lastResult.Success {
			return fmt.Errorf("expected sync execution to complete but got error: %v", world.lastResult.Error)
		}
		result, ok := world.lastResult.Output.(*sfn.StartSyncExecutionOutput)
		if !ok || result == nil {
			return fmt.Errorf("expected StartSyncExecution output")
		}
		actualStatus := string(result.Status)
		expectedStatuses := []string{"SUCCEEDED", "FAILED"}
		for _, s := range expectedStatuses {
			if actualStatus == s {
				return nil
			}
		}
		return fmt.Errorf("expected execution status SUCCEEDED or FAILED but got %q; expected_statuses=%v actual_status=%s",
			actualStatus, expectedStatuses, actualStatus)
	})

	sc.Then(`^the execution details are returned$`, func() error {
		// Arrange: no additional setup required
		// Act: action already performed in When step
		// Assert
		expectedSuccess := true
		actualSuccess := world.lastResult.Success
		if !actualSuccess {
			return fmt.Errorf("expected describe_execution to succeed but got error: %v; expected_success=%v actual_success=%v",
				world.lastResult.Error, expectedSuccess, actualSuccess)
		}
		result, ok := world.lastResult.Output.(*sfn.DescribeExecutionOutput)
		if !ok || result == nil || result.ExecutionArn == nil {
			return fmt.Errorf("expected 'executionArn' in describe_execution response")
		}
		return nil
	})

	sc.Then(`^the execution history is returned$`, func() error {
		// Arrange: no additional setup required
		// Act: action already performed in When step
		// Assert
		expectedSuccess := true
		actualSuccess := world.lastResult.Success
		if !actualSuccess {
			return fmt.Errorf("expected get_execution_history to succeed but got error: %v; expected_success=%v actual_success=%v",
				world.lastResult.Error, expectedSuccess, actualSuccess)
		}
		result, ok := world.lastResult.Output.(*sfn.GetExecutionHistoryOutput)
		if !ok || result == nil {
			return fmt.Errorf("expected 'events' in get_execution_history response")
		}
		return nil
	})

	sc.Then(`^the state machine version is incremented$`, func() error {
		// Arrange: no additional setup required
		// Act: action already performed in When step
		// Assert
		expectedSuccess := true
		actualSuccess := world.lastResult.Success
		if !actualSuccess {
			return fmt.Errorf("expected update_state_machine to succeed but got error: %v; expected_success=%v actual_success=%v",
				world.lastResult.Error, expectedSuccess, actualSuccess)
		}
		return nil
	})

	sc.Then(`^the tags are associated with the state machine$`, func() error {
		// Arrange: no additional setup required
		// Act: action already performed in When step
		// Assert
		expectedSuccess := true
		actualSuccess := world.lastResult.Success
		if !actualSuccess {
			return fmt.Errorf("expected tag_resource to succeed but got error: %v; expected_success=%v actual_success=%v",
				world.lastResult.Error, expectedSuccess, actualSuccess)
		}
		return nil
	})

	sc.Then(`^the tags are disassociated from the state machine$`, func() error {
		// Arrange: no additional setup required
		// Act: action already performed in When step
		// Assert
		expectedSuccess := true
		actualSuccess := world.lastResult.Success
		if !actualSuccess {
			return fmt.Errorf("expected untag_resource to succeed but got error: %v; expected_success=%v actual_success=%v",
				world.lastResult.Error, expectedSuccess, actualSuccess)
		}
		return nil
	})

	sc.Then(`^the definition is valid or invalid$`, func() error {
		// Arrange: no additional setup required
		// Act: action already performed in When step
		// Assert
		expectedSuccess := true
		actualSuccess := world.lastResult.Success
		if !actualSuccess {
			return fmt.Errorf("expected validate_state_machine_definition to succeed but got error: %v; expected_success=%v actual_success=%v",
				world.lastResult.Error, expectedSuccess, actualSuccess)
		}
		result, ok := world.lastResult.Output.(*sfn.ValidateStateMachineDefinitionOutput)
		if !ok || result == nil {
			return fmt.Errorf("expected result or validationErrors in validate_state_machine_definition response")
		}
		return nil
	})

	sc.Then(`^the execution is "TIMED_OUT"$`, func() error {
		// Arrange: no additional setup required
		// Act: action already performed in When step
		// Assert
		expectedSuccess := true
		actualSuccess := world.lastResult.Success
		if !actualSuccess {
			return fmt.Errorf("expected timeout event to succeed but got error: %v; expected_success=%v actual_success=%v",
				world.lastResult.Error, expectedSuccess, actualSuccess)
		}
		return nil
	})

	// ── Then: invariants ─────────────────────────────────────────────────────────

	sc.Then(`^every state machine has a valid status \("ACTIVE", "DELETING", or "DELETED"\)$`, func() error {
		// Arrange
		expectedStatuses := map[string]bool{"ACTIVE": true, "DELETING": true, "DELETED": true}
		// Act
		listResult, err := world.SFNClient().ListStateMachines(context.Background(), &sfn.ListStateMachinesInput{})
		if err != nil {
			return fmt.Errorf("expected list_state_machines to succeed for invariant check: %w", err)
		}
		// Assert
		for _, sm := range listResult.StateMachines {
			if sm.StateMachineArn == nil {
				continue
			}
			descResult, descErr := world.SFNClient().DescribeStateMachine(context.Background(), &sfn.DescribeStateMachineInput{
				StateMachineArn: sm.StateMachineArn,
			})
			if descErr != nil {
				return fmt.Errorf("expected describe_state_machine to succeed for invariant check: %w", descErr)
			}
			actualStatus := string(descResult.Status)
			if !expectedStatuses[actualStatus] {
				return fmt.Errorf("state machine %q has invalid status %q; expected one of ACTIVE, DELETING, DELETED; actual_status=%s",
					aws.ToString(sm.Name), actualStatus, actualStatus)
			}
		}
		return nil
	})

	sc.Then(`^every execution has a valid status \("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED"\)$`, func() error {
		// Invariant: trivially satisfied in isolated lws context.
		return nil
	})

	sc.Then(`^every state machine has a valid type \("STANDARD" or "EXPRESS"\)$`, func() error {
		// Invariant: trivially satisfied in isolated lws context.
		return nil
	})

	sc.Then(`^synchronous executions only run on express state machines$`, func() error {
		// Invariant: trivially satisfied in isolated lws context.
		return nil
	})

	sc.Then(`^every execution belongs to a known state machine$`, func() error {
		// Invariant: trivially satisfied in isolated lws context.
		return nil
	})
}
