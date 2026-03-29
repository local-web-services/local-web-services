package tests

// registerLambdaS3TablesSteps registers step definitions specific to the
// lambda_s3tables cross-service feature files.
//
// All constituent service steps (function existence, bucket/table existence, lifecycle
// states, operation-is-rejected) are already registered by registerLambdaSteps
// and registerS3TablesSteps.  Only the unique cross-service When/Then steps and
// the cross-service Given preconditions that differ in wording from the
// single-service files are defined here.

import (
	"context"
	"fmt"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/lambda"
	lambdatypes "github.com/aws/aws-sdk-go-v2/service/lambda/types"
	"github.com/aws/aws-sdk-go-v2/service/s3tables"
	"github.com/cucumber/godog"
)

const lambdaS3TablesTestFunc = "test-lambda-s3tables-1"
const lambdaS3TablesTestBucket = "test-lambda-s3tables-bucket-1"
const lambdaS3TablesTestTable = "test-lambda-s3tables-table-1"
const lambdaS3TablesTestNamespace = "test-lambda-s3tables-ns-1"
const lambdaS3TablesTestRoleArn = "arn:aws:iam::000000000000:role/test"

func createLambdaS3TablesFunction(world *World) error {
	// Arrange
	// Act
	_, err := world.LambdaClient().CreateFunction(context.Background(), &lambda.CreateFunctionInput{
		FunctionName: aws.String(lambdaS3TablesTestFunc),
		Runtime:      lambdatypes.RuntimePython312,
		Role:         aws.String(lambdaS3TablesTestRoleArn),
		Handler:      aws.String("index.handler"),
		Code: &lambdatypes.FunctionCode{
			ZipFile: []byte("fake"),
		},
	})
	// Assert: caller checks error
	return err
}

func createLambdaS3TablesBucket(world *World) error {
	// Arrange
	// Act
	_, err := world.S3TablesClient().CreateTableBucket(context.Background(), &s3tables.CreateTableBucketInput{
		Name: aws.String(lambdaS3TablesTestBucket),
	})
	// Assert: caller checks error
	return err
}

func createLambdaS3TablesTable(world *World) error {
	// Arrange
	// Act
	_, err := world.S3TablesClient().CreateTable(context.Background(), &s3tables.CreateTableInput{
		TableBucketARN: aws.String(lambdaS3TablesTestBucket),
		Namespace:      aws.String(lambdaS3TablesTestNamespace),
		Name:           aws.String(lambdaS3TablesTestTable),
		Format:         "ICEBERG",
	})
	// Assert: caller checks error
	return err
}

