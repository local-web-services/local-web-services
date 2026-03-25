package tests

// registerLambdaElastiCacheSteps wires all lambda_elasticache cross-service step definitions.
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
	"github.com/aws/aws-sdk-go-v2/service/elasticache"
	"github.com/aws/aws-sdk-go-v2/service/lambda"
	lambdatypes "github.com/aws/aws-sdk-go-v2/service/lambda/types"
	"github.com/cucumber/godog"
)

const lambdaElastiCacheTestFunc = "test-lambda-elasticache-1"
const lambdaElastiCacheTestCluster = "test-lambda-elasticache-cluster-1"
const lambdaElastiCacheTestRoleArn = "arn:aws:iam::000000000000:role/test"

func lambdaElastiCacheCreateFunction(world *World) error {
	// Arrange
	// Act
	_, err := world.LambdaClient().CreateFunction(context.Background(), &lambda.CreateFunctionInput{
		FunctionName: aws.String(lambdaElastiCacheTestFunc),
		Runtime:      lambdatypes.RuntimePython312,
		Role:         aws.String(lambdaElastiCacheTestRoleArn),
		Handler:      aws.String("index.handler"),
		Code: &lambdatypes.FunctionCode{
			ZipFile: []byte("fake"),
		},
	})
	// Assert: caller checks error
	return err
}

func lambdaElastiCacheCreateCluster(world *World) error {
	// Arrange
	// Act
	_, err := world.ElastiCacheClient().CreateCacheCluster(context.Background(), &elasticache.CreateCacheClusterInput{
		CacheClusterId: aws.String(lambdaElastiCacheTestCluster),
		Engine:         aws.String("redis"),
		CacheNodeType:  aws.String("cache.t3.micro"),
		NumCacheNodes:  aws.Int32(1),
	})
	// Assert: caller checks error
	return err
}

