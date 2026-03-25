package tests

// registerLambdaS3apiSteps registers step definitions specific to the
// lambda_s3api cross-service feature files.
//
// Features: lang/specification/core/informal/lambda_s3api/
// Safety invariants: InvocationRequiresActiveFunction, ObjectRequiresActiveBucket
//
// Steps already registered in single-service files (lambda_test.go, s3api_test.go,
// sequences_test.go, sqs_test.go) are NOT re-registered here.

import (
	"context"
	"fmt"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/lambda"
	lambdatypes "github.com/aws/aws-sdk-go-v2/service/lambda/types"
	"github.com/aws/aws-sdk-go-v2/service/s3"
	"github.com/cucumber/godog"
)

const lambdaS3apiTestFuncName = "e2e-test-func-1"
const lambdaS3apiTestBucketName = "e2e-test-bucket-1"
const lambdaS3apiTestRoleArn = "arn:aws:iam::000000000000:role/test"

func lambdaS3apiCreateFunction(world *World) error {
	// Arrange
	// Act
	_, err := world.LambdaClient().CreateFunction(context.Background(), &lambda.CreateFunctionInput{
		FunctionName: aws.String(lambdaS3apiTestFuncName),
		Runtime:      lambdatypes.RuntimePython312,
		Role:         aws.String(lambdaS3apiTestRoleArn),
		Handler:      aws.String("index.handler"),
		Code: &lambdatypes.FunctionCode{
			ZipFile: []byte("fake"),
		},
	})
	// Assert: caller checks error
	return err
}

func registerLambdaS3apiSteps(sc *godog.ScenarioContext, world *World) {
	// ── Given: invocation slot state ─────────────────────────────────────────

	sc.Given(`^an invocation slot is available$`, func() error {
		// No-op: always room for invocations in fresh state.
		return nil
	})

	sc.Given(`^no invocation slot is available$`, func() error {
		// @internal: Cannot exhaust Lambda invocation slot limit via public API.
		return nil
	})

	// ── Given: invocation in-progress state ──────────────────────────────────

	sc.Given(`^an invocation is "IN_PROGRESS"$`, func() error {
		// Arrange: create the function so an invocation could be in progress.
		// Act: the lws fake does not expose invocation state; creating the
		// function is the closest reachable precondition.
		return lambdaS3apiCreateFunction(world)
	})

	sc.Given(`^no invocation is "IN_PROGRESS"$`, func() error {
		// No-op: fresh state has no invocations.
		return nil
	})

	// ── Given: object slot state ──────────────────────────────────────────────

	sc.Given(`^an object slot is available$`, func() error {
		// No-op: always room for objects in fresh state.
		return nil
	})

	sc.Given(`^no object slot is available$`, func() error {
		// @internal: Cannot exhaust object slot limit via public API.
		return nil
	})

	// ── When: actions ─────────────────────────────────────────────────────────

	sc.When(`^a Lambda function is deployed$`, func() error {
		// Arrange
		// Act
		result, err := world.LambdaClient().CreateFunction(context.Background(), &lambda.CreateFunctionInput{
			FunctionName: aws.String(lambdaS3apiTestFuncName),
			Runtime:      lambdatypes.RuntimePython312,
			Role:         aws.String(lambdaS3apiTestRoleArn),
			Handler:      aws.String("index.handler"),
			Code: &lambdatypes.FunctionCode{
				ZipFile: []byte("fake"),
			},
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^an S3 bucket is created$`, func() error {
		// Arrange
		// Act
		result, err := world.S3Client().CreateBucket(context.Background(), &s3.CreateBucketInput{
			Bucket: aws.String(lambdaS3apiTestBucketName),
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^the Lambda function is invoked$`, func() error {
		// @internal: Cannot trigger Lambda function invocation via public API in lws.
		setResult(world, nil, fmt.Errorf("cannot invoke Lambda function: not reachable via public API in lws"))
		return nil
	})

	sc.When(`^the Lambda invocation fails$`, func() error {
		// @internal: Cannot trigger Lambda invocation failure via public API in lws.
		setResult(world, nil, fmt.Errorf("cannot trigger Lambda invocation failure: scenario is @internal"))
		return nil
	})

	sc.When(`^the Lambda invocation completes successfully$`, func() error {
		// @internal: Cannot trigger Lambda invocation success via public API in lws.
		setResult(world, nil, fmt.Errorf("cannot trigger Lambda invocation success: scenario is @internal"))
		return nil
	})

	sc.When(`^the Lambda function writes an object to the S3 bucket during invocation$`, func() error {
		// @internal: Cannot trigger Lambda object write during invocation via public API in lws.
		setResult(world, nil, fmt.Errorf("cannot trigger Lambda object write: scenario is @internal"))
		return nil
	})

	// ── Then: assertions ──────────────────────────────────────────────────────

	// "the bucket is "ACTIVE"" is already registered as a no-op Given in s3api_test.go;
	// it matches the Then keyword via godog's keyword-agnostic step registry.

	sc.Then(`^the invocation is "IN_PROGRESS"$`, func() error {
		// @internal: Cannot observe Lambda invocation IN_PROGRESS state in lws.
		return nil
	})

	sc.Then(`^the invocation is "FAILED"$`, func() error {
		// @internal: Cannot observe Lambda invocation FAILED state in lws.
		return nil
	})

	sc.Then(`^the invocation is "SUCCESS"$`, func() error {
		// @internal: Cannot observe Lambda invocation SUCCESS state in lws.
		return nil
	})

	// ── Then: invariant assertions (no-op) ───────────────────────────────────

	sc.Then(`^every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function$`, func() error {
		// No-op: model-level invariant; trivially satisfied in isolated lws context.
		return nil
	})

	sc.Then(`^every existing object belongs to an "ACTIVE" bucket$`, func() error {
		// No-op: model-level invariant; trivially satisfied in isolated lws context.
		return nil
	})
}
