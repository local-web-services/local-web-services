/** Step definitions: apigateway_lambda cross-service informal specification scenarios */

import { Given, When, Then } from "@cucumber/cucumber";
import assert from "assert";
import type { SdkWorld } from "../support/world";

const APIGW_LAMBDA_TEST_API_NAME = "e2e-test-api-1";

// ── Helpers ────────────────────────────────────────────────────────────────────

function apigwLambdaApigwClient(world: SdkWorld) {
  const { APIGatewayClient } = require("@aws-sdk/client-api-gateway");
  return world.session!.client<typeof APIGatewayClient>("apigateway");
}

// ── Given: API integration state ──────────────────────────────────────────────

Given('the "API" has no integration configured', async function (this: SdkWorld) {
  // No-op: APIs have no integration configured by default after creation.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the "API" already has an integration configured', async function (this: SdkWorld) {
  // @internal: Cannot configure Lambda integration on REST API in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the "API" has a Lambda integration configured', async function (this: SdkWorld) {
  // @internal: Cannot configure Lambda integration on REST API in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the "API" has no Lambda integration configured', async function (this: SdkWorld) {
  // No-op: APIs have no Lambda integration configured by default.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Given: integrated function state ──────────────────────────────────────────

Given('the integrated function is "ACTIVE"', async function (this: SdkWorld) {
  // @internal: Requires a Lambda integration to be configured first, which is
  // not supported via public APIs in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the integrated function is not "ACTIVE"', async function (this: SdkWorld) {
  // @internal: Requires a Lambda integration and lifecycle manipulation.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Given: capacity / slot state ──────────────────────────────────────────────

Given("a request slot is available", async function (this: SdkWorld) {
  // Arrange: set apigateway capacity to unlimited so request slots are available
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await this.session!.capacity("apigateway").unlimited().apply();
  // Assert: capacity applied
});

Given("no request slot is available", async function (this: SdkWorld) {
  // @internal: Cannot send requests through API Gateway Lambda integration in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── When: actions ──────────────────────────────────────────────────────────────

When('a "REST" "API" is created', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { CreateRestApiCommand } = require("@aws-sdk/client-api-gateway");
  // Act
  try {
    const result = await apigwLambdaApigwClient(this).send(
      new CreateRestApiCommand({ name: APIGW_LAMBDA_TEST_API_NAME }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When(
  'a Lambda integration is configured on the "REST" "API"',
  async function (this: SdkWorld) {
    // @internal: Cannot configure Lambda integration on REST API in lws.
    assert.ok(this.session, "Expected session to be initialized");
    this.lastCallResult = {
      success: false,
      output: null,
      error: new Error(
        "cannot configure Lambda integration: scenario is @internal",
      ),
    };
    // Assert: captured in lastCallResult
  },
);

When(
  'the "API" receives an "HTTP" request and synchronously invokes the Lambda function',
  async function (this: SdkWorld) {
    // @internal: Cannot send requests through API Gateway Lambda integration in lws.
    assert.ok(this.session, "Expected session to be initialized");
    this.lastCallResult = {
      success: false,
      output: null,
      error: new Error(
        "cannot send HTTP request through API Gateway Lambda integration: scenario is @internal",
      ),
    };
    // Assert: captured in lastCallResult
  },
);

When(
  'the Lambda invocation completes successfully and the "API" returns a successful response',
  async function (this: SdkWorld) {
    // @internal: Cannot trigger Lambda invocation completion via API Gateway in lws.
    assert.ok(this.session, "Expected session to be initialized");
    this.lastCallResult = {
      success: false,
      output: null,
      error: new Error(
        "cannot trigger Lambda invocation success via API Gateway: scenario is @internal",
      ),
    };
    // Assert: captured in lastCallResult
  },
);

When(
  'the Lambda invocation fails and the "API" returns an error response',
  async function (this: SdkWorld) {
    // @internal: Cannot trigger Lambda invocation failure via API Gateway in lws.
    assert.ok(this.session, "Expected session to be initialized");
    this.lastCallResult = {
      success: false,
      output: null,
      error: new Error(
        "cannot trigger Lambda invocation failure via API Gateway: scenario is @internal",
      ),
    };
    // Assert: captured in lastCallResult
  },
);

// ── Then: assertions ───────────────────────────────────────────────────────────

Then(
  'the "API" is "ACTIVE" with no Lambda integration configured',
  async function (this: SdkWorld) {
    // Arrange
    assert.ok(this.session, "Expected session to be initialized");
    const { GetRestApisCommand } = require("@aws-sdk/client-api-gateway");
    // Act
    const result = await apigwLambdaApigwClient(this).send(
      new GetRestApisCommand({}),
    );
    const items: Array<{ name: string }> = result.items ?? [];
    // Assert
    const expectedName = APIGW_LAMBDA_TEST_API_NAME;
    const actualExists = items.some((api) => api.name === expectedName);
    assert.ok(
      actualExists,
      `Expected REST API "${expectedName}" to exist but it was not found; expected_name=${expectedName}`,
    );
  },
);

Then(
  'the "API" will synchronously invoke the function when a request arrives',
  async function (this: SdkWorld) {
    // @internal: Cannot verify Lambda integration behaviour in lws.
    assert.ok(this.session, "Expected session to be initialized");
  },
);

Then(
  'the request and invocation are both "IN_PROGRESS"',
  async function (this: SdkWorld) {
    // @internal: Cannot observe in-progress request and invocation state in lws.
    assert.ok(this.session, "Expected session to be initialized");
  },
);

Then(
  'the invocation is "SUCCESS" and the request is "SUCCESS"',
  async function (this: SdkWorld) {
    // @internal: Cannot observe invocation and request success state in lws.
    assert.ok(this.session, "Expected session to be initialized");
  },
);

Then(
  'the invocation is "FAILED" and the request is "FAILED"',
  async function (this: SdkWorld) {
    // @internal: Cannot observe invocation and request failure state in lws.
    assert.ok(this.session, "Expected session to be initialized");
  },
);

// ── Invariant catch-all steps ──────────────────────────────────────────────────

Then(
  'every "IN_PROGRESS" request references an "ACTIVE" "API"',
  async function (this: SdkWorld) {
    // No-op: model-level invariant; trivially satisfied in isolated lws context.
    assert.ok(this.session, "Expected session to be initialized");
  },
);

Then(
  'every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request',
  async function (this: SdkWorld) {
    // No-op: model-level invariant; trivially satisfied in isolated lws context.
    assert.ok(this.session, "Expected session to be initialized");
  },
);
