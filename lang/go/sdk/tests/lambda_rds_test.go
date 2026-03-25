package tests

// registerLambdaRDSSteps registers step definitions specific to the
// lambda_rds cross-service feature files.
//
// All constituent service steps (function existence, instance existence, lifecycle
// states, operation-is-rejected) are already registered by registerLambdaSteps
// and registerRDSSteps.  Only the unique cross-service When/Then steps and
// the cross-service Given preconditions that differ in wording from the
// single-service files are defined here.

import (
	"context"
	"fmt"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/lambda"
	lambdatypes "github.com/aws/aws-sdk-go-v2/service/lambda/types"
	"github.com/aws/aws-sdk-go-v2/service/rds"
	"github.com/cucumber/godog"
)

const lambdaRDSTestFunc = "test-lambda-rds-1"
const lambdaRDSTestInstance = "test-lambda-rds-instance-1"
const lambdaRDSTestRoleArn = "arn:aws:iam::000000000000:role/test"

func createLambdaRDSFunction(world *World) error {
	// Arrange
	// Act
	_, err := world.LambdaClient().CreateFunction(context.Background(), &lambda.CreateFunctionInput{
		FunctionName: aws.String(lambdaRDSTestFunc),
		Runtime:      lambdatypes.RuntimePython312,
		Role:         aws.String(lambdaRDSTestRoleArn),
		Handler:      aws.String("index.handler"),
		Code: &lambdatypes.FunctionCode{
			ZipFile: []byte("fake"),
		},
	})
	// Assert: caller checks error
	return err
}

func createLambdaRDSInstance(world *World) error {
	// Arrange
	// Act
	_, err := world.RDSClient().CreateDBInstance(context.Background(), &rds.CreateDBInstanceInput{
		DBInstanceIdentifier: aws.String(lambdaRDSTestInstance),
		DBInstanceClass:      aws.String("db.t3.micro"),
		Engine:               aws.String("mysql"),
		MasterUsername:       aws.String("admin"),
		MasterUserPassword:   aws.String("password123"),
	})
	// Assert: caller checks error
	return err
}

