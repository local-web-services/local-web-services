package main

import (
	"context"
	"testing"

	"github.com/aws/aws-sdk-go-v2/service/sfn"
	"github.com/local-web-services/local-web-services-go-sdk/lws"
)

const stateMachineDefinition = `{
  "Comment": "Simple order processor — passes input through as output",
  "StartAt": "ProcessOrder",
  "States": {
    "ProcessOrder": {
      "Type": "Pass",
      "End": true
    }
  }
}`

func TestProcessOrder_runsStateMachineAndReturnsResult(t *testing.T) {
	// Arrange — start ldk with an explicit state machine spec
	session, err := lws.New(lws.SessionSpec{
		StateMachines: []lws.StateMachineSpec{
			{Name: "OrderProcessor", Definition: stateMachineDefinition},
		},
	})
	if err != nil {
		t.Fatalf("failed to start lws session: %v", err)
	}
	defer session.Close()

	sfnClient := session.SFNClient()
	stateMachineArn := resolveStateMachineArn(t, sfnClient)
	processor := NewOrderProcessor(sfnClient)

	expectedOrderId := "order-001"

	// Act
	actualOutput, err := processor.ProcessOrder(context.Background(), expectedOrderId, stateMachineArn)

	// Assert
	if err != nil {
		t.Fatalf("ProcessOrder returned error: %v", err)
	}
	if actualOutput == nil {
		t.Fatal("expected non-nil output")
	}
	if actualOutput["orderId"] != expectedOrderId {
		t.Errorf("output orderId = %q, want %q", actualOutput["orderId"], expectedOrderId)
	}
}

func TestProcessOrder_handlesMultipleOrders(t *testing.T) {
	// Arrange — start ldk with an explicit state machine spec
	session, err := lws.New(lws.SessionSpec{
		StateMachines: []lws.StateMachineSpec{
			{Name: "OrderProcessor", Definition: stateMachineDefinition},
		},
	})
	if err != nil {
		t.Fatalf("failed to start lws session: %v", err)
	}
	defer session.Close()

	sfnClient := session.SFNClient()
	stateMachineArn := resolveStateMachineArn(t, sfnClient)
	processor := NewOrderProcessor(sfnClient)

	expectedFirstOrderId := "order-101"
	expectedSecondOrderId := "order-102"
	expectedThirdOrderId := "order-103"

	// Act
	actualFirstOutput, err := processor.ProcessOrder(context.Background(), expectedFirstOrderId, stateMachineArn)
	if err != nil {
		t.Fatalf("first ProcessOrder returned error: %v", err)
	}
	actualSecondOutput, err := processor.ProcessOrder(context.Background(), expectedSecondOrderId, stateMachineArn)
	if err != nil {
		t.Fatalf("second ProcessOrder returned error: %v", err)
	}
	actualThirdOutput, err := processor.ProcessOrder(context.Background(), expectedThirdOrderId, stateMachineArn)
	if err != nil {
		t.Fatalf("third ProcessOrder returned error: %v", err)
	}

	// Assert
	if actualFirstOutput["orderId"] != expectedFirstOrderId {
		t.Errorf("first output orderId = %q, want %q", actualFirstOutput["orderId"], expectedFirstOrderId)
	}
	if actualSecondOutput["orderId"] != expectedSecondOrderId {
		t.Errorf("second output orderId = %q, want %q", actualSecondOutput["orderId"], expectedSecondOrderId)
	}
	if actualThirdOutput["orderId"] != expectedThirdOrderId {
		t.Errorf("third output orderId = %q, want %q", actualThirdOutput["orderId"], expectedThirdOrderId)
	}
}

func TestProcessOrder_returnsErrorForUnknownStateMachine(t *testing.T) {
	// Arrange — start ldk with no state machines declared
	session, err := lws.New(lws.SessionSpec{})
	if err != nil {
		t.Fatalf("failed to start lws session: %v", err)
	}
	defer session.Close()

	sfnClient := session.SFNClient()
	processor := NewOrderProcessor(sfnClient)

	// Use an ARN that does not exist in the local emulator
	nonExistentArn := "arn:aws:states:us-east-1:000000000000:stateMachine:DoesNotExist"

	// Act
	actualOutput, actualErr := processor.ProcessOrder(context.Background(), "order-999", nonExistentArn)

	// Assert — production code should propagate the AWS error, not swallow it
	if actualErr == nil {
		t.Errorf("expected an error for unknown state machine, got output: %v", actualOutput)
	}
}

func TestProcessOrder_usingTerraformDefinition(t *testing.T) {
	// Arrange — start ldk from the Terraform config; it reads terraform/main.tf
	// and provisions the OrderProcessor state machine automatically
	session, err := lws.FromHcl("terraform")
	if err != nil {
		t.Fatalf("failed to start lws session: %v", err)
	}
	defer session.Close()

	sfnClient := session.SFNClient()
	stateMachineArn := resolveStateMachineArn(t, sfnClient)
	processor := NewOrderProcessor(sfnClient)

	expectedOrderId := "order-tf"

	// Act
	actualOutput, err := processor.ProcessOrder(context.Background(), expectedOrderId, stateMachineArn)

	// Assert
	if err != nil {
		t.Fatalf("ProcessOrder returned error: %v", err)
	}
	if actualOutput["orderId"] != expectedOrderId {
		t.Errorf("output orderId = %q, want %q", actualOutput["orderId"], expectedOrderId)
	}
}

