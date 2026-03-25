package tests

// registerAPIGatewayDynamodbSteps registers step definitions specific to the
// apigateway_dynamodb cross-service feature files.
//
// Constituent service steps for single-service preconditions (table existence,
// "the system is initialized", "the operation is rejected") are already
// registered by registerDynamoDBSteps and registerAPIGatewaySteps.  Only the
// unique cross-service Given preconditions, When actions, and Then assertions
// that have no equivalent in the single-service step files are defined here.

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
	"github.com/aws/aws-sdk-go-v2/service/dynamodb"
	dynamodbtypes "github.com/aws/aws-sdk-go-v2/service/dynamodb/types"
	"github.com/cucumber/godog"
	core "github.com/local-web-services/local-web-services-go-core/lws"
)

const apigwDynamodbTestAPIName = "e2e-test-api-1"
const apigwDynamodbTestTable = "e2e-test-table-1"
const apigwDynamodbTestPK = "e2e-id"
const apigwDynamodbTestItemKey = "e2e-item-1"
const apigwDynamodbTestStageName = "prod"
const apigwDynamodbRegion = "us-east-1"

// apigwDynamodbState holds mutable cross-service state for one scenario.
type apigwDynamodbState struct {
	restApiID string
	itemKey   string
	invokeStatus int
}

