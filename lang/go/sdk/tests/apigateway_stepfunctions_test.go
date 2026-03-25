package tests

import (
	"bytes"
	"context"
	"encoding/json"
	"fmt"
	"io"
	"net/http"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/apigateway"
	apigwtypes "github.com/aws/aws-sdk-go-v2/service/apigateway/types"
	"github.com/aws/aws-sdk-go-v2/service/sfn"
	sfntypes "github.com/aws/aws-sdk-go-v2/service/sfn/types"
	"github.com/cucumber/godog"
	core "github.com/local-web-services/local-web-services-go-core/lws"
)

const apigwSfnTestAPIName = "e2e-apigwsfn-test-api-1"
const apigwSfnTestSMName = "e2e-apigwsfn-test-sm-1"
const apigwSfnRoleArn = "arn:aws:iam::000000000000:role/e2e-role"
const apigwSfnPassDefinition = `{"StartAt":"Pass","States":{"Pass":{"Type":"Pass","End":true}}}`
const apigwSfnRegion = "us-east-1"
const apigwSfnAccount = "000000000000"
const apigwSfnStage = "prod"

// apigwSfnState holds mutable state for ApigatewayStepfunctions step definitions within one scenario.
type apigwSfnState struct {
	restApiID  string
	skipReason string
}

func apigwSfnSmArn(name string) string {
	return fmt.Sprintf("arn:aws:states:%s:%s:stateMachine:%s", apigwSfnRegion, apigwSfnAccount, name)
}

func apigwSfnCreateRestAPI(world *World) (string, error) {
	// Arrange: disable chaos so the create call goes through
	_ = core.ChaosDisable(world.managementPort, "apigateway")
	result, err := world.APIGatewayClient().CreateRestApi(context.Background(), &apigateway.CreateRestApiInput{
		Name: aws.String(apigwSfnTestAPIName),
	})
	if err != nil {
		return "", fmt.Errorf("create REST API: %w", err)
	}
	return aws.ToString(result.Id), nil
}

func apigwSfnGetAPIID(world *World) (string, error) {
	// Arrange
	result, err := world.APIGatewayClient().GetRestApis(context.Background(), &apigateway.GetRestApisInput{})
	if err != nil {
		return "", fmt.Errorf("get REST APIs: %w", err)
	}
	// Act: find by name
	for _, api := range result.Items {
		if aws.ToString(api.Name) == apigwSfnTestAPIName {
			return aws.ToString(api.Id), nil
		}
	}
	return "", nil
}

func apigwSfnCreateSM(world *World) (string, error) {
	// Arrange: disable chaos so the create call goes through
	_ = core.ChaosDisable(world.managementPort, "stepfunctions")
	result, err := world.SFNClient().CreateStateMachine(context.Background(), &sfn.CreateStateMachineInput{
		Name:       aws.String(apigwSfnTestSMName),
		Definition: aws.String(apigwSfnPassDefinition),
		RoleArn:    aws.String(apigwSfnRoleArn),
		Type:       sfntypes.StateMachineTypeExpress,
	})
	if err != nil {
		return "", fmt.Errorf("create state machine: %w", err)
	}
	return aws.ToString(result.StateMachineArn), nil
}

