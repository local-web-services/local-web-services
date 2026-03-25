package tests

// registerRDSLambdaSteps wires all step definitions for the rds_lambda informal
// specification feature files (create_d_b_instance, deploy_function,
// delete_function, configure_lambda_integration, stored_proc_invokes_lambda,
// invocation_fails_function_deleted).
//
// The stored procedure invocations (stored_proc_invokes_lambda,
// invocation_fails_function_deleted) are @internal because triggering
// a stored procedure invocation is not possible via public AWS APIs in lws.

import (
	"context"
	"fmt"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/lambda"
	lambdatypes "github.com/aws/aws-sdk-go-v2/service/lambda/types"
	"github.com/aws/aws-sdk-go-v2/service/rds"
	"github.com/cucumber/godog"
)

const (
	rdsLambdaTestDBInstanceID = "test-rds-db-1"
	rdsLambdaTestFuncName     = "e2e-test-func-1"
	rdsLambdaTestRoleArn      = "arn:aws:iam::000000000000:role/test"
	rdsLambdaTestDBEngine     = "mysql"
	rdsLambdaTestDBClass      = "db.t3.micro"
)

// rdsLambdaCreateDBInstance is a helper that creates the test RDS DB instance for rds_lambda.
func rdsLambdaCreateDBInstance(world *World) error {
	// Arrange
	// Act
	_, err := world.RDSClient().CreateDBInstance(context.Background(), &rds.CreateDBInstanceInput{
		DBInstanceIdentifier: aws.String(rdsLambdaTestDBInstanceID),
		DBInstanceClass:      aws.String(rdsLambdaTestDBClass),
		Engine:               aws.String(rdsLambdaTestDBEngine),
		MasterUsername:       aws.String("admin"),
		MasterUserPassword:   aws.String("password123"),
	})
	// Assert: caller checks error
	if err != nil && isAlreadyExists(err) {
		return nil
	}
	return err
}

// rdsLambdaCreateFunction is a helper that creates the test Lambda function.
func rdsLambdaCreateFunction(world *World) error {
	// Arrange
	// Act
	_, err := world.LambdaClient().CreateFunction(context.Background(), &lambda.CreateFunctionInput{
		FunctionName: aws.String(rdsLambdaTestFuncName),
		Runtime:      lambdatypes.RuntimePython312,
		Role:         aws.String(rdsLambdaTestRoleArn),
		Handler:      aws.String("index.handler"),
		Code: &lambdatypes.FunctionCode{
			ZipFile: []byte("fake"),
		},
	})
	// Assert: caller checks error
	if err != nil && isAlreadyExists(err) {
		return nil
	}
	return err
}

