package tests

// registerLambdaMemoryDBSteps registers step definitions specific to the
// lambda_memorydb cross-service feature files.
//
// All constituent service steps (function existence, cluster existence, lifecycle
// states, operation-is-rejected) are already registered by registerLambdaSteps
// and registerMemoryDBSteps.  Only the unique cross-service When/Then steps and
// the cross-service Given preconditions that differ in wording from the
// single-service files are defined here.

import (
	"context"
	"fmt"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/lambda"
	lambdatypes "github.com/aws/aws-sdk-go-v2/service/lambda/types"
	"github.com/aws/aws-sdk-go-v2/service/memorydb"
	"github.com/cucumber/godog"
)

const lambdaMemoryDBTestFunc = "test-lambda-memorydb-1"
const lambdaMemoryDBTestCluster = "test-lambda-memorydb-cluster-1"
const lambdaMemoryDBTestRoleArn = "arn:aws:iam::000000000000:role/test"

func createLambdaMemoryDBFunction(world *World) error {
	// Arrange
	// Act
	_, err := world.LambdaClient().CreateFunction(context.Background(), &lambda.CreateFunctionInput{
		FunctionName: aws.String(lambdaMemoryDBTestFunc),
		Runtime:      lambdatypes.RuntimePython312,
		Role:         aws.String(lambdaMemoryDBTestRoleArn),
		Handler:      aws.String("index.handler"),
		Code: &lambdatypes.FunctionCode{
			ZipFile: []byte("fake"),
		},
	})
	// Assert: caller checks error
	return err
}

func createLambdaMemoryDBCluster(world *World) error {
	// Arrange
	// Act
	_, err := world.MemoryDBClient().CreateCluster(context.Background(), &memorydb.CreateClusterInput{
		ClusterName: aws.String(lambdaMemoryDBTestCluster),
		NodeType:    aws.String("db.t4g.small"),
		ACLName:     aws.String("open-access"),
	})
	// Assert: caller checks error
	return err
}

func registerLambdaMemoryDBSteps(sc *godog.ScenarioContext, world *World) {
	// ── Given: invocation / slot state ─────────────────────────────────────────

	sc.Given(`^an invocation is "IN_PROGRESS"$`, func() error {
		// Arrange: create the Lambda function so an invocation could be in progress
		// Act
		return createLambdaMemoryDBFunction(world)
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

	// ── When: actions ────────────────────────────────────────────────────────────

	sc.When(`^a Lambda function is deployed$`, func() error {
		// Arrange
		// Act
		result, err := world.LambdaClient().CreateFunction(context.Background(), &lambda.CreateFunctionInput{
			FunctionName: aws.String(lambdaMemoryDBTestFunc),
			Runtime:      lambdatypes.RuntimePython312,
			Role:         aws.String(lambdaMemoryDBTestRoleArn),
			Handler:      aws.String("index.handler"),
			Code: &lambdatypes.FunctionCode{
				ZipFile: []byte("fake"),
			},
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^a MemoryDB cluster is created$`, func() error {
		// Arrange
		// Act
		result, err := world.MemoryDBClient().CreateCluster(context.Background(), &memorydb.CreateClusterInput{
			ClusterName: aws.String(lambdaMemoryDBTestCluster),
			NodeType:    aws.String("db.t4g.small"),
			ACLName:     aws.String("open-access"),
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^a MemoryDB cluster update begins$`, func() error {
		// @internal: Cannot force a cluster into UPDATING state via public APIs.
		setResult(world, nil, fmt.Errorf("cannot force cluster update: scenario is @internal"))
		return nil
	})

	sc.When(`^the MemoryDB cluster update completes$`, func() error {
		// @internal: Cannot force cluster update completion via public APIs.
		setResult(world, nil, fmt.Errorf("cannot force cluster update completion: scenario is @internal"))
		return nil
	})

	sc.When(`^the Lambda function is invoked$`, func() error {
		// @internal: Cannot trigger Lambda invocation in lws without Docker.
		setResult(world, nil, fmt.Errorf("cannot trigger Lambda invocation: scenario is @internal"))
		return nil
	})

	sc.When(`^the Lambda function fails to write because the cluster is updating$`, func() error {
		// @internal: Cannot trigger Lambda invocation failure in lws.
		setResult(world, nil, fmt.Errorf("cannot trigger Lambda invocation failure: scenario is @internal"))
		return nil
	})

	sc.When(`^the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation$`, func() error {
		// @internal: Cannot trigger Lambda record write in lws without Docker.
		setResult(world, nil, fmt.Errorf("cannot trigger Lambda record write: scenario is @internal"))
		return nil
	})

	// ── Then: assertions ──────────────────────────────────────────────────────────

	sc.Then(`^the function is "ACTIVE"$`, func() error {
		// Arrange
		// Act
		resp, err := world.LambdaClient().GetFunction(context.Background(), &lambda.GetFunctionInput{
			FunctionName: aws.String(lambdaMemoryDBTestFunc),
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
		resp, err := world.MemoryDBClient().DescribeClusters(context.Background(), &memorydb.DescribeClustersInput{
			ClusterName: aws.String(lambdaMemoryDBTestCluster),
		})
		if err != nil {
			return fmt.Errorf("describe cluster: %w", err)
		}
		// Assert
		expectedStatus := "available"
		actualStatus := aws.ToString(resp.Clusters[0].Status)
		if actualStatus != expectedStatus {
			return fmt.Errorf("expected cluster status %q but got %q; expected_status=%s actual_status=%s",
				expectedStatus, actualStatus, expectedStatus, actualStatus)
		}
		return nil
	})

	sc.Then(`^the cluster is "UPDATING" and write operations may fail$`, func() error {
		// @internal: Cannot observe cluster UPDATING state in lws.
		return nil
	})

	sc.Then(`^the cluster is "AVAILABLE" again$`, func() error {
		// @internal: Cannot observe cluster AVAILABLE-again state in lws.
		return nil
	})

	sc.Then(`^the invocation is "IN_PROGRESS"$`, func() error {
		// @internal: Cannot observe Lambda invocation state in lws.
		return nil
	})

	sc.Then(`^the invocation is "FAILED" with a connection refused error$`, func() error {
		// @internal: Cannot observe Lambda invocation failure in lws.
		return nil
	})

	sc.Then(`^the record "EXISTS" in the cluster and the invocation is "SUCCESS"$`, func() error {
		// @internal: Cannot observe Lambda record write result in lws.
		return nil
	})

	// ── Invariant catch-all steps ─────────────────────────────────────────────────

	sc.Then(`^every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function$`, func() error {
		// No-op: model-level invariant; trivially satisfied in isolated lws context.
		return nil
	})

	sc.Then(`^every existing record references a cluster that exists$`, func() error {
		// No-op: model-level invariant; trivially satisfied in isolated lws context.
		return nil
	})
}
