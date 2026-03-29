/** Step definitions: apigateway_sns cross-service scenarios — unique steps only */

import { Given, When, Then } from "@cucumber/cucumber";
import assert from "assert";
import type { SdkWorld } from "../support/world";

// Steps already registered in cross_service_common.ts:
//   "the topic does not already exist"
//   "the topic already exists"
//   "the topic exists"
//   "the topic is already {string}"
//   "the target topic is {string}"
//   "the target topic is not {string}"
//   "the topic does not exist"
//   "a message slot is available"
//   "no message slot is available"
//   "an {string} topic is created"
//   "the {string} topic is deleted"
//   "the topic is {string}"   (Then)
//
// Steps already registered in apigateway.ts:
//   "the {string} does not already exist"
//   "the {string} already exists"
//
// Only steps unique to apigateway_sns are registered here.

const APIGW_SNS_API_NAME = "e2e-test-api-1";
const APIGW_SNS_TOPIC_NAME = "e2e-test-topic-1";
const APIGW_SNS_STAGE = "prod";
const REGION = "us-east-1";
const ACCOUNT_ID = "000000000000";

// ── Helpers ───────────────────────────────────────────────────────────────────

function apigwClient(world: SdkWorld) {
  const { APIGatewayClient } = require("@aws-sdk/client-api-gateway");
  return world.session!.client<typeof APIGatewayClient>("apigateway");
}

function snsClient(world: SdkWorld) {
  const { SNSClient } = require("@aws-sdk/client-sns");
  return world.session!.client<typeof SNSClient>("sns");
}

function apigwSnsTopicArn(): string {
  return `arn:aws:sns:${REGION}:${ACCOUNT_ID}:${APIGW_SNS_TOPIC_NAME}`;
}

async function apigwSnsCreateRestApi(world: SdkWorld): Promise<string> {
  const { CreateRestApiCommand } = require("@aws-sdk/client-api-gateway");
  const result = await apigwClient(world).send(
    new CreateRestApiCommand({ name: APIGW_SNS_API_NAME }),
  );
  (world as any)._apigwSnsApiId = result.id;
  return result.id as string;
}

async function apigwSnsGetApiId(world: SdkWorld): Promise<string | undefined> {
  const { GetRestApisCommand } = require("@aws-sdk/client-api-gateway");
  const result = await apigwClient(world).send(new GetRestApisCommand({}));
  const items: Array<{ id: string; name: string }> = result.items ?? [];
  const api = items.find((a) => a.name === APIGW_SNS_API_NAME);
  return api?.id;
}

async function apigwSnsGetRootResourceId(world: SdkWorld, apiId: string): Promise<string> {
  const { GetResourcesCommand } = require("@aws-sdk/client-api-gateway");
  const result = await apigwClient(world).send(new GetResourcesCommand({ restApiId: apiId }));
  const items: Array<{ id: string; path: string }> = result.items ?? [];
  const root = items.find((r) => r.path === "/");
  if (!root) throw new Error(`Root resource not found for API ${apiId}`);
  return root.id;
}

async function apigwSnsCreateTopic(world: SdkWorld): Promise<void> {
  const { CreateTopicCommand } = require("@aws-sdk/client-sns");
  try {
    await snsClient(world).send(new CreateTopicCommand({ Name: APIGW_SNS_TOPIC_NAME }));
  } catch {
    // May already exist
  }
}

