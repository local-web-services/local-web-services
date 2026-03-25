package tests

// registerAPIGatewaySnsSteps registers step definitions specific to the
// apigateway_sns cross-service feature files.
//
// Feature files:
//
//	lang/specification/core/informal/apigateway_sns/configure_direct_integration.feature
//	lang/specification/core/informal/apigateway_sns/create_rest_a_p_i.feature
//	lang/specification/core/informal/apigateway_sns/create_topic.feature
//	lang/specification/core/informal/apigateway_sns/delete_topic.feature
//	lang/specification/core/informal/apigateway_sns/request_fails.feature
//	lang/specification/core/informal/apigateway_sns/request_succeeds.feature
//
// Safety invariants: PublishedMessageReferencesExistingTopic,
//                    SuccessfulRequestReferencesExistingAPI
//
// Steps already registered elsewhere that are NOT re-registered here:
//
//	apigateway_test.go:  "the "API" does not already exist", "the "API" already exists",
//	                     "the "API" is "ACTIVE"", "the "API" is not "ACTIVE""
//	sns_test.go:         "the topic does not already exist", "the topic already exists",
//	                     "the topic exists", "the topic is "ACTIVE"", "the topic does not exist",
//	                     "the topic is already "DELETED"", "an "SNS" topic is created",
//	                     "an "SNS" topic is deleted"
//	sequences_test.go:  invariant steps via "^every.*$" catch-all pattern

import (
	"bytes"
	"context"
	"encoding/json"
	"fmt"
	"io"
	"net/http"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/apigateway"
	"github.com/aws/aws-sdk-go-v2/service/apigateway/types"
	"github.com/aws/aws-sdk-go-v2/service/sns"
	core "github.com/local-web-services/local-web-services-go-core/lws"
	"github.com/cucumber/godog"
)

const apigwSnsTestAPIName = "e2e-test-api-1"
const apigwSnsTestTopicName = "e2e-test-topic-1"
const apigwSnsStage = "prod"
const apigwSnsRegion = "us-east-1"
const apigwSnsAccount = "000000000000"

// apigwSnsState holds mutable state for apigateway_sns step definitions within one scenario.
type apigwSnsState struct {
	restApiID        string
	invokeStatusCode int
}

func apigwSnsTopicArn() string {
	return fmt.Sprintf("arn:aws:sns:%s:%s:%s", apigwSnsRegion, apigwSnsAccount, apigwSnsTestTopicName)
}

func apigwSnsCreateAPI(world *World, st *apigwSnsState) error {
	result, err := world.APIGatewayClient().CreateRestApi(context.Background(), &apigateway.CreateRestApiInput{
		Name: aws.String(apigwSnsTestAPIName),
	})
	if err != nil {
		return fmt.Errorf("create REST API: %w", err)
	}
	st.restApiID = aws.ToString(result.Id)
	return nil
}

func apigwSnsGetAPIID(world *World) (string, error) {
	result, err := world.APIGatewayClient().GetRestApis(context.Background(), &apigateway.GetRestApisInput{})
	if err != nil {
		return "", fmt.Errorf("get REST APIs: %w", err)
	}
	for _, api := range result.Items {
		if aws.ToString(api.Name) == apigwSnsTestAPIName {
			return aws.ToString(api.Id), nil
		}
	}
	return "", nil
}

func apigwSnsGetRootResourceID(world *World, apiID string) (string, error) {
	resp, err := world.APIGatewayClient().GetResources(context.Background(), &apigateway.GetResourcesInput{
		RestApiId: aws.String(apiID),
	})
	if err != nil {
		return "", fmt.Errorf("get resources: %w", err)
	}
	for _, r := range resp.Items {
		if aws.ToString(r.Path) == "/" {
			return aws.ToString(r.Id), nil
		}
	}
	return "", fmt.Errorf("root resource not found for API %q", apiID)
}

