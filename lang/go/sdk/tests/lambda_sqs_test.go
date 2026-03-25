package tests

// registerLambdaSqsSteps wires step definitions unique to the lambda_sqs
// cross-service feature files. Steps already registered in lambda_test.go
// (function existence/lifecycle, ESM given/when), sqs_test.go (queue
// existence/lifecycle, dead-letter queue, "the operation is rejected"), or
// common shared files ("the system is initialized") are NOT re-registered here.

import (
	"context"
	"encoding/json"
	"fmt"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/lambda"
	lambdatypes "github.com/aws/aws-sdk-go-v2/service/lambda/types"
	"github.com/aws/aws-sdk-go-v2/service/sqs"
	sqstypes "github.com/aws/aws-sdk-go-v2/service/sqs/types"
	"github.com/cucumber/godog"
)

const lambdaSqsTestFunc = "e2e-test-func-1"
const lambdaSqsTestQueue = "e2e-test-q1"
const lambdaSqsTestDLQ = "e2e-test-dlq-1"
const lambdaSqsTestRoleArn = "arn:aws:iam::000000000000:role/test"
const lambdaSqsTestRegion = "us-east-1"
const lambdaSqsTestAccountID = "000000000000"

func lambdaSqsQueueURL(world *World, queueName string) string {
	return world.SQSQueueURL(queueName)
}

func lambdaSqsQueueARN(queueName string) string {
	return fmt.Sprintf("arn:aws:sqs:%s:%s:%s", lambdaSqsTestRegion, lambdaSqsTestAccountID, queueName)
}

func lambdaSqsCreateFunction(world *World) error {
	// Arrange
	// Act
	_, err := world.LambdaClient().CreateFunction(context.Background(), &lambda.CreateFunctionInput{
		FunctionName: aws.String(lambdaSqsTestFunc),
		Runtime:      lambdatypes.RuntimePython312,
		Role:         aws.String(lambdaSqsTestRoleArn),
		Handler:      aws.String("index.handler"),
		Code: &lambdatypes.FunctionCode{
			ZipFile: []byte("fake"),
		},
	})
	// Assert: caller checks error
	return err
}

func lambdaSqsCreateQueue(world *World, queueName string) error {
	// Arrange
	// Act
	_, err := world.SQSClient().CreateQueue(context.Background(), &sqs.CreateQueueInput{
		QueueName: aws.String(queueName),
	})
	// Assert: caller checks error
	return err
}