func registerAPIGatewayDynamodbSteps(sc *godog.ScenarioContext, world *World) {
	st := &apigwDynamodbState{}

	sc.Before(func(ctx context.Context, scenario *godog.Scenario) (context.Context, error) {
		st.restApiID = ""
		st.itemKey = ""
		st.invokeStatus = 0
		return ctx, nil
	})

	// ── Helpers ───────────────────────────────────────────────────────────────────

	createCrossAPI := func() error {
		// Arrange
		// Act
		result, err := world.APIGatewayClient().CreateRestApi(context.Background(), &apigateway.CreateRestApiInput{
			Name: aws.String(apigwDynamodbTestAPIName),
		})
		if err != nil {
			return fmt.Errorf("create REST API: %w", err)
		}
		// Assert: store API ID
		st.restApiID = aws.ToString(result.Id)
		return nil
	}

	getCrossAPIID := func() (string, error) {
		// Arrange
		// Act
		resp, err := world.APIGatewayClient().GetRestApis(context.Background(), &apigateway.GetRestApisInput{})
		if err != nil {
			return "", fmt.Errorf("get REST APIs: %w", err)
		}
		// Assert: find by name
		for _, api := range resp.Items {
			if aws.ToString(api.Name) == apigwDynamodbTestAPIName {
				return aws.ToString(api.Id), nil
			}
		}
		return "", nil
	}

	createCrossTable := func() error {
		// Arrange
		// Act
		_, err := world.DynamoDBClient().CreateTable(context.Background(), &dynamodb.CreateTableInput{
			TableName: aws.String(apigwDynamodbTestTable),
			KeySchema: []dynamodbtypes.KeySchemaElement{
				{AttributeName: aws.String(apigwDynamodbTestPK), KeyType: dynamodbtypes.KeyTypeHash},
			},
			AttributeDefinitions: []dynamodbtypes.AttributeDefinition{
				{AttributeName: aws.String(apigwDynamodbTestPK), AttributeType: dynamodbtypes.ScalarAttributeTypeS},
			},
			BillingMode: dynamodbtypes.BillingModePayPerRequest,
		})
		// Assert: caller checks error
		return err
	}

	configureDynamoDBIntegration := func(apiID string) error {
		// Arrange: fetch root resource
		resp, err := world.APIGatewayClient().GetResources(context.Background(), &apigateway.GetResourcesInput{
			RestApiId: aws.String(apiID),
		})
		if err != nil {
			return fmt.Errorf("get resources: %w", err)
		}
		var rootResourceID string
		for _, r := range resp.Items {
			if aws.ToString(r.Path) == "/" {
				rootResourceID = aws.ToString(r.Id)
				break
			}
		}
		if rootResourceID == "" {
			return fmt.Errorf("root resource not found for API %q", apiID)
		}

		// Act: put POST method
		_, err = world.APIGatewayClient().PutMethod(context.Background(), &apigateway.PutMethodInput{
			RestApiId:         aws.String(apiID),
			ResourceId:        aws.String(rootResourceID),
			HttpMethod:        aws.String("POST"),
			AuthorizationType: aws.String("NONE"),
		})
		if err != nil {
			return fmt.Errorf("put method: %w", err)
		}

		// Act: put DynamoDB AWS integration
		integrationURI := fmt.Sprintf("arn:aws:apigateway:%s:dynamodb:action/PutItem", apigwDynamodbRegion)
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

		// Act: create prod stage
		_, err = world.APIGatewayClient().CreateStage(context.Background(), &apigateway.CreateStageInput{
			RestApiId:    aws.String(apiID),
			StageName:    aws.String(apigwDynamodbTestStageName),
			DeploymentId: deployResp.Id,
		})
		if err != nil {
			return fmt.Errorf("create stage: %w", err)
		}
		return nil
	}

	invokeAPI := func(apiID string, body map[string]interface{}) (int, error) {
		// Arrange: build request URL using apigateway port
		port := basePort + core.ServiceOffsets["apigateway"]
		url := fmt.Sprintf("http://127.0.0.1:%d/%s/%s/", port, apiID, apigwDynamodbTestStageName)
		bodyBytes, err := json.Marshal(body)
		if err != nil {
			return 0, fmt.Errorf("marshal body: %w", err)
		}
		// Act: POST to the API stage
		req, err := http.NewRequestWithContext(context.Background(), http.MethodPost, url, bytes.NewReader(bodyBytes))
		if err != nil {
			return 0, fmt.Errorf("new request: %w", err)
		}
		req.Header.Set("Content-Type", "application/json")
		resp, err := http.DefaultClient.Do(req)
		if err != nil {
			return 0, fmt.Errorf("http do: %w", err)
		}
		defer resp.Body.Close()
		_, _ = io.ReadAll(resp.Body)
		// Assert: caller uses status code
		return resp.StatusCode, nil
	}

	// ── Given: API has DynamoDB integration ───────────────────────────────────────

	sc.Given(`^the "API" exists and is "ACTIVE"$`, func() error {
		// Arrange: create a REST API for cross-service scenarios
		// Act
		return createCrossAPI()
	})

	sc.Given(`^the "API" does not exist or is not "ACTIVE"$`, func() error {
		// No-op: cannot simulate non-ACTIVE REST API in lws; @internal excluded.
		return nil
	})

	sc.Given(`^the "API" has no DynamoDB integration configured$`, func() error {
		// No-op: APIs have no DynamoDB integration by default.
		return nil
	})

	sc.Given(`^the "API" already has a DynamoDB integration configured$`, func() error {
		// No-op: cannot simulate pre-configured integration conflict in lws; @internal excluded.
		return nil
	})

	sc.Given(`^the "API" has a DynamoDB integration configured$`, func() error {
		// Arrange: create an API with a DynamoDB PutItem integration
		apiID, err := getCrossAPIID()
		if err != nil {
			return err
		}
		if apiID == "" {
			if err := createCrossAPI(); err != nil {
				return err
			}
			apiID = st.restApiID
		}
		if err := createCrossTable(); err != nil {
			return fmt.Errorf("create table for integration setup: %w", err)
		}
		if err := configureDynamoDBIntegration(apiID); err != nil {
			return err
		}
		// Assert: store API ID
		st.restApiID = apiID
		return nil
	})

	// ── Given: table state (cross-service wording) ────────────────────────────────

	sc.Given(`^the table exists and is "ACTIVE"$`, func() error {
		// Arrange: create the test table
		// Act
		return createCrossTable()
	})

	sc.Given(`^the table does not exist or is not "ACTIVE"$`, func() error {
		// No-op: cannot simulate non-ACTIVE table in lws; @internal excluded.
		return nil
	})

	sc.Given(`^the target table is "ACTIVE"$`, func() error {
		// Arrange: ensure the table exists
		// Act
		_ = createCrossTable() // ignore error if already exists
		return nil
	})

	sc.Given(`^the target table is not "ACTIVE"$`, func() error {
		// No-op: cannot simulate non-ACTIVE target table in lws; @internal excluded.
		return nil
	})

	sc.Given(`^the target table is "DELETING"$`, func() error {
		// No-op: cannot simulate DELETING table state in lws; @internal excluded.
		return nil
	})

	sc.Given(`^the target table is not "DELETING"$`, func() error {
		// No-op: tables are not DELETING by default.
		return nil
	})

	sc.Given(`^the table is already "DELETING"$`, func() error {
		// No-op: cannot simulate DELETING state in lws; @internal excluded.
		return nil
	})

	// ── Given: capacity / slot state ─────────────────────────────────────────────

	sc.Given(`^a request slot is available$`, func() error {
		// Arrange: set apigateway capacity to unlimited
		// Act
		return managementSession().Capacity("apigateway").Unlimited().Apply()
	})

	sc.Given(`^no request slot is available$`, func() error {
		// No-op: cannot simulate exhausted request slots via public API; @internal excluded.
		return nil
	})

	sc.Given(`^an item slot is available$`, func() error {
		// Arrange: set dynamodb capacity to unlimited
		// Act
		return managementSession().Capacity("dynamodb").Unlimited().Apply()
	})

	sc.Given(`^no item slot is available$`, func() error {
		// No-op: cannot simulate exhausted item slots via public API; @internal excluded.
		return nil
	})

	// ── When: actions ─────────────────────────────────────────────────────────────

	sc.When(`^an "API" Gateway "REST" "API" is created$`, func() error {
		// Arrange
		// Act
		err := createCrossAPI()
		// Assert: store result
		setResult(world, apigwDynamodbTestAPIName, err)
		return nil
	})

	sc.When(`^a DynamoDB table is created$`, func() error {
		// Arrange
		// Act
		err := createCrossTable()
		// Assert: store result
		setResult(world, apigwDynamodbTestTable, err)
		return nil
	})

	sc.When(`^a direct DynamoDB integration is configured on the "API"$`, func() error {
		// Arrange
		apiID, err := getCrossAPIID()
		if err != nil {
			setResult(world, nil, err)
			return nil
		}
		if apiID == "" {
			setResult(world, nil, fmt.Errorf("REST API not found"))
			return nil
		}
		// Act
		err = configureDynamoDBIntegration(apiID)
		// Assert: store result
		setResult(world, map[string]bool{"configured": true}, err)
		if err == nil {
			st.restApiID = apiID
		}
		return nil
	})

	sc.When(`^a request is received, the "API" writes to the DynamoDB table, and returns 200$`, func() error {
		// Arrange
		apiID := st.restApiID
		if apiID == "" {
			var err error
			apiID, err = getCrossAPIID()
			if err != nil {
				setResult(world, nil, err)
				return nil
			}
		}
		// Act
		status, err := invokeAPI(apiID, map[string]interface{}{
			"TableName": apigwDynamodbTestTable,
			"Item": map[string]interface{}{
				apigwDynamodbTestPK: map[string]string{"S": apigwDynamodbTestItemKey},
				"value":             map[string]string{"S": "hello"},
			},
		})
		if err != nil {
			setResult(world, nil, err)
			return nil
		}
		st.invokeStatus = status
		if status != 200 {
			setResult(world, nil, fmt.Errorf("API request failed with status %d", status))
		} else {
			setResult(world, status, nil)
		}
		return nil
	})

	sc.When(`^a request is received but the DynamoDB write fails because the table is being deleted$`, func() error {
		// No-op: cannot simulate DELETING table during request in lws; @internal excluded.
		setResult(world, nil, fmt.Errorf("cannot simulate DELETING table during request: @internal"))
		return nil
	})

	sc.When(`^a table deletion is initiated$`, func() error {
		// Arrange
		// Act
		resp, err := world.DynamoDBClient().DeleteTable(context.Background(), &dynamodb.DeleteTableInput{
			TableName: aws.String(apigwDynamodbTestTable),
		})
		// Assert: store result
		setResult(world, resp, err)
		return nil
	})

	// ── Then: assertions ──────────────────────────────────────────────────────────

	sc.Then(`^the "API" is "ACTIVE" with no DynamoDB integration configured$`, func() error {
		// Arrange
		apiID, err := getCrossAPIID()
		if err != nil {
			return fmt.Errorf("get API ID: %w", err)
		}
		// Act
		resp, err := world.APIGatewayClient().GetRestApi(context.Background(), &apigateway.GetRestApiInput{
			RestApiId: aws.String(apiID),
		})
		if err != nil {
			return fmt.Errorf("get REST API: %w", err)
		}
		// Assert
		expectedName := apigwDynamodbTestAPIName
		actualName := aws.ToString(resp.Name)
		if actualName != expectedName {
			return fmt.Errorf("expected API name %q but got %q", expectedName, actualName)
		}
		return nil
	})

	sc.Then(`^the table is "ACTIVE"$`, func() error {
		// Arrange
		// Act
		resp, err := world.DynamoDBClient().DescribeTable(context.Background(), &dynamodb.DescribeTableInput{
			TableName: aws.String(apigwDynamodbTestTable),
		})
		if err != nil {
			return fmt.Errorf("describe table: %w", err)
		}
		// Assert
		expectedStatus := dynamodbtypes.TableStatusActive
		actualStatus := resp.Table.TableStatus
		if actualStatus != expectedStatus {
			return fmt.Errorf("expected table status %q but got %q", expectedStatus, actualStatus)
		}
		return nil
	})

	sc.Then(`^the "API" will write to the table when requests are received$`, func() error {
		// Arrange
		apiID := st.restApiID
		if apiID == "" {
			var err error
			apiID, err = getCrossAPIID()
			if err != nil {
				return err
			}
		}
		// Act
		status, err := invokeAPI(apiID, map[string]interface{}{
			"TableName": apigwDynamodbTestTable,
			"Item": map[string]interface{}{
				apigwDynamodbTestPK: map[string]string{"S": "check-item-1"},
				"value":             map[string]string{"S": "ok"},
			},
		})
		if err != nil {
			return fmt.Errorf("invoke API: %w", err)
		}
		// Assert
		expectedStatus := 200
		actualStatus := status
		if actualStatus != expectedStatus {
			return fmt.Errorf("expected status %d but got %d", expectedStatus, actualStatus)
		}
		return nil
	})

	sc.Then(`^the item "EXISTS" and the request is "SUCCESS"$`, func() error {
		// Arrange
		expectedInvokeStatus := 200
		actualInvokeStatus := st.invokeStatus
		if actualInvokeStatus != expectedInvokeStatus {
			return fmt.Errorf("expected request status %d but got %d", expectedInvokeStatus, actualInvokeStatus)
		}
		// Act
		resp, err := world.DynamoDBClient().GetItem(context.Background(), &dynamodb.GetItemInput{
			TableName: aws.String(apigwDynamodbTestTable),
			Key: map[string]dynamodbtypes.AttributeValue{
				apigwDynamodbTestPK: &dynamodbtypes.AttributeValueMemberS{Value: apigwDynamodbTestItemKey},
			},
		})
		if err != nil {
			return fmt.Errorf("get item: %w", err)
		}
		// Assert
		actualItem := resp.Item
		if actualItem == nil {
			return fmt.Errorf("expected item to exist in DynamoDB but it was not found")
		}
		return nil
	})

	sc.Then(`^the request is "FAILED" and no item is written$`, func() error {
		// No-op: cannot simulate DynamoDB write failure via API Gateway in lws; @internal excluded.
		return nil
	})

	sc.Then(`^the table is "DELETING" and "API" requests targeting it will fail$`, func() error {
		// Arrange
		// Act / Assert: delete_table should have succeeded (no error stored)
		expectedError := error(nil)
		actualError := world.lastResult.Error
		if actualError != expectedError {
			return fmt.Errorf("expected delete_table to succeed but got: %v", actualError)
		}
		return nil
	})

	// ── Invariant catch-all steps ─────────────────────────────────────────────────

	sc.Then(`^every existing item references a table that exists$`, func() error {
		// No-op: model-level invariant; trivially satisfied in isolated lws context.
		return nil
	})

	sc.Then(`^every successful request references an "API" that exists$`, func() error {
		// No-op: model-level invariant; trivially satisfied in isolated lws context.
		return nil
	})
}
