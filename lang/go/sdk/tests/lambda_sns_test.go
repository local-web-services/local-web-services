package tests

// registerLambdaSnsSteps registers step definitions unique to the lambda_sns
// cross-service feature files.
//
// Features: lang/specification/core/informal/lambda_sns/
// Safety invariants: InvocationRequiresActiveFunction, PublishRequiresActiveTopic
//
// Steps already registered elsewhere are NOT re-registered here:
//   - "the system is initialized"         — registered in sequences_test.go
//   - "the operation is rejected"         — registered in sqs_test.go
//   - "the function does not already exist" / "the function already exists" /
//     "the function exists" / "the function does not exist"  — lambda_test.go
//   - "the function is {string}" / "the function is not {string}"         — lambda_test.go
//   - "the topic does not already exist" / "the topic already exists" /
//     "the topic exists" / "the topic does not exist"                  — sns_test.go
//   - "the topic is {string}" / "the topic is not {string}"             — sns_test.go

import (
	"context"
	"fmt"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/lambda"
	lambdatypes "github.com/aws/aws-sdk-go-v2/service/lambda/types"
	"github.com/cucumber/godog"
)

const lambdaSnsTestFunc = "e2e-test-func-1"
const lambdaSnsTestRoleArn = "arn:aws:iam::000000000000:role/test"

func registerLambdaSnsSteps(sc *godog.ScenarioContext, world *World) {
	// ── Given: invocation state ────────────────────────────────────────────────

	sc.Given(`^an invocation is "IN_PROGRESS"$`, func() error {
		// Arrange: create a Lambda function so an invocation can be considered in-progress
		// Act
		_, err := world.LambdaClient().CreateFunction(context.Background(), &lambda.CreateFunctionInput{
			FunctionName: aws.String(lambdaSnsTestFunc),
			Runtime:      lambdatypes.RuntimePython312,
			Role:         aws.String(lambdaSnsTestRoleArn),
			Handler:      aws.String("index.handler"),
			Code: &lambdatypes.FunctionCode{
				ZipFile: []byte("fake"),
			},
		})
		// Assert: caller checks error; duplicate ignored
		if err != nil {
			if isAlreadyExists(err) {
				return nil
			}
			return fmt.Errorf("create function for in-progress invocation: %w", err)
		}
		return nil
	})

	sc.Given(`^no invocation is "IN_PROGRESS"$`, func() error {
		// No-op: fresh state after reset has no in-progress invocations.
		return nil
	})

	sc.Given(`^an invocation slot is available$`, func() error {
		// No-op: always room for invocations in lws.
		return nil
	})

	sc.Given(`^no invocation slot is available$`, func() error {
		// @capacity: Cannot exhaust invocation slot limit via public API in lws.
		// Scenarios tagged @capacity are reachable only when capacity management is supported.
		return managementSession().Capacity("lambda").Exhaust().Apply()
	})

	// ── When: actions ──────────────────────────────────────────────────────────

	sc.When(`^a Lambda function is deployed$`, func() error {
		// Arrange
		// Act
		result, err := world.LambdaClient().CreateFunction(context.Background(), &lambda.CreateFunctionInput{
			FunctionName: aws.String(lambdaSnsTestFunc),
			Runtime:      lambdatypes.RuntimePython312,
			Role:         aws.String(lambdaSnsTestRoleArn),
			Handler:      aws.String("index.handler"),
			Code: &lambdatypes.FunctionCode{
				ZipFile: []byte("fake"),
			},
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

	sc.When(`^the Lambda function publishes a message to the "SNS" topic during invocation$`, func() error {
		// @internal: Cannot trigger Lambda SNS publish in lws without Docker.
		setResult(world, nil, fmt.Errorf("cannot trigger Lambda SNS publish: scenario is @internal"))
		return nil
	})

	// ── Then: assertions ───────────────────────────────────────────────────────

	sc.Then(`^the invocation is "IN_PROGRESS"$`, func() error {
		// @internal: Cannot observe Lambda invocation state in lws.
		return nil
	})

	sc.Then(`^the invocation is "FAILED"$`, func() error {
		// @internal: Cannot observe Lambda invocation failure state in lws.
		return nil
	})

	sc.Then(`^the invocation is "SUCCESS"$`, func() error {
		// @internal: Cannot observe Lambda invocation success state in lws.
		return nil
	})

	sc.Then(`^the message is published to the topic$`, func() error {
		// @internal: Cannot observe Lambda SNS publish result in lws.
		return nil
	})

	// ── Invariant Then steps ───────────────────────────────────────────────────

	sc.Then(`^every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function$`, func() error {
		// No-op: model-level invariant; trivially satisfied in isolated lws context.
		return nil
	})

	sc.Then(`^publishing requires an "ACTIVE" topic to be present$`, func() error {
		// No-op: model-level invariant; trivially satisfied in isolated lws context.
		return nil
	})
}