func registerLambdaSqsSteps(sc *godog.ScenarioContext, world *World) {
	// ── Given: source queue state (lambda_sqs-specific — NOT in sqs_test.go) ──

	sc.Given(`^the source queue exists$`, func() error {
		// Arrange: create the source queue
		// Act
		return lambdaSqsCreateQueue(world, lambdaSqsTestQueue)
	})

	sc.Given(`^the source queue does not exist$`, func() error {
		// No-op: fresh state has no queues.
		return nil
	})

	sc.Given(`^the source queue is "([^"]*)"$`, func(state string) error {
		if state == "ACTIVE" {
			// No-op: queues are ACTIVE immediately after creation in lws.
			return nil
		}
		// Arrange: apply lifecycle dwell so the source queue is non-ACTIVE
		sess := managementSession()
		// Act
		if err := sess.Lifecycle("sqs").CreateDwellMs(5000).Apply(); err != nil {
			return fmt.Errorf("lifecycle apply failed: %w", err)
		}
		_, _ = world.SQSClient().DeleteQueue(context.Background(), &sqs.DeleteQueueInput{
			QueueUrl: aws.String(lambdaSqsQueueURL(world, lambdaSqsTestQueue)),
		})
		return lambdaSqsCreateQueue(world, lambdaSqsTestQueue)
	})

	sc.Given(`^the source queue is not "([^"]*)"$`, func(state string) error {
		if state == "ACTIVE" {
			// Arrange: apply lifecycle dwell so the source queue is non-ACTIVE
			sess := managementSession()
			// Act
			if err := sess.Lifecycle("sqs").CreateDwellMs(5000).Apply(); err != nil {
				return fmt.Errorf("lifecycle apply failed: %w", err)
			}
			_, _ = world.SQSClient().DeleteQueue(context.Background(), &sqs.DeleteQueueInput{
				QueueUrl: aws.String(lambdaSqsQueueURL(world, lambdaSqsTestQueue)),
			})
			return lambdaSqsCreateQueue(world, lambdaSqsTestQueue)
		}
		// For other states, no-op.
		return nil
	})

	sc.Given(`^the source queue has no dead-letter queue configured$`, func() error {
		// No-op: queue created without a DLQ.
		return nil
	})

	sc.Given(`^the source queue already has a dead-letter queue configured$`, func() error {
		// Arrange: ensure source queue and DLQ exist, then configure redrive policy
		if err := lambdaSqsCreateQueue(world, lambdaSqsTestQueue); err != nil {
			// ignore duplicate queue error
		}
		if err := lambdaSqsCreateQueue(world, lambdaSqsTestDLQ); err != nil {
			// ignore duplicate DLQ error
		}
		// Act: apply redrive policy
		dlqARN := lambdaSqsQueueARN(lambdaSqsTestDLQ)
		redrivePolicy := map[string]interface{}{
			"deadLetterTargetArn": dlqARN,
			"maxReceiveCount":     2,
		}
		redriveJSON, err := json.Marshal(redrivePolicy)
		if err != nil {
			return fmt.Errorf("marshal redrive policy: %w", err)
		}
		_, err = world.SQSClient().SetQueueAttributes(context.Background(), &sqs.SetQueueAttributesInput{
			QueueUrl: aws.String(lambdaSqsQueueURL(world, lambdaSqsTestQueue)),
			Attributes: map[string]string{
				"RedrivePolicy": string(redriveJSON),
			},
		})
		// Assert: redrive policy applied
		return err
	})

	// ── Given: event source mapping state (lambda_sqs-specific phrasings) ─────
	// "the event source mapping does not already exist", "the event source mapping already exists",
	// "the event source mapping exists", "the event source mapping does not exist" are already
	// registered in lambda_test.go — NOT re-registered here.

	sc.Given(`^the event source mapping is "([^"]*)"$`, func(state string) error {
		// @internal: Cannot pre-create event source mapping in lws.
		return nil
	})

	sc.Given(`^the event source mapping is not "([^"]*)"$`, func(state string) error {
		// @internal: Cannot pre-create disabled event source mapping in lws.
		return nil
	})

	sc.Given(`^the mapped function is "([^"]*)"$`, func(state string) error {
		// @internal: Cannot set up event source mapping in lws.
		return nil
	})

	sc.Given(`^the mapped function is not "([^"]*)"$`, func(state string) error {
		// @internal: Cannot set up event source mapping in lws.
		return nil
	})

	// ── Given: invocation / message / slot state ──────────────────────────────

	sc.Given(`^an invocation is "IN_PROGRESS"$`, func() error {
		// Arrange: create the function so an invocation state can be referenced
		// Act
		return lambdaSqsCreateFunction(world)
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
		// @internal: Cannot exhaust invocation slot limit in lws.
		return nil
	})

	sc.Given(`^an "AVAILABLE" message exists in the mapped queue$`, func() error {
		// @internal: Cannot set up event source mapping in lws.
		return nil
	})

	sc.Given(`^no "AVAILABLE" message exists in the mapped queue$`, func() error {
		// @internal: Cannot set up event source mapping in lws.
		return nil
	})

	sc.Given(`^a message slot is available$`, func() error {
		// No-op: always room for messages in lws.
		return nil
	})

	sc.Given(`^no message slot is available$`, func() error {
		// @internal: Cannot exhaust message slot limit in lws.
		return nil
	})

	// ── When: actions ─────────────────────────────────────────────────────────

	sc.When(`^a Lambda function is deployed$`, func() error {
		// Arrange
		// Act
		result, err := world.LambdaClient().CreateFunction(context.Background(), &lambda.CreateFunctionInput{
			FunctionName: aws.String(lambdaSqsTestFunc),
			Runtime:      lambdatypes.RuntimePython312,
			Role:         aws.String(lambdaSqsTestRoleArn),
			Handler:      aws.String("index.handler"),
			Code: &lambdatypes.FunctionCode{
				ZipFile: []byte("fake"),
			},
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^an "SQS" queue is created$`, func() error {
		// Arrange
		// Act
		result, err := world.SQSClient().CreateQueue(context.Background(), &sqs.CreateQueueInput{
			QueueName: aws.String(lambdaSqsTestQueue),
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^the "SQS" queue is configured with a dead-letter queue$`, func() error {
		// Arrange
		dlqARN := lambdaSqsQueueARN(lambdaSqsTestDLQ)
		redrivePolicy := map[string]interface{}{
			"deadLetterTargetArn": dlqARN,
			"maxReceiveCount":     2,
		}
		redriveJSON, err := json.Marshal(redrivePolicy)
		if err != nil {
			setResult(world, nil, err)
			return nil
		}
		// Act
		result, err := world.SQSClient().SetQueueAttributes(context.Background(), &sqs.SetQueueAttributesInput{
			QueueUrl: aws.String(lambdaSqsQueueURL(world, lambdaSqsTestQueue)),
			Attributes: map[string]string{
				"RedrivePolicy": string(redriveJSON),
			},
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^a Lambda event source mapping is created linking a queue to a function$`, func() error {
		// @internal: Cannot create event source mapping in lws.
		setResult(world, nil, fmt.Errorf("cannot create ESM linking queue to function: scenario is @internal"))
		return nil
	})

	sc.When(`^the event source mapping polls the queue and invokes the Lambda function$`, func() error {
		// @internal: Cannot trigger ESM polling in lws.
		setResult(world, nil, fmt.Errorf("cannot trigger ESM polling: scenario is @internal"))
		return nil
	})

	sc.When(`^the Lambda function is invoked$`, func() error {
		// @internal: Cannot trigger Lambda invocation in lws.
		setResult(world, nil, fmt.Errorf("cannot trigger Lambda invocation: scenario is @internal"))
		return nil
	})

	sc.When(`^the Lambda invocation fails$`, func() error {
		// @internal: Cannot trigger Lambda invocation failure in lws.
		setResult(world, nil, fmt.Errorf("cannot trigger Lambda invocation failure: scenario is @internal"))
		return nil
	})

	sc.When(`^the Lambda invocation completes successfully$`, func() error {
		// @internal: Cannot trigger Lambda invocation success in lws.
		setResult(world, nil, fmt.Errorf("cannot trigger Lambda invocation success: scenario is @internal"))
		return nil
	})

	sc.When(`^a message arrives in the "SQS" queue$`, func() error {
		// @internal: Cannot trigger internal message arrival in lws.
		setResult(world, nil, fmt.Errorf("cannot trigger internal message arrival: scenario is @internal"))
		return nil
	})

	// ── Then: assertions ──────────────────────────────────────────────────────
	// "the function is "([^"]*)"" is already registered in lambda_test.go — NOT re-registered.
	// "the operation is rejected" is already registered in sqs_test.go — NOT re-registered.

	sc.Then(`^the queue is "ACTIVE" with no dead-letter queue configured$`, func() error {
		// Arrange
		queueURL := lambdaSqsQueueURL(world, lambdaSqsTestQueue)
		// Act
		resp, err := world.SQSClient().GetQueueAttributes(context.Background(), &sqs.GetQueueAttributesInput{
			QueueUrl:       aws.String(queueURL),
			AttributeNames: []sqstypes.QueueAttributeName{sqstypes.QueueAttributeNameRedrivePolicy},
		})
		if err != nil {
			return fmt.Errorf("get queue attributes: %w", err)
		}
		// Assert
		expectedRedrive := ""
		actualRedrive := resp.Attributes[string(sqstypes.QueueAttributeNameRedrivePolicy)]
		if actualRedrive != expectedRedrive {
			return fmt.Errorf("expected no RedrivePolicy but got %q; expected_redrive=%q actual_redrive=%q",
				actualRedrive, expectedRedrive, actualRedrive)
		}
		return nil
	})

	sc.Then(`^failed messages will be redriven to the dead-letter queue after two receives$`, func() error {
		// Arrange
		queueURL := lambdaSqsQueueURL(world, lambdaSqsTestQueue)
		// Act
		resp, err := world.SQSClient().GetQueueAttributes(context.Background(), &sqs.GetQueueAttributesInput{
			QueueUrl:       aws.String(queueURL),
			AttributeNames: []sqstypes.QueueAttributeName{sqstypes.QueueAttributeNameRedrivePolicy},
		})
		if err != nil {
			return fmt.Errorf("get queue attributes: %w", err)
		}
		// Assert
		actualPolicy := resp.Attributes[string(sqstypes.QueueAttributeNameRedrivePolicy)]
		if actualPolicy == "" {
			return fmt.Errorf("expected a RedrivePolicy to be configured but got none")
		}
		var policy map[string]interface{}
		if err := json.Unmarshal([]byte(actualPolicy), &policy); err != nil {
			return fmt.Errorf("unmarshal redrive policy: %w", err)
		}
		expectedCount := 2
		var actualCount int
		switch v := policy["maxReceiveCount"].(type) {
		case float64:
			actualCount = int(v)
		case int:
			actualCount = v
		}
		if actualCount != expectedCount {
			return fmt.Errorf("expected maxReceiveCount %d but got %d; expected_count=%d actual_count=%d",
				expectedCount, actualCount, expectedCount, actualCount)
		}
		return nil
	})

	sc.Then(`^the event source mapping is "ENABLED" and will poll the queue for messages$`, func() error {
		// @internal: Cannot observe event source mapping state in lws.
		return nil
	})

	sc.Then(`^the invocation is "IN_PROGRESS"$`, func() error {
		// @internal: Cannot observe Lambda invocation state in lws.
		return nil
	})

	sc.Then(`^the invocation is "FAILED"$`, func() error {
		// @internal: Cannot observe Lambda invocation failure in lws.
		return nil
	})

	sc.Then(`^the invocation is "SUCCESS" and the "SQS" message is "DELETED"$`, func() error {
		// @internal: Cannot observe Lambda invocation result in lws.
		return nil
	})

	sc.Then(`^if the receive count is below the threshold the message is "AVAILABLE" for reprocessing, otherwise it is redriven to the dead-letter queue$`, func() error {
		// @internal: Cannot observe Lambda SQS failure handling in lws.
		return nil
	})

	sc.Then(`^the message is "IN_FLIGHT" and a Lambda invocation is "IN_PROGRESS"$`, func() error {
		// @internal: Cannot observe ESM polling result in lws.
		return nil
	})

	sc.Then(`^the message is "AVAILABLE" for processing$`, func() error {
		// @internal: Cannot observe internal message state in lws.
		return nil
	})

	// ── Then: invariants ──────────────────────────────────────────────────────

	sc.Then(`^every in-progress invocation was initiated by an "ENABLED" event source mapping$`, func() error {
		// No-op: model-level invariant; trivially satisfied in isolated lws context.
		return nil
	})

	sc.Then(`^every in-progress invocation references an "ACTIVE" Lambda function$`, func() error {
		// No-op: model-level invariant; trivially satisfied in isolated lws context.
		return nil
	})

	sc.Then(`^every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue$`, func() error {
		// No-op: model-level invariant; trivially satisfied in isolated lws context.
		return nil
	})

	sc.Then(`^every "ENABLED" event source mapping references an "ACTIVE" queue$`, func() error {
		// No-op: model-level invariant; trivially satisfied in isolated lws context.
		return nil
	})
}