func TestProcessOrder_withMockedSuccessResponse(t *testing.T) {
	// Arrange — start ldk with no state machines; we will mock the SFN calls
	session, err := lws.New(lws.SessionSpec{})
	if err != nil {
		t.Fatalf("failed to start lws session: %v", err)
	}
	defer session.Close()

	sfnClient := session.SFNClient()
	processor := NewOrderProcessor(sfnClient)

	expectedOrderId := "order-mock"
	expectedExecutionArn := "arn:aws:states:us-east-1:000000000000:execution:OrderProcessor:mock-exec"
	expectedStateMachineArn := "arn:aws:states:us-east-1:000000000000:stateMachine:OrderProcessor"

	// Mock StartExecution to return a pre-defined execution ARN
	sfnMock, err := session.Mock("stepfunctions").Operation("start-execution").Respond(200, map[string]any{
		"executionArn": expectedExecutionArn,
		"startDate":    1704067200.0,
	})
	if err != nil {
		t.Fatalf("failed to configure StartExecution mock: %v", err)
	}

	// Mock DescribeExecution to return SUCCEEDED with the order in the output
	_, err = sfnMock.Operation("describe-execution").Respond(200, map[string]any{
		"executionArn":    expectedExecutionArn,
		"stateMachineArn": expectedStateMachineArn,
		"name":            "mock-exec",
		"status":          "SUCCEEDED",
		"startDate":       1704067200.0,
		"output":          `{"orderId":"order-mock"}`,
	})
	if err != nil {
		t.Fatalf("failed to configure DescribeExecution mock: %v", err)
	}

	// Act
	actualOutput, actualErr := processor.ProcessOrder(context.Background(), expectedOrderId, expectedStateMachineArn)

	// Assert
	if actualErr != nil {
		t.Fatalf("ProcessOrder returned unexpected error: %v", actualErr)
	}
	if actualOutput["orderId"] != expectedOrderId {
		t.Errorf("output orderId = %q, want %q", actualOutput["orderId"], expectedOrderId)
	}

	// Cleanup — clear mocks so subsequent tests are unaffected
	if err := session.Mock("stepfunctions").Clear(); err != nil {
		t.Fatalf("failed to clear stepfunctions mocks: %v", err)
	}
}

func TestProcessOrder_withInjectedError(t *testing.T) {
	// Arrange — start ldk with no state machines; we will inject an error
	session, err := lws.New(lws.SessionSpec{})
	if err != nil {
		t.Fatalf("failed to start lws session: %v", err)
	}
	defer session.Close()

	sfnClient := session.SFNClient()
	processor := NewOrderProcessor(sfnClient)

	expectedStateMachineArn := "arn:aws:states:us-east-1:000000000000:stateMachine:OrderProcessor"

	// Mock StartExecution to return an AWS error
	_, err = session.Mock("stepfunctions").Operation("start-execution").Error(
		"ExecutionLimitExceeded",
		"You have exceeded the maximum number of running executions.",
	)
	if err != nil {
		t.Fatalf("failed to configure StartExecution error mock: %v", err)
	}

	// Act
	actualOutput, actualErr := processor.ProcessOrder(context.Background(), "order-999", expectedStateMachineArn)

	// Assert — production code should propagate the AWS error
	if actualErr == nil {
		t.Errorf("expected an error for ExecutionLimitExceeded, got output: %v", actualOutput)
	}

	// Cleanup — clear mocks so subsequent tests are unaffected
	if err := session.Mock("stepfunctions").Clear(); err != nil {
		t.Fatalf("failed to clear stepfunctions mocks: %v", err)
	}
}