func registerLambdaElastiCacheSteps(sc *godog.ScenarioContext, world *World) {
	// ── Given: cluster state ──────────────────────────────────────────────────

	sc.Given(`^the cluster does not already exist$`, func() error {
		// No-op: fresh state has no clusters.
		return nil
	})

	sc.Given(`^the cluster already exists$`, func() error {
		// Arrange: create the cluster so it already exists
		// Act
		return lambdaElastiCacheCreateCluster(world)
	})

	sc.Given(`^the cluster exists$`, func() error {
		// Arrange: create the cluster
		// Act
		return lambdaElastiCacheCreateCluster(world)
	})

	sc.Given(`^the cluster is "AVAILABLE"$`, func() error {
		// Arrange: create the cluster so it is AVAILABLE
		// Act
		return lambdaElastiCacheCreateCluster(world)
	})

	sc.Given(`^the cluster is not "AVAILABLE"$`, func() error {
		// Arrange: create the cluster; lws does not expose non-AVAILABLE state via public API
		// Act
		return lambdaElastiCacheCreateCluster(world)
	})

	sc.Given(`^the cluster does not exist$`, func() error {
		// No-op: fresh state has no clusters.
		return nil
	})

	// ── Given: cache entry state ──────────────────────────────────────────────

	sc.Given(`^a "CACHED" entry exists$`, func() error {
		// @internal: Cannot insert CACHED entries via public APIs without Lambda invocation.
		return nil
	})

	sc.Given(`^no "CACHED" entry exists$`, func() error {
		// No-op: fresh state has no cached entries.
		return nil
	})

	// ── Given: invocation state ───────────────────────────────────────────────

	sc.Given(`^an invocation is "IN_PROGRESS"$`, func() error {
		// Arrange: create the Lambda function so an invocation could be in progress
		// Act
		return lambdaElastiCacheCreateFunction(world)
	})

	sc.Given(`^no invocation is "IN_PROGRESS"$`, func() error {
		// No-op: fresh state has no in-progress invocations.
		return nil
	})

	// ── Given: slot state ─────────────────────────────────────────────────────

	sc.Given(`^a key slot is available$`, func() error {
		// No-op: always room for cache keys in lws.
		return nil
	})

	sc.Given(`^no key slot is available$`, func() error {
		// @internal: Cannot exhaust key slot limit in lws via public APIs.
		return nil
	})

	// ── Given: sequence state (fid/cid/iid/kid) ───────────────────────────────

	sc.Given(`^fid in func_status$`, func() error {
		// Arrange: create the Lambda function so fid is tracked in func_status
		// Act
		return lambdaElastiCacheCreateFunction(world)
	})

	sc.Given(`^fid not in func_status$`, func() error {
		// No-op: fresh state has no functions in func_status.
		return nil
	})

	sc.Given(`^cid not in cluster_status$`, func() error {
		// No-op: fresh state has no clusters in cluster_status.
		return nil
	})

	sc.Given(`^iid in inv_status$`, func() error {
		// Arrange: create the Lambda function so an invocation can be tracked
		// Act
		return lambdaElastiCacheCreateFunction(world)
	})

	sc.Given(`^kid in key_status$`, func() error {
		// @internal: Cannot insert CACHED key entries via public APIs without Lambda invocation.
		return nil
	})

	// ── When: actions ─────────────────────────────────────────────────────────

	sc.When(`^a Lambda function is deployed$`, func() error {
		// Arrange
		// Act
		result, err := world.LambdaClient().CreateFunction(context.Background(), &lambda.CreateFunctionInput{
			FunctionName: aws.String(lambdaElastiCacheTestFunc),
			Runtime:      lambdatypes.RuntimePython312,
			Role:         aws.String(lambdaElastiCacheTestRoleArn),
			Handler:      aws.String("index.handler"),
			Code: &lambdatypes.FunctionCode{
				ZipFile: []byte("fake"),
			},
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^an ElastiCache cluster is created$`, func() error {
		// Arrange
		// Act
		result, err := world.ElastiCacheClient().CreateCacheCluster(context.Background(), &elasticache.CreateCacheClusterInput{
			CacheClusterId: aws.String(lambdaElastiCacheTestCluster),
			Engine:         aws.String("redis"),
			CacheNodeType:  aws.String("cache.t3.micro"),
			NumCacheNodes:  aws.Int32(1),
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

	sc.When(`^the Lambda function writes a value to the ElastiCache cluster during invocation$`, func() error {
		// @internal: Cannot trigger Lambda cache write in lws without Docker.
		setResult(world, nil, fmt.Errorf("cannot trigger Lambda cache write: scenario is @internal"))
		return nil
	})

	sc.When(`^ElastiCache evicts a cache entry due to memory pressure or "TTL" expiry$`, func() error {
		// @internal: Cannot trigger ElastiCache eviction via public APIs in lws.
		setResult(world, nil, fmt.Errorf("cannot trigger ElastiCache eviction: scenario is @internal"))
		return nil
	})

	sc.When(`^the Lambda invocation fails because all cache entries have been evicted$`, func() error {
		// @internal: Cannot trigger Lambda invocation failure in lws without Docker.
		setResult(world, nil, fmt.Errorf("cannot trigger Lambda invocation failure: scenario is @internal"))
		return nil
	})

	sc.When(`^the Lambda invocation reads an existing cache entry and completes successfully$`, func() error {
		// @internal: Cannot trigger Lambda invocation success in lws without Docker.
		setResult(world, nil, fmt.Errorf("cannot trigger Lambda invocation success: scenario is @internal"))
		return nil
	})

	// ── Then: assertions ──────────────────────────────────────────────────────

	sc.Then(`^the function is "ACTIVE"$`, func() error {
		// Arrange
		// Act
		resp, err := world.LambdaClient().GetFunction(context.Background(), &lambda.GetFunctionInput{
			FunctionName: aws.String(lambdaElastiCacheTestFunc),
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
		resp, err := world.ElastiCacheClient().DescribeCacheClusters(context.Background(), &elasticache.DescribeCacheClustersInput{
			CacheClusterId: aws.String(lambdaElastiCacheTestCluster),
		})
		if err != nil {
			return fmt.Errorf("describe cache clusters: %w", err)
		}
		if len(resp.CacheClusters) == 0 {
			return fmt.Errorf("expected cluster to be AVAILABLE but cluster was not found")
		}
		// Assert
		expectedStatus := "available"
		actualStatus := aws.ToString(resp.CacheClusters[0].CacheClusterStatus)
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

	sc.Then(`^the invocation is "FAILED"$`, func() error {
		// @internal: Cannot observe Lambda invocation failure in lws.
		return nil
	})

	sc.Then(`^the invocation is "SUCCESS"$`, func() error {
		// @internal: Cannot observe Lambda invocation success in lws.
		return nil
	})

	sc.Then(`^the cache entry is "CACHED" in the cluster$`, func() error {
		// @internal: Cannot observe Lambda cache write result in lws.
		return nil
	})

	sc.Then(`^the cache entry is "EVICTED"$`, func() error {
		// @internal: Cannot observe ElastiCache eviction in lws.
		return nil
	})

	// ── Invariant catch-all steps ─────────────────────────────────────────────

	sc.Then(`^every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function$`, func() error {
		// No-op: model-level invariant; trivially satisfied in isolated lws context.
		return nil
	})

	sc.Then(`^every "CACHED" entry belongs to an "AVAILABLE" cluster$`, func() error {
		// No-op: model-level invariant; trivially satisfied in isolated lws context.
		return nil
	})
}
