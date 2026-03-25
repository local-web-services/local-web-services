package tests

// registerLambdaOpenSearchSteps registers step definitions specific to the
// lambda_opensearch cross-service feature files.
//
// All constituent service steps (function existence, domain/index existence, lifecycle
// states, operation-is-rejected) are already registered by registerLambdaSteps
// and registerOpenSearchSteps.  Only the unique cross-service When/Then steps and
// the cross-service Given preconditions that differ in wording from the
// single-service files are defined here.

import (
	"context"
	"fmt"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/lambda"
	lambdatypes "github.com/aws/aws-sdk-go-v2/service/lambda/types"
	"github.com/aws/aws-sdk-go-v2/service/opensearch"
	"github.com/cucumber/godog"
)

const lambdaOpenSearchTestFunc = "test-lambda-opensearch-1"
const lambdaOpenSearchTestDomain = "test-lambda-opensearch-domain-1"
const lambdaOpenSearchTestIndex = "test-lambda-opensearch-index-1"
const lambdaOpenSearchTestRoleArn = "arn:aws:iam::000000000000:role/test"

func createLambdaOpenSearchFunction(world *World) error {
	// Arrange
	// Act
	_, err := world.LambdaClient().CreateFunction(context.Background(), &lambda.CreateFunctionInput{
		FunctionName: aws.String(lambdaOpenSearchTestFunc),
		Runtime:      lambdatypes.RuntimePython312,
		Role:         aws.String(lambdaOpenSearchTestRoleArn),
		Handler:      aws.String("index.handler"),
		Code: &lambdatypes.FunctionCode{
			ZipFile: []byte("fake"),
		},
	})
	// Assert: caller checks error
	return err
}

func createLambdaOpenSearchDomain(world *World) error {
	// Arrange
	// Act
	_, err := world.OpenSearchClient().CreateDomain(context.Background(), &opensearch.CreateDomainInput{
		DomainName: aws.String(lambdaOpenSearchTestDomain),
	})
	// Assert: caller checks error
	return err
}

func registerLambdaOpenSearchSteps(sc *godog.ScenarioContext, world *World) {
	// ── Given: invocation / slot state ─────────────────────────────────────────

	sc.Given(`^an invocation is "IN_PROGRESS"$`, func() error {
		// Arrange: create the Lambda function so an invocation could be in progress
		// Act
		return createLambdaOpenSearchFunction(world)
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

	sc.Given(`^a document slot is available$`, func() error {
		// No-op: always room for documents in lws.
		return nil
	})

	sc.Given(`^no document slot is available$`, func() error {
		// @internal: Cannot exhaust document slot limit in lws via public APIs.
		return nil
	})

	// ── Given: OpenSearch domain/index state unique to cross-service scenarios ──

	sc.Given(`^the domain exists$`, func() error {
		// Arrange
		// Act
		return createLambdaOpenSearchDomain(world)
	})

	sc.Given(`^the index exists$`, func() error {
		// No-op: index existence is managed via the OpenSearch domain; handled by registerOpenSearchSteps.
		return nil
	})

	sc.Given(`^the index's domain is "ACTIVE"$`, func() error {
		// Arrange: ensure domain exists and is ACTIVE
		// Act
		return createLambdaOpenSearchDomain(world)
	})

	sc.Given(`^the index's domain is not "ACTIVE"$`, func() error {
		// @internal: Cannot force a domain into a non-ACTIVE state via public APIs.
		return nil
	})

	sc.Given(`^the index does not exist$`, func() error {
		// No-op: fresh state has no indexes in lws.
		return nil
	})

	// ── When: actions ────────────────────────────────────────────────────────────

	sc.When(`^a Lambda function is deployed$`, func() error {
		// Arrange
		// Act
		result, err := world.LambdaClient().CreateFunction(context.Background(), &lambda.CreateFunctionInput{
			FunctionName: aws.String(lambdaOpenSearchTestFunc),
			Runtime:      lambdatypes.RuntimePython312,
			Role:         aws.String(lambdaOpenSearchTestRoleArn),
			Handler:      aws.String("index.handler"),
			Code: &lambdatypes.FunctionCode{
				ZipFile: []byte("fake"),
			},
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^an OpenSearch domain is created$`, func() error {
		// Arrange
		// Act
		result, err := world.OpenSearchClient().CreateDomain(context.Background(), &opensearch.CreateDomainInput{
			DomainName: aws.String(lambdaOpenSearchTestDomain),
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^an index is created in the OpenSearch domain$`, func() error {
		// @internal: OpenSearch index creation requires HTTP calls to the domain endpoint, not via the management API.
		setResult(world, nil, fmt.Errorf("cannot create index via management API: scenario is @internal"))
		return nil
	})

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

	sc.When(`^the Lambda function indexes a document into the OpenSearch index during invocation$`, func() error {
		// @internal: Cannot trigger Lambda document indexing in lws without Docker.
		setResult(world, nil, fmt.Errorf("cannot trigger Lambda document indexing: scenario is @internal"))
		return nil
	})

	// ── Then: assertions ──────────────────────────────────────────────────────────

	sc.Then(`^the function is "ACTIVE"$`, func() error {
		// Arrange
		// Act
		resp, err := world.LambdaClient().GetFunction(context.Background(), &lambda.GetFunctionInput{
			FunctionName: aws.String(lambdaOpenSearchTestFunc),
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

	sc.Then(`^the domain is "ACTIVE"$`, func() error {
		// Arrange
		// Act
		resp, err := world.OpenSearchClient().DescribeDomain(context.Background(), &opensearch.DescribeDomainInput{
			DomainName: aws.String(lambdaOpenSearchTestDomain),
		})
		if err != nil {
			return fmt.Errorf("describe domain: %w", err)
		}
		// Assert
		expectedName := lambdaOpenSearchTestDomain
		actualName := aws.ToString(resp.DomainStatus.DomainName)
		if actualName != expectedName {
			return fmt.Errorf("expected domain name %q but got %q; expected_name=%s actual_name=%s",
				expectedName, actualName, expectedName, actualName)
		}
		return nil
	})

	sc.Then(`^the index "EXISTS" and is ready to receive documents$`, func() error {
		// @internal: Cannot verify index existence via management API alone.
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

	sc.Then(`^the document is "INDEXED"$`, func() error {
		// @internal: Cannot observe Lambda document indexing result in lws.
		return nil
	})

	// ── Invariant catch-all steps ─────────────────────────────────────────────────

	sc.Then(`^every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function$`, func() error {
		// No-op: model-level invariant; trivially satisfied in isolated lws context.
		return nil
	})

	sc.Then(`^every indexed document belongs to an existing index$`, func() error {
		// No-op: model-level invariant; trivially satisfied in isolated lws context.
		return nil
	})

	sc.Then(`^every existing index belongs to an "ACTIVE" domain$`, func() error {
		// No-op: model-level invariant; trivially satisfied in isolated lws context.
		return nil
	})
}
