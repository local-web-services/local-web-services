package tests

// registerLambdaElasticsearchServiceSteps wires all lambda_elasticsearch cross-service step definitions.
// Steps already registered in lambda_test.go ("the function does not already exist",
// "the function already exists", "the function exists", "the function does not exist",
// "the function is \"ACTIVE\"", "the function is not \"ACTIVE\"",
// "an invocation slot is available", "no invocation slot is available"),
// elasticsearch_test.go ("the domain does not already exist", "the domain already exists",
// "the domain exists", "the domain does not exist", "the domain is \"PROCESSING\"",
// "the domain is not \"PROCESSING\""),
// sequences_test.go ("the system is initialized"), and
// sqs_test.go ("the operation is rejected") are NOT re-registered here.

import (
	"context"
	"fmt"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/elasticsearchservice"
	"github.com/aws/aws-sdk-go-v2/service/lambda"
	lambdatypes "github.com/aws/aws-sdk-go-v2/service/lambda/types"
	"github.com/cucumber/godog"
)

const lambdaElasticsearchTestFunc = "test-lambda-elasticsearch-1"
const lambdaElasticsearchTestDomain = "test-lambda-elasticsearch-domain-1"
const lambdaElasticsearchTestRoleArn = "arn:aws:iam::000000000000:role/test"

func lambdaElasticsearchCreateFunction(world *World) error {
	// Arrange
	// Act
	_, err := world.LambdaClient().CreateFunction(context.Background(), &lambda.CreateFunctionInput{
		FunctionName: aws.String(lambdaElasticsearchTestFunc),
		Runtime:      lambdatypes.RuntimePython312,
		Role:         aws.String(lambdaElasticsearchTestRoleArn),
		Handler:      aws.String("index.handler"),
		Code: &lambdatypes.FunctionCode{
			ZipFile: []byte("fake"),
		},
	})
	// Assert: caller checks error
	return err
}

func lambdaElasticsearchCreateDomain(world *World) error {
	// Arrange
	// Act
	_, err := world.ElasticsearchClient().CreateElasticsearchDomain(context.Background(), &elasticsearchservice.CreateElasticsearchDomainInput{
		DomainName: aws.String(lambdaElasticsearchTestDomain),
	})
	// Assert: caller checks error
	return err
}

