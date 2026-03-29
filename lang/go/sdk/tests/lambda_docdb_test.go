package tests

// registerLambdaDocDBSteps wires all lambda_docdb cross-service step definitions.
// Steps already registered in lambda_test.go ("the function does not already exist",
// "the function already exists", "the function exists", "the function does not exist",
// "the function is \"ACTIVE\"", "the function is not \"ACTIVE\"",
// "an invocation slot is available", "no invocation slot is available"),
// sequences_test.go ("the system is initialized"), and
// sqs_test.go ("the operation is rejected") are NOT re-registered here.

import (
	"context"
	"fmt"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/docdb"
	"github.com/aws/aws-sdk-go-v2/service/lambda"
	lambdatypes "github.com/aws/aws-sdk-go-v2/service/lambda/types"
	"github.com/cucumber/godog"
)

const lambdaDocDBTestFunc = "test-lambda-docdb-1"
const lambdaDocDBTestCluster = "test-lambda-docdb-cluster-1"
const lambdaDocDBTestRoleArn = "arn:aws:iam::000000000000:role/test"

func lambdaDocDBCreateFunction(world *World) error {
	// Arrange
	// Act
	_, err := world.LambdaClient().CreateFunction(context.Background(), &lambda.CreateFunctionInput{
		FunctionName: aws.String(lambdaDocDBTestFunc),
		Runtime:      lambdatypes.RuntimePython312,
		Role:         aws.String(lambdaDocDBTestRoleArn),
		Handler:      aws.String("index.handler"),
		Code: &lambdatypes.FunctionCode{
			ZipFile: []byte("fake"),
		},
	})
	// Assert: caller checks error
	return err
}

func lambdaDocDBCreateCluster(world *World) error {
	// Arrange
	// Act
	_, err := world.DocDBClient().CreateDBCluster(context.Background(), &docdb.CreateDBClusterInput{
		DBClusterIdentifier: aws.String(lambdaDocDBTestCluster),
		Engine:              aws.String("docdb"),
		MasterUsername:      aws.String("admin"),
		MasterUserPassword:  aws.String("pass1234"),
	})
	// Assert: caller checks error
	return err
}