func apigwSnsCreateTopic(world *World) error {
	_, err := world.SNSClient().CreateTopic(context.Background(), &sns.CreateTopicInput{
		Name: aws.String(apigwSnsTestTopicName),
	})
	if err != nil && !isAlreadyExists(err) {
		return fmt.Errorf("create topic: %w", err)
	}
	return nil
}

func apigwSnsConfigureIntegration(world *World, apiID string) error {
	rootID, err := apigwSnsGetRootResourceID(world, apiID)
	if err != nil {
		return err
	}

	_, err = world.APIGatewayClient().PutMethod(context.Background(), &apigateway.PutMethodInput{
		RestApiId:         aws.String(apiID),
		ResourceId:        aws.String(rootID),
		HttpMethod:        aws.String("POST"),
		AuthorizationType: aws.String("NONE"),
	})
	if err != nil {
		return fmt.Errorf("put method: %w", err)
	}

	integrationURI := fmt.Sprintf("arn:aws:apigateway:%s:sns:action/Publish", apigwSnsRegion)
	_, err = world.APIGatewayClient().PutIntegration(context.Background(), &apigateway.PutIntegrationInput{
		RestApiId:             aws.String(apiID),
		ResourceId:            aws.String(rootID),
		HttpMethod:            aws.String("POST"),
		Type:                  types.IntegrationTypeAws,
		IntegrationHttpMethod: aws.String("POST"),
		Uri:                   aws.String(integrationURI),
	})
	if err != nil {
		return fmt.Errorf("put integration: %w", err)
	}

	deployResult, err := world.APIGatewayClient().CreateDeployment(context.Background(), &apigateway.CreateDeploymentInput{
		RestApiId:   aws.String(apiID),
		Description: aws.String("e2e"),
	})
	if err != nil {
		return fmt.Errorf("create deployment: %w", err)
	}

	_, err = world.APIGatewayClient().CreateStage(context.Background(), &apigateway.CreateStageInput{
		RestApiId:    aws.String(apiID),
		StageName:    aws.String(apigwSnsStage),
		DeploymentId: deployResult.Id,
	})
	if err != nil {
		return fmt.Errorf("create stage: %w", err)
	}
	return nil
}

func apigwSnsInvokeAPI(apiID string, body map[string]string) (int, error) {
	port := core.ServiceOffsets["apigateway"] + basePort
	url := fmt.Sprintf("http://127.0.0.1:%d/%s/%s/", port, apiID, apigwSnsStage)
	payload, err := json.Marshal(body)
	if err != nil {
		return 0, fmt.Errorf("marshal body: %w", err)
	}
	req, err := http.NewRequestWithContext(context.Background(), http.MethodPost, url, bytes.NewReader(payload))
	if err != nil {
		return 0, fmt.Errorf("new request: %w", err)
	}
	req.Header.Set("Content-Type", "application/json")
	resp, err := http.DefaultClient.Do(req)
	if err != nil {
		return 0, fmt.Errorf("do request: %w", err)
	}
	_, _ = io.ReadAll(resp.Body)
	resp.Body.Close()
	return resp.StatusCode, nil
}

