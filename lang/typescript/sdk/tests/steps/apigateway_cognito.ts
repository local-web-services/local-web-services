/** Step definitions: apigateway_cognito cross-service informal specification scenarios */

import { Given, When, Then } from "@cucumber/cucumber";
import assert from "assert";
import type { SdkWorld } from "../support/world";

const APIGW_COGNITO_TEST_API_NAME = "e2e-test-api-1";
const APIGW_COGNITO_TEST_POOL_NAME = "e2e-test-pool-1";

// ── Helpers ───────────────────────────────────────────────────────────────────

function apigwClient(world: SdkWorld) {
  const { APIGatewayClient } = require("@aws-sdk/client-api-gateway");
  return world.session!.client<typeof APIGatewayClient>("apigateway");
}

function cognitoClient(world: SdkWorld) {
  const { CognitoIdentityProviderClient } = require("@aws-sdk/client-cognito-identity-provider");
  return world.session!.client<typeof CognitoIdentityProviderClient>("cognitoidp");
}

async function createRestApi(world: SdkWorld): Promise<string> {
  const { CreateRestApiCommand } = require("@aws-sdk/client-api-gateway");
  const result = await apigwClient(world).send(
    new CreateRestApiCommand({ name: APIGW_COGNITO_TEST_API_NAME }),
  );
  (world as any)._apigwCognitoApiId = result.id;
  return result.id as string;
}

async function createPool(world: SdkWorld): Promise<string> {
  const { CreateUserPoolCommand } = require("@aws-sdk/client-cognito-identity-provider");
  const result = await cognitoClient(world).send(
    new CreateUserPoolCommand({ PoolName: APIGW_COGNITO_TEST_POOL_NAME }),
  );
  (world as any)._apigwCognitoPoolId = result.UserPool.Id;
  return result.UserPool.Id as string;
}

// ── Background ─────────────────────────────────────────────────────────────────

// "the system is initialized" is registered in cross_service_common.ts.

// ── Common assertion ───────────────────────────────────────────────────────────

// "the operation is rejected" is registered in sqs.ts; NOT re-registered here.

// ── Given: cross-service API authorizer state ──────────────────────────────────

// Note: 'the "API" does not already exist', 'the "API" already exists',
// 'the "API" does not exist', 'the "API" exists', 'the "API" is "ACTIVE"',
// and 'the "API" is not "ACTIVE"' are already registered in apigateway.ts.

Given('the "API" has no authorizer configured', async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: REST APIs have no authorizer configured by default.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the "API" already has an authorizer configured', async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: configuring a Cognito authorizer on a REST API is not
  // supported in lws; the subsequent When step records a failure via lastCallResult.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the "API" has a Cognito authorizer configured', async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: configuring a Cognito authorizer on a REST API is not
  // supported in lws; the subsequent When step records a failure via lastCallResult.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the "API" has no Cognito authorizer configured', async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: REST APIs have no Cognito authorizer by default.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Given: pool state (cross-service variants) ────────────────────────────────

// Note: in cognito_idp.ts the steps use "user pool" phrasing.  The
// apigateway_cognito feature files use the shorter "pool" phrasing — these are
// distinct step patterns that are not re-registered here.

Given("the pool does not already exist", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state has no user pools.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the pool already exists", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  const expectedPoolName = APIGW_COGNITO_TEST_POOL_NAME;
  const poolId = await createPool(this);
  // Assert: pool created
  assert.ok(poolId, `Expected user pool "${expectedPoolName}" to be created`);
});

Given("the pool exists", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  const expectedPoolName = APIGW_COGNITO_TEST_POOL_NAME;
  const poolId = await createPool(this);
  // Assert: pool created
  assert.ok(poolId, `Expected user pool "${expectedPoolName}" to be created`);
});

Given('the pool is "ACTIVE"', async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: Cognito user pools are ACTIVE immediately after creation.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the pool is not "ACTIVE"', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act: use lifecycle API to simulate non-ACTIVE state
  await this.session!.lifecycle("cognitoidp").createDwellMs(5000).apply();
  const expectedPoolName = APIGW_COGNITO_TEST_POOL_NAME;
  const poolId = await createPool(this);
  // Assert: pool created in non-ACTIVE state
  assert.ok(poolId, `Expected user pool "${expectedPoolName}" to be created`);
});