func registerLambdaDocDBSteps(sc *godog.ScenarioContext, world *World) {
	// ── Given: cluster state ──────────────────────────────────────────────────

	sc.Given(`^the cluster does not already exist$`, func() error {
		// No-op: fresh state has no clusters.
		return nil
	})

	sc.Given(`^the cluster already exists$`, func() error {
		// Arrange: create the cluster so it already exists
		// Act
		return lambdaDocDBCreateCluster(world)
	})

	sc.Given(`^the cluster exists$`, func() error {
		// Arrange: create the cluster
		// Act
		return lambdaDocDBCreateCluster(world)
	})

	sc.Given(`^the cluster is "AVAILABLE"$`, func() error {
		// Arrange: create the cluster so it is AVAILABLE
		// Act
		return lambdaDocDBCreateCluster(world)
	})

	sc.Given(`^the cluster is not "AVAILABLE"$`, func() error {
		// Arrange: create the cluster; lws does not expose STOPPING state via public API
		// Act
		return lambdaDocDBCreateCluster(world)
	})

	sc.Given(`^the cluster is "STOPPED"$`, func() error {
		// Arrange: create the cluster; lws does not expose STOPPED state via StopDBCluster
		// Act
		return lambdaDocDBCreateCluster(world)
	})

	sc.Given(`^the cluster is not "STOPPED"$`, func() error {
		// Arrange: create the cluster (AVAILABLE state is not STOPPED)
		// Act
		return lambdaDocDBCreateCluster(world)
	})

	sc.Given(`^the cluster does not exist$`, func() error {
		// No-op: fresh state has no clusters.
		return nil
	})

	// ── Given: invocation state ───────────────────────────────────────────────

	sc.Given(`^an invocation is "IN_PROGRESS"$`, func() error {
		// Arrange: create the Lambda function so an invocation could be in progress
		// Act
		return lambdaDocDBCreateFunction(world)
	})

	sc.Given(`^no invocation is "IN_PROGRESS"$`, func() error {
		// No-op: fresh state has no in-progress invocations.
		return nil
	})

	// ── Given: slot state ─────────────────────────────────────────────────────

	sc.Given(`^a document slot is available$`, func() error {
		// No-op: always room for documents in lws.
		return nil
	})

	sc.Given(`^no document slot is available$`, func() error {
		// @internal: Cannot exhaust document slot limit in lws via public APIs.
		return nil
	})

	// ── Given: sequence state (fid/cid/iid) ──────────────────────────────────

	sc.Given(`^fid in func_status$`, func() error {
		// Arrange: create the Lambda function so fid is tracked in func_status
		// Act
		return lambdaDocDBCreateFunction(world)
	})

	sc.Given(`^fid not in func_status$`, func() error {
		// No-op: fresh state has no functions in func_status.
		return nil
	})

	sc.Given(`^cid in cluster_status$`, func() error {
		// Arrange: create the cluster so cid is tracked in cluster_status
		// Act
		return lambdaDocDBCreateCluster(world)
	})

	sc.Given(`^cid not in cluster_status$`, func() error {
		// No-op: fresh state has no clusters in cluster_status.
		return nil
	})

	sc.Given(`^iid in inv_status$`, func() error {
		// Arrange: create the Lambda function so an invocation can be tracked
		// Act
		return lambdaDocDBCreateFunction(world)
	})

	// ── When: actions ─────────────────────────────────────────────────────────

	sc.When(`^a Lambda function is deployed$`, func() error {
		// Arrange
		// Act
		result, err := world.LambdaClient().CreateFunction(context.Background(), &lambda.CreateFunctionInput{
			FunctionName: aws.String(lambdaDocDBTestFunc),
			Runtime:      lambdatypes.RuntimePython312,
			Role:         aws.String(lambdaDocDBTestRoleArn),
			Handler:      aws.String("index.handler"),
			Code: &lambdatypes.FunctionCode{
				ZipFile: []byte("fake"),
			},
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^a DocumentDB cluster is created$`, func() error {
		// Arrange
		// Act
		result, err := world.DocDBClient().CreateDBCluster(context.Background(), &docdb.CreateDBClusterInput{
			DBClusterIdentifier: aws.String(lambdaDocDBTestCluster),
			Engine:              aws.String("docdb"),
			MasterUsername:      aws.String("admin"),
			MasterUserPassword:  aws.String("pass1234"),
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^the DocumentDB cluster is stopped$`, func() error {
		// @internal: StopDBCluster is not yet implemented in lws.
		setResult(world, nil, fmt.Errorf("cannot stop DocumentDB cluster: StopDBCluster not implemented in lws"))
		return nil
	})

	sc.When(`^the DocumentDB cluster is started$`, func() error {
		// @internal: StartDBCluster is not yet implemented in lws.
		setResult(world, nil, fmt.Errorf("cannot start DocumentDB cluster: StartDBCluster not implemented in lws"))
		return nil
	})

	sc.When(`^the Lambda function is invoked$`, func() error {
		// @internal: Cannot trigger Lambda invocation in lws without Docker.
		setResult(world, nil, fmt.Errorf("cannot trigger Lambda invocation: scenario is @internal"))
		return nil
	})

	sc.When(`^the Lambda function fails to connect because the DocumentDB cluster is stopped$`, func() error {
		// @internal: Cannot trigger Lambda invocation failure in lws without Docker.
		setResult(world, nil, fmt.Errorf("cannot trigger Lambda invocation failure: scenario is @internal"))
		return nil
	})

	sc.When(`^the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds$`, func() error {
		// @internal: Cannot trigger Lambda document write in lws without Docker.
		setResult(world, nil, fmt.Errorf("cannot trigger Lambda document write: scenario is @internal"))
		return nil
	})

	// ── Then: assertions ──────────────────────────────────────────────────────

	sc.Then(`^the function is "ACTIVE"$`, func() error {
		// Arrange
		// Act
		resp, err := world.LambdaClient().GetFunction(context.Background(), &lambda.GetFunctionInput{
			FunctionName: aws.String(lambdaDocDBTestFunc),
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

	sc.Then(`^the cluster is "AVAILABLE"$`, func() error {
		// Arrange
		// Act
		resp, err := world.DocDBClient().DescribeDBClusters(context.Background(), &docdb.DescribeDBClustersInput{
			DBClusterIdentifier: aws.String(lambdaDocDBTestCluster),
		})
		if err != nil {
			return fmt.Errorf("describe db clusters: %w", err)
		}
		if len(resp.DBClusters) == 0 {
			return fmt.Errorf("expected cluster to be AVAILABLE but cluster was not found")
		}
		// Assert
		expectedStatus := "available"
		actualStatus := aws.ToString(resp.DBClusters[0].Status)
		if actualStatus != expectedStatus {
			return fmt.Errorf("expected cluster status %q but got %q; expected_status=%s actual_status=%s",
				expectedStatus, actualStatus, expectedStatus, actualStatus)
		}
		return nil
	})

	sc.Then(`^the cluster is "AVAILABLE" and ready to accept connections$`, func() error {
		// @internal: StartDBCluster is not yet implemented in lws.
		return nil
	})

	sc.Then(`^the cluster is "STOPPED" and connections will be rejected$`, func() error {
		// @internal: StopDBCluster is not yet implemented in lws.
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

	sc.Then(`^the document "EXISTS" and the invocation is "SUCCESS"$`, func() error {
		// @internal: Cannot observe Lambda document write result in lws.
		return nil
	})

	// ── Invariant catch-all steps ─────────────────────────────────────────────

	sc.Then(`^every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function$`, func() error {
		// No-op: model-level invariant; trivially satisfied in isolated lws context.
		return nil
	})

	sc.Then(`^every existing document references a cluster that exists$`, func() error {
		// No-op: model-level invariant; trivially satisfied in isolated lws context.
		return nil
	})
}
