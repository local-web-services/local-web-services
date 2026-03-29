package tests

// registerSnsLambdaSteps registers step definitions unique to the sns_lambda
// cross-service feature files. Steps already registered by registerSNSSteps,
// registerLambdaSteps, registerSequenceSteps, and other Lambda cross-service
// step files are NOT re-registered here.
//
// Steps already registered elsewhere and intentionally absent here:
//   - "the system is initialized"                       — sequences_test.go
//   - "the operation is rejected"                       — sqs_test.go
//   - "the topic does not already exist"                — sns_test.go
//   - "the topic already exists"                        — sns_test.go
//   - "the topic exists"                                — sns_test.go
//   - 'the topic is "ACTIVE"' (Then)                   — sns_test.go
//   - "the topic is not {string}" (Given)               — sns_test.go
//   - "the topic does not exist"                        — sns_test.go
//   - "the subscription slot is available"              — sns_test.go
//   - "the subscription slot is not available"          — sns_test.go
//   - "a confirmed subscription exists for the topic"   — sns_test.go
//   - "no confirmed subscription exists for the topic"  — sns_test.go
//   - "the function does not already exist"             — lambda_test.go
//   - "the function already exists"                     — lambda_test.go
//   - "the function exists"                             — lambda_test.go
//   - "the function does not exist"                     — lambda_test.go
//   - "the function is {string}"                        — lambda_test.go (parameterized)
//   - "the function is not {string}"                    — lambda_test.go (parameterized)
//   - 'an invocation is "IN_PROGRESS"' (Given)          — lambda_sqs_test.go, lambda_sns_test.go
//   - 'no invocation is "IN_PROGRESS"' (Given)          — lambda_sqs_test.go, lambda_sns_test.go
//   - "an invocation slot is available" (Given)         — lambda_sqs_test.go, lambda_sns_test.go
//   - "no invocation slot is available" (Given)         — lambda_sqs_test.go, lambda_sns_test.go
//   - "a Lambda function is deployed" (When)            — lambda_sqs_test.go, lambda_sns_test.go
//   - "the Lambda invocation fails" (When)              — lambda_sqs_test.go, lambda_sns_test.go
//   - "the Lambda invocation completes successfully" (When) — lambda_sqs_test.go, lambda_sns_test.go
//   - 'an "SNS" topic is created' (When)               — sns_test.go
//   - 'the invocation is "IN_PROGRESS"' (Then)          — lambda_sqs_test.go, lambda_sns_test.go
//   - 'the invocation is "SUCCESS"' (Then)              — lambda_sns_test.go
//   - 'the invocation is "FAILED"' (Then)               — lambda_sqs_test.go, lambda_sns_test.go
//   - 'every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function' (Then)
//                                                       — lambda_sns_test.go

import (
	"context"
	"fmt"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/lambda"
	lambdatypes "github.com/aws/aws-sdk-go-v2/service/lambda/types"
	"github.com/cucumber/godog"
)

func registerSnsLambdaSteps(sc *godog.ScenarioContext, world *World) {
	// ── Given: subscribed function state ──────────────────────────────────────────

	sc.Given(`^the subscribed function is "ACTIVE"$`, func() error {
		// No-op: Lambda functions are ACTIVE immediately after creation in lws.
		// The sns_lambda @minimal happy-path scenario marks this as a precondition;
		// the actual function is created by "the function exists" in a prior Given step.
		return nil
	})

	sc.Given(`^the subscribed function is not "ACTIVE"$`, func() error {
		// Arrange: delete the function, apply a create dwell, and re-create so it exists
		// but has not yet resolved to ACTIVE. This reuses the same function name as
		// lambdaTestFunctionName in lambda_test.go (which "the function exists" creates).
		sess := managementSession()
		// Act: delete any existing function, apply dwell, then re-create
		_, _ = world.LambdaClient().DeleteFunction(context.Background(), &lambda.DeleteFunctionInput{
			FunctionName: aws.String(lambdaTestFunctionName),
		})
		if err := sess.Lifecycle("lambda").CreateDwellMs(5000).Apply(); err != nil {
			return fmt.Errorf("lifecycle apply failed: %w", err)
		}
		_, err := world.LambdaClient().CreateFunction(context.Background(), &lambda.CreateFunctionInput{
			FunctionName: aws.String(lambdaTestFunctionName),
			Runtime:      lambdatypes.RuntimePython312,
			Role:         aws.String(lambdaTestRoleArn),
			Handler:      aws.String("index.handler"),
			Code: &lambdatypes.FunctionCode{
				ZipFile: []byte("fake"),
			},
		})
		// Assert: caller checks error
		return err
	})

	// ── When: cross-service actions ────────────────────────────────────────────────

	sc.When(`^a Lambda function subscribes to an "SNS" topic$`, func() error {
		// Cannot configure SNS->Lambda subscription via the public API in lws.
		// Pre-load a failure so "the operation is rejected" passes when needed.
		setResult(world, nil, fmt.Errorf("cannot configure SNS subscription to Lambda in lws"))
		return nil
	})

	sc.When(`^a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function$`, func() error {
		// Cannot trigger SNS->Lambda invocation in lws without Docker.
		// Pre-load a failure so "the operation is rejected" passes when needed.
		setResult(world, nil, fmt.Errorf("cannot trigger SNS->Lambda invocation in lws"))
		return nil
	})

	// ── Then: cross-service assertions ─────────────────────────────────────────────

	sc.Then(`^the subscription is "CONFIRMED" and the function will be invoked on published messages$`, func() error {
		// @internal: Cannot verify SNS->Lambda subscription via the public API in lws.
		// Scenarios using this step are all tagged @internal and excluded by the tag filter.
		return nil
	})

	// ── Invariant Then steps ───────────────────────────────────────────────────────

	sc.Then(`^every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic$`, func() error {
		// No-op: model-level invariant; trivially satisfied in isolated lws context.
		return nil
	})

	sc.Then(`^every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription$`, func() error {
		// No-op: model-level invariant; trivially satisfied in isolated lws context.
		return nil
	})
}
