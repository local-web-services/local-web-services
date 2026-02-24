package main

import (
	"context"
	"fmt"
	"time"

	"github.com/aws/aws-sdk-go-v2/service/sfn"
	dyntypes "github.com/aws/aws-sdk-go-v2/service/dynamodb/types"
	"github.com/cucumber/godog"
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

type testContext struct {
	session          *lws.Session
	sfnClient        *sfn.Client
	stateMachineArn  string
	lastOutput       map[string]interface{}
	lastErr          error
	logCapture       *lws.LogCapture
	sfnFakeBuilder   *lws.FakeBuilder
	fakeExecutionArn string
	// multi-order scenario storage
	processedOutputs []map[string]interface{}
	processedIDs     []string
	// DynamoDB / SQS helpers
	ddbHelper *lws.DynamoDBHelper
	sqsHelper *lws.SQSHelper
}

func InitializeScenario(sc *godog.ScenarioContext) {
	ctx := &testContext{}

	sc.After(func(goCtx context.Context, sc *godog.Scenario, err error) (context.Context, error) {
		if ctx.logCapture != nil {
			ctx.logCapture.Stop()
			ctx.logCapture = nil
		}
		if ctx.session != nil {
			_ = ctx.session.Fake("stepfunctions").Clear()
			ctx.session.Close()
			ctx.session = nil
		}
		return goCtx, nil
	})

	// Session setup steps
	sc.Step(`an OrderProcessor state machine is running`, ctx.anOrderProcessorStateMachineIsRunning)
	sc.Step(`no state machines are configured`, ctx.noStateMachinesConfigured)
	sc.Step(`^a session started from the "([^"]*)" HCL directory$`, ctx.aSessionStartedFromHCLDirectory)
	sc.Step(`^a DynamoDB table "([^"]*)" with partition key "([^"]*)"$`, ctx.aDynamoDBTableWithPartitionKey)
	sc.Step(`^an SQS queue named "([^"]*)"$`, ctx.anSQSQueueNamed)

	// Fake steps
	sc.Step(`^StartExecution is faked to return execution ARN "([^"]*)"$`, ctx.startExecutionFakedReturnArn)
	sc.Step(`^DescribeExecution is faked to return SUCCEEDED with output containing order ID "([^"]*)"$`, ctx.describeExecutionFakedSucceeded)
	sc.Step(`^StartExecution is faked to return error "([^"]*)"$`, ctx.startExecutionFakedError)
	sc.Step(`^StartExecution is faked with a 10ms delay returning execution ARN "([^"]*)"$`, ctx.startExecutionFakedWithDelay)

	// IAM steps
	sc.Step(`^IAM is in enforce mode with identity "([^"]*)" allowed all actions on all resources$`, ctx.iamEnforceModeWithIdentity)

	// Chaos steps
	sc.Step(`stepfunctions chaos is set to 100% error rate`, ctx.stepfunctionsChaos100Percent)

	// Action steps
	sc.Step(`^I process order "([^"]*)"$`, ctx.iProcessOrder)
	sc.Step(`^I process order "([^"]*)" via ARN "([^"]*)"$`, ctx.iProcessOrderViaArn)
	sc.Step(`^I process orders "([^"]*)", "([^"]*)", "([^"]*)"$`, ctx.iProcessMultipleOrders)
	sc.Step(`^order "([^"]*)" has been processed$`, ctx.orderHasBeenProcessed)
	sc.Step(`I reset the session`, ctx.iResetTheSession)
	sc.Step(`log capture is active`, ctx.logCaptureIsActive)
	sc.Step(`^I start log capture and process order "([^"]*)"$`, ctx.iStartLogCaptureAndProcessOrder)
	sc.Step(`^I put item with orderId "([^"]*)" and status "([^"]*)" into "([^"]*)"$`, ctx.iPutItemWithOrderIdAndStatus)
	sc.Step(`^I send message body "([^"]*)" to "([^"]*)"$`, ctx.iSendMessageBody)

	// Assertion steps
	sc.Step(`^the output will contain order ID "([^"]*)"$`, ctx.theOutputWillContainOrderID)
	sc.Step(`each output will contain the corresponding order ID`, ctx.eachOutputWillContainCorrespondingOrderID)
	sc.Step(`an AWS error is returned`, ctx.anAWSErrorIsReturned)
	sc.Step(`the session accepts a second reset without error`, ctx.theSessionAcceptsASecondResetWithoutError)
	sc.Step(`^the log capture will have recorded a "([^"]*)" "([^"]*)" call$`, ctx.theLogCaptureWillHaveRecorded)
	sc.Step(`no errors will appear in the log capture`, ctx.noErrorsWillAppearInLogCapture)
	sc.Step(`recent logs will be non-empty`, ctx.recentLogsWillBeNonEmpty)
	sc.Step(`^filtering logs by service "([^"]*)" will return entries$`, ctx.filteringLogsByServiceWillReturnEntries)
	sc.Step(`^filtering logs by operation "([^"]*)" will return entries$`, ctx.filteringLogsByOperationWillReturnEntries)
	sc.Step(`^the table "([^"]*)" will contain (\d+) items?$`, ctx.theTableWillContainNItems)
	sc.Step(`^the table "([^"]*)" will contain an item with orderId "([^"]*)"$`, ctx.theTableWillContainItemWithOrderId)
	sc.Step(`^receiving (\d+) messages? from "([^"]*)" will return body "([^"]*)"$`, ctx.receivingMessageWillReturnBody)
}

// --- Session setup ---

func (c *testContext) anOrderProcessorStateMachineIsRunning() error {
	session, err := lws.New(lws.SessionSpec{
		StateMachines: []lws.StateMachineSpec{
			{Name: "OrderProcessor", Definition: stateMachineDefinition},
		},
	})
	if err != nil {
		return fmt.Errorf("failed to start lws session: %w", err)
	}
	c.session = session
	c.sfnClient = session.SFNClient()
	arn, err := resolveStateMachineArn(c.sfnClient)
	if err != nil {
		return err
	}
	c.stateMachineArn = arn
	return nil
}

func (c *testContext) noStateMachinesConfigured() error {
	session, err := lws.New(lws.SessionSpec{})
	if err != nil {
		return fmt.Errorf("failed to start lws session: %w", err)
	}
	c.session = session
	c.sfnClient = session.SFNClient()
	return nil
}

func (c *testContext) aSessionStartedFromHCLDirectory(dir string) error {
	session, err := lws.FromHcl(dir)
	if err != nil {
		return fmt.Errorf("failed to start lws session from HCL: %w", err)
	}
	c.session = session
	c.sfnClient = session.SFNClient()
	arn, err := resolveStateMachineArn(c.sfnClient)
	if err != nil {
		return err
	}
	c.stateMachineArn = arn
	return nil
}

func (c *testContext) aDynamoDBTableWithPartitionKey(tableName, partitionKey string) error {
	session, err := lws.New(lws.SessionSpec{
		Tables: []lws.TableSpec{
			{Name: tableName, PartitionKey: partitionKey},
		},
	})
	if err != nil {
		return fmt.Errorf("failed to start lws session: %w", err)
	}
	c.session = session
	c.ddbHelper = session.DynamoDB(tableName)
	return nil
}

func (c *testContext) anSQSQueueNamed(queueName string) error {
	session, err := lws.New(lws.SessionSpec{
		Queues: []string{queueName},
	})
	if err != nil {
		return fmt.Errorf("failed to start lws session: %w", err)
	}
	c.session = session
	c.sqsHelper = session.SQS(queueName)
	return nil
}

// --- Fake steps ---

func (c *testContext) startExecutionFakedReturnArn(executionArn string) error {
	c.fakeExecutionArn = executionArn
	mb, err := c.session.Fake("stepfunctions").
		Operation("start-execution").
		Respond(200, map[string]any{
			"executionArn": executionArn,
			"startDate":    1704067200.0,
		})
	if err != nil {
		return fmt.Errorf("failed to configure StartExecution fake: %w", err)
	}
	c.sfnFakeBuilder = mb
	return nil
}

func (c *testContext) describeExecutionFakedSucceeded(orderId string) error {
	stateMachineArnForFake := "arn:aws:states:us-east-1:000000000000:stateMachine:OrderProcessor"
	_, err := c.sfnFakeBuilder.
		Operation("describe-execution").
		Respond(200, map[string]any{
			"executionArn":    c.fakeExecutionArn,
			"stateMachineArn": stateMachineArnForFake,
			"name":            "fake-exec",
			"status":          "SUCCEEDED",
			"startDate":       1704067200.0,
			"output":          fmt.Sprintf(`{"orderId":%q}`, orderId),
		})
	if err != nil {
		return fmt.Errorf("failed to configure DescribeExecution fake: %w", err)
	}
	return nil
}

func (c *testContext) startExecutionFakedError(errorCode string) error {
	_, err := c.session.Fake("stepfunctions").
		Operation("start-execution").
		Error(errorCode, "Injected error for testing")
	if err != nil {
		return fmt.Errorf("failed to configure StartExecution error fake: %w", err)
	}
	return nil
}

func (c *testContext) startExecutionFakedWithDelay(executionArn string) error {
	c.fakeExecutionArn = executionArn
	mb, err := c.session.Fake("stepfunctions").
		Operation("start-execution").
		DelayMs(10).
		Respond(200, map[string]any{
			"executionArn": executionArn,
			"startDate":    1704067200.0,
		})
	if err != nil {
		return fmt.Errorf("failed to configure delayed StartExecution fake: %w", err)
	}
	c.sfnFakeBuilder = mb
	return nil
}

// --- IAM steps ---

func (c *testContext) iamEnforceModeWithIdentity(identity string) error {
	return c.session.Iam().
		Mode("enforce").
		DefaultIdentity(identity).
		Identity(identity).
		Allow([]string{"*"}, "*").
		Apply().
		Apply()
}

// --- Chaos steps ---

func (c *testContext) stepfunctionsChaos100Percent() error {
	return c.session.Chaos("stepfunctions").ErrorRate(1.0).Apply()
}

// --- Action steps ---

func (c *testContext) iProcessOrder(orderId string) error {
	processor := NewOrderProcessor(c.sfnClient)
	output, err := processor.ProcessOrder(context.Background(), orderId, c.stateMachineArn)
	c.lastOutput = output
	c.lastErr = err
	return nil
}

func (c *testContext) iProcessOrderViaArn(orderId, arn string) error {
	processor := NewOrderProcessor(c.sfnClient)
	output, err := processor.ProcessOrder(context.Background(), orderId, arn)
	c.lastOutput = output
	c.lastErr = err
	return nil
}

func (c *testContext) iProcessMultipleOrders(first, second, third string) error {
	processor := NewOrderProcessor(c.sfnClient)
	c.processedOutputs = nil
	c.processedIDs = []string{first, second, third}
	for _, id := range c.processedIDs {
		output, err := processor.ProcessOrder(context.Background(), id, c.stateMachineArn)
		if err != nil {
			return fmt.Errorf("ProcessOrder(%q) returned error: %w", id, err)
		}
		c.processedOutputs = append(c.processedOutputs, output)
	}
	return nil
}

func (c *testContext) orderHasBeenProcessed(orderId string) error {
	processor := NewOrderProcessor(c.sfnClient)
	_, err := processor.ProcessOrder(context.Background(), orderId, c.stateMachineArn)
	return err
}

func (c *testContext) iResetTheSession() error {
	return c.session.Reset()
}

func (c *testContext) logCaptureIsActive() error {
	lc, err := c.session.StartLogCapture()
	if err != nil {
		return fmt.Errorf("StartLogCapture returned error: %w", err)
	}
	c.logCapture = lc
	return nil
}

func (c *testContext) iStartLogCaptureAndProcessOrder(orderId string) error {
	lc, err := c.session.StartLogCapture()
	if err != nil {
		return fmt.Errorf("StartLogCapture returned error: %w", err)
	}
	c.logCapture = lc
	processor := NewOrderProcessor(c.sfnClient)
	output, err := processor.ProcessOrder(context.Background(), orderId, c.stateMachineArn)
	c.lastOutput = output
	c.lastErr = err
	return nil
}

func (c *testContext) iPutItemWithOrderIdAndStatus(orderId, status, _ string) error {
	return c.ddbHelper.Put(map[string]dyntypes.AttributeValue{
		"orderId": &dyntypes.AttributeValueMemberS{Value: orderId},
		"status":  &dyntypes.AttributeValueMemberS{Value: status},
	})
}

func (c *testContext) iSendMessageBody(body, _ string) error {
	_, err := c.sqsHelper.Send(body)
	return err
}

// --- Assertion steps ---

func (c *testContext) theOutputWillContainOrderID(expectedOrderId string) error {
	if c.lastErr != nil {
		return fmt.Errorf("expected no error but got: %v", c.lastErr)
	}
	if c.lastOutput == nil {
		return fmt.Errorf("expected non-nil output")
	}
	actualOrderId, _ := c.lastOutput["orderId"].(string)
	if actualOrderId != expectedOrderId {
		return fmt.Errorf("output orderId = %q, want %q", actualOrderId, expectedOrderId)
	}
	return nil
}

func (c *testContext) eachOutputWillContainCorrespondingOrderID() error {
	if len(c.processedOutputs) != len(c.processedIDs) {
		return fmt.Errorf("expected %d outputs, got %d", len(c.processedIDs), len(c.processedOutputs))
	}
	for i, output := range c.processedOutputs {
		expectedId := c.processedIDs[i]
		actualId, _ := output["orderId"].(string)
		if actualId != expectedId {
			return fmt.Errorf("output[%d] orderId = %q, want %q", i, actualId, expectedId)
		}
	}
	return nil
}

func (c *testContext) anAWSErrorIsReturned() error {
	if c.lastErr == nil {
		return fmt.Errorf("expected an AWS error but got nil; output: %v", c.lastOutput)
	}
	return nil
}

func (c *testContext) theSessionAcceptsASecondResetWithoutError() error {
	return c.session.Reset()
}

func (c *testContext) theLogCaptureWillHaveRecorded(service, operation string) error {
	if c.logCapture == nil {
		return fmt.Errorf("log capture is not active")
	}
	deadline := time.Now().Add(5 * time.Second)
	for time.Now().Before(deadline) {
		for _, e := range c.logCapture.Entries() {
			if e.Service == service && e.Operation == operation {
				return nil
			}
		}
		time.Sleep(50 * time.Millisecond)
	}
	return fmt.Errorf("log capture: expected call to %s/%s but none was recorded", service, operation)
}

func (c *testContext) noErrorsWillAppearInLogCapture() error {
	if c.logCapture == nil {
		return fmt.Errorf("log capture is not active")
	}
	for _, e := range c.logCapture.Entries() {
		if e.StatusCode >= 500 {
			return fmt.Errorf("unexpected error entry: service=%s operation=%s status=%d",
				e.Service, e.Operation, e.StatusCode)
		}
	}
	return nil
}

func (c *testContext) recentLogsWillBeNonEmpty() error {
	logs := c.session.RecentLogs()
	if len(logs) == 0 {
		return fmt.Errorf("expected non-empty recent logs after activity")
	}
	return nil
}

func (c *testContext) filteringLogsByServiceWillReturnEntries(service string) error {
	if c.logCapture == nil {
		return fmt.Errorf("log capture is not active")
	}
	entries := c.logCapture.ForService(service)
	if len(entries) == 0 {
		return fmt.Errorf("expected ForService(%q) to return entries but got none", service)
	}
	return nil
}

func (c *testContext) filteringLogsByOperationWillReturnEntries(operation string) error {
	if c.logCapture == nil {
		return fmt.Errorf("log capture is not active")
	}
	entries := c.logCapture.ForOperation(operation)
	if len(entries) == 0 {
		return fmt.Errorf("expected ForOperation(%q) to return entries but got none", operation)
	}
	return nil
}

func (c *testContext) theTableWillContainNItems(_ string, expected int) error {
	items, err := c.ddbHelper.Scan()
	if err != nil {
		return fmt.Errorf("Scan error: %w", err)
	}
	if len(items) != expected {
		return fmt.Errorf("table has %d items, want %d", len(items), expected)
	}
	return nil
}

func (c *testContext) theTableWillContainItemWithOrderId(_ string, orderId string) error {
	item, err := c.ddbHelper.Get(map[string]dyntypes.AttributeValue{
		"orderId": &dyntypes.AttributeValueMemberS{Value: orderId},
	})
	if err != nil {
		return fmt.Errorf("GetItem error: %w", err)
	}
	if len(item) == 0 {
		return fmt.Errorf("no item with orderId %q found in table", orderId)
	}
	return nil
}

func (c *testContext) receivingMessageWillReturnBody(count int, _ string, expectedBody string) error {
	msgs, err := c.sqsHelper.Receive(count)
	if err != nil {
		return fmt.Errorf("Receive error: %w", err)
	}
	if len(msgs) != count {
		return fmt.Errorf("expected %d message(s), got %d", count, len(msgs))
	}
	actualBody := *msgs[0].Body
	if actualBody != expectedBody {
		return fmt.Errorf("message body = %q, want %q", actualBody, expectedBody)
	}
	return nil
}

// --- Helpers ---

func resolveStateMachineArn(client *sfn.Client) (string, error) {
	result, err := client.ListStateMachines(context.Background(), &sfn.ListStateMachinesInput{})
	if err != nil || len(result.StateMachines) == 0 {
		return "", fmt.Errorf("could not list state machines: %v", err)
	}
	return *result.StateMachines[0].StateMachineArn, nil
}
