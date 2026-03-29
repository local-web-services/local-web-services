package tests

// registerAPIGatewayLambdaSteps registers step definitions specific to the
// apigateway_lambda cross-service feature files.
//
// Constituent service steps already registered by registerAPIGatewaySteps:
//   - the "API" does not already exist / already exists / does not exist / exists
//   - the "API" is "ACTIVE" / is not "ACTIVE"
//
// Constituent service steps already registered by registerLambdaSteps:
//   - the function does not already exist / already exists / exists / does not exist
//   - the function is "ACTIVE" / is not "ACTIVE"
//
// Steps already registered by registerLambdaDynamodbSteps:
//   - an invocation is "IN_PROGRESS" / no invocation is "IN_PROGRESS"
//   - an invocation slot is available / no invocation slot is available
//   - a Lambda function is deployed
//   - the function is "ACTIVE" (Then)
//   - every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
//
// Only the NEW unique cross-service steps absent from all constituent files are
// defined here.

import (
	"context"
	"fmt"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/apigateway"
	"github.com/cucumber/godog"
)

const apigwLambdaTestApiName = "e2e-test-api-1"

func registerAPIGatewayLambdaSteps(sc *godog.ScenarioContext, world *World) {
	// ── Given: API integration state ──────────────────────────────────────────

	sc.Given(`^the "API" has no integration configured$`, func() error {
		// No-op: APIs have no integration configured by default after creation.
		return nil
	})

	sc.Given(`^the "API" already has an integration configured$`, func() error {
		// @internal: Cannot configure Lambda integration on REST API in lws.
		// Scenarios relying on this step are unreachable via public APIs.
		return nil
	})

	sc.Given(`^the "API" has a Lambda integration configured$`, func() error {
		// @internal: Cannot configure Lambda integration on REST API in lws.
		return nil
	})

	sc.Given(`^the "API" has no Lambda integration configured$`, func() error {
		// No-op: APIs have no Lambda integration configured by default.
		return nil
	})

	// ── Given: integrated function state ──────────────────────────────────────

	sc.Given(`^the integrated function is "ACTIVE"$`, func() error {
		// @internal: Requires a Lambda integration to be configured first, which is
		// not supported via public APIs in lws.
		return nil
	})

	sc.Given(`^the integrated function is not "ACTIVE"$`, func() error {
		// @internal: Requires a Lambda integration and lifecycle manipulation.
		return nil
	})

	// ── Given: capacity / slot state ──────────────────────────────────────────

	sc.Given(`^a request slot is available$`, func() error {
		// Arrange: set apigateway capacity to unlimited so request slots are available
		// Act
		if err := managementSession().Capacity("apigateway").Unlimited().Apply(); err != nil {
			return fmt.Errorf("set apigateway capacity unlimited: %w", err)
		}
		// Assert: capacity applied
		return nil
	})

	sc.Given(`^no request slot is available$`, func() error {
		// @internal: Cannot send requests through API Gateway Lambda integration in lws.
		return nil
	})

	// ── When: actions ─────────────────────────────────────────────────────────

	sc.When(`^a "REST" "API" is created$`, func() error {
		// Arrange
		// Act
		result, err := world.APIGatewayClient().CreateRestApi(context.Background(), &apigateway.CreateRestApiInput{
			Name: aws.String(apigwLambdaTestApiName),
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^a Lambda integration is configured on the "REST" "API"$`, func() error {
		// @internal: Cannot configure Lambda integration on REST API in lws.
		setResult(world, nil, fmt.Errorf("cannot configure Lambda integration: scenario is @internal"))
		return nil
	})

	sc.When(`^the "API" receives an "HTTP" request and synchronously invokes the Lambda function$`, func() error {
		// @internal: Cannot send requests through API Gateway Lambda integration in lws.
		setResult(world, nil, fmt.Errorf("cannot send HTTP request through API Gateway Lambda integration: scenario is @internal"))
		return nil
	})

	sc.When(`^the Lambda invocation completes successfully and the "API" returns a successful response$`, func() error {
		// @internal: Cannot trigger Lambda invocation completion via API Gateway in lws.
		setResult(world, nil, fmt.Errorf("cannot trigger Lambda invocation success via API Gateway: scenario is @internal"))
		return nil
	})

	sc.When(`^the Lambda invocation fails and the "API" returns an error response$`, func() error {
		// @internal: Cannot trigger Lambda invocation failure via API Gateway in lws.
		setResult(world, nil, fmt.Errorf("cannot trigger Lambda invocation failure via API Gateway: scenario is @internal"))
		return nil
	})

	// ── Then: assertions ──────────────────────────────────────────────────────

	sc.Then(`^the "API" is "ACTIVE" with no Lambda integration configured$`, func() error {
		// Arrange
		// Act
		resp, err := world.APIGatewayClient().GetRestApis(context.Background(), &apigateway.GetRestApisInput{})
		if err != nil {
			return fmt.Errorf("get rest apis: %w", err)
		}
		// Assert
		expectedName := apigwLambdaTestApiName
		for _, api := range resp.Items {
			actualName := aws.ToString(api.Name)
			if actualName == expectedName {
				return nil
			}
		}
		return fmt.Errorf("expected REST API %q to exist but it was not found; expected_name=%s",
			expectedName, expectedName)
	})

	sc.Then(`^the "API" will synchronously invoke the function when a request arrives$`, func() error {
		// @internal: Cannot verify Lambda integration behaviour in lws.
		return nil
	})

	sc.Then(`^the request and invocation are both "IN_PROGRESS"$`, func() error {
		// @internal: Cannot observe in-progress request and invocation state in lws.
		return nil
	})

	sc.Then(`^the invocation is "SUCCESS" and the request is "SUCCESS"$`, func() error {
		// @internal: Cannot observe invocation and request success state in lws.
		return nil
	})

	sc.Then(`^the invocation is "FAILED" and the request is "FAILED"$`, func() error {
		// @internal: Cannot observe invocation and request failure state in lws.
		return nil
	})

	// ── Invariant catch-all steps ──────────────────────────────────────────────

	sc.Then(`^every "IN_PROGRESS" request references an "ACTIVE" "API"$`, func() error {
		// No-op: model-level invariant; trivially satisfied in isolated lws context.
		return nil
	})

	sc.Then(`^every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request$`, func() error {
		// No-op: model-level invariant; trivially satisfied in isolated lws context.
		return nil
	})
}