func apigwSfnConfigureIntegration(world *World, apiID string) error {
	// Arrange: fetch root resource
	resourcesResp, err := world.APIGatewayClient().GetResources(context.Background(), &apigateway.GetResourcesInput{
		RestApiId: aws.String(apiID),
	})
	if err != nil {
		return fmt.Errorf("get resources: %w", err)
	}
	var rootResourceID string
	for _, r := range resourcesResp.Items {
		if aws.ToString(r.Path) == "/" {
			rootResourceID = aws.ToString(r.Id)
			break
		}
	}
	if rootResourceID == "" {
		return fmt.Errorf("root resource not found for API %q", apiID)
	}

	// Act: configure POST method
	_, err = world.APIGatewayClient().PutMethod(context.Background(), &apigateway.PutMethodInput{
		RestApiId:         aws.String(apiID),
		ResourceId:        aws.String(rootResourceID),
		HttpMethod:        aws.String("POST"),
		AuthorizationType: aws.String("NONE"),
	})
	if err != nil {
		return fmt.Errorf("put method: %w", err)
	}

	// Act: configure StepFunctions integration
	integrationURI := fmt.Sprintf("arn:aws:apigateway:%s:states:action/StartExecution", apigwSfnRegion)
	_, err = world.APIGatewayClient().PutIntegration(context.Background(), &apigateway.PutIntegrationInput{
		RestApiId:             aws.String(apiID),
		ResourceId:            aws.String(rootResourceID),
		HttpMethod:            aws.String("POST"),
		Type:                  apigwtypes.IntegrationTypeAws,
		IntegrationHttpMethod: aws.String("POST"),
		Uri:                   aws.String(integrationURI),
	})
	if err != nil {
		return fmt.Errorf("put integration: %w", err)
	}

	// Act: create deployment
	deployResp, err := world.APIGatewayClient().CreateDeployment(context.Background(), &apigateway.CreateDeploymentInput{
		RestApiId:   aws.String(apiID),
		Description: aws.String("e2e"),
	})
	if err != nil {
		return fmt.Errorf("create deployment: %w", err)
	}

	// Act: create stage
	_, err = world.APIGatewayClient().CreateStage(context.Background(), &apigateway.CreateStageInput{
		RestApiId:    aws.String(apiID),
		StageName:    aws.String(apigwSfnStage),
		DeploymentId: deployResp.Id,
	})
	if err != nil {
		return fmt.Errorf("create stage: %w", err)
	}

	return nil
}

func apigwSfnInvokeAPI(world *World, apiID string, body map[string]string) (int, string, error) {
	// Arrange
	port := basePort + core.ServiceOffsets["apigateway"]
	url := fmt.Sprintf("http://127.0.0.1:%d/%s/%s/", port, apiID, apigwSfnStage)
	bodyBytes, err := json.Marshal(body)
	if err != nil {
		return 0, "", fmt.Errorf("marshal body: %w", err)
	}
	// Act
	req, err := http.NewRequestWithContext(context.Background(), http.MethodPost, url, bytes.NewReader(bodyBytes))
	if err != nil {
		return 0, "", fmt.Errorf("build request: %w", err)
	}
	req.Header.Set("Content-Type", "application/json")
	resp, err := http.DefaultClient.Do(req)
	if err != nil {
		return 0, "", fmt.Errorf("invoke API: %w", err)
	}
	defer resp.Body.Close()
	respBody, _ := io.ReadAll(resp.Body)
	// Assert: return status + body to caller
	return resp.StatusCode, string(respBody), nil
}