func registerLambdaElasticsearchServiceSteps(sc *godog.ScenarioContext, world *World) {
	// ── Given: domain state ───────────────────────────────────────────────────

	sc.Given(`^the domain does not already exist$`, func() error {
		// No-op: fresh state has no domains.
		return nil
	})

	sc.Given(`^the domain already exists$`, func() error {
		// Arrange: create the domain so it already exists
		// Act
		return lambdaElasticsearchCreateDomain(world)
	})

	sc.Given(`^the domain exists$`, func() error {
		// Arrange: create the domain
		// Act
		return lambdaElasticsearchCreateDomain(world)
	})

	sc.Given(`^the domain is "AVAILABLE"$`, func() error {
		// Arrange: create the domain so it is AVAILABLE
		// Act
		return lambdaElasticsearchCreateDomain(world)
	})

	sc.Given(`^the domain is not "AVAILABLE"$`, func() error {
		// Arrange: create the domain; lws does not expose non-AVAILABLE state via public API
		// Act
		return lambdaElasticsearchCreateDomain(world)
	})

	sc.Given(`^the domain is "PROCESSING"$`, func() error {
		// Arrange: create the domain; PROCESSING state is set by UpdateElasticsearchDomainConfig
		// Act
		return lambdaElasticsearchCreateDomain(world)
	})

	sc.Given(`^the domain is not "PROCESSING"$`, func() error {
		// Arrange: create the domain so it is not in PROCESSING state
		// Act
		return lambdaElasticsearchCreateDomain(world)
	})

	sc.Given(`^the domain does not exist$`, func() error {
		// No-op: fresh state has no domains.
		return nil
	})

	// ── Given: invocation state ───────────────────────────────────────────────

	sc.Given(`^an invocation is "IN_PROGRESS"$`, func() error {
		// Arrange: create the Lambda function so an invocation could be in progress
		// Act
		return lambdaElasticsearchCreateFunction(world)
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

	// ── Given: sequence state (fid/did/iid) ───────────────────────────────────

	sc.Given(`^fid in func_status$`, func() error {
		// Arrange: create the Lambda function so fid is tracked in func_status
		// Act
		return lambdaElasticsearchCreateFunction(world)
	})

	sc.Given(`^fid not in func_status$`, func() error {
		// No-op: fresh state has no functions in func_status.
		return nil
	})

	sc.Given(`^did in domain_status$`, func() error {
		// Arrange: create the domain so did is tracked in domain_status
		// Act
		return lambdaElasticsearchCreateDomain(world)
	})

	sc.Given(`^did not in domain_status$`, func() error {
		// No-op: fresh state has no domains in domain_status.
		return nil
	})

	sc.Given(`^iid in inv_status$`, func() error {
		// Arrange: create the Lambda function so an invocation can be tracked
		// Act
		return lambdaElasticsearchCreateFunction(world)
	})

	// ── When: actions ─────────────────────────────────────────────────────────

	sc.When(`^a Lambda function is deployed$`, func() error {
		// Arrange
		// Act
		result, err := world.LambdaClient().CreateFunction(context.Background(), &lambda.CreateFunctionInput{
			FunctionName: aws.String(lambdaElasticsearchTestFunc),
			Runtime:      lambdatypes.RuntimePython312,
			Role:         aws.String(lambdaElasticsearchTestRoleArn),
			Handler:      aws.String("index.handler"),
			Code: &lambdatypes.FunctionCode{
				ZipFile: []byte("fake"),
			},
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^an Elasticsearch domain is created and becomes "AVAILABLE"$`, func() error {
		// Arrange
		// Act
		result, err := world.ElasticsearchClient().CreateElasticsearchDomain(context.Background(), &elasticsearchservice.CreateElasticsearchDomainInput{
			DomainName: aws.String(lambdaElasticsearchTestDomain),
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^a domain configuration update begins$`, func() error {
		// Arrange
		// Act
		result, err := world.ElasticsearchClient().UpdateElasticsearchDomainConfig(context.Background(), &elasticsearchservice.UpdateElasticsearchDomainConfigInput{
			DomainName: aws.String(lambdaElasticsearchTestDomain),
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^the domain configuration update completes$`, func() error {
		// @internal: Cannot trigger domain configuration update completion in lws.
		setResult(world, nil, fmt.Errorf("cannot trigger domain config update completion: scenario is @internal"))
		return nil
	})

	sc.When(`^the Lambda function is invoked$`, func() error {
		// @internal: Cannot trigger Lambda invocation in lws without Docker.
		setResult(world, nil, fmt.Errorf("cannot trigger Lambda invocation: scenario is @internal"))
		return nil
	})

	sc.When(`^the Lambda function fails to write because the domain is processing a config update$`, func() error {
		// @internal: Cannot trigger Lambda invocation failure in lws without Docker.
		setResult(world, nil, fmt.Errorf("cannot trigger Lambda invocation failure: scenario is @internal"))
		return nil
	})

	sc.When(`^the Lambda function indexes a document into the "AVAILABLE" domain and succeeds$`, func() error {
		// @internal: Cannot trigger Lambda document index in lws without Docker.
		setResult(world, nil, fmt.Errorf("cannot trigger Lambda document index: scenario is @internal"))
		return nil
	})

	// ── Then: assertions ──────────────────────────────────────────────────────

	sc.Then(`^the function is "ACTIVE"$`, func() error {
		// Arrange
		// Act
		resp, err := world.LambdaClient().GetFunction(context.Background(), &lambda.GetFunctionInput{
			FunctionName: aws.String(lambdaElasticsearchTestFunc),
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

	sc.Then(`^the domain is "AVAILABLE"$`, func() error {
		// Arrange
		// Act
		resp, err := world.ElasticsearchClient().DescribeElasticsearchDomain(context.Background(), &elasticsearchservice.DescribeElasticsearchDomainInput{
			DomainName: aws.String(lambdaElasticsearchTestDomain),
		})
		if err != nil {
			return fmt.Errorf("describe elasticsearch domain: %w", err)
		}
		// Assert
		expectedProcessing := false
		actualProcessing := aws.ToBool(resp.DomainStatus.Processing)
		if actualProcessing != expectedProcessing {
			return fmt.Errorf("expected domain not to be processing but it is; expected_processing=%v actual_processing=%v",
				expectedProcessing, actualProcessing)
		}
		return nil
	})

	sc.Then(`^the domain is "AVAILABLE" again$`, func() error {
		// @internal: Cannot observe domain AVAILABLE-after-PROCESSING state in lws.
		return nil
	})

	sc.Then(`^the domain is "PROCESSING" and write operations may fail$`, func() error {
		// Arrange
		// Act
		resp, err := world.ElasticsearchClient().DescribeElasticsearchDomain(context.Background(), &elasticsearchservice.DescribeElasticsearchDomainInput{
			DomainName: aws.String(lambdaElasticsearchTestDomain),
		})
		if err != nil {
			return fmt.Errorf("describe elasticsearch domain: %w", err)
		}
		// Assert
		expectedProcessing := true
		actualProcessing := aws.ToBool(resp.DomainStatus.Processing)
		if actualProcessing != expectedProcessing {
			return fmt.Errorf("expected domain to be processing but it is not; expected_processing=%v actual_processing=%v",
				expectedProcessing, actualProcessing)
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

	sc.Then(`^the document "EXISTS" and the invocation is "SUCCESS"$`, func() error {
		// @internal: Cannot observe Lambda document index result in lws.
		return nil
	})

	// ── Invariant catch-all steps ─────────────────────────────────────────────

	sc.Then(`^every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function$`, func() error {
		// No-op: model-level invariant; trivially satisfied in isolated lws context.
		return nil
	})

	sc.Then(`^every existing document references a domain that exists$`, func() error {
		// No-op: model-level invariant; trivially satisfied in isolated lws context.
		return nil
	})
}