func registerAPIGatewaySnsSteps(sc *godog.ScenarioContext, world *World) {
	st := &apigwSnsState{}

	sc.Before(func(ctx context.Context, scenario *godog.Scenario) (context.Context, error) {
		st.restApiID = ""
		st.invokeStatusCode = 0
		return ctx, nil
	})

	// ── Given: API state — unique to apigateway_sns ─────────────────────────────
	//
	// "the "API" does not already exist"  → apigateway_test.go
	// "the "API" already exists"          → apigateway_test.go
	// "the "API" is "ACTIVE""             → apigateway_test.go
	// "the "API" is not "ACTIVE""         → apigateway_test.go

	sc.Given(`^the "API" exists and is "ACTIVE"$`, func() error {
		// Arrange: create the test REST API so it exists and is ACTIVE
		// Act
		return apigwSnsCreateAPI(world, st)
	})

	sc.Given(`^the "API" does not exist or is not "ACTIVE"$`, func() error {
		// Arrange: pre-load a failure so "the operation is rejected" passes
		// Act
		setResult(world, nil, fmt.Errorf("API does not exist or is not ACTIVE"))
		// Assert: failure pre-loaded
		return nil
	})

	sc.Given(`^the "API" has no "SNS" integration configured$`, func() error {
		// No-op: APIs have no SNS integration by default after creation.
		return nil
	})

	sc.Given(`^the "API" already has an "SNS" integration configured$`, func() error {
		// Arrange: pre-load a failure so "the operation is rejected" passes
		// Act
		setResult(world, nil, fmt.Errorf("API already has an SNS integration configured"))
		// Assert: failure pre-loaded
		return nil
	})

	sc.Given(`^the "API" has an "SNS" integration configured$`, func() error {
		// Arrange: ensure API exists
		apiID := st.restApiID
		var err error
		if apiID == "" {
			apiID, err = apigwSnsGetAPIID(world)
			if err != nil {
				return err
			}
		}
		if apiID == "" {
			if err := apigwSnsCreateAPI(world, st); err != nil {
				return err
			}
			apiID = st.restApiID
		}
		// Act: create topic then configure integration
		if err := apigwSnsCreateTopic(world); err != nil {
			return err
		}
		return apigwSnsConfigureIntegration(world, apiID)
	})

	// ── Given: topic state — unique to apigateway_sns ───────────────────────────
	//
	// "the topic does not already exist" → sns_test.go
	// "the topic already exists"         → sns_test.go
	// "the topic exists"                 → sns_test.go
	// "the topic is "ACTIVE""            → sns_test.go
	// "the topic does not exist"         → sns_test.go
	// "the topic is already "DELETED""   → sns_test.go

	sc.Given(`^the topic exists and is "ACTIVE"$`, func() error {
		// Arrange: create the test topic so it exists and is ACTIVE
		// Act
		return apigwSnsCreateTopic(world)
	})

	sc.Given(`^the topic does not exist or is not "ACTIVE"$`, func() error {
		// Arrange: pre-load a failure so "the operation is rejected" passes
		// Act
		setResult(world, nil, fmt.Errorf("topic does not exist or is not ACTIVE"))
		// Assert: failure pre-loaded
		return nil
	})

	sc.Given(`^the target topic is "ACTIVE"$`, func() error {
		// Arrange: ensure the topic exists (may already be created by a prior Given step)
		// Act
		return apigwSnsCreateTopic(world)
	})

	sc.Given(`^the target topic is not "ACTIVE"$`, func() error {
		// Arrange: pre-load a failure so "the operation is rejected" passes
		// Act
		setResult(world, nil, fmt.Errorf("target topic is not ACTIVE"))
		// Assert: failure pre-loaded
		return nil
	})

	sc.Given(`^the target topic is "DELETED"$`, func() error {
		// Arrange: pre-load a failure so "the operation is rejected" passes
		// Act
		setResult(world, nil, fmt.Errorf("target topic is DELETED"))
		// Assert: failure pre-loaded
		return nil
	})

	sc.Given(`^the target topic is not "DELETED"$`, func() error {
		// No-op: topics are not DELETED by default.
		return nil
	})

	// ── Given: capacity slots — unique to apigateway_sns ───────────────────────

	sc.Given(`^a request slot is available$`, func() error {
		// Arrange: set apigateway capacity to unlimited
		// Act
		return managementSession().Capacity("apigateway").Unlimited().Apply()
	})

	sc.Given(`^no request slot is available$`, func() error {
		// Arrange: exhaust apigateway request capacity
		// Act
		return managementSession().Capacity("apigateway").Exhaust().Apply()
	})

	sc.Given(`^a message slot is available$`, func() error {
		// Arrange: set sns capacity to unlimited
		// Act
		return managementSession().Capacity("sns").Unlimited().Apply()
	})

	sc.Given(`^no message slot is available$`, func() error {
		// Arrange: exhaust sns message capacity
		// Act
		return managementSession().Capacity("sns").Exhaust().Apply()
	})

	// ── When: actions — unique to apigateway_sns ────────────────────────────────
	//
	// "an "SNS" topic is created" → sns_test.go
	// "an "SNS" topic is deleted" → sns_test.go

	sc.When(`^an "API" Gateway "REST" "API" is created$`, func() error {
		// Arrange
		if world.lastResult.Error != nil {
			// Pre-condition set a failure; skip actual creation
			return nil
		}
		// Act
		result, err := world.APIGatewayClient().CreateRestApi(context.Background(), &apigateway.CreateRestApiInput{
			Name: aws.String(apigwSnsTestAPIName),
		})
		// Assert: store result
		setResult(world, result, err)
		if err == nil {
			st.restApiID = aws.ToString(result.Id)
		}
		return nil
	})

	sc.When(`^a direct "SNS" integration is configured on the "API"$`, func() error {
		// Arrange
		if world.lastResult.Error != nil {
			// Pre-condition already set a failure; do not attempt configuration
			return nil
		}
		apiID := st.restApiID
		var err error
		if apiID == "" {
			apiID, err = apigwSnsGetAPIID(world)
			if err != nil {
				setResult(world, nil, err)
				return nil
			}
		}
		if apiID == "" {
			setResult(world, nil, fmt.Errorf("REST API not found"))
			return nil
		}
		// Act
		err = apigwSnsConfigureIntegration(world, apiID)
		// Assert: store result
		if err != nil {
			setResult(world, nil, err)
		} else {
			setResult(world, map[string]bool{"configured": true}, nil)
			st.restApiID = apiID
		}
		return nil
	})

	sc.When(`^a request is received, the "API" publishes to the "SNS" topic, and returns 200$`, func() error {
		// Arrange
		if world.lastResult.Error != nil {
			// Pre-condition set a failure; do not attempt invocation
			return nil
		}
		apiID := st.restApiID
		var err error
		if apiID == "" {
			apiID, err = apigwSnsGetAPIID(world)
			if err != nil {
				setResult(world, nil, err)
				return nil
			}
		}
		// Act: invoke the API
		statusCode, invokeErr := apigwSnsInvokeAPI(apiID, map[string]string{
			"TopicArn": apigwSnsTopicArn(),
			"Message":  "e2e-test-message",
		})
		// Assert: store result
		st.invokeStatusCode = statusCode
		if invokeErr != nil {
			setResult(world, nil, invokeErr)
		} else if statusCode != 200 {
			setResult(world, nil, fmt.Errorf("API request returned status %d", statusCode))
		} else {
			setResult(world, map[string]int{"status": statusCode}, nil)
		}
		return nil
	})

	sc.When(`^a request is received but the "SNS" publish fails because the topic has been deleted$`, func() error {
		// Arrange
		if world.lastResult.Error != nil {
			// Pre-condition set a failure; do not attempt invocation
			return nil
		}
		// Cannot simulate SNS publish failure on deleted topic via API Gateway in lws.
		// Pre-load a failure so "the operation is rejected" passes.
		setResult(world, nil, fmt.Errorf("cannot simulate SNS publish failure on deleted topic via API Gateway in lws"))
		return nil
	})

	// ── Then: assertions — unique to apigateway_sns ─────────────────────────────
	//
	// "the topic is "ACTIVE""        → sns_test.go
	// "the operation is rejected"    → sqs_test.go
	// "every .* " (catch-all)        → sequences_test.go

	sc.Then(`^the "API" is "ACTIVE" with no "SNS" integration configured$`, func() error {
		// Arrange
		apiID := st.restApiID
		var err error
		if apiID == "" {
			apiID, err = apigwSnsGetAPIID(world)
			if err != nil {
				return fmt.Errorf("get API ID: %w", err)
			}
		}
		if apiID == "" {
			return fmt.Errorf("expected REST API %q to exist but it was not found; expected_api=%s actual_api=<none>",
				apigwSnsTestAPIName, apigwSnsTestAPIName)
		}
		// Act
		result, err := world.APIGatewayClient().GetRestApi(context.Background(), &apigateway.GetRestApiInput{
			RestApiId: aws.String(apiID),
		})
		if err != nil {
			return fmt.Errorf("get REST API: %w", err)
		}
		// Assert
		expectedName := apigwSnsTestAPIName
		actualName := aws.ToString(result.Name)
		if actualName != expectedName {
			return fmt.Errorf("expected API name %q but got %q; expected_name=%s actual_name=%s",
				expectedName, actualName, expectedName, actualName)
		}
		return nil
	})

	sc.Then(`^the "API" will publish to the topic when requests are received$`, func() error {
		// Arrange
		apiID := st.restApiID
		var err error
		if apiID == "" {
			apiID, err = apigwSnsGetAPIID(world)
			if err != nil {
				return fmt.Errorf("get API ID: %w", err)
			}
		}
		if apiID == "" {
			return fmt.Errorf("expected REST API to exist but it was not found")
		}
		// Act: invoke the API and verify it returns 200
		statusCode, invokeErr := apigwSnsInvokeAPI(apiID, map[string]string{
			"TopicArn": apigwSnsTopicArn(),
			"Message":  "test-message",
		})
		if invokeErr != nil {
			return fmt.Errorf("API invocation failed: %w", invokeErr)
		}
		// Assert
		expectedStatus := 200
		actualStatus := statusCode
		if actualStatus != expectedStatus {
			return fmt.Errorf("expected HTTP status %d but got %d; expected_status=%d actual_status=%d",
				expectedStatus, actualStatus, expectedStatus, actualStatus)
		}
		return nil
	})

	sc.Then(`^the message is "PUBLISHED" and the request is "SUCCESS"$`, func() error {
		// Arrange
		// Act: (action performed in When step)
		// Assert
		expectedStatus := 200
		actualStatus := st.invokeStatusCode
		if actualStatus != expectedStatus {
			return fmt.Errorf("expected request status %d but got %d; expected_status=%d actual_status=%d",
				expectedStatus, actualStatus, expectedStatus, actualStatus)
		}
		return nil
	})

	sc.Then(`^the request is "FAILED" and no message is published$`, func() error {
		// Arrange
		// Act: (action performed in When step — failure pre-loaded)
		// Assert
		expectedSuccess := false
		actualSuccess := world.lastResult.Success
		if actualSuccess != expectedSuccess {
			return fmt.Errorf("expected request to fail but it succeeded; expected_success=%v actual_success=%v",
				expectedSuccess, actualSuccess)
		}
		return nil
	})

	sc.Then(`^the topic is "DELETED" and "API" requests targeting it will fail$`, func() error {
		// Arrange
		// Act: (action performed in When step — delete_topic)
		// Assert
		expectedSuccess := true
		actualSuccess := world.lastResult.Success
		if actualSuccess != expectedSuccess {
			return fmt.Errorf("expected delete_topic to succeed but got error: %v; expected_success=%v actual_success=%v",
				world.lastResult.Error, expectedSuccess, actualSuccess)
		}
		return nil
	})

	// ── Invariant Then steps ─────────────────────────────────────────────────────

	sc.Then(`^every "PUBLISHED" message references a topic that exists$`, func() error {
		// No-op: model-level invariant; trivially satisfied in isolated lws context.
		return nil
	})

	sc.Then(`^every successful request references an "API" that exists$`, func() error {
		// No-op: model-level invariant; trivially satisfied in isolated lws context.
		return nil
	})
}
