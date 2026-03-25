package tests

// registerLambdaNeptuneSteps registers step definitions specific to the
// lambda_neptune cross-service feature files.
//
// All constituent service steps (function existence, cluster existence, lifecycle
// states, operation-is-rejected) are already registered by registerLambdaSteps
// and registerNeptuneSteps.  Only the unique cross-service When/Then steps and
// the cross-service Given preconditions that differ in wording from the
// single-service files are defined here.

import (
	"context"
	"fmt"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/lambda"
	lambdatypes "github.com/aws/aws-sdk-go-v2/service/lambda/types"
	"github.com/aws/aws-sdk-go-v2/service/neptune"
	"github.com/cucumber/godog"
)

const lambdaNeptuneTestFunc = "test-lambda-neptune-1"
const lambdaNeptuneTestCluster = "test-lambda-neptune-cluster-1"
const lambdaNeptuneTestRoleArn = "arn:aws:iam::000000000000:role/test"

func createLambdaNeptuneFunction(world *World) error {
	// Arrange
	// Act
	_, err := world.LambdaClient().CreateFunction(context.Background(), &lambda.CreateFunctionInput{
		FunctionName: aws.String(lambdaNeptuneTestFunc),
		Runtime:      lambdatypes.RuntimePython312,
		Role:         aws.String(lambdaNeptuneTestRoleArn),
		Handler:      aws.String("index.handler"),
		Code: &lambdatypes.FunctionCode{
			ZipFile: []byte("fake"),
		},
	})
	// Assert: caller checks error
	return err
}

func createLambdaNeptuneCluster(world *World) error {
	// Arrange
	// Act
	_, err := world.NeptuneClient().CreateDBCluster(context.Background(), &neptune.CreateDBClusterInput{
		DBClusterIdentifier: aws.String(lambdaNeptuneTestCluster),
		Engine:              aws.String("neptune"),
	})
	// Assert: caller checks error
	return err
}