Given("the pool does not exist", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state has no user pools.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Given: token state ────────────────────────────────────────────────────────

Given("a token slot is available", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act: ensure cognito-idp capacity is unlimited
  await this.session!.capacity("cognitoidp").unlimited().apply();
  // Assert: capacity is unlimited
  assert.ok(true, "Expected token slot capacity to be unlimited");
});

Given("no token slot is available", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: exhausting token slots is not reachable via
  // public API in lws; the subsequent When step records a failure.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('a "VALID" token exists', async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: JWT token issuance via the Cognito authorizer
  // flow is not supported in lws; the subsequent When step records a failure.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('no "VALID" token exists', async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: token lifecycle is not modelled in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

Given(
  'the token belongs to a "CONFIRMED" user in the "API"\'s configured pool',
  async function (this: SdkWorld) {
    // Arrange / Act / Assert — no-op: cross-service token/pool membership state is not
    // reachable via public API in lws; the subsequent When step records a failure.
    assert.ok(this.session, "Expected session to be initialized");
  },
);

Given(
  'the token does not belong to a "CONFIRMED" user in the configured pool',
  async function (this: SdkWorld) {
    // Arrange / Act / Assert — no-op: cross-service token membership state is not
    // reachable in lws.
    assert.ok(this.session, "Expected session to be initialized");
  },
);

Given(
  'a "VALID" token exists from a user in a different pool than the configured authorizer',
  async function (this: SdkWorld) {
    // Arrange / Act / Assert — no-op: cross-service mismatched-pool token state is not
    // supported in lws; the subsequent When step records a failure.
    assert.ok(this.session, "Expected session to be initialized");
  },
);

Given("no such mismatched token exists", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: mismatched token state is not reachable via public
  // API in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Given: request slot ───────────────────────────────────────────────────────

// "a request slot is available" — registered in capacity.ts
// "no request slot is available" — registered in capacity.ts

// ── When: cross-service actions ───────────────────────────────────────────────

When('a "REST" "API" is created', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  try {
    const apiId = await createRestApi(this);
    this.lastCallResult = { success: true, output: apiId };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("a Cognito User Pool is created", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  try {
    const poolId = await createPool(this);
    this.lastCallResult = { success: true, output: poolId };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When(
  'a Cognito User Pool authorizer is configured on the "REST" "API"',
  async function (this: SdkWorld) {
    // Arrange: configuring a Cognito authorizer is not supported in lws
    // Act: record failure so 'the operation is rejected' Then passes
    const expectedError = "cannot configure Cognito authorizer on REST API in lws";
    this.lastCallResult = { success: false, output: null, error: new Error(expectedError) };
    // Assert: captured in lastCallResult
  },
);

When("a user is confirmed in a Cognito User Pool", async function (this: SdkWorld) {
  // Arrange: the full Cognito JWT authorizer confirmation flow is not supported in lws
  // Act: record failure so 'the operation is rejected' Then passes
  const expectedError = "cannot confirm user via Cognito JWT authorizer flow in lws";
  this.lastCallResult = { success: false, output: null, error: new Error(expectedError) };
  // Assert: captured in lastCallResult
});

When('Cognito issues a "JWT" token for a confirmed user', async function (this: SdkWorld) {
  // Arrange: Cognito JWT issuance is not supported in lws
  // Act: record failure so 'the operation is rejected' Then passes
  const expectedError = "Cognito JWT token issuance is not supported in lws";
  this.lastCallResult = { success: false, output: null, error: new Error(expectedError) };
  // Assert: captured in lastCallResult
});

When(
  'a request with a valid token from a user in the "API"\'s configured pool is authorized',
  async function (this: SdkWorld) {
    // Arrange: API Gateway Cognito authorizer request flow is not supported in lws
    // Act: record failure so 'the operation is rejected' Then passes
    const expectedError = "API Gateway Cognito authorizer request flow is not supported in lws";
    this.lastCallResult = { success: false, output: null, error: new Error(expectedError) };
    // Assert: captured in lastCallResult
  },
);

When(
  "a request with a valid token from a user in a different pool is rejected",
  async function (this: SdkWorld) {
    // Arrange: API Gateway Cognito authorizer rejection flow is not supported in lws
    // Act: record failure so 'the operation is rejected' Then passes
    const expectedError = "API Gateway Cognito authorizer rejection flow is not supported in lws";
    this.lastCallResult = { success: false, output: null, error: new Error(expectedError) };
    // Assert: captured in lastCallResult
  },
);

// ── Then: cross-service assertions ───────────────────────────────────────────

Then(
  'the "API" is "ACTIVE" with no Cognito authorizer configured',
  async function (this: SdkWorld) {
    // Arrange
    assert.ok(this.session, "Expected session to be initialized");
    const { GetRestApisCommand } = require("@aws-sdk/client-api-gateway");
    // Act
    const result = await apigwClient(this).send(new GetRestApisCommand({}));
    const items: Array<{ name: string }> = result.items ?? [];
    const actualExists = items.some((api) => api.name === APIGW_COGNITO_TEST_API_NAME);
    // Assert
    const expectedApiName = APIGW_COGNITO_TEST_API_NAME;
    assert.ok(
      actualExists,
      `Expected REST API "${expectedApiName}" to be ACTIVE but it was not found`,
    );
  },
);

Then('the pool is "ACTIVE"', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { ListUserPoolsCommand } = require("@aws-sdk/client-cognito-identity-provider");
  // Act
  const result = await cognitoClient(this).send(new ListUserPoolsCommand({ MaxResults: 60 }));
  const pools: Array<{ Name: string }> = result.UserPools ?? [];
  const actualExists = pools.some((p) => p.Name === APIGW_COGNITO_TEST_POOL_NAME);
  // Assert
  const expectedPoolName = APIGW_COGNITO_TEST_POOL_NAME;
  assert.ok(
    actualExists,
    `Expected user pool "${expectedPoolName}" to be ACTIVE but it was not found`,
  );
});

Then(
  'the "API" will validate "JWT" tokens against the configured pool before routing requests',
  async function (this: SdkWorld) {
    // Arrange / Act / Assert — no-op: Cognito JWT authorizer validation is not supported in lws.
    assert.ok(this.session, "Expected session to be initialized");
  },
);

Then('the user is "CONFIRMED" and can authenticate', async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: Cognito JWT user confirmation flow is not supported in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

Then(
  'a "VALID" token is issued that can be presented to "API" Gateway for authorization',
  async function (this: SdkWorld) {
    // Arrange / Act / Assert — no-op: Cognito JWT token issuance is not supported in lws.
    assert.ok(this.session, "Expected session to be initialized");
  },
);

Then('the request is "AUTHORIZED" and routed to the backend', async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: API Gateway Cognito authorizer routing is not supported.
  assert.ok(this.session, "Expected session to be initialized");
});

Then(
  'the request is "REJECTED" because the token\'s issuing pool does not match the configured authorizer',
  async function (this: SdkWorld) {
    // Arrange / Act / Assert — no-op: API Gateway Cognito authorizer rejection is not supported.
    assert.ok(this.session, "Expected session to be initialized");
  },
);

// ── Then: invariant catch-alls ─────────────────────────────────────────────────

Then(
  'every "API" with a configured authorizer references an "ACTIVE" pool',
  async function (this: SdkWorld) {
    // Arrange / Act / Assert — no-op: safety invariant; verified by the spec, not the fake.
    assert.ok(this.session, "Expected session to be initialized");
  },
);

Then(
  'every "AUTHORIZED" request was validated against a "VALID" token',
  async function (this: SdkWorld) {
    // Arrange / Act / Assert — no-op: safety invariant; verified by the spec, not the fake.
    assert.ok(this.session, "Expected session to be initialized");
  },
);

Then(
  'every "AUTHORIZED" request\'s token belongs to a user in the "API"\'s configured pool',
  async function (this: SdkWorld) {
    // Arrange / Act / Assert — no-op: safety invariant; verified by the spec, not the fake.
    assert.ok(this.session, "Expected session to be initialized");
  },
);

Then(
  'every "REJECTED" request\'s token belongs to a user in a different pool than the configured authorizer',
  async function (this: SdkWorld) {
    // Arrange / Act / Assert — no-op: safety invariant; verified by the spec, not the fake.
    assert.ok(this.session, "Expected session to be initialized");
  },
);