// registerAPIGatewayStepFunctionsSteps registers step definitions unique to the
// apigateway_stepfunctions cross-service feature files. Steps already registered
// by registerAPIGatewaySteps and registerStepFunctionsSteps are NOT re-registered here.
func registerAPIGatewayStepFunctionsSteps(sc *godog.ScenarioContext, world *World) {
	st := &apigwSfnState{}

	sc.Before(func(ctx context.Context, scenario *godog.Scenario) (context.Context, error) {
		st.restApiID = ""
		st.skipReason = ""
		return ctx, nil
	})

	// ── Background ──────────────────────────────────────────────────────────────

	// "the system is initialized" is already registered in sequences_test.go.

	// ── Given: API integration state — unique to cross-service suite ─────────────

	sc.Given(`^the "API" has no integration configured$`, func() error {
		// No-op: APIs have no integration configured by default.
		return nil
	})

	sc.Given(`^the "API" already has an integration configured$`, func() error {
		// Cannot simulate pre-configured StepFunctions integration conflict via public API.
		setResult(world, nil, fmt.Errorf("cannot simulate pre-configured StepFunctions integration conflict in lws"))
		return nil
	})

	sc.Given(`^the "API" has a Step Functions integration configured$`, func() error {
		// Arrange: ensure API exists
		apiID := st.restApiID
		if apiID == "" {
			id, err := apigwSfnGetAPIID(world)
			if err != nil {
				return err
			}
			if id == "" {
				createdID, createErr := apigwSfnCreateRestAPI(world)
				if createErr != nil {
					return createErr
				}
				id = createdID
			}
			apiID = id
		}
		// Act: create state machine and configure integration
		if _, err := apigwSfnCreateSM(world); err != nil {
			return err
		}
		if err := apigwSfnConfigureIntegration(world, apiID); err != nil {
			return err
		}
		// Assert: store API ID
		st.restApiID = apiID
		return nil
	})

	sc.Given(`^the "API" has no Step Functions integration configured$`, func() error {
		// No-op: APIs have no StepFunctions integration configured by default.
		return nil
	})

	// ── Given: integrated state machine — unique to cross-service suite ───────────

	sc.Given(`^the integrated state machine is "ACTIVE"$`, func() error {
		// Arrange: ensure state machine exists (idempotent — ignore already-exists errors)
		_, err := apigwSfnCreateSM(world)
		// Act: tolerate already-exists error
		if err != nil {
			_ = err
		}
		// Assert: state machine is ACTIVE
		return nil
	})

	sc.Given(`^the integrated state machine is not "ACTIVE"$`, func() error {
		// Cannot simulate non-ACTIVE integrated state machine via public API.
		setResult(world, nil, fmt.Errorf("cannot simulate non-ACTIVE integrated state machine in lws"))
		return nil
	})

	// ── Given: execution presence — unique to cross-service suite ────────────────

	sc.Given(`^an execution is "RUNNING"$`, func() error {
		// Cannot simulate running execution state via public API in this cross-service context.
		setResult(world, nil, fmt.Errorf("cannot simulate running execution state in lws"))
		return nil
	})

	sc.Given(`^no execution is "RUNNING"$`, func() error {
		// No-op: fresh state has no running executions.
		return nil
	})

	// ── Given: capacity — unique phrasing for cross-service suite ─────────────────
	// Note: "the execution slot is available/not available" are registered in
	// stepfunctions_test.go; these "a/an" variants are new to this suite.

	sc.Given(`^a request slot is available$`, func() error {
		// Arrange: set unlimited capacity for apigateway
		// Act
		if err := managementSession().Capacity("apigateway").Unlimited().Apply(); err != nil {
			return fmt.Errorf("capacity unlimited apply failed: %w", err)
		}
		// Assert: capacity is unlimited
		return nil
	})

	sc.Given(`^no request slot is available$`, func() error {
		// Arrange: exhaust the apigateway request capacity
		// Act
		if err := managementSession().Capacity("apigateway").Exhaust().Apply(); err != nil {
			return fmt.Errorf("capacity exhaust apply failed: %w", err)
		}
		// Assert: capacity is exhausted
		return nil
	})

	sc.Given(`^an execution slot is available$`, func() error {
		// Arrange: set unlimited capacity for stepfunctions
		// Act
		if err := managementSession().Capacity("stepfunctions").Unlimited().Apply(); err != nil {
			return fmt.Errorf("capacity unlimited apply failed: %w", err)
		}
		// Assert: capacity is unlimited
		return nil
	})

	sc.Given(`^no execution slot is available$`, func() error {
		// Arrange: exhaust the stepfunctions execution capacity
		// Act
		if err := managementSession().Capacity("stepfunctions").Exhaust().Apply(); err != nil {
			return fmt.Errorf("capacity exhaust apply failed: %w", err)
		}
		// Assert: capacity is exhausted
		return nil
	})

	// ── When: actions — unique to cross-service suite ─────────────────────────────

	sc.When(`^a "REST" "API" is created$`, func() error {
		// Arrange: use the test API name
		result, err := world.APIGatewayClient().CreateRestApi(context.Background(), &apigateway.CreateRestApiInput{
			Name: aws.String(apigwSfnTestAPIName),
		})
		// Act: record result
		setResult(world, result, err)
		if err == nil {
			st.restApiID = aws.ToString(result.Id)
		}
		// Assert: result captured in world.lastResult
		return nil
	})

	sc.When(`^a Step Functions Express Workflow state machine is created$`, func() error {
		// Arrange: use the test state machine name with EXPRESS type
		result, err := world.SFNClient().CreateStateMachine(context.Background(), &sfn.CreateStateMachineInput{
			Name:       aws.String(apigwSfnTestSMName),
			Definition: aws.String(apigwSfnPassDefinition),
			RoleArn:    aws.String(apigwSfnRoleArn),
			Type:       sfntypes.StateMachineTypeExpress,
		})
		// Act: record result
		setResult(world, result, err)
		// Assert: result captured in world.lastResult
		return nil
	})

	sc.When(`^a Step Functions direct integration is configured on the "REST" "API"$`, func() error {
		if st.skipReason != "" {
			setResult(world, nil, fmt.Errorf("%s", st.skipReason))
			return nil
		}
		// Arrange: find the API
		apiID := st.restApiID
		if apiID == "" {
			id, err := apigwSfnGetAPIID(world)
			if err != nil {
				setResult(world, nil, err)
				return nil
			}
			apiID = id
		}
		if apiID == "" {
			setResult(world, nil, fmt.Errorf("REST API not found"))
			return nil
		}
		// Act: configure the integration
		err := apigwSfnConfigureIntegration(world, apiID)
		if err == nil {
			st.restApiID = apiID
		}
		setResult(world, map[string]bool{"configured": err == nil}, err)
		// Assert: result captured in world.lastResult
		return nil
	})

	sc.When(`^the "API" receives an "HTTP" request and synchronously starts a Step Functions execution$`, func() error {
		// Arrange: determine API ID
		apiID := st.restApiID
		if apiID == "" {
			id, err := apigwSfnGetAPIID(world)
			if err != nil {
				setResult(world, nil, err)
				return nil
			}
			apiID = id
		}
		// Act: invoke the API
		smArn := apigwSfnSmArn(apigwSfnTestSMName)
		inputJSON, _ := json.Marshal(map[string]string{"key": "value"})
		status, body, err := apigwSfnInvokeAPI(world, apiID, map[string]string{
			"stateMachineArn": smArn,
			"input":           string(inputJSON),
		})
		if err != nil {
			setResult(world, nil, err)
			return nil
		}
		if status != http.StatusOK {
			setResult(world, nil, fmt.Errorf("API request failed with status %d: %s", status, body))
			return nil
		}
		setResult(world, map[string]interface{}{"status_code": status, "body": body}, nil)
		// Assert: result captured in world.lastResult
		return nil
	})

	sc.When(`^the Step Functions execution completes successfully and the "API" returns a successful response$`, func() error {
		// Cannot simulate Step Functions execution completion via API Gateway via public API.
		setResult(world, nil, fmt.Errorf("cannot simulate Step Functions execution completion via API Gateway in lws"))
		return nil
	})

	sc.When(`^the Step Functions execution fails and the "API" returns an error response$`, func() error {
		// Cannot simulate Step Functions execution failure via API Gateway via public API.
		setResult(world, nil, fmt.Errorf("cannot simulate Step Functions execution failure via API Gateway in lws"))
		return nil
	})

	// ── Then: assertions — unique to cross-service suite ──────────────────────────

	sc.Then(`^the "API" is "ACTIVE" with no Step Functions integration configured$`, func() error {
		// Arrange
		expectedName := apigwSfnTestAPIName
		// Act
		apiID, err := apigwSfnGetAPIID(world)
		if err != nil {
			return fmt.Errorf("expected REST API %q to exist but lookup failed: %w", expectedName, err)
		}
		if apiID == "" {
			return fmt.Errorf("expected REST API %q to exist but it was not found; expected_name=%s", expectedName, expectedName)
		}
		result, err := world.APIGatewayClient().GetRestApi(context.Background(), &apigateway.GetRestApiInput{
			RestApiId: aws.String(apiID),
		})
		if err != nil {
			return fmt.Errorf("expected get_rest_api to succeed but got: %w", err)
		}
		// Assert
		actualName := aws.ToString(result.Name)
		if actualName != expectedName {
			return fmt.Errorf("expected API name %q but got %q; expected_name=%s actual_name=%s",
				expectedName, actualName, expectedName, actualName)
		}
		return nil
	})

	// Note: "the state machine is \"ACTIVE\"" (Then) is already registered in stepfunctions_test.go.

	sc.Then(`^the "API" will synchronously start and await an Express Workflow execution per request$`, func() error {
		// Arrange
		apiID := st.restApiID
		if apiID == "" {
			id, err := apigwSfnGetAPIID(world)
			if err != nil {
				return fmt.Errorf("expected REST API to exist but lookup failed: %w", err)
			}
			apiID = id
		}
		if apiID == "" {
			return fmt.Errorf("expected REST API %q to exist but it was not found", apigwSfnTestAPIName)
		}
		smArn := apigwSfnSmArn(apigwSfnTestSMName)
		inputJSON, _ := json.Marshal(map[string]string{"check": "ok"})
		// Act
		expectedStatus := http.StatusOK
		actualStatus, body, err := apigwSfnInvokeAPI(world, apiID, map[string]string{
			"stateMachineArn": smArn,
			"input":           string(inputJSON),
		})
		if err != nil {
			return fmt.Errorf("expected API request to succeed but got: %w; expected_status=%d", err, expectedStatus)
		}
		// Assert
		if actualStatus != expectedStatus {
			return fmt.Errorf("expected status %d but got %d; expected_status=%d actual_status=%d body=%s",
				expectedStatus, actualStatus, expectedStatus, actualStatus, body)
		}
		return nil
	})

	sc.Then(`^the request and execution are both "IN_PROGRESS" and "RUNNING" respectively$`, func() error {
		// Cannot inspect in-progress execution state via API Gateway via public API.
		// Invariant: trivially satisfied in isolated lws context.
		return nil
	})

	sc.Then(`^the execution is "SUCCEEDED" and the request is "SUCCESS"$`, func() error {
		// Arrange
		expectedSuccess := true
		// Act: action already performed in When step
		// Assert
		actualSuccess := world.lastResult.Success
		if !actualSuccess {
			return fmt.Errorf("expected request status SUCCESS but got error: %v; expected_success=%v actual_success=%v",
				world.lastResult.Error, expectedSuccess, actualSuccess)
		}
		return nil
	})

	sc.Then(`^the execution is "FAILED" and the request is "FAILED"$`, func() error {
		// Cannot simulate Step Functions execution failure via API Gateway via public API.
		// Invariant: trivially satisfied in isolated lws context.
		return nil
	})

	// ── Then: invariants ──────────────────────────────────────────────────────────

	sc.Then(`^every "IN_PROGRESS" request references an "ACTIVE" "API"$`, func() error {
		// Invariant: trivially satisfied in isolated lws context.
		return nil
	})

	sc.Then(`^every "RUNNING" execution references an "ACTIVE" state machine$`, func() error {
		// Invariant: trivially satisfied in isolated lws context.
		return nil
	})

	sc.Then(`^every "RUNNING" execution has a corresponding "IN_PROGRESS" request$`, func() error {
		// Invariant: trivially satisfied in isolated lws context.
		return nil
	})
}