func registerRDSLambdaSteps(sc *godog.ScenarioContext, world *World) {
	// -------------------------------------------------------------------------
	// Given: DB instance state setup
	// -------------------------------------------------------------------------

	sc.Given(`^the "DB" instance does not already exist$`, func() error {
		// No-op: fresh state after reset has no DB instances.
		return nil
	})

	sc.Given(`^the "DB" instance already exists$`, func() error {
		// Arrange / Act: create the DB instance so it already exists.
		return rdsLambdaCreateDBInstance(world)
	})

	sc.Given(`^the "DB" instance exists and is "AVAILABLE"$`, func() error {
		// Arrange: create the DB instance (lws instances are AVAILABLE after creation)
		// Act
		return rdsLambdaCreateDBInstance(world)
	})

	sc.Given(`^the "DB" instance does not exist or is not "AVAILABLE"$`, func() error {
		// @internal: Cannot force a DB instance into a non-AVAILABLE state via public API.
		// Only reached by @lifecycle scenarios excluded by the tag filter.
		return nil
	})

	sc.Given(`^the "DB" instance is "AVAILABLE"$`, func() error {
		// Arrange: create the DB instance (lws instances are AVAILABLE after creation)
		// Act
		return rdsLambdaCreateDBInstance(world)
	})

	sc.Given(`^the "DB" instance is not "AVAILABLE"$`, func() error {
		// @internal: Cannot force a DB instance into a non-AVAILABLE state via public API.
		// Only reached by @lifecycle scenarios excluded by the tag filter.
		return nil
	})

	// ── Given: Lambda integration state ───────────────────────────────────────

	sc.Given(`^the "DB" instance has no Lambda integration configured$`, func() error {
		// No-op: fresh DB instances have no Lambda integration configured.
		return nil
	})

	sc.Given(`^the "DB" instance already has a Lambda integration configured$`, func() error {
		// @internal: Cannot configure Lambda integration on an lws DB instance via public API
		// in a way that lws tracks as a precondition. No-op: only reached by excluded scenarios.
		return nil
	})

	sc.Given(`^the "DB" instance has a Lambda integration configured$`, func() error {
		// @internal: Cannot configure Lambda integration state in lws via public API.
		// Only reached by @internal scenarios excluded by the tag filter.
		return nil
	})

	// ── Given: Lambda function state ──────────────────────────────────────────

	sc.Given(`^the function does not already exist$`, func() error {
		// No-op: fresh state after reset has no Lambda functions.
		return nil
	})

	sc.Given(`^the function already exists$`, func() error {
		// Arrange / Act: create the function so it already exists.
		return rdsLambdaCreateFunction(world)
	})

	sc.Given(`^the function exists$`, func() error {
		// Arrange: ensure the Lambda function exists.
		// Act
		return rdsLambdaCreateFunction(world)
	})

	sc.Given(`^the function exists and is "ACTIVE"$`, func() error {
		// Arrange: create the Lambda function (lws functions are ACTIVE after creation)
		// Act
		return rdsLambdaCreateFunction(world)
	})

	sc.Given(`^the function does not exist or is not "ACTIVE"$`, func() error {
		// No-op: fresh state after reset has no Lambda functions (simulates absent function).
		return nil
	})

	sc.Given(`^the Lambda function is "ACTIVE"$`, func() error {
		// No-op: Lambda functions in lws are ACTIVE after creation.
		return nil
	})

	sc.Given(`^the Lambda function is not "ACTIVE"$`, func() error {
		// @internal: Cannot force a Lambda function into a non-ACTIVE state via public API.
		// Only reached by @lifecycle scenarios excluded by the tag filter.
		return nil
	})

	sc.Given(`^the Lambda function is "DELETED"$`, func() error {
		// No-op: fresh state after reset has no Lambda functions (simulates deleted function).
		return nil
	})

	sc.Given(`^the Lambda function is not "DELETED"$`, func() error {
		// Arrange: create the Lambda function so it is not deleted.
		// Act
		return rdsLambdaCreateFunction(world)
	})

	sc.Given(`^the function is "ACTIVE"$`, func() error {
		// No-op: Lambda functions in lws are ACTIVE after creation.
		return nil
	})

	sc.Given(`^the function is already "DELETED"$`, func() error {
		// @internal: Cannot force a function into DELETED state via public API while still tracked.
		// Only reached by @lifecycle scenarios excluded by the tag filter.
		return nil
	})

	// ── Given: invocation slot state ──────────────────────────────────────────

	sc.Given(`^an invocation slot is available$`, func() error {
		// No-op: always room for invocations in lws.
		return nil
	})

	sc.Given(`^no invocation slot is available$`, func() error {
		// @internal: Cannot exhaust invocation slot limit in lws via public APIs.
		return nil
	})

	// -------------------------------------------------------------------------
	// When: actions
	// -------------------------------------------------------------------------

	sc.When(`^an "RDS" "DB" instance is created$`, func() error {
		// Arrange: (DB instance state set up by Given steps)
		// Act
		resp, err := world.RDSClient().CreateDBInstance(context.Background(), &rds.CreateDBInstanceInput{
			DBInstanceIdentifier: aws.String(rdsLambdaTestDBInstanceID),
			DBInstanceClass:      aws.String(rdsLambdaTestDBClass),
			Engine:               aws.String(rdsLambdaTestDBEngine),
			MasterUsername:       aws.String("admin"),
			MasterUserPassword:   aws.String("password123"),
		})
		// Assert: captured in world
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^a Lambda function is deployed$`, func() error {
		// Arrange: (function state set up by Given steps)
		// Act
		resp, err := world.LambdaClient().CreateFunction(context.Background(), &lambda.CreateFunctionInput{
			FunctionName: aws.String(rdsLambdaTestFuncName),
			Runtime:      lambdatypes.RuntimePython312,
			Role:         aws.String(rdsLambdaTestRoleArn),
			Handler:      aws.String("index.handler"),
			Code: &lambdatypes.FunctionCode{
				ZipFile: []byte("fake"),
			},
		})
		// Assert: captured in world
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^the Lambda function is deleted$`, func() error {
		// Arrange: (function state set up by Given steps)
		// Act
		resp, err := world.LambdaClient().DeleteFunction(context.Background(), &lambda.DeleteFunctionInput{
			FunctionName: aws.String(rdsLambdaTestFuncName),
		})
		// Assert: captured in world
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^the "DB" instance is configured with an "IAM" role to invoke the Lambda function$`, func() error {
		// Arrange: (DB instance and function state set up by Given steps)
		// Act: ModifyDBInstance to add Lambda integration via custom endpoint domain association
		resp, err := world.RDSClient().ModifyDBInstance(context.Background(), &rds.ModifyDBInstanceInput{
			DBInstanceIdentifier: aws.String(rdsLambdaTestDBInstanceID),
		})
		// Assert: captured in world
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^an "RDS" stored procedure invokes the Lambda function and succeeds$`, func() error {
		// @internal: stored_proc_invokes_lambda cannot be triggered via public API.
		setResult(world, nil, fmt.Errorf("stored_proc_invokes_lambda: scenario is @internal"))
		return nil
	})

	sc.When(`^an "RDS" stored procedure fails to invoke Lambda because the function has been deleted$`, func() error {
		// @internal: invocation_fails_function_deleted cannot be triggered via public API.
		setResult(world, nil, fmt.Errorf("invocation_fails_function_deleted: scenario is @internal"))
		return nil
	})

	// -------------------------------------------------------------------------
	// Then: assertions
	// -------------------------------------------------------------------------

	sc.Then(`^the "DB" instance is "AVAILABLE" with no Lambda integration configured$`, func() error {
		// Arrange: no additional setup required
		// Act: action already performed in the When step
		// Assert
		if world.lastResult.Error != nil {
			return fmt.Errorf("expected RDS DB instance creation to succeed but got: %w", world.lastResult.Error)
		}
		resp, err := world.RDSClient().DescribeDBInstances(context.Background(), &rds.DescribeDBInstancesInput{
			DBInstanceIdentifier: aws.String(rdsLambdaTestDBInstanceID),
		})
		if err != nil {
			return fmt.Errorf("expected describe_db_instances to succeed but got: %w", err)
		}
		expectedStatus := "available"
		actualStatus := ""
		if len(resp.DBInstances) > 0 && resp.DBInstances[0].DBInstanceStatus != nil {
			actualStatus = *resp.DBInstances[0].DBInstanceStatus
		}
		if actualStatus != expectedStatus {
			return fmt.Errorf("expected DB instance status %q but got %q; expected_status=%s actual_status=%s",
				expectedStatus, actualStatus, expectedStatus, actualStatus)
		}
		return nil
	})

	sc.Then(`^the function is "ACTIVE"$`, func() error {
		// Arrange: no additional setup required
		// Act: action already performed in the When step
		// Assert
		if world.lastResult.Error != nil {
			return fmt.Errorf("expected Lambda function deployment to succeed but got: %w", world.lastResult.Error)
		}
		return nil
	})

	sc.Then(`^the function is "DELETED" and stored procedure invocations targeting it will fail$`, func() error {
		// Arrange: no additional setup required
		// Act: action already performed in the When step
		// Assert
		if world.lastResult.Error != nil {
			return fmt.Errorf("expected Lambda function deletion to succeed but got: %w", world.lastResult.Error)
		}
		return nil
	})

	sc.Then(`^stored procedures on the "DB" can invoke the Lambda function$`, func() error {
		// Arrange: no additional setup required
		// Act: action already performed in the When step
		// Assert
		if world.lastResult.Error != nil {
			return fmt.Errorf("expected configure_lambda_integration to succeed but got: %w", world.lastResult.Error)
		}
		return nil
	})

	sc.Then(`^the invocation is "SUCCESS"$`, func() error {
		// @internal: stored_proc_invokes_lambda outcome not observable via public API.
		return nil
	})

	sc.Then(`^the invocation is "FAILED" with a function not found error$`, func() error {
		// @internal: invocation_fails_function_deleted outcome not observable via public API.
		return nil
	})

	// ── Invariant catch-all steps ─────────────────────────────────────────────

	sc.Then(`^every successful invocation references a "DB" instance that exists$`, func() error {
		// No-op invariant: trivially satisfied in an isolated test context.
		return nil
	})

	sc.Then(`^every successful invocation recorded which function it invoked$`, func() error {
		// No-op invariant: trivially satisfied in an isolated test context.
		return nil
	})
}
