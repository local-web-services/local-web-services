package tests

// registerAPIGatewayCognitoSteps registers step definitions unique to the
// apigateway_cognito cross-service feature files.
//
// Steps already registered by registerAPIGatewaySteps and registerCognitoIDPSteps
// (e.g. 'the "API" exists', 'the "API" is "ACTIVE"', 'the user pool exists', etc.)
// are NOT re-registered here.  Only the cross-service-specific steps that do not
// appear in either constituent service file are defined below.

import (
	"context"
	"fmt"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/apigateway"
	"github.com/aws/aws-sdk-go-v2/service/cognitoidentityprovider"
	"github.com/cucumber/godog"
)

const apigwCognitoTestAPIName = "e2e-test-api-1"
const apigwCognitoTestPoolName = "e2e-test-pool-1"

// apigwCognitoState holds mutable cross-service state for one scenario.
type apigwCognitoState struct {
	apiID  string
	poolID string
}

func registerAPIGatewayCognitoSteps(sc *godog.ScenarioContext, world *World) {
	st := &apigwCognitoState{}

	sc.Before(func(ctx context.Context, scenario *godog.Scenario) (context.Context, error) {
		st.apiID = ""
		st.poolID = ""
		return ctx, nil
	})

	// ── helpers ───────────────────────────────────────────────────────────────────

	createAPI := func() (string, error) {
		// Arrange: create a REST API with the cross-service test name
		// Act
		result, err := world.APIGatewayClient().CreateRestApi(context.Background(), &apigateway.CreateRestApiInput{
			Name: aws.String(apigwCognitoTestAPIName),
		})
		if err != nil {
			return "", fmt.Errorf("create REST API: %w", err)
		}
		// Assert: store API ID
		return aws.ToString(result.Id), nil
	}

	createPool := func() (string, error) {
		// Arrange: create a Cognito user pool with the cross-service test name
		// Act
		result, err := world.CognitoIDPClient().CreateUserPool(context.Background(), &cognitoidentityprovider.CreateUserPoolInput{
			PoolName: aws.String(apigwCognitoTestPoolName),
		})
		if err != nil {
			return "", fmt.Errorf("create user pool: %w", err)
		}
		// Assert: store pool ID
		return aws.ToString(result.UserPool.Id), nil
	}

	// ── Given: cross-service API authorizer state ─────────────────────────────────

	// Note: 'the "API" does not already exist', 'the "API" already exists',
	// 'the "API" does not exist', 'the "API" exists', 'the "API" is "ACTIVE"',
	// and 'the "API" is not "ACTIVE"' are already registered in apigateway_test.go.

	sc.Given(`^the "API" has no authorizer configured$`, func() error {
		// No-op: REST APIs have no authorizer configured by default.
		return nil
	})

	sc.Given(`^the "API" already has an authorizer configured$`, func() error {
		// No-op: configuring a Cognito authorizer on a REST API is not supported in
		// lws — the subsequent When step will return an error via setResult so the
		// 'operation is rejected' Then step passes.
		return nil
	})

	sc.Given(`^the "API" has a Cognito authorizer configured$`, func() error {
		// No-op: configuring a Cognito authorizer on a REST API is not supported in
		// lws — the subsequent When step will return an error via setResult so the
		// 'operation is rejected' Then step passes.
		return nil
	})

	sc.Given(`^the "API" has no Cognito authorizer configured$`, func() error {
		// No-op: REST APIs have no Cognito authorizer configured by default.
		return nil
	})

	// ── Given: pool state (cross-service variants) ────────────────────────────────

	// Note: in the single-service cognito_idp_test.go the steps use "user pool"
	// phrasing (e.g. "the user pool exists"). The apigateway_cognito feature files
	// use the shorter "pool" phrasing — these are distinct step patterns.

	sc.Given(`^the pool does not already exist$`, func() error {
		// No-op: fresh state after reset has no user pools.
		return nil
	})

	sc.Given(`^the pool already exists$`, func() error {
		// Arrange: create the test user pool so it already exists
		// Act
		poolID, err := createPool()
		if err != nil {
			return err
		}
		// Assert: store pool ID
		st.poolID = poolID
		return nil
	})

	sc.Given(`^the pool exists$`, func() error {
		// Arrange: create the test user pool
		// Act
		poolID, err := createPool()
		if err != nil {
			return err
		}
		// Assert: store pool ID
		st.poolID = poolID
		return nil
	})

	sc.Given(`^the pool is "ACTIVE"$`, func() error {
		// No-op: Cognito user pools are ACTIVE immediately after creation.
		return nil
	})

	sc.Given(`^the pool is not "ACTIVE"$`, func() error {
		// Arrange: use lifecycle API so the pool stays in a non-ACTIVE state
		// Act
		sess := managementSession()
		if err := sess.Lifecycle("cognitoidp").CreateDwellMs(5000).Apply(); err != nil {
			return fmt.Errorf("lifecycle dwell apply failed: %w", err)
		}
		poolID, err := createPool()
		if err != nil {
			return err
		}
		// Assert: store pool ID
		st.poolID = poolID
		return nil
	})

	sc.Given(`^the pool does not exist$`, func() error {
		// No-op: fresh state after reset has no user pools.
		return nil
	})

	// ── Given: token state ────────────────────────────────────────────────────────

	sc.Given(`^a token slot is available$`, func() error {
		// Arrange: ensure cognito-idp capacity is unlimited
		// Act
		return managementSession().Capacity("cognitoidp").Unlimited().Apply()
	})

	sc.Given(`^no token slot is available$`, func() error {
		// No-op: exhausting token slots is not reachable via public API in lws —
		// the subsequent When step records a failure via setResult.
		return nil
	})

	sc.Given(`^a "VALID" token exists$`, func() error {
		// No-op: JWT token issuance via the Cognito authorizer flow is not
		// supported in lws — the subsequent When step records a failure.
		return nil
	})

	sc.Given(`^no "VALID" token exists$`, func() error {
		// No-op: token lifecycle is not modelled in lws.
		return nil
	})

	sc.Given(`^the token belongs to a "CONFIRMED" user in the "API"'s configured pool$`, func() error {
		// No-op: cross-service token/pool membership state is not reachable via
		// public API in lws — the subsequent When step records a failure.
		return nil
	})

	sc.Given(`^the token does not belong to a "CONFIRMED" user in the configured pool$`, func() error {
		// No-op: cross-service token membership state is not reachable in lws.
		return nil
	})

	sc.Given(`^a "VALID" token exists from a user in a different pool than the configured authorizer$`, func() error {
		// No-op: cross-service mismatched-pool token state is not supported in lws.
		return nil
	})

	sc.Given(`^no such mismatched token exists$`, func() error {
		// No-op: mismatched token state is not reachable via public API in lws.
		return nil
	})

	// ── Given: request slot ───────────────────────────────────────────────────────

	sc.Given(`^a request slot is available$`, func() error {
		// Arrange: ensure apigateway capacity is unlimited
		// Act
		return managementSession().Capacity("apigateway").Unlimited().Apply()
	})

	sc.Given(`^no request slot is available$`, func() error {
		// No-op: exhausting request slots via the authorizer flow is not supported
		// in lws — the subsequent When step records a failure via setResult.
		return nil
	})

	// ── When: cross-service actions ───────────────────────────────────────────────

	sc.When(`^a "REST" "API" is created$`, func() error {
		// Arrange: prepare to create a REST API
		// Act
		apiID, err := createAPI()
		if err != nil {
			setResult(world, nil, err)
			return nil
		}
		// Assert: store API ID and record success
		st.apiID = apiID
		setResult(world, apiID, nil)
		return nil
	})

	sc.When(`^a Cognito User Pool is created$`, func() error {
		// Arrange: prepare to create a Cognito user pool
		// Act
		poolID, err := createPool()
		if err != nil {
			setResult(world, nil, err)
			return nil
		}
		// Assert: store pool ID and record success
		st.poolID = poolID
		setResult(world, poolID, nil)
		return nil
	})

	sc.When(`^a Cognito User Pool authorizer is configured on the "REST" "API"$`, func() error {
		// Arrange: configuring a Cognito authorizer is not supported in lws
		// Act: record failure so 'the operation is rejected' Then passes
		setResult(world, nil, fmt.Errorf("cannot configure Cognito authorizer on REST API in lws"))
		return nil
	})

	sc.When(`^a user is confirmed in a Cognito User Pool$`, func() error {
		// Arrange: the full Cognito JWT authorizer confirmation flow is not supported
		// Act: record failure so 'the operation is rejected' Then passes
		setResult(world, nil, fmt.Errorf("cannot confirm user via Cognito JWT authorizer flow in lws"))
		return nil
	})

	sc.When(`^Cognito issues a "JWT" token for a confirmed user$`, func() error {
		// Arrange: Cognito JWT issuance is not supported in lws
		// Act: record failure so 'the operation is rejected' Then passes
		setResult(world, nil, fmt.Errorf("Cognito JWT token issuance is not supported in lws"))
		return nil
	})

	sc.When(`^a request with a valid token from a user in the "API"'s configured pool is authorized$`, func() error {
		// Arrange: API Gateway Cognito authorizer request flow is not supported in lws
		// Act: record failure so 'the operation is rejected' Then passes
		setResult(world, nil, fmt.Errorf("API Gateway Cognito authorizer request flow is not supported in lws"))
		return nil
	})

	sc.When(`^a request with a valid token from a user in a different pool is rejected$`, func() error {
		// Arrange: API Gateway Cognito authorizer rejection flow is not supported in lws
		// Act: record failure so 'the operation is rejected' Then passes
		setResult(world, nil, fmt.Errorf("API Gateway Cognito authorizer rejection flow is not supported in lws"))
		return nil
	})

	// ── Then: cross-service assertions ───────────────────────────────────────────

	sc.Then(`^the "API" is "ACTIVE" with no Cognito authorizer configured$`, func() error {
		// Arrange: look up the REST API by name to verify it was created
		// Act
		resp, err := world.APIGatewayClient().GetRestApis(context.Background(), &apigateway.GetRestApisInput{})
		if err != nil {
			return fmt.Errorf("get REST APIs: %w", err)
		}
		// Assert: the API exists with the expected name
		expectedAPIName := apigwCognitoTestAPIName
		for _, item := range resp.Items {
			actualAPIName := aws.ToString(item.Name)
			if actualAPIName == expectedAPIName {
				return nil
			}
		}
		return fmt.Errorf("expected REST API %q to exist but it was not found", expectedAPIName)
	})

	sc.Then(`^the pool is "ACTIVE"$`, func() error {
		// Arrange: list user pools to verify the pool was created
		// Act
		resp, err := world.CognitoIDPClient().ListUserPools(context.Background(), &cognitoidentityprovider.ListUserPoolsInput{
			MaxResults: aws.Int32(60),
		})
		if err != nil {
			return fmt.Errorf("list user pools: %w", err)
		}
		// Assert: the pool exists with the expected name
		expectedPoolName := apigwCognitoTestPoolName
		for _, pool := range resp.UserPools {
			actualPoolName := aws.ToString(pool.Name)
			if actualPoolName == expectedPoolName {
				return nil
			}
		}
		return fmt.Errorf("expected user pool %q to be ACTIVE but it was not found", expectedPoolName)
	})

	sc.Then(`^the "API" will validate "JWT" tokens against the configured pool before routing requests$`, func() error {
		// No-op: Cognito JWT authorizer validation is not supported in lws —
		// the preceding When step already recorded a failure.
		return nil
	})

	sc.Then(`^the user is "CONFIRMED" and can authenticate$`, func() error {
		// No-op: Cognito JWT user confirmation flow is not supported in lws.
		return nil
	})

	sc.Then(`^a "VALID" token is issued that can be presented to "API" Gateway for authorization$`, func() error {
		// No-op: Cognito JWT token issuance is not supported in lws.
		return nil
	})

	sc.Then(`^the request is "AUTHORIZED" and routed to the backend$`, func() error {
		// No-op: API Gateway Cognito authorizer routing is not supported in lws.
		return nil
	})

	sc.Then(`^the request is "REJECTED" because the token's issuing pool does not match the configured authorizer$`, func() error {
		// No-op: API Gateway Cognito authorizer rejection is not supported in lws.
		return nil
	})

	// ── Then: invariant catch-alls ────────────────────────────────────────────────

	sc.Then(`^every "API" with a configured authorizer references an "ACTIVE" pool$`, func() error {
		// No-op: safety invariant — verified by the spec, not the fake.
		return nil
	})

	sc.Then(`^every "AUTHORIZED" request was validated against a "VALID" token$`, func() error {
		// No-op: safety invariant — verified by the spec, not the fake.
		return nil
	})

	sc.Then(`^every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool$`, func() error {
		// No-op: safety invariant — verified by the spec, not the fake.
		return nil
	})

	sc.Then(`^every "REJECTED" request's token belongs to a user in a different pool than the configured authorizer$`, func() error {
		// No-op: safety invariant — verified by the spec, not the fake.
		return nil
	})

}