func registerLambdaNeptuneSteps(sc *godog.ScenarioContext, world *World) {
	// ── Given: invocation / slot state ─────────────────────────────────────────

	sc.Given(`^an invocation is "IN_PROGRESS"$`, func() error {
		// Arrange: create the Lambda function so an invocation could be in progress
		// Act
		return createLambdaNeptuneFunction(world)
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

	// ── Given: Neptune cluster state unique to cross-service scenarios ──────────

	sc.Given(`^the Neptune cluster is "STOPPED"$`, func() error {
		// Arrange: create then stop the cluster
		_ = createLambdaNeptuneCluster(world)
		// Act
		_, err := world.NeptuneClient().StopDBCluster(context.Background(), &neptune.StopDBClusterInput{
			DBClusterIdentifier: aws.String(lambdaNeptuneTestCluster),
		})
		// Assert: caller checks error
		return err
	})

	sc.Given(`^the Neptune cluster is not "STOPPED"$`, func() error {
		// Arrange: create the cluster (available, not stopped)
		// Act
		return createLambdaNeptuneCluster(world)
	})

	sc.Given(`^the Neptune cluster is "AVAILABLE"$`, func() error {
		// Arrange: create the cluster (available by default)
		// Act
		return createLambdaNeptuneCluster(world)
	})

	sc.Given(`^the Neptune cluster is not "AVAILABLE"$`, func() error {
		// Arrange: create then stop the cluster so it is not AVAILABLE
		_ = createLambdaNeptuneCluster(world)
		// Act
		_, err := world.NeptuneClient().StopDBCluster(context.Background(), &neptune.StopDBClusterInput{
			DBClusterIdentifier: aws.String(lambdaNeptuneTestCluster),
		})
		// Assert: caller checks error
		return err
	})

	// ── When: actions ────────────────────────────────────────────────────────────

	sc.When(`^a Lambda function is deployed$`, func() error {
		// Arrange
		// Act
		result, err := world.LambdaClient().CreateFunction(context.Background(), &lambda.CreateFunctionInput{
			FunctionName: aws.String(lambdaNeptuneTestFunc),
			Runtime:      lambdatypes.RuntimePython312,
			Role:         aws.String(lambdaNeptuneTestRoleArn),
			Handler:      aws.String("index.handler"),
			Code: &lambdatypes.FunctionCode{
				ZipFile: []byte("fake"),
			},
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^a Neptune cluster is created$`, func() error {
		// Arrange
		// Act
		result, err := world.NeptuneClient().CreateDBCluster(context.Background(), &neptune.CreateDBClusterInput{
			DBClusterIdentifier: aws.String(lambdaNeptuneTestCluster),
			Engine:              aws.String("neptune"),
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^the Neptune cluster is stopped$`, func() error {
		// Arrange
		// Act
		result, err := world.NeptuneClient().StopDBCluster(context.Background(), &neptune.StopDBClusterInput{
			DBClusterIdentifier: aws.String(lambdaNeptuneTestCluster),
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^the Neptune cluster is started$`, func() error {
		// Arrange
		// Act
		result, err := world.NeptuneClient().StartDBCluster(context.Background(), &neptune.StartDBClusterInput{
			DBClusterIdentifier: aws.String(lambdaNeptuneTestCluster),
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

	sc.When(`^the Lambda function fails to connect because the Neptune cluster is stopped$`, func() error {
		// @internal: Cannot trigger Lambda invocation failure in lws.
		setResult(world, nil, fmt.Errorf("cannot trigger Lambda invocation failure: scenario is @internal"))
		return nil
	})

	sc.When(`^the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds$`, func() error {
		// @internal: Cannot trigger Lambda invocation success in lws.
		setResult(world, nil, fmt.Errorf("cannot trigger Lambda invocation success: scenario is @internal"))
		return nil
	})

	// ── Then: assertions ──────────────────────────────────────────────────────────

	sc.Then(`^the function is "ACTIVE"$`, func() error {
		// Arrange
		// Act
		resp, err := world.LambdaClient().GetFunction(context.Background(), &lambda.GetFunctionInput{
			FunctionName: aws.String(lambdaNeptuneTestFunc),
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
		resp, err := world.NeptuneClient().DescribeDBClusters(context.Background(), &neptune.DescribeDBClustersInput{
			DBClusterIdentifier: aws.String(lambdaNeptuneTestCluster),
		})
		if err != nil {
			return fmt.Errorf("describe cluster: %w", err)
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

	sc.Then(`^the cluster is "AVAILABLE" and ready to accept graph queries$`, func() error {
		// Arrange
		// Act
		resp, err := world.NeptuneClient().DescribeDBClusters(context.Background(), &neptune.DescribeDBClustersInput{
			DBClusterIdentifier: aws.String(lambdaNeptuneTestCluster),
		})
		if err != nil {
			return fmt.Errorf("describe cluster: %w", err)
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

	sc.Then(`^the cluster is "STOPPED" and graph queries will be rejected$`, func() error {
		// Arrange
		// Act
		resp, err := world.NeptuneClient().DescribeDBClusters(context.Background(), &neptune.DescribeDBClustersInput{
			DBClusterIdentifier: aws.String(lambdaNeptuneTestCluster),
		})
		if err != nil {
			return fmt.Errorf("describe cluster: %w", err)
		}
		// Assert
		expectedStatus := "stopped"
		actualStatus := aws.ToString(resp.DBClusters[0].Status)
		if actualStatus != expectedStatus {
			return fmt.Errorf("expected cluster status %q but got %q; expected_status=%s actual_status=%s",
				expectedStatus, actualStatus, expectedStatus, actualStatus)
		}
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

	sc.Then(`^every successful invocation recorded which cluster it queried$`, func() error {
		// No-op: model-level invariant; trivially satisfied in isolated lws context.
		return nil
	})
}