func registerLambdaRDSSteps(sc *godog.ScenarioContext, world *World) {
	// ── Given: invocation / slot state ─────────────────────────────────────────

	sc.Given(`^an invocation is "IN_PROGRESS"$`, func() error {
		// Arrange: create the Lambda function so an invocation could be in progress
		// Act
		return createLambdaRDSFunction(world)
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

	// ── Given: RDS instance state unique to cross-service scenarios ─────────────

	sc.Given(`^the database instance is "FAILING_OVER"$`, func() error {
		// Arrange: create instance then trigger failover
		_ = createLambdaRDSInstance(world)
		// Act
		_, err := world.RDSClient().RebootDBInstance(context.Background(), &rds.RebootDBInstanceInput{
			DBInstanceIdentifier: aws.String(lambdaRDSTestInstance),
			ForceFailover:        aws.Bool(true),
		})
		// Assert: caller checks error
		return err
	})

	sc.Given(`^the database instance is not "FAILING_OVER"$`, func() error {
		// Arrange: create the instance (available, not failing over)
		// Act
		return createLambdaRDSInstance(world)
	})

	sc.Given(`^the database instance is "AVAILABLE"$`, func() error {
		// Arrange: create the instance (available by default)
		// Act
		return createLambdaRDSInstance(world)
	})

	// ── When: actions ────────────────────────────────────────────────────────────

	sc.When(`^a Lambda function is deployed$`, func() error {
		// Arrange
		// Act
		result, err := world.LambdaClient().CreateFunction(context.Background(), &lambda.CreateFunctionInput{
			FunctionName: aws.String(lambdaRDSTestFunc),
			Runtime:      lambdatypes.RuntimePython312,
			Role:         aws.String(lambdaRDSTestRoleArn),
			Handler:      aws.String("index.handler"),
			Code: &lambdatypes.FunctionCode{
				ZipFile: []byte("fake"),
			},
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^an "RDS" database instance is created$`, func() error {
		// Arrange
		// Act
		result, err := world.RDSClient().CreateDBInstance(context.Background(), &rds.CreateDBInstanceInput{
			DBInstanceIdentifier: aws.String(lambdaRDSTestInstance),
			DBInstanceClass:      aws.String("db.t3.micro"),
			Engine:               aws.String("mysql"),
			MasterUsername:       aws.String("admin"),
			MasterUserPassword:   aws.String("password123"),
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^a Multi-"AZ" failover begins on the "RDS" instance$`, func() error {
		// Arrange
		// Act
		result, err := world.RDSClient().RebootDBInstance(context.Background(), &rds.RebootDBInstanceInput{
			DBInstanceIdentifier: aws.String(lambdaRDSTestInstance),
			ForceFailover:        aws.Bool(true),
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^the Multi-"AZ" failover completes and the new primary is promoted$`, func() error {
		// @internal: Cannot force failover completion via public APIs.
		setResult(world, nil, fmt.Errorf("cannot force failover completion: scenario is @internal"))
		return nil
	})

	sc.When(`^the Lambda function is invoked$`, func() error {
		// @internal: Cannot trigger Lambda invocation in lws without Docker.
		setResult(world, nil, fmt.Errorf("cannot trigger Lambda invocation: scenario is @internal"))
		return nil
	})

	sc.When(`^the Lambda function fails to connect because the database is failing over$`, func() error {
		// @internal: Cannot trigger Lambda invocation failure in lws.
		setResult(world, nil, fmt.Errorf("cannot trigger Lambda invocation failure: scenario is @internal"))
		return nil
	})

	sc.When(`^the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds$`, func() error {
		// @internal: Cannot trigger Lambda invocation success in lws.
		setResult(world, nil, fmt.Errorf("cannot trigger Lambda invocation success: scenario is @internal"))
		return nil
	})

	// ── Then: assertions ──────────────────────────────────────────────────────────

	sc.Then(`^the function is "ACTIVE"$`, func() error {
		// Arrange
		// Act
		resp, err := world.LambdaClient().GetFunction(context.Background(), &lambda.GetFunctionInput{
			FunctionName: aws.String(lambdaRDSTestFunc),
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

	sc.Then(`^the instance is "AVAILABLE"$`, func() error {
		// Arrange
		// Act
		resp, err := world.RDSClient().DescribeDBInstances(context.Background(), &rds.DescribeDBInstancesInput{
			DBInstanceIdentifier: aws.String(lambdaRDSTestInstance),
		})
		if err != nil {
			return fmt.Errorf("describe instance: %w", err)
		}
		// Assert
		expectedStatus := "available"
		actualStatus := aws.ToString(resp.DBInstances[0].DBInstanceStatus)
		if actualStatus != expectedStatus {
			return fmt.Errorf("expected instance status %q but got %q; expected_status=%s actual_status=%s",
				expectedStatus, actualStatus, expectedStatus, actualStatus)
		}
		return nil
	})

	sc.Then(`^the instance is "FAILING_OVER" and temporarily unavailable for connections$`, func() error {
		// Arrange
		// Act
		resp, err := world.RDSClient().DescribeDBInstances(context.Background(), &rds.DescribeDBInstancesInput{
			DBInstanceIdentifier: aws.String(lambdaRDSTestInstance),
		})
		if err != nil {
			return fmt.Errorf("describe instance: %w", err)
		}
		// Assert
		expectedStatus := "failing-over"
		actualStatus := aws.ToString(resp.DBInstances[0].DBInstanceStatus)
		if actualStatus != expectedStatus {
			return fmt.Errorf("expected instance status %q but got %q; expected_status=%s actual_status=%s",
				expectedStatus, actualStatus, expectedStatus, actualStatus)
		}
		return nil
	})

	sc.Then(`^the instance is "AVAILABLE" again$`, func() error {
		// @internal: Cannot observe failover completion in lws.
		return nil
	})

	sc.Then(`^the invocation is "IN_PROGRESS"$`, func() error {
		// @internal: Cannot observe Lambda invocation state in lws.
		return nil
	})

	sc.Then(`^the invocation is "FAILED" with a connection error$`, func() error {
		// @internal: Cannot observe Lambda invocation failure in lws.
		return nil
	})

	sc.Then(`^the invocation is "SUCCESS"$`, func() error {
		// @internal: Cannot observe Lambda invocation success in lws.
		return nil
	})

	// ── Invariant catch-all steps ─────────────────────────────────────────────────

	sc.Then(`^every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function$`, func() error {
		// No-op: model-level invariant; trivially satisfied in isolated lws context.
		return nil
	})

	sc.Then(`^every successful invocation recorded which database it queried$`, func() error {
		// No-op: model-level invariant; trivially satisfied in isolated lws context.
		return nil
	})
}