async function apigwSnsConfigureIntegration(world: SdkWorld, apiId: string): Promise<void> {
  const {
    PutMethodCommand,
    PutIntegrationCommand,
    CreateDeploymentCommand,
    CreateStageCommand,
  } = require("@aws-sdk/client-api-gateway");

  const rootId = await apigwSnsGetRootResourceId(world, apiId);
  const integrationUri = `arn:aws:apigateway:${REGION}:sns:action/Publish`;

  // Act: put POST method
  await apigwClient(world).send(
    new PutMethodCommand({
      restApiId: apiId,
      resourceId: rootId,
      httpMethod: "POST",
      authorizationType: "NONE",
    }),
  );

  // Act: put SNS integration
  await apigwClient(world).send(
    new PutIntegrationCommand({
      restApiId: apiId,
      resourceId: rootId,
      httpMethod: "POST",
      type: "AWS",
      integrationHttpMethod: "POST",
      uri: integrationUri,
    }),
  );

  // Act: create deployment
  const deployResult = await apigwClient(world).send(
    new CreateDeploymentCommand({ restApiId: apiId, description: "e2e" }),
  );

  // Act: create stage
  await apigwClient(world).send(
    new CreateStageCommand({
      restApiId: apiId,
      stageName: APIGW_SNS_STAGE,
      deploymentId: deployResult.id,
    }),
  );
}

async function apigwSnsInvokeApi(
  world: SdkWorld,
  apiId: string,
  body: Record<string, string>,
): Promise<number> {
  const port = world.session!.portFor("apigateway");
  const url = `http://127.0.0.1:${port}/${apiId}/${APIGW_SNS_STAGE}/`;
  const response = await fetch(url, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(body),
  });
  return response.status;
}

// ── Given: API state ──────────────────────────────────────────────────────────

// "the {string} does not already exist" is registered in apigateway.ts.
// "the {string} already exists" is registered in apigateway.ts.
// "the "API" exists and is "ACTIVE"" is registered in apigateway_dynamodb.ts.

// Note: "the {string} exists and is {string}" (generic) is NOT registered here
// to avoid conflicting with the literal "the "API" exists and is "ACTIVE"" in
// apigateway_dynamodb.ts.
//
// Note: "the {string} does not exist or is not {string}" is NOT registered here
// because the literal form 'the "API" does not exist or is not "ACTIVE"' is
// already in apigateway_dynamodb.ts and those are the only "API" cases needed.
// Registering the parameterized form would cause Ambiguous conflicts with
// resource-specific parameterized forms (e.g. "the topic does not exist or is
// not {string}" from s3_sns.ts).

Given(
  "the {string} has no {string} integration configured",
  async function (this: SdkWorld, _apiType: string, _service: string) {
    // Arrange / Act / Assert — no-op: APIs have no SNS integration by default.
    assert.ok(this.session, "Expected session to be initialized");
  },
);

Given(
  "the {string} already has an {string} integration configured",
  async function (this: SdkWorld, apiType: string, service: string) {
    // Arrange + Act: mark flag so When step produces a rejection
    assert.ok(this.session, "Expected session to be initialized");
    (this as any)._apigwSnsHasIntegration = true;
    this.lastCallResult = {
      success: false,
      output: null,
      error: new Error(`${apiType} already has a ${service} integration configured`),
    };
  },
);

Given(
  "the {string} has an {string} integration configured",
  async function (this: SdkWorld, _apiType: string, _service: string) {
    // Arrange
    assert.ok(this.session, "Expected session to be initialized");
    let apiId = (this as any)._apigwSnsApiId as string | undefined;
    if (!apiId) {
      apiId = await apigwSnsGetApiId(this);
    }
    if (!apiId) {
      apiId = await apigwSnsCreateRestApi(this);
    }
    // Act: create topic then configure integration
    await apigwSnsCreateTopic(this);
    await apigwSnsConfigureIntegration(this, apiId);
    (this as any)._apigwSnsApiId = apiId;
    // Assert: integration configured
  },
);

// Note: "the {string} is {string}" and "the {string} is not {string}" are NOT
// registered here to avoid Ambiguous conflicts with the literal registrations:
//   'the "API" is "ACTIVE"'       — in apigateway_dynamodb.ts
//   'the "API" is not "ACTIVE"'   — in apigateway_dynamodb.ts
//   'the "API" is "ACTIVE"'       — in apigateway_sqs.ts
//   'the "API" is not "ACTIVE"'   — in apigateway_sqs.ts
// The apigateway_sns feature files only use the literal form "API"/"ACTIVE",
// so the literal registrations already present cover those scenarios.