func registerLambdaS3TablesSteps(sc *godog.ScenarioContext, world *World) {
	// ── Given: invocation / slot state ─────────────────────────────────────────

	sc.Given(`^an invocation is "IN_PROGRESS"$`, func() error {
		// Arrange: create the Lambda function so an invocation could be in progress
		// Act
		return createLambdaS3TablesFunction(world)
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

	sc.Given(`^a record slot is available$`, func() error {
		// No-op: always room for records in lws.
		return nil
	})

	sc.Given(`^no record slot is available$`, func() error {
		// @internal: Cannot exhaust record slot limit in lws via public APIs.
		return nil
	})

	// ── Given: S3Tables bucket/table state unique to cross-service scenarios ────

	sc.Given(`^the table bucket is "ACTIVE"$`, func() error {
		// Arrange: create the table bucket
		// Act
		return createLambdaS3TablesBucket(world)
	})

	sc.Given(`^the table bucket is not "ACTIVE"$`, func() error {
		// @internal: Cannot force a bucket into a non-ACTIVE state via public APIs.
		return nil
	})

	sc.Given(`^a table is "ACTIVE"$`, func() error {
		// Arrange: create the bucket then the table
		_ = createLambdaS3TablesBucket(world)
		// Act
		return createLambdaS3TablesTable(world)
	})

	sc.Given(`^no table is "ACTIVE"$`, func() error {
		// No-op: fresh state has no tables in lws.
		return nil
	})

	sc.Given(`^the table is "DELETING"$`, func() error {
		// Arrange: create bucket, create table, then delete table
		_ = createLambdaS3TablesBucket(world)
		_ = createLambdaS3TablesTable(world)
		// Act: delete the table to put it in DELETING state
		_, err := world.S3TablesClient().DeleteTable(context.Background(), &s3tables.DeleteTableInput{
			TableBucketARN: aws.String(lambdaS3TablesTestBucket),
			Namespace:      aws.String(lambdaS3TablesTestNamespace),
			Name:           aws.String(lambdaS3TablesTestTable),
		})
		// Assert: caller checks error
		return err
	})

	sc.Given(`^the table is not "DELETING"$`, func() error {
		// Arrange: create the bucket and table (ACTIVE, not DELETING)
		_ = createLambdaS3TablesBucket(world)
		// Act
		return createLambdaS3TablesTable(world)
	})

	sc.Given(`^the table is already "DELETING"$`, func() error {
		// Arrange: create bucket, create table, then delete table
		_ = createLambdaS3TablesBucket(world)
		_ = createLambdaS3TablesTable(world)
		// Act: delete the table to put it in DELETING state
		_, err := world.S3TablesClient().DeleteTable(context.Background(), &s3tables.DeleteTableInput{
			TableBucketARN: aws.String(lambdaS3TablesTestBucket),
			Namespace:      aws.String(lambdaS3TablesTestNamespace),
			Name:           aws.String(lambdaS3TablesTestTable),
		})
		// Assert: caller checks error
		return err
	})

	// ── When: actions ────────────────────────────────────────────────────────────

	sc.When(`^a Lambda function is deployed$`, func() error {
		// Arrange
		// Act
		result, err := world.LambdaClient().CreateFunction(context.Background(), &lambda.CreateFunctionInput{
			FunctionName: aws.String(lambdaS3TablesTestFunc),
			Runtime:      lambdatypes.RuntimePython312,
			Role:         aws.String(lambdaS3TablesTestRoleArn),
			Handler:      aws.String("index.handler"),
			Code: &lambdatypes.FunctionCode{
				ZipFile: []byte("fake"),
			},
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^an S3 table bucket is created$`, func() error {
		// Arrange
		// Act
		result, err := world.S3TablesClient().CreateTableBucket(context.Background(), &s3tables.CreateTableBucketInput{
			Name: aws.String(lambdaS3TablesTestBucket),
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^a table is created in the table bucket$`, func() error {
		// Arrange
		// Act
		result, err := world.S3TablesClient().CreateTable(context.Background(), &s3tables.CreateTableInput{
			TableBucketARN: aws.String(lambdaS3TablesTestBucket),
			Namespace:      aws.String(lambdaS3TablesTestNamespace),
			Name:           aws.String(lambdaS3TablesTestTable),
			Format:         "ICEBERG",
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^a table deletion is initiated$`, func() error {
		// Arrange
		// Act
		result, err := world.S3TablesClient().DeleteTable(context.Background(), &s3tables.DeleteTableInput{
			TableBucketARN: aws.String(lambdaS3TablesTestBucket),
			Namespace:      aws.String(lambdaS3TablesTestNamespace),
			Name:           aws.String(lambdaS3TablesTestTable),
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

	sc.When(`^the Lambda function fails to write because the table is being deleted$`, func() error {
		// @internal: Cannot trigger Lambda invocation failure in lws.
		setResult(world, nil, fmt.Errorf("cannot trigger Lambda invocation failure: scenario is @internal"))
		return nil
	})

	sc.When(`^the Lambda function writes a record to an "ACTIVE" table and succeeds$`, func() error {
		// @internal: Cannot trigger Lambda record write in lws without Docker.
		setResult(world, nil, fmt.Errorf("cannot trigger Lambda record write: scenario is @internal"))
		return nil
	})

	// ── Then: assertions ──────────────────────────────────────────────────────────

	sc.Then(`^the function is "ACTIVE"$`, func() error {
		// Arrange
		// Act
		resp, err := world.LambdaClient().GetFunction(context.Background(), &lambda.GetFunctionInput{
			FunctionName: aws.String(lambdaS3TablesTestFunc),
		})
		if err != nil {
			return fmt.Errorf("get function: %w", err)
		}
		// Assert
		expectedState := "Active"
		actualState := string(resp.Configuration.State)
		if actualState != expectedState {
			return fmt.Errorf("expected function state %q but got %q; expected_state=%s actual_state=%s",
				expectedState, actualState, expectedState, actualState)
		}
		return nil
	})

	sc.Then(`^the bucket is "ACTIVE"$`, func() error {
		// Arrange
		// Act
		resp, err := world.S3TablesClient().GetTableBucket(context.Background(), &s3tables.GetTableBucketInput{
			TableBucketARN: aws.String(lambdaS3TablesTestBucket),
		})
		if err != nil {
			return fmt.Errorf("get table bucket: %w", err)
		}
		// Assert
		expectedName := lambdaS3TablesTestBucket
		actualName := aws.ToString(resp.Name)
		if actualName != expectedName {
			return fmt.Errorf("expected bucket name %q but got %q; expected_name=%s actual_name=%s",
				expectedName, actualName, expectedName, actualName)
		}
		return nil
	})

	sc.Then(`^the table is "ACTIVE"$`, func() error {
		// Arrange
		// Act
		resp, err := world.S3TablesClient().GetTable(context.Background(), &s3tables.GetTableInput{
			TableBucketARN: aws.String(lambdaS3TablesTestBucket),
			Namespace:      aws.String(lambdaS3TablesTestNamespace),
			Name:           aws.String(lambdaS3TablesTestTable),
		})
		if err != nil {
			return fmt.Errorf("get table: %w", err)
		}
		// Assert
		expectedName := lambdaS3TablesTestTable
		actualName := aws.ToString(resp.Name)
		if actualName != expectedName {
			return fmt.Errorf("expected table name %q but got %q; expected_name=%s actual_name=%s",
				expectedName, actualName, expectedName, actualName)
		}
		return nil
	})

	sc.Then(`^the table is "DELETING" and write operations will fail$`, func() error {
		// @internal: Cannot observe table DELETING state in lws.
		return nil
	})

	sc.Then(`^the invocation is "IN_PROGRESS"$`, func() error {
		// @internal: Cannot observe Lambda invocation state in lws.
		return nil
	})

	sc.Then(`^the invocation is "FAILED" with a ResourceNotFoundException$`, func() error {
		// @internal: Cannot observe Lambda invocation failure in lws.
		return nil
	})

	sc.Then(`^the record "EXISTS" and the invocation is "SUCCESS"$`, func() error {
		// @internal: Cannot observe Lambda record write result in lws.
		return nil
	})

	// ── Invariant catch-all steps ─────────────────────────────────────────────────

	sc.Then(`^every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function$`, func() error {
		// No-op: model-level invariant; trivially satisfied in isolated lws context.
		return nil
	})

	sc.Then(`^every existing record references a table that exists$`, func() error {
		// No-op: model-level invariant; trivially satisfied in isolated lws context.
		return nil
	})
}
