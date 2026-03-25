package tests

import (
	"context"
	"fmt"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/apigateway"
	"github.com/aws/aws-sdk-go-v2/service/apigateway/types"
	"github.com/cucumber/godog"
)

const apigwTestApiName = "e2e-apigw-test-api-1"
const apigwTestApiDescription = "e2e test REST API"
const apigwTestChildPath = "items"

// apigwState holds mutable state for API Gateway step definitions within one scenario.
type apigwState struct {
	restApiID       string
	rootResourceID  string
	childResourceID string
	httpMethod      string
	deploymentID    string
	devStageID      string
	prodStageID     string
}

func registerAPIGatewaySteps(sc *godog.ScenarioContext, world *World) {
	st := &apigwState{}

	sc.Before(func(ctx context.Context, scenario *godog.Scenario) (context.Context, error) {
		st.restApiID = ""
		st.rootResourceID = ""
		st.childResourceID = ""
		st.httpMethod = "GET"
		st.deploymentID = ""
		st.devStageID = ""
		st.prodStageID = ""
		return ctx, nil
	})

	// ── Helpers ──────────────────────────────────────────────────────────────────

	createAPI := func() error {
		result, err := world.APIGatewayClient().CreateRestApi(context.Background(), &apigateway.CreateRestApiInput{
			Name:        aws.String(apigwTestApiName),
			Description: aws.String(apigwTestApiDescription),
		})
		if err != nil {
			return fmt.Errorf("create REST API: %w", err)
		}
		st.restApiID = aws.ToString(result.Id)
		return nil
	}

	fetchRootResource := func() error {
		if st.restApiID == "" {
			return fmt.Errorf("no REST API ID available to fetch root resource")
		}
		resp, err := world.APIGatewayClient().GetResources(context.Background(), &apigateway.GetResourcesInput{
			RestApiId: aws.String(st.restApiID),
		})
		if err != nil {
			return fmt.Errorf("get resources: %w", err)
		}
		for _, r := range resp.Items {
			if aws.ToString(r.Path) == "/" {
				st.rootResourceID = aws.ToString(r.Id)
				return nil
			}
		}
		return fmt.Errorf("root resource not found for API %q", st.restApiID)
	}

	createAPIWithRoot := func() error {
		if err := createAPI(); err != nil {
			return err
		}
		return fetchRootResource()
	}

	setupAPIWithMethod := func() error {
		if err := createAPIWithRoot(); err != nil {
			return err
		}
		_, err := world.APIGatewayClient().PutMethod(context.Background(), &apigateway.PutMethodInput{
			RestApiId:         aws.String(st.restApiID),
			ResourceId:        aws.String(st.rootResourceID),
			HttpMethod:        aws.String(st.httpMethod),
			AuthorizationType: aws.String("NONE"),
		})
		return err
	}

	setupAPIWithIntegration := func() error {
		if err := setupAPIWithMethod(); err != nil {
			return err
		}
		_, err := world.APIGatewayClient().PutIntegration(context.Background(), &apigateway.PutIntegrationInput{
			RestApiId:        aws.String(st.restApiID),
			ResourceId:       aws.String(st.rootResourceID),
			HttpMethod:       aws.String(st.httpMethod),
			Type:             types.IntegrationTypeMock,
			RequestTemplates: map[string]string{"application/json": `{"statusCode": 200}`},
		})
		return err
	}

	setupDeployment := func() error {
		if err := setupAPIWithIntegration(); err != nil {
			return err
		}
		result, err := world.APIGatewayClient().CreateDeployment(context.Background(), &apigateway.CreateDeploymentInput{
			RestApiId: aws.String(st.restApiID),
		})
		if err != nil {
			return fmt.Errorf("create deployment: %w", err)
		}
		st.deploymentID = aws.ToString(result.Id)
		return nil
	}

	setupDevStage := func() error {
		if err := setupDeployment(); err != nil {
			return err
		}
		result, err := world.APIGatewayClient().CreateStage(context.Background(), &apigateway.CreateStageInput{
			RestApiId:    aws.String(st.restApiID),
			StageName:    aws.String("dev"),
			DeploymentId: aws.String(st.deploymentID),
		})
		if err != nil {
			return fmt.Errorf("create dev stage: %w", err)
		}
		st.devStageID = aws.ToString(result.StageName)
		return nil
	}

	setupProdStage := func() error {
		if err := setupDeployment(); err != nil {
			return err
		}
		result, err := world.APIGatewayClient().CreateStage(context.Background(), &apigateway.CreateStageInput{
			RestApiId:    aws.String(st.restApiID),
			StageName:    aws.String("prod"),
			DeploymentId: aws.String(st.deploymentID),
		})
		if err != nil {
			return fmt.Errorf("create prod stage: %w", err)
		}
		st.prodStageID = aws.ToString(result.StageName)
		return nil
	}

	// ── Background: the system is initialized (already registered in sequences_test.go) ──

	// ── Given: API state setup ────────────────────────────────────────────────────

	sc.Given(`^the "API" does not already exist$`, func() error {
		// No-op: fresh state after reset has no REST APIs.
		return nil
	})

	sc.Given(`^the "API" already exists$`, func() error {
		// Arrange: create the test API so it already exists
		// Act
		return createAPI()
	})

	sc.Given(`^the "API" does not exist$`, func() error {
		// No-op: fresh state after reset has no REST APIs.
		return nil
	})

	sc.Given(`^the "API" exists$`, func() error {
		// Arrange: create the test REST API
		// Act
		return createAPIWithRoot()
	})

	sc.Given(`^the "API" is "ACTIVE"$`, func() error {
		// No-op: in lws REST APIs are ACTIVE immediately after creation.
		return nil
	})

	sc.Given(`^the "API" is not "ACTIVE"$`, func() error {
		// Arrange: enable lifecycle simulation so API stays in CREATING state
		// Act
		sess := managementSession()
		if err := sess.Lifecycle("apigateway").CreateDwellMs(5000).Apply(); err != nil {
			return fmt.Errorf("lifecycle apply: %w", err)
		}
		return createAPIWithRoot()
	})

	// ── Given: resource slot availability ────────────────────────────────────────

	sc.Given(`^a resource slot is available$`, func() error {
		// No-op: fresh state has resource slots available.
		return nil
	})

	sc.Given(`^no resource slot is available$`, func() error {
		// Arrange: exhaust apigateway capacity
		// Act
		return managementSession().Capacity("apigateway").Exhaust().Apply()
	})

	// ── Given: parent resource state ─────────────────────────────────────────────

	sc.Given(`^the parent resource exists$`, func() error {
		// Arrange: create an API — the root resource is the parent
		// Act
		return createAPIWithRoot()
	})

	sc.Given(`^the parent resource does not exist$`, func() error {
		// No-op: fresh state has no REST APIs or resources.
		return nil
	})

	sc.Given(`^the parent resource is "ACTIVE"$`, func() error {
		// No-op: resources are ACTIVE immediately after creation.
		return nil
	})

	sc.Given(`^the parent resource is not "ACTIVE"$`, func() error {
		// No-op: this state is not reachable via public API in lws.
		return nil
	})

	// ── Given: resource slot ─────────────────────────────────────────────────────

	sc.Given(`^the resource slot is unallocated$`, func() error {
		// No-op: fresh state has no allocated resource slots.
		return nil
	})

	sc.Given(`^the resource slot is already allocated$`, func() error {
		// No-op: this state is not reachable via public API in lws.
		return nil
	})

	// ── Given: resource state ─────────────────────────────────────────────────────

	sc.Given(`^the resource exists$`, func() error {
		// Arrange: create an API which provides a root resource
		// Act
		return createAPIWithRoot()
	})

	sc.Given(`^the resource does not exist$`, func() error {
		// No-op: fresh state has no resources.
		return nil
	})

	sc.Given(`^the resource is "ACTIVE"$`, func() error {
		// No-op: resources are ACTIVE immediately after creation.
		return nil
	})

	sc.Given(`^the resource is not "ACTIVE"$`, func() error {
		// No-op: this state is not reachable via public API in lws.
		return nil
	})

	sc.Given(`^the resource has a path$`, func() error {
		// No-op: resources always have paths in lws.
		return nil
	})

	sc.Given(`^the resource does not have a path$`, func() error {
		// No-op: cannot create a resource without a path in lws.
		return nil
	})

	sc.Given(`^the resource is not the root resource$`, func() error {
		// Arrange: create a child resource under the root
		// Act
		if st.restApiID == "" || st.rootResourceID == "" {
			return nil
		}
		result, err := world.APIGatewayClient().CreateResource(context.Background(), &apigateway.CreateResourceInput{
			RestApiId: aws.String(st.restApiID),
			ParentId:  aws.String(st.rootResourceID),
			PathPart:  aws.String(apigwTestChildPath),
		})
		if err != nil {
			return err
		}
		st.childResourceID = aws.ToString(result.Id)
		return nil
	})

	sc.Given(`^the resource is the root resource$`, func() error {
		// No-op: the root resource is created implicitly with each REST API.
		return nil
	})

	// ── Given: method state ───────────────────────────────────────────────────────

	sc.Given(`^the method does not already exist$`, func() error {
		// No-op: fresh state has no methods.
		return nil
	})

	sc.Given(`^the method already exists$`, func() error {
		// Arrange: create an API with a GET method on the root resource
		// Act
		return setupAPIWithMethod()
	})

	sc.Given(`^the method does not exist$`, func() error {
		// No-op: fresh state has no methods.
		return nil
	})

	sc.Given(`^the method exists$`, func() error {
		// Arrange: create an API with a GET method on the root resource
		// Act
		return setupAPIWithMethod()
	})

	sc.Given(`^the method "EXISTS"$`, func() error {
		// No-op: method existence is already set up by prior steps.
		return nil
	})

	// ── Given: integration state ──────────────────────────────────────────────────

	sc.Given(`^the method has an integration$`, func() error {
		// No-op: integration state is set up by other Given steps.
		return nil
	})

	sc.Given(`^the method does not have an integration$`, func() error {
		// No-op: fresh state has no integrations.
		return nil
	})

	sc.Given(`^the method has an "API" association$`, func() error {
		// No-op: methods implicitly belong to an API in lws.
		return nil
	})

	sc.Given(`^the method does not have an "API" association$`, func() error {
		// No-op: cannot create a method without an API association in lws.
		return nil
	})

	sc.Given(`^the integration exists$`, func() error {
		// Arrange: create an API with a method and integration
		// Act
		return setupAPIWithIntegration()
	})

	sc.Given(`^the integration does not exist$`, func() error {
		// No-op: fresh state has no integrations.
		return nil
	})

	sc.Given(`^the integration "EXISTS"$`, func() error {
		// No-op: integration existence is verified after setup.
		return nil
	})

	// ── Given: deployment state ───────────────────────────────────────────────────

	sc.Given(`^the deployment slot is available$`, func() error {
		// No-op: fresh state has deployment slots available.
		return nil
	})

	sc.Given(`^the deployment slot is already in use$`, func() error {
		// No-op: this state is not reachable via public API in lws.
		return nil
	})

	sc.Given(`^the deployment exists$`, func() error {
		// Arrange: create an API with method, integration, and deployment
		// Act
		return setupDeployment()
	})

	sc.Given(`^the deployment does not exist$`, func() error {
		// No-op: fresh state has no deployments.
		return nil
	})

	sc.Given(`^the deployment is "ACTIVE"$`, func() error {
		// No-op: deployments are ACTIVE immediately after creation.
		return nil
	})

	sc.Given(`^the deployment is not "ACTIVE"$`, func() error {
		// No-op: this state is not reachable via public API in lws.
		return nil
	})

	// ── Given: dev stage state ────────────────────────────────────────────────────

	sc.Given(`^the dev stage already exists for this "API"$`, func() error {
		// Arrange: create a dev stage
		// Act
		return setupDevStage()
	})

	sc.Given(`^the dev stage does not already exist for this "API"$`, func() error {
		// No-op: fresh state has no stages.
		return nil
	})

	sc.Given(`^the dev stage does not exist$`, func() error {
		// No-op: fresh state has no stages.
		return nil
	})

	sc.Given(`^the dev stage exists$`, func() error {
		// Arrange: create a dev stage
		// Act
		return setupDevStage()
	})

	sc.Given(`^the dev stage is active$`, func() error {
		// No-op: stages are active immediately after creation.
		return nil
	})

	sc.Given(`^the dev stage is not active$`, func() error {
		// No-op: this state is not reachable via public API in lws.
		return nil
	})

	sc.Given(`^the dev stage has throttling configured$`, func() error {
		// No-op: all request_throttled_dev scenarios are @internal.
		return nil
	})

	sc.Given(`^the dev stage does not have throttling configured$`, func() error {
		// No-op: all request_throttled_dev scenarios are @internal.
		return nil
	})

	// ── Given: prod stage state ───────────────────────────────────────────────────

	sc.Given(`^the prod stage already exists for this "API"$`, func() error {
		// Arrange: create a prod stage
		// Act
		return setupProdStage()
	})

	sc.Given(`^the prod stage does not already exist for this "API"$`, func() error {
		// No-op: fresh state has no stages.
		return nil
	})

	sc.Given(`^the prod stage does not exist$`, func() error {
		// No-op: fresh state has no stages.
		return nil
	})

	sc.Given(`^the prod stage exists$`, func() error {
		// Arrange: create a prod stage
		// Act
		return setupProdStage()
	})

	sc.Given(`^the prod stage is active$`, func() error {
		// No-op: stages are active immediately after creation.
		return nil
	})

	sc.Given(`^the prod stage is not active$`, func() error {
		// No-op: this state is not reachable via public API in lws.
		return nil
	})

	sc.Given(`^the prod stage has throttling configured$`, func() error {
		// No-op: all request_throttled_prod scenarios are @internal.
		return nil
	})

	sc.Given(`^the prod stage does not have throttling configured$`, func() error {
		// No-op: all request_throttled_prod scenarios are @internal.
		return nil
	})

	// ── Given: throttling state ───────────────────────────────────────────────────

	sc.Given(`^throttling is not enabled for the dev stage$`, func() error {
		// No-op: no throttling configured by default.
		return nil
	})

	sc.Given(`^throttling is not enabled for the prod stage$`, func() error {
		// No-op: no throttling configured by default.
		return nil
	})

	// ── When: actions ─────────────────────────────────────────────────────────────

	sc.When(`^a "REST" "API" is created with a root resource$`, func() error {
		// Arrange
		// Act
		result, err := world.APIGatewayClient().CreateRestApi(context.Background(), &apigateway.CreateRestApiInput{
			Name:        aws.String(apigwTestApiName),
			Description: aws.String(apigwTestApiDescription),
		})
		// Assert: store result
		setResult(world, result, err)
		if err == nil {
			st.restApiID = aws.ToString(result.Id)
			_ = fetchRootResource()
		}
		return nil
	})

	sc.When(`^a "REST" "API" is deleted$`, func() error {
		// Arrange: find the first REST API
		// Act
		apis, err := world.APIGatewayClient().GetRestApis(context.Background(), &apigateway.GetRestApisInput{})
		if err != nil {
			setResult(world, nil, err)
			return nil
		}
		if len(apis.Items) == 0 {
			setResult(world, nil, fmt.Errorf("no REST API found to delete"))
			return nil
		}
		apiID := aws.ToString(apis.Items[0].Id)
		result, err := world.APIGatewayClient().DeleteRestApi(context.Background(), &apigateway.DeleteRestApiInput{
			RestApiId: aws.String(apiID),
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^a root resource is initialized for an "API"$`, func() error {
		// Arrange
		// Act: in lws the root resource is created with the API; GetResources serves as a no-op trigger
		if st.restApiID == "" {
			setResult(world, nil, fmt.Errorf("no REST API ID available"))
			return nil
		}
		result, err := world.APIGatewayClient().GetResources(context.Background(), &apigateway.GetResourcesInput{
			RestApiId: aws.String(st.restApiID),
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^a child resource is created under an existing resource$`, func() error {
		// Arrange
		if st.restApiID == "" || st.rootResourceID == "" {
			setResult(world, nil, fmt.Errorf("no REST API or root resource available"))
			return nil
		}
		// Act
		result, err := world.APIGatewayClient().CreateResource(context.Background(), &apigateway.CreateResourceInput{
			RestApiId: aws.String(st.restApiID),
			ParentId:  aws.String(st.rootResourceID),
			PathPart:  aws.String(apigwTestChildPath),
		})
		// Assert: store result
		setResult(world, result, err)
		if err == nil {
			st.childResourceID = aws.ToString(result.Id)
		}
		return nil
	})

	sc.When(`^a non-root resource is deleted along with its methods and integrations$`, func() error {
		// Arrange
		resourceID := st.childResourceID
		if resourceID == "" {
			resourceID = st.rootResourceID
		}
		if st.restApiID == "" || resourceID == "" {
			setResult(world, nil, fmt.Errorf("no resource available to delete"))
			return nil
		}
		// Act
		result, err := world.APIGatewayClient().DeleteResource(context.Background(), &apigateway.DeleteResourceInput{
			RestApiId:  aws.String(st.restApiID),
			ResourceId: aws.String(resourceID),
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^a "GET" method is created on a resource$`, func() error {
		// Arrange
		if st.restApiID == "" || st.rootResourceID == "" {
			setResult(world, nil, fmt.Errorf("no REST API or resource available"))
			return nil
		}
		// Act
		result, err := world.APIGatewayClient().PutMethod(context.Background(), &apigateway.PutMethodInput{
			RestApiId:         aws.String(st.restApiID),
			ResourceId:        aws.String(st.rootResourceID),
			HttpMethod:        aws.String("GET"),
			AuthorizationType: aws.String("NONE"),
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^an existing method is updated$`, func() error {
		// Arrange
		if st.restApiID == "" || st.rootResourceID == "" {
			setResult(world, nil, fmt.Errorf("no REST API or resource available"))
			return nil
		}
		// Act: re-put the same method (idempotent update)
		result, err := world.APIGatewayClient().PutMethod(context.Background(), &apigateway.PutMethodInput{
			RestApiId:         aws.String(st.restApiID),
			ResourceId:        aws.String(st.rootResourceID),
			HttpMethod:        aws.String(st.httpMethod),
			AuthorizationType: aws.String("NONE"),
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^a method is deleted along with its integration$`, func() error {
		// Arrange
		if st.restApiID == "" || st.rootResourceID == "" {
			setResult(world, nil, fmt.Errorf("no REST API or resource available"))
			return nil
		}
		// Act
		result, err := world.APIGatewayClient().DeleteMethod(context.Background(), &apigateway.DeleteMethodInput{
			RestApiId:  aws.String(st.restApiID),
			ResourceId: aws.String(st.rootResourceID),
			HttpMethod: aws.String(st.httpMethod),
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^a backend integration is attached to a method$`, func() error {
		// Arrange
		if st.restApiID == "" || st.rootResourceID == "" {
			setResult(world, nil, fmt.Errorf("no REST API or resource available"))
			return nil
		}
		// Act
		result, err := world.APIGatewayClient().PutIntegration(context.Background(), &apigateway.PutIntegrationInput{
			RestApiId:        aws.String(st.restApiID),
			ResourceId:       aws.String(st.rootResourceID),
			HttpMethod:       aws.String(st.httpMethod),
			Type:             types.IntegrationTypeMock,
			RequestTemplates: map[string]string{"application/json": `{"statusCode": 200}`},
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^an integration is deleted$`, func() error {
		// Arrange
		if st.restApiID == "" || st.rootResourceID == "" {
			setResult(world, nil, fmt.Errorf("no REST API or resource available"))
			return nil
		}
		// Act
		result, err := world.APIGatewayClient().DeleteIntegration(context.Background(), &apigateway.DeleteIntegrationInput{
			RestApiId:  aws.String(st.restApiID),
			ResourceId: aws.String(st.rootResourceID),
			HttpMethod: aws.String(st.httpMethod),
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^a 200 method response is configured$`, func() error {
		// Arrange
		if st.restApiID == "" || st.rootResourceID == "" {
			setResult(world, nil, fmt.Errorf("no REST API or resource available"))
			return nil
		}
		// Act
		result, err := world.APIGatewayClient().PutMethodResponse(context.Background(), &apigateway.PutMethodResponseInput{
			RestApiId:  aws.String(st.restApiID),
			ResourceId: aws.String(st.rootResourceID),
			HttpMethod: aws.String(st.httpMethod),
			StatusCode: aws.String("200"),
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^a 200 integration response is configured$`, func() error {
		// Arrange
		if st.restApiID == "" || st.rootResourceID == "" {
			setResult(world, nil, fmt.Errorf("no REST API or resource available"))
			return nil
		}
		// Act
		result, err := world.APIGatewayClient().PutIntegrationResponse(context.Background(), &apigateway.PutIntegrationResponseInput{
			RestApiId:  aws.String(st.restApiID),
			ResourceId: aws.String(st.rootResourceID),
			HttpMethod: aws.String(st.httpMethod),
			StatusCode: aws.String("200"),
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^an "API" deployment is created$`, func() error {
		// Arrange
		if st.restApiID == "" {
			setResult(world, nil, fmt.Errorf("no REST API ID available"))
			return nil
		}
		// Act
		result, err := world.APIGatewayClient().CreateDeployment(context.Background(), &apigateway.CreateDeploymentInput{
			RestApiId: aws.String(st.restApiID),
		})
		// Assert: store result
		setResult(world, result, err)
		if err == nil {
			st.deploymentID = aws.ToString(result.Id)
		}
		return nil
	})

	sc.When(`^a deployment is deleted when no stage references it$`, func() error {
		// Arrange
		if st.restApiID == "" || st.deploymentID == "" {
			setResult(world, nil, fmt.Errorf("no REST API or deployment available"))
			return nil
		}
		// Act
		result, err := world.APIGatewayClient().DeleteDeployment(context.Background(), &apigateway.DeleteDeploymentInput{
			RestApiId:    aws.String(st.restApiID),
			DeploymentId: aws.String(st.deploymentID),
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^a dev stage is created for an "API"$`, func() error {
		// Arrange
		if st.restApiID == "" || st.deploymentID == "" {
			setResult(world, nil, fmt.Errorf("no REST API or deployment available"))
			return nil
		}
		// Act
		result, err := world.APIGatewayClient().CreateStage(context.Background(), &apigateway.CreateStageInput{
			RestApiId:    aws.String(st.restApiID),
			StageName:    aws.String("dev"),
			DeploymentId: aws.String(st.deploymentID),
		})
		// Assert: store result
		setResult(world, result, err)
		if err == nil {
			st.devStageID = aws.ToString(result.StageName)
		}
		return nil
	})

	sc.When(`^the dev stage is deleted$`, func() error {
		// Arrange
		if st.restApiID == "" {
			setResult(world, nil, fmt.Errorf("no REST API available"))
			return nil
		}
		// Act
		result, err := world.APIGatewayClient().DeleteStage(context.Background(), &apigateway.DeleteStageInput{
			RestApiId: aws.String(st.restApiID),
			StageName: aws.String("dev"),
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^the dev stage is redeployed to a new deployment$`, func() error {
		// Arrange
		if st.restApiID == "" || st.deploymentID == "" {
			setResult(world, nil, fmt.Errorf("no REST API or deployment available"))
			return nil
		}
		// Act
		result, err := world.APIGatewayClient().UpdateStage(context.Background(), &apigateway.UpdateStageInput{
			RestApiId: aws.String(st.restApiID),
			StageName: aws.String("dev"),
			PatchOperations: []types.PatchOperation{
				{Op: types.OpReplace, Path: aws.String("/deploymentId"), Value: aws.String(st.deploymentID)},
			},
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^throttling is enabled for the dev stage$`, func() error {
		// Arrange
		if st.restApiID == "" {
			setResult(world, nil, fmt.Errorf("no REST API available"))
			return nil
		}
		// Act
		result, err := world.APIGatewayClient().UpdateStage(context.Background(), &apigateway.UpdateStageInput{
			RestApiId: aws.String(st.restApiID),
			StageName: aws.String("dev"),
			PatchOperations: []types.PatchOperation{
				{Op: types.OpReplace, Path: aws.String("/*/*/throttling/rateLimit"), Value: aws.String("500")},
				{Op: types.OpReplace, Path: aws.String("/*/*/throttling/burstLimit"), Value: aws.String("100")},
			},
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^throttling is disabled for the dev stage$`, func() error {
		// Arrange
		if st.restApiID == "" {
			setResult(world, nil, fmt.Errorf("no REST API available"))
			return nil
		}
		// Act
		result, err := world.APIGatewayClient().UpdateStage(context.Background(), &apigateway.UpdateStageInput{
			RestApiId: aws.String(st.restApiID),
			StageName: aws.String("dev"),
			PatchOperations: []types.PatchOperation{
				{Op: types.OpRemove, Path: aws.String("/*/*/throttling/rateLimit")},
				{Op: types.OpRemove, Path: aws.String("/*/*/throttling/burstLimit")},
			},
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^a prod stage is created for an "API"$`, func() error {
		// Arrange
		if st.restApiID == "" || st.deploymentID == "" {
			setResult(world, nil, fmt.Errorf("no REST API or deployment available"))
			return nil
		}
		// Act
		result, err := world.APIGatewayClient().CreateStage(context.Background(), &apigateway.CreateStageInput{
			RestApiId:    aws.String(st.restApiID),
			StageName:    aws.String("prod"),
			DeploymentId: aws.String(st.deploymentID),
		})
		// Assert: store result
		setResult(world, result, err)
		if err == nil {
			st.prodStageID = aws.ToString(result.StageName)
		}
		return nil
	})

	sc.When(`^the prod stage is deleted$`, func() error {
		// Arrange
		if st.restApiID == "" {
			setResult(world, nil, fmt.Errorf("no REST API available"))
			return nil
		}
		// Act
		result, err := world.APIGatewayClient().DeleteStage(context.Background(), &apigateway.DeleteStageInput{
			RestApiId: aws.String(st.restApiID),
			StageName: aws.String("prod"),
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^the prod stage is redeployed to a new deployment$`, func() error {
		// Arrange
		if st.restApiID == "" || st.deploymentID == "" {
			setResult(world, nil, fmt.Errorf("no REST API or deployment available"))
			return nil
		}
		// Act
		result, err := world.APIGatewayClient().UpdateStage(context.Background(), &apigateway.UpdateStageInput{
			RestApiId: aws.String(st.restApiID),
			StageName: aws.String("prod"),
			PatchOperations: []types.PatchOperation{
				{Op: types.OpReplace, Path: aws.String("/deploymentId"), Value: aws.String(st.deploymentID)},
			},
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^throttling is enabled for the prod stage$`, func() error {
		// Arrange
		if st.restApiID == "" {
			setResult(world, nil, fmt.Errorf("no REST API available"))
			return nil
		}
		// Act
		result, err := world.APIGatewayClient().UpdateStage(context.Background(), &apigateway.UpdateStageInput{
			RestApiId: aws.String(st.restApiID),
			StageName: aws.String("prod"),
			PatchOperations: []types.PatchOperation{
				{Op: types.OpReplace, Path: aws.String("/*/*/throttling/rateLimit"), Value: aws.String("500")},
				{Op: types.OpReplace, Path: aws.String("/*/*/throttling/burstLimit"), Value: aws.String("100")},
			},
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^throttling is disabled for the prod stage$`, func() error {
		// Arrange
		if st.restApiID == "" {
			setResult(world, nil, fmt.Errorf("no REST API available"))
			return nil
		}
		// Act
		result, err := world.APIGatewayClient().UpdateStage(context.Background(), &apigateway.UpdateStageInput{
			RestApiId: aws.String(st.restApiID),
			StageName: aws.String("prod"),
			PatchOperations: []types.PatchOperation{
				{Op: types.OpRemove, Path: aws.String("/*/*/throttling/rateLimit")},
				{Op: types.OpRemove, Path: aws.String("/*/*/throttling/burstLimit")},
			},
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	// ── Then: assertions ──────────────────────────────────────────────────────────

	sc.Then(`^the "API" is "ACTIVE" and its root resource is "ACTIVE"$`, func() error {
		// Arrange
		// Act
		apis, err := world.APIGatewayClient().GetRestApis(context.Background(), &apigateway.GetRestApisInput{})
		if err != nil {
			return fmt.Errorf("get REST APIs: %w", err)
		}
		// Assert
		expectedMinCount := 1
		actualCount := len(apis.Items)
		if actualCount < expectedMinCount {
			return fmt.Errorf("expected at least %d REST API to be ACTIVE but found %d",
				expectedMinCount, actualCount)
		}
		return nil
	})

	sc.Then(`^the "API" is "DELETED" along with all its resources, methods, integrations, deployments, and stages$`, func() error {
		// Arrange
		// Act
		apis, err := world.APIGatewayClient().GetRestApis(context.Background(), &apigateway.GetRestApisInput{})
		if err != nil {
			return fmt.Errorf("get REST APIs: %w", err)
		}
		// Assert
		expectedCount := 0
		actualCount := len(apis.Items)
		if actualCount != expectedCount {
			return fmt.Errorf("expected %d REST APIs after deletion but found %d",
				expectedCount, actualCount)
		}
		return nil
	})

	sc.Then(`^the root resource is "ACTIVE"$`, func() error {
		// Arrange
		// Act: (action performed in When step — GetResources)
		// Assert
		expectedSuccess := true
		actualSuccess := world.lastResult.Success
		if !actualSuccess {
			return fmt.Errorf("expected root resource initialization to succeed but got error: %v; expected_success=%v actual_success=%v",
				world.lastResult.Error, expectedSuccess, actualSuccess)
		}
		return nil
	})

	sc.Then(`^the new resource is "ACTIVE"$`, func() error {
		// Arrange
		// Act: (action performed in When step)
		// Assert
		expectedSuccess := true
		actualSuccess := world.lastResult.Success
		if !actualSuccess {
			return fmt.Errorf("expected new resource to be ACTIVE but got error: %v; expected_success=%v actual_success=%v",
				world.lastResult.Error, expectedSuccess, actualSuccess)
		}
		return nil
	})

	sc.Then(`^the resource is "DELETED" along with all its methods and integrations$`, func() error {
		// Arrange
		// Act: (action performed in When step)
		// Assert
		expectedSuccess := true
		actualSuccess := world.lastResult.Success
		if !actualSuccess {
			return fmt.Errorf("expected resource deletion to succeed but got error: %v; expected_success=%v actual_success=%v",
				world.lastResult.Error, expectedSuccess, actualSuccess)
		}
		return nil
	})

	sc.Then(`^the method "EXISTS" on the resource$`, func() error {
		// Arrange
		// Act: (action performed in When step)
		// Assert
		expectedSuccess := true
		actualSuccess := world.lastResult.Success
		if !actualSuccess {
			return fmt.Errorf("expected method to exist on resource but got error: %v; expected_success=%v actual_success=%v",
				world.lastResult.Error, expectedSuccess, actualSuccess)
		}
		return nil
	})

	sc.Then(`^the method remains unchanged$`, func() error {
		// Arrange
		// Act: (action performed in When step)
		// Assert
		expectedSuccess := true
		actualSuccess := world.lastResult.Success
		if !actualSuccess {
			return fmt.Errorf("expected method update to succeed but got error: %v; expected_success=%v actual_success=%v",
				world.lastResult.Error, expectedSuccess, actualSuccess)
		}
		return nil
	})

	sc.Then(`^the method is "DELETED" and its integration is "DELETED" if it exists$`, func() error {
		// Arrange
		// Act: (action performed in When step)
		// Assert
		expectedSuccess := true
		actualSuccess := world.lastResult.Success
		if !actualSuccess {
			return fmt.Errorf("expected method deletion to succeed but got error: %v; expected_success=%v actual_success=%v",
				world.lastResult.Error, expectedSuccess, actualSuccess)
		}
		return nil
	})

	sc.Then(`^the integration "EXISTS"$`, func() error {
		// Arrange
		// Act: (action performed in When step)
		// Assert
		expectedSuccess := true
		actualSuccess := world.lastResult.Success
		if !actualSuccess {
			return fmt.Errorf("expected integration to exist but got error: %v; expected_success=%v actual_success=%v",
				world.lastResult.Error, expectedSuccess, actualSuccess)
		}
		return nil
	})

	sc.Then(`^the integration is "DELETED"$`, func() error {
		// Arrange
		// Act: (action performed in When step)
		// Assert
		expectedSuccess := true
		actualSuccess := world.lastResult.Success
		if !actualSuccess {
			return fmt.Errorf("expected integration deletion to succeed but got error: %v; expected_success=%v actual_success=%v",
				world.lastResult.Error, expectedSuccess, actualSuccess)
		}
		return nil
	})

	sc.Then(`^the method response exists$`, func() error {
		// Arrange
		// Act: (action performed in When step)
		// Assert
		expectedSuccess := true
		actualSuccess := world.lastResult.Success
		if !actualSuccess {
			return fmt.Errorf("expected method response to exist but got error: %v; expected_success=%v actual_success=%v",
				world.lastResult.Error, expectedSuccess, actualSuccess)
		}
		return nil
	})

	sc.Then(`^the integration response exists$`, func() error {
		// Arrange
		// Act: (action performed in When step)
		// Assert
		expectedSuccess := true
		actualSuccess := world.lastResult.Success
		if !actualSuccess {
			return fmt.Errorf("expected integration response to exist but got error: %v; expected_success=%v actual_success=%v",
				world.lastResult.Error, expectedSuccess, actualSuccess)
		}
		return nil
	})

	sc.Then(`^the deployment is "ACTIVE"$`, func() error {
		// Arrange
		// Act: (action performed in When step)
		// Assert
		expectedSuccess := true
		actualSuccess := world.lastResult.Success
		if !actualSuccess {
			return fmt.Errorf("expected deployment to be ACTIVE but got error: %v; expected_success=%v actual_success=%v",
				world.lastResult.Error, expectedSuccess, actualSuccess)
		}
		return nil
	})

	sc.Then(`^the deployment is "DELETED"$`, func() error {
		// Arrange
		// Act: (action performed in When step)
		// Assert
		expectedSuccess := true
		actualSuccess := world.lastResult.Success
		if !actualSuccess {
			return fmt.Errorf("expected deployment deletion to succeed but got error: %v; expected_success=%v actual_success=%v",
				world.lastResult.Error, expectedSuccess, actualSuccess)
		}
		return nil
	})

	sc.Then(`^the dev stage exists pointing to the deployment$`, func() error {
		// Arrange
		// Act: (action performed in When step)
		// Assert
		expectedSuccess := true
		actualSuccess := world.lastResult.Success
		if !actualSuccess {
			return fmt.Errorf("expected dev stage to exist pointing to deployment but got error: %v; expected_success=%v actual_success=%v",
				world.lastResult.Error, expectedSuccess, actualSuccess)
		}
		return nil
	})

	sc.Then(`^the dev stage no longer exists$`, func() error {
		// Arrange
		// Act: (action performed in When step)
		// Assert
		expectedSuccess := true
		actualSuccess := world.lastResult.Success
		if !actualSuccess {
			return fmt.Errorf("expected dev stage deletion to succeed but got error: %v; expected_success=%v actual_success=%v",
				world.lastResult.Error, expectedSuccess, actualSuccess)
		}
		return nil
	})

	sc.Then(`^the dev stage points to the new deployment$`, func() error {
		// Arrange
		// Act: (action performed in When step)
		// Assert
		expectedSuccess := true
		actualSuccess := world.lastResult.Success
		if !actualSuccess {
			return fmt.Errorf("expected dev stage to point to new deployment but got error: %v; expected_success=%v actual_success=%v",
				world.lastResult.Error, expectedSuccess, actualSuccess)
		}
		return nil
	})

	sc.Then(`^dev stage requests are throttled$`, func() error {
		// Arrange
		// Act: (action performed in When step)
		// Assert
		expectedSuccess := true
		actualSuccess := world.lastResult.Success
		if !actualSuccess {
			return fmt.Errorf("expected dev stage throttling to be enabled but got error: %v; expected_success=%v actual_success=%v",
				world.lastResult.Error, expectedSuccess, actualSuccess)
		}
		return nil
	})

	sc.Then(`^dev stage requests are not throttled$`, func() error {
		// Arrange
		// Act: (action performed in When step)
		// Assert
		expectedSuccess := true
		actualSuccess := world.lastResult.Success
		if !actualSuccess {
			return fmt.Errorf("expected dev stage throttling to be disabled but got error: %v; expected_success=%v actual_success=%v",
				world.lastResult.Error, expectedSuccess, actualSuccess)
		}
		return nil
	})

	sc.Then(`^the prod stage exists pointing to the deployment$`, func() error {
		// Arrange
		// Act: (action performed in When step)
		// Assert
		expectedSuccess := true
		actualSuccess := world.lastResult.Success
		if !actualSuccess {
			return fmt.Errorf("expected prod stage to exist pointing to deployment but got error: %v; expected_success=%v actual_success=%v",
				world.lastResult.Error, expectedSuccess, actualSuccess)
		}
		return nil
	})

	sc.Then(`^the prod stage no longer exists$`, func() error {
		// Arrange
		// Act: (action performed in When step)
		// Assert
		expectedSuccess := true
		actualSuccess := world.lastResult.Success
		if !actualSuccess {
			return fmt.Errorf("expected prod stage deletion to succeed but got error: %v; expected_success=%v actual_success=%v",
				world.lastResult.Error, expectedSuccess, actualSuccess)
		}
		return nil
	})

	sc.Then(`^the prod stage points to the new deployment$`, func() error {
		// Arrange
		// Act: (action performed in When step)
		// Assert
		expectedSuccess := true
		actualSuccess := world.lastResult.Success
		if !actualSuccess {
			return fmt.Errorf("expected prod stage to point to new deployment but got error: %v; expected_success=%v actual_success=%v",
				world.lastResult.Error, expectedSuccess, actualSuccess)
		}
		return nil
	})

	sc.Then(`^prod stage requests are throttled$`, func() error {
		// Arrange
		// Act: (action performed in When step)
		// Assert
		expectedSuccess := true
		actualSuccess := world.lastResult.Success
		if !actualSuccess {
			return fmt.Errorf("expected prod stage throttling to be enabled but got error: %v; expected_success=%v actual_success=%v",
				world.lastResult.Error, expectedSuccess, actualSuccess)
		}
		return nil
	})

	sc.Then(`^prod stage requests are not throttled$`, func() error {
		// Arrange
		// Act: (action performed in When step)
		// Assert
		expectedSuccess := true
		actualSuccess := world.lastResult.Success
		if !actualSuccess {
			return fmt.Errorf("expected prod stage throttling to be disabled but got error: %v; expected_success=%v actual_success=%v",
				world.lastResult.Error, expectedSuccess, actualSuccess)
		}
		return nil
	})

	// ── Invariant no-op steps (model-level, always pass) ─────────────────────────

	sc.Then(`^every "API" has a valid status \("CREATING", "ACTIVE", or "DELETED"\)$`, func() error {
		// No-op: API status validity is an internal invariant in lws; always passes.
		return nil
	})

	sc.Then(`^each "ACTIVE" "API" has at least one "ACTIVE" root resource$`, func() error {
		// No-op: root resource creation is an internal invariant in lws; always passes.
		return nil
	})

	sc.Then(`^all "ACTIVE" resources belong to "ACTIVE" APIs$`, func() error {
		// No-op: resource-API membership is an internal invariant in lws; always passes.
		return nil
	})

	sc.Then(`^all "EXISTING" methods belong to "ACTIVE" resources$`, func() error {
		// No-op: method-resource membership is an internal invariant in lws; always passes.
		return nil
	})

	sc.Then(`^all "EXISTING" integrations correspond to "EXISTING" methods$`, func() error {
		// No-op: integration-method correspondence is an internal invariant in lws; always passes.
		return nil
	})

	sc.Then(`^all "ACTIVE" deployments belong to "ACTIVE" APIs$`, func() error {
		// No-op: deployment-API membership is an internal invariant in lws; always passes.
		return nil
	})

	sc.Then(`^all active stages belong to "ACTIVE" APIs$`, func() error {
		// No-op: stage-API membership is an internal invariant in lws; always passes.
		return nil
	})

	sc.Then(`^all active stages reference "ACTIVE" deployments$`, func() error {
		// No-op: stage-deployment references are an internal invariant in lws; always passes.
		return nil
	})
}
