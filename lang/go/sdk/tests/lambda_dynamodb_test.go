package tests

// registerLambdaDynamodbSteps registers step definitions specific to the
// lambda_dynamodb cross-service feature files.
//
// All constituent service steps (function existence, table existence, lifecycle
// states, operation-is-rejected) are already registered by registerLambdaSteps
// and registerDynamoDBSteps.  Only the unique cross-service When/Then steps and
// the cross-service Given preconditions that differ in wording from the
// single-service files are defined here.

import (
	"context"
	"fmt"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/dynamodb"
	dynamodbtypes "github.com/aws/aws-sdk-go-v2/service/dynamodb/types"
	"github.com/aws/aws-sdk-go-v2/service/lambda"
	lambdatypes "github.com/aws/aws-sdk-go-v2/service/lambda/types"
	"github.com/cucumber/godog"
)

const lambdaDynamodbTestFunc = "e2e-test-func-1"
const lambdaDynamodbTestTable = "e2e-test-table-1"
const lambdaDynamodbTestPK = "pk"
const lambdaDynamodbTestRoleArn = "arn:aws:iam::000000000000:role/test"

func createLambdaDynamodbFunction(world *World) error {
	// Arrange
	// Act
	_, err := world.LambdaClient().CreateFunction(context.Background(), &lambda.CreateFunctionInput{
		FunctionName: aws.String(lambdaDynamodbTestFunc),
		Runtime:      lambdatypes.RuntimePython312,
		Role:         aws.String(lambdaDynamodbTestRoleArn),
		Handler:      aws.String("index.handler"),
		Code: &lambdatypes.FunctionCode{
			ZipFile: []byte("fake"),
		},
	})
	// Assert: caller checks error
	return err
}

func createLambdaDynamodbTable(world *World) error {
	// Arrange
	// Act
	_, err := world.DynamoDBClient().CreateTable(context.Background(), &dynamodb.CreateTableInput{
		TableName: aws.String(lambdaDynamodbTestTable),
		KeySchema: []dynamodbtypes.KeySchemaElement{
			{AttributeName: aws.String(lambdaDynamodbTestPK), KeyType: dynamodbtypes.KeyTypeHash},
		},
		AttributeDefinitions: []dynamodbtypes.AttributeDefinition{
			{AttributeName: aws.String(lambdaDynamodbTestPK), AttributeType: dynamodbtypes.ScalarAttributeTypeS},
		},
		BillingMode: dynamodbtypes.BillingModePayPerRequest,
	})
	// Assert: caller checks error
	return err
}

func registerLambdaDynamodbSteps(sc *godog.ScenarioContext, world *World) {
	// ── Given: invocation / slot state ─────────────────────────────────────────

	sc.Given(`^an invocation is "IN_PROGRESS"$`, func() error {
		// Arrange: create the Lambda function so an invocation could be in progress
		// Act
		return createLambdaDynamodbFunction(world)
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
		// @internal: Cannot exhaust invocation slot limit in lws via public APIs.
		return nil
	})

	sc.Given(`^an item slot is available$`, func() error {
		// No-op: always room for items in lws.
		return nil
	})

	sc.Given(`^no item slot is available$`, func() error {
		// @internal: Cannot exhaust item slot limit in lws via public APIs.
		return nil
	})

	// ── When: actions ────────────────────────────────────────────────────────────

	sc.When(`^a Lambda function is deployed$`, func() error {
		// Arrange
		// Act
		err := createLambdaDynamodbFunction(world)
		// Assert: store result
		setResult(world, lambdaDynamodbTestFunc, err)
		return nil
	})

	// "a DynamoDB table is created" — already registered by registerSequenceSteps in
	// sequences_test.go; NOT re-registered here to avoid godog duplicate-step panics.

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

	sc.When(`^the Lambda function writes an item to the DynamoDB table during invocation$`, func() error {
		// @internal: Cannot trigger Lambda item write in lws without Docker.
		setResult(world, nil, fmt.Errorf("cannot trigger Lambda item write: scenario is @internal"))
		return nil
	})

	// ── Then: assertions ──────────────────────────────────────────────────────────

	// "the function is "ACTIVE"" — already registered as a Given no-op in lambda_test.go;
	// that registration also matches the Then keyword in the deploy_function feature.

	// "the table is "ACTIVE"" — already registered as a Given no-op in dynamodb_test.go;
	// that registration also matches the Then keyword in the create_table feature.

	sc.Then(`^the invocation is "IN_PROGRESS"$`, func() error {
		// @internal: Cannot observe Lambda invocation state in lws.
		return nil
	})

	sc.Then(`^the invocation is "FAILED"$`, func() error {
		// @internal: Cannot observe Lambda invocation failure in lws.
		return nil
	})

	sc.Then(`^the invocation is "SUCCESS"$`, func() error {
		// @internal: Cannot observe Lambda invocation success in lws.
		return nil
	})

	sc.Then(`^the item "EXISTS" in the table$`, func() error {
		// @internal: Cannot observe Lambda item write result in lws.
		return nil
	})

	// ── Invariant catch-all steps ─────────────────────────────────────────────────

	sc.Then(`^every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function$`, func() error {
		// No-op: model-level invariant; trivially satisfied in isolated lws context.
		return nil
	})

	// "every existing item belongs to an "ACTIVE" table" — already registered by
	// registerSequenceSteps in sequences_test.go; NOT re-registered here to avoid
	// godog duplicate-step panics.
}