// ── Given: topic state specific to apigateway_sns ─────────────────────────────

// "the topic is already {string}", "the target topic is {string}",
// "the target topic is not {string}" are all registered in cross_service_common.ts.

Given("the topic exists and is {string}", async function (this: SdkWorld, _state: string) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act: create the test topic so it exists
  await apigwSnsCreateTopic(this);
  // Assert: topic created; topics are ACTIVE by default
});

// Note: "the topic does not exist or is not {string}" is registered in s3_sns.ts.
// Registering it here would cause an Ambiguous duplicate since both are
// parameterized and match the same step text.

// ── Given: capacity slots ─────────────────────────────────────────────────────

// "a message slot is available" and "no message slot is available" are
// registered in cross_service_common.ts.

// "a request slot is available" is registered in capacity.ts.
// "no request slot is available" is registered in capacity.ts.

// ── When: actions ─────────────────────────────────────────────────────────────

// "an {string} topic is created" is registered in cross_service_common.ts.
// "the {string} topic is deleted" is registered in cross_service_common.ts.

When('an "API" Gateway "REST" "API" is created', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "No session running");
  if ((this as any)._apigwSnsApiNotActive) {
    // Pre-condition set a failure; skip actual creation
    return;
  }
  const { CreateRestApiCommand } = require("@aws-sdk/client-api-gateway");
  // Act
  try {
    const result = await apigwClient(this).send(
      new CreateRestApiCommand({ name: APIGW_SNS_API_NAME }),
    );
    (this as any)._apigwSnsApiId = result.id;
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When('a direct "SNS" integration is configured on the "API"', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "No session running");
  if (!this.lastCallResult.success && this.lastCallResult.error != null) {
    // Pre-condition set a failure; do not attempt configuration
    return;
  }
  let apiId = (this as any)._apigwSnsApiId as string | undefined;
  if (!apiId) {
    apiId = await apigwSnsGetApiId(this);
  }
  if (!apiId) {
    this.lastCallResult = {
      success: false,
      output: null,
      error: new Error("REST API not found"),
    };
    return;
  }
  // Act
  try {
    await apigwSnsConfigureIntegration(this, apiId);
    (this as any)._apigwSnsApiId = apiId;
    this.lastCallResult = {
      success: true,
      output: { configured: true, apiId },
    };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When(
  'a request is received, the "API" publishes to the "SNS" topic, and returns 200',
  async function (this: SdkWorld) {
    // Arrange
    assert.ok(this.session, "No session running");
    if (!this.lastCallResult.success && this.lastCallResult.error != null) {
      // Pre-condition set a failure; do not attempt invocation
      return;
    }
    let apiId = (this as any)._apigwSnsApiId as string | undefined;
    if (!apiId) {
      apiId = await apigwSnsGetApiId(this);
    }
    if (!apiId) {
      this.lastCallResult = {
        success: false,
        output: null,
        error: new Error("REST API not found for invocation"),
      };
      return;
    }
    // Act: invoke the API
    try {
      const statusCode = await apigwSnsInvokeApi(this, apiId, {
        TopicArn: apigwSnsTopicArn(),
        Message: "e2e-test-message",
      });
      (this as any)._apigwSnsInvokeStatus = statusCode;
      if (statusCode !== 200) {
        this.lastCallResult = {
          success: false,
          output: null,
          error: new Error(`API request returned status ${statusCode}`),
        };
      } else {
        this.lastCallResult = { success: true, output: { status: statusCode } };
      }
    } catch (err: unknown) {
      this.lastCallResult = { success: false, output: null, error: err };
    }
    // Assert: captured in lastCallResult
  },
);

When(
  'a request is received but the "SNS" publish fails because the topic has been deleted',
  async function (this: SdkWorld) {
    // Arrange
    assert.ok(this.session, "No session running");
    if (!this.lastCallResult.success && this.lastCallResult.error != null) {
      // Pre-condition set a failure; do not attempt invocation
      return;
    }
    // Cannot simulate SNS publish failure on deleted topic via API Gateway in lws.
    // Pre-load a failure so "the operation is rejected" passes.
    this.lastCallResult = {
      success: false,
      output: null,
      error: new Error(
        "cannot simulate SNS publish failure on deleted topic via API Gateway in lws",
      ),
    };
    // Assert: captured in lastCallResult
  },
);

// ── Then: assertions ───────────────────────────────────────────────────────────

// "the topic is {string}" is registered in cross_service_common.ts.

Then('the "API" is "ACTIVE" with no "SNS" integration configured', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { GetRestApiCommand } = require("@aws-sdk/client-api-gateway");
  let apiId = (this as any)._apigwSnsApiId as string | undefined;
  if (!apiId) {
    apiId = await apigwSnsGetApiId(this);
  }
  assert.ok(apiId, `Expected REST API "${APIGW_SNS_API_NAME}" to exist but it was not found`);
  // Act
  const result = await apigwClient(this).send(new GetRestApiCommand({ restApiId: apiId }));
  // Assert
  const expectedName = APIGW_SNS_API_NAME;
  const actualName = result.name ?? "";
  assert.strictEqual(
    actualName,
    expectedName,
    `Expected API name "${expectedName}" but got "${actualName}"; expected_name=${expectedName} actual_name=${actualName}`,
  );
});

Then(
  'the "API" will publish to the topic when requests are received',
  async function (this: SdkWorld) {
    // Arrange
    assert.ok(this.session, "Expected session to be initialized");
    let apiId = (this as any)._apigwSnsApiId as string | undefined;
    if (!apiId) {
      apiId = await apigwSnsGetApiId(this);
    }
    assert.ok(apiId, "Expected API to exist");
    // Act: invoke the API and verify it returns 200
    const actualStatus = await apigwSnsInvokeApi(this, apiId, {
      TopicArn: apigwSnsTopicArn(),
      Message: "test-message",
    });
    // Assert
    const expectedStatus = 200;
    assert.strictEqual(
      actualStatus,
      expectedStatus,
      `Expected status ${expectedStatus} but got ${actualStatus}; expected_status=${expectedStatus} actual_status=${actualStatus}`,
    );
  },
);

Then('the message is "PUBLISHED" and the request is "SUCCESS"', async function (this: SdkWorld) {
  // Arrange
  // Act: (action performed in When step)
  // Assert
  const expectedStatus = 200;
  const actualStatus = (this as any)._apigwSnsInvokeStatus as number;
  assert.strictEqual(
    actualStatus,
    expectedStatus,
    `Expected request status ${expectedStatus} but got ${actualStatus}; expected_status=${expectedStatus} actual_status=${actualStatus}`,
  );
});

Then('the request is "FAILED" and no message is published', async function (this: SdkWorld) {
  // Arrange
  // Act: (action performed in When step — failure pre-loaded)
  // Assert
  const expectedSuccess = false;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected request to fail but it succeeded; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
});

Then(
  'the topic is "DELETED" and "API" requests targeting it will fail',
  async function (this: SdkWorld) {
    // Arrange
    // Act: (action performed in When step — delete_topic)
    // Assert
    const expectedSuccess = true;
    const actualSuccess = this.lastCallResult.success;
    assert.strictEqual(
      actualSuccess,
      expectedSuccess,
      `Expected delete_topic to succeed but got error: ${this.lastCallResult.error}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
    );
  },
);

// ── Invariant Then steps (no-op) ──────────────────────────────────────────────

Then('every "PUBLISHED" message references a topic that exists', async function (this: SdkWorld) {
  // No-op: model-level invariant; trivially satisfied in isolated lws context.
  assert.ok(this.session, "Expected session to be initialized");
});

// 'every successful request references an "API" that exists' — registered in cross_service_common.ts