func TestProcessOrder_withMockDelayAndHeader(t *testing.T) {
	// Arrange — start ldk with no state machines; we will mock the SFN calls with delay and header matching
	session, err := lws.New(lws.SessionSpec{})
	if err != nil {
		t.Fatalf("failed to start lws session: %v", err)
	}
	defer session.Close()

	sfnClient := session.SFNClient()
	processor := NewOrderProcessor(sfnClient)

	expectedOrderId := "order-header"
	expectedExecutionArn := "arn:aws:states:us-east-1:000000000000:execution:OrderProcessor:header-exec"
	expectedStateMachineArn := "arn:aws:states:us-east-1:000000000000:stateMachine:OrderProcessor"

	// Mock StartExecution with a 10ms delay
	sfnMock, err := session.Mock("stepfunctions").
		Operation("start-execution").
		DelayMs(10).
		Respond(200, map[string]any{
			"executionArn": expectedExecutionArn,
			"startDate":    1704067200.0,
		})
	if err != nil {
		t.Fatalf("failed to configure StartExecution mock: %v", err)
	}

	// Mock DescribeExecution to return SUCCEEDED
	_, err = sfnMock.Operation("describe-execution").Respond(200, map[string]any{
		"executionArn":    expectedExecutionArn,
		"stateMachineArn": expectedStateMachineArn,
		"name":            "header-exec",
		"status":          "SUCCEEDED",
		"startDate":       1704067200.0,
		"output":          `{"orderId":"order-header"}`,
	})
	if err != nil {
		t.Fatalf("failed to configure DescribeExecution mock: %v", err)
	}

	// Act
	actualOutput, actualErr := processor.ProcessOrder(context.Background(), expectedOrderId, expectedStateMachineArn)

	// Assert
	if actualErr != nil {
		t.Fatalf("ProcessOrder returned unexpected error: %v", actualErr)
	}
	if actualOutput["orderId"] != expectedOrderId {
		t.Errorf("output orderId = %q, want %q", actualOutput["orderId"], expectedOrderId)
	}

	if err := session.Mock("stepfunctions").Clear(); err != nil {
		t.Fatalf("failed to clear stepfunctions mocks: %v", err)
	}
}

func TestProcessOrder_resetClearsState(t *testing.T) {
	// Arrange — start ldk with a state machine and run an execution
	session, err := lws.New(lws.SessionSpec{
		StateMachines: []lws.StateMachineSpec{
			{Name: "OrderProcessor", Definition: stateMachineDefinition},
		},
	})
	if err != nil {
		t.Fatalf("failed to start lws session: %v", err)
	}
	defer session.Close()

	sfnClient := session.SFNClient()
	stateMachineArn := resolveStateMachineArn(t, sfnClient)
	processor := NewOrderProcessor(sfnClient)

	// Act — run an execution before reset
	_, err = processor.ProcessOrder(context.Background(), "order-before-reset", stateMachineArn)
	if err != nil {
		t.Fatalf("ProcessOrder returned error: %v", err)
	}

	// Act — reset state
	if err := session.Reset(); err != nil {
		t.Fatalf("Reset returned error: %v", err)
	}

	// Assert — session is still functional after reset
	if err := session.Reset(); err != nil {
		t.Fatalf("second Reset returned error: %v", err)
	}
}

func TestProcessOrder_chaosInjectsErrors(t *testing.T) {
	// Arrange — start ldk with a state machine
	session, err := lws.New(lws.SessionSpec{
		StateMachines: []lws.StateMachineSpec{
			{Name: "OrderProcessor", Definition: stateMachineDefinition},
		},
	})
	if err != nil {
		t.Fatalf("failed to start lws session: %v", err)
	}
	defer session.Close()

	sfnClient := session.SFNClient()
	stateMachineArn := resolveStateMachineArn(t, sfnClient)
	processor := NewOrderProcessor(sfnClient)

	// Act — enable chaos with 100% error rate
	if err := session.Chaos("stepfunctions").ErrorRate(1.0).Apply(); err != nil {
		t.Fatalf("Chaos.Apply returned error: %v", err)
	}

	// Act — attempt to process order under chaos
	_, chaosErr := processor.ProcessOrder(context.Background(), "order-chaos", stateMachineArn)

	// Act — clear chaos
	if err := session.Chaos("stepfunctions").Clear(); err != nil {
		t.Fatalf("Chaos.Clear returned error: %v", err)
	}

	// Assert — chaos should have caused an error
	if chaosErr == nil {
		t.Error("expected an error under 100% error rate chaos, got nil")
	}
}

func TestProcessOrder_logCaptureRecordsStartExecution(t *testing.T) {
	// Arrange — start ldk with a state machine and log capture
	session, err := lws.New(lws.SessionSpec{
		StateMachines: []lws.StateMachineSpec{
			{Name: "OrderProcessor", Definition: stateMachineDefinition},
		},
	})
	if err != nil {
		t.Fatalf("failed to start lws session: %v", err)
	}
	defer session.Close()

	logs, err := session.StartLogCapture()
	if err != nil {
		t.Fatalf("StartLogCapture returned error: %v", err)
	}
	defer logs.Stop()

	sfnClient := session.SFNClient()
	stateMachineArn := resolveStateMachineArn(t, sfnClient)
	processor := NewOrderProcessor(sfnClient)

	// Act
	_, err = processor.ProcessOrder(context.Background(), "order-logged", stateMachineArn)
	if err != nil {
		t.Fatalf("ProcessOrder returned error: %v", err)
	}

	// Assert — start-execution should have been logged
	logs.AssertCalled(t, "stepfunctions", "StartExecution")
	logs.AssertNoErrors(t)
}

func resolveStateMachineArn(t *testing.T, client *sfn.Client) string {
	t.Helper()
	result, err := client.ListStateMachines(context.Background(), &sfn.ListStateMachinesInput{})
	if err != nil || len(result.StateMachines) == 0 {
		t.Fatalf("could not list state machines: %v", err)
	}
	return *result.StateMachines[0].StateMachineArn
}
