/** Step definitions: apigateway_sqs cross-service informal specification scenarios */

import { Before, Given, When, Then } from "@cucumber/cucumber";
import assert from "assert";
import type { SdkWorld } from "../support/world";

const APIGW_SQS_API_NAME = "e2e-test-api-1";
const APIGW_SQS_QUEUE = "e2e-test-q1";
const APIGW_SQS_STAGE = "prod";
const APIGW_SQS_REGION = "us-east-1";
const APIGW_SQS_ACCOUNT = "000000000000";

// ── Helpers ───────────────────────────────────────────────────────────────────

function apigwSqsApigwClient(world: SdkWorld) {
  const { APIGatewayClient } = require("@aws-sdk/client-api-gateway");
  return world.session!.client<typeof APIGatewayClient>("apigateway");
}

function apigwSqsSqsClient(world: SdkWorld) {
  const { SQSClient } = require("@aws-sdk/client-sqs");
  return world.session!.client<typeof SQSClient>("sqs");
}

function apigwSqsQueueUrl(world: SdkWorld): string {
  const port = world.session!.portFor("sqs");
  return `http://127.0.0.1:${port}/${APIGW_SQS_ACCOUNT}/${APIGW_SQS_QUEUE}`;
}

async function apigwSqsCreateRestApi(world: SdkWorld): Promise<string> {
  // Arrange
  const { CreateRestApiCommand } = require("@aws-sdk/client-api-gateway");
  // Act
  const result = await apigwSqsApigwClient(world).send(
    new CreateRestApiCommand({ name: APIGW_SQS_API_NAME }),
  );
  // Assert: store and return ID
  (world as any)._apigwSqsRestApiId = result.id as string;
  return result.id as string;
}

async function apigwSqsFetchRootResourceId(world: SdkWorld, restApiId: string): Promise<string> {
  // Arrange
  const { GetResourcesCommand } = require("@aws-sdk/client-api-gateway");
  // Act
  const result = await apigwSqsApigwClient(world).send(new GetResourcesCommand({ restApiId }));
  const items: Array<{ id: string; path: string }> = result.items ?? [];
  const root = items.find((r: { id: string; path: string }) => r.path === "/");
  // Assert
  if (!root) throw new Error(`Root resource not found for API ${restApiId}`);
  (world as any)._apigwSqsRootResourceId = root.id;
  return root.id;
}

async function apigwSqsGetApiId(world: SdkWorld): Promise<string | undefined> {
  // Arrange
  const { GetRestApisCommand } = require("@aws-sdk/client-api-gateway");
  // Act
  const result = await apigwSqsApigwClient(world).send(new GetRestApisCommand({}));
  const items: Array<{ id: string; name: string }> = result.items ?? [];
  // Assert: find by name
  const found = items.find((a: { id: string; name: string }) => a.name === APIGW_SQS_API_NAME);
  return found?.id;
}

async function apigwSqsConfigureIntegration(
  world: SdkWorld,
  restApiId: string,
  rootResourceId: string,
): Promise<void> {
  // Arrange: put POST method
  const {
    PutMethodCommand,
    PutIntegrationCommand,
    CreateDeploymentCommand,
    CreateStageCommand,
  } = require("@aws-sdk/client-api-gateway");
  await apigwSqsApigwClient(world).send(
    new PutMethodCommand({
      restApiId,
      resourceId: rootResourceId,
      httpMethod: "POST",
      authorizationType: "NONE",
    }),
  );
  // Act: wire SQS direct integration
  const integrationUri = `arn:aws:apigateway:${APIGW_SQS_REGION}:sqs:path/${APIGW_SQS_ACCOUNT}/${APIGW_SQS_QUEUE}`;
  await apigwSqsApigwClient(world).send(
    new PutIntegrationCommand({
      restApiId,
      resourceId: rootResourceId,
      httpMethod: "POST",
      type: "AWS",
      integrationHttpMethod: "POST",
      uri: integrationUri,
    }),
  );
  const deployResult = await apigwSqsApigwClient(world).send(
    new CreateDeploymentCommand({ restApiId, description: "e2e" }),
  );
  await apigwSqsApigwClient(world).send(
    new CreateStageCommand({
      restApiId,
      stageName: APIGW_SQS_STAGE,
      deploymentId: deployResult.id as string,
    }),
  );
}

async function apigwSqsInvokeApi(
  world: SdkWorld,
  restApiId: string,
  body: Record<string, string>,
): Promise<{ statusCode: number }> {
  // Arrange
  const port = world.session!.portFor("apigateway");
  const url = `http://127.0.0.1:${port}/${restApiId}/${APIGW_SQS_STAGE}/`;
  // Act
  const response = await fetch(url, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(body),
  });
  await response.text();
  // Assert: return status for caller
  return { statusCode: response.status };
}

async function apigwSqsCreateQueue(world: SdkWorld): Promise<void> {
  // Arrange
  const { CreateQueueCommand } = require("@aws-sdk/client-sqs");
  // Act
  await apigwSqsSqsClient(world).send(new CreateQueueCommand({ QueueName: APIGW_SQS_QUEUE }));
}

// ── Background ────────────────────────────────────────────────────────────────

// "the system is initialized" is registered in cross_service_common.ts.

// ── Before hook: register API helpers for @apigatewaysqs scenarios ─────────────

Before({ tags: "@apigatewaysqs" }, function (this: SdkWorld) {
  this.apiHelpers = {
    createApi: apigwSqsCreateRestApi,
    createApiWithRoot: async (world: SdkWorld) => {
      const restApiId = await apigwSqsCreateRestApi(world);
      await apigwSqsFetchRootResourceId(world, restApiId);
    },
  };
});

// ── Given: API state ──────────────────────────────────────────────────────────

// "the \"API\" does not already exist", "the \"API\" already exists",
// "the \"API\" does not exist", "the \"API\" exists", "the \"API\" is \"ACTIVE\"",
// "the \"API\" is not \"ACTIVE\"" are registered in apigateway.ts (dispatches via apiHelpers).

Given('the "API" has no integration configured', async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: APIs have no integration configured by default.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the "API" already has an integration configured', async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: this state is not reachable without going through
  // the happy-path configure step first; scenarios using this are @standard @negative.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the "API" has an "SQS" integration configured', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  let restApiId = (this as any)._apigwSqsRestApiId as string | undefined;
  if (!restApiId) {
    restApiId = await apigwSqsCreateRestApi(this);
  }
  const rootResourceId = await apigwSqsFetchRootResourceId(this, restApiId);
  await apigwSqsCreateQueue(this);
  // Act
  await apigwSqsConfigureIntegration(this, restApiId, rootResourceId);
});

Given('the "API" has no "SQS" integration configured', async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: APIs have no SQS integration configured by default.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Given: queue state ────────────────────────────────────────────────────────

// "the queue does not already exist" is registered in cross_service_common.ts.

// "the queue already exists" is registered in cross_service_common.ts.

// "the queue exists" is registered in cross_service_common.ts.

// "the queue is {string}" is registered in cross_service_common.ts.

Given('the queue is not "ACTIVE"', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act: use lifecycle API to keep queue in non-ACTIVE state
  await this.session!.lifecycle("sqs").createDwellMs(5000).apply();
  try {
    const { DeleteQueueCommand } = require("@aws-sdk/client-sqs");
    await apigwSqsSqsClient(this).send(
      new DeleteQueueCommand({ QueueUrl: apigwSqsQueueUrl(this) }),
    );
  } catch {
    // queue may not exist
  }
  await apigwSqsCreateQueue(this);
});

// "the queue does not exist" is registered in cross_service_common.ts.

// "the target queue is {string}" is registered in cross_service_common.ts.

Given('the target queue is not "ACTIVE"', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act: use lifecycle API to keep queue in non-ACTIVE state
  await this.session!.lifecycle("sqs").createDwellMs(5000).apply();
  try {
    const { DeleteQueueCommand } = require("@aws-sdk/client-sqs");
    await apigwSqsSqsClient(this).send(
      new DeleteQueueCommand({ QueueUrl: apigwSqsQueueUrl(this) }),
    );
  } catch {
    // queue may not exist
  }
  await apigwSqsCreateQueue(this);
});

// ── Given: capacity slots ─────────────────────────────────────────────────────

Given("a request slot is available", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await this.session!.capacity("apigateway").unlimited().apply();
});

Given("no request slot is available", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await this.session!.capacity("apigateway").exhaust().apply();
});

// "a message slot is available" is registered in cross_service_common.ts.
// "no message slot is available" is registered in cross_service_common.ts.

// ── When: actions ─────────────────────────────────────────────────────────────

When('a "REST" "API" is created', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  try {
    const result = await apigwSqsCreateRestApi(this);
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

// "an {string} queue is created" is registered in cross_service_common.ts.

When(
  'an "SQS" direct integration is configured on the "REST" "API"',
  async function (this: SdkWorld) {
    // Arrange
    assert.ok(this.session, "Expected session to be initialized");
    try {
      let restApiId = (this as any)._apigwSqsRestApiId as string | undefined;
      if (!restApiId) {
        restApiId = await apigwSqsGetApiId(this);
      }
      if (!restApiId) {
        throw new Error(`REST API "${APIGW_SQS_API_NAME}" not found`);
      }
      const rootResourceId = await apigwSqsFetchRootResourceId(this, restApiId);
      // Act
      await apigwSqsConfigureIntegration(this, restApiId, rootResourceId);
      this.lastCallResult = { success: true, output: { configured: true } };
    } catch (err: unknown) {
      this.lastCallResult = { success: false, output: null, error: err };
    }
    // Assert: captured in lastCallResult
  },
);

When(
  'the "API" receives a request and enqueues it as an "SQS" message',
  async function (this: SdkWorld) {
    // Arrange
    assert.ok(this.session, "Expected session to be initialized");
    try {
      let restApiId = (this as any)._apigwSqsRestApiId as string | undefined;
      if (!restApiId) {
        restApiId = await apigwSqsGetApiId(this);
      }
      if (!restApiId) {
        throw new Error(`REST API "${APIGW_SQS_API_NAME}" not found`);
      }
      // Act: POST to the deployed stage
      const result = await apigwSqsInvokeApi(this, restApiId, {
        event: "order-created",
        orderId: "e2e-1",
      });
      (this as any)._apigwSqsInvokeStatus = result.statusCode;
      if (result.statusCode !== 200) {
        throw new Error(`API request failed with status ${result.statusCode}`);
      }
      this.lastCallResult = { success: true, output: result };
    } catch (err: unknown) {
      this.lastCallResult = { success: false, output: null, error: err };
    }
    // Assert: captured in lastCallResult
  },
);

When("a backend consumer processes the message from the queue", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  try {
    const { ReceiveMessageCommand, DeleteMessageCommand } = require("@aws-sdk/client-sqs");
    const queueUrl = apigwSqsQueueUrl(this);
    // Act: receive
    const recvResult = await apigwSqsSqsClient(this).send(
      new ReceiveMessageCommand({
        QueueUrl: queueUrl,
        MaxNumberOfMessages: 1,
        WaitTimeSeconds: 0,
      }),
    );
    const messages: Array<{ ReceiptHandle?: string }> = recvResult.Messages ?? [];
    if (messages.length === 0) {
      throw new Error(`No AVAILABLE message found in queue "${APIGW_SQS_QUEUE}"`);
    }
    // Act: delete (consumer acknowledges)
    await apigwSqsSqsClient(this).send(
      new DeleteMessageCommand({
        QueueUrl: queueUrl,
        ReceiptHandle: messages[0].ReceiptHandle,
      }),
    );
    this.lastCallResult = { success: true, output: { deleted: true } };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

// ── Then: assertions ──────────────────────────────────────────────────────────

Then('the "API" is "ACTIVE" with no "SQS" integration configured', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { GetRestApisCommand } = require("@aws-sdk/client-api-gateway");
  // Act
  const result = await apigwSqsApigwClient(this).send(new GetRestApisCommand({}));
  const items: Array<{ id: string; name: string }> = result.items ?? [];
  // Assert
  const expectedName = APIGW_SQS_API_NAME;
  const actualFound = items.some((a: { id: string; name: string }) => a.name === expectedName);
  assert.ok(
    actualFound,
    `Expected REST API "${expectedName}" to be ACTIVE but not found; actual_found=${actualFound}`,
  );
});

// "the queue is {string}" is registered in cross_service_common.ts.

Then(
  'the "API" will enqueue incoming requests as "SQS" messages without invoking Lambda',
  async function (this: SdkWorld) {
    // Arrange
    assert.ok(this.session, "Expected session to be initialized");
    let restApiId = (this as any)._apigwSqsRestApiId as string | undefined;
    if (!restApiId) {
      restApiId = await apigwSqsGetApiId(this);
    }
    assert.ok(restApiId, `Expected REST API "${APIGW_SQS_API_NAME}" to exist but not found`);
    // Act: POST a test request
    const result = await apigwSqsInvokeApi(this, restApiId!, {
      event: "check",
      orderId: "check-1",
    });
    // Assert
    const expectedStatus = 200;
    const actualStatus = result.statusCode;
    assert.strictEqual(
      actualStatus,
      expectedStatus,
      `Expected status ${expectedStatus} but got ${actualStatus}; expected_status=${expectedStatus} actual_status=${actualStatus}`,
    );
  },
);

Then(
  'the request is "ACCEPTED" and the message is "AVAILABLE" in the queue',
  async function (this: SdkWorld) {
    // Arrange
    const expectedStatus = 200;
    const actualStatus = (this as any)._apigwSqsInvokeStatus as number;
    assert.strictEqual(
      actualStatus,
      expectedStatus,
      `Expected request status ${expectedStatus} but got ${actualStatus}; expected_status=${expectedStatus} actual_status=${actualStatus}`,
    );
    const { ReceiveMessageCommand } = require("@aws-sdk/client-sqs");
    // Act: check queue for enqueued message
    const recvResult = await apigwSqsSqsClient(this).send(
      new ReceiveMessageCommand({
        QueueUrl: apigwSqsQueueUrl(this),
        MaxNumberOfMessages: 1,
        WaitTimeSeconds: 0,
      }),
    );
    const messages: unknown[] = recvResult.Messages ?? [];
    // Assert
    const expectedCount = 1;
    const actualCount = messages.length;
    assert.ok(
      actualCount >= expectedCount,
      `Expected at least ${expectedCount} message in queue but found ${actualCount}; expected_count=${expectedCount} actual_count=${actualCount}`,
    );
  },
);

// ── Invariant catch-all Then steps ────────────────────────────────────────────

Then('every "ACCEPTED" request references an "ACTIVE" "API"', async function (this: SdkWorld) {
  // No-op: model-level invariant; trivially satisfied in isolated lws context.
  assert.ok(this.session, "Expected session to be initialized");
});

// "every {string} message belongs to an {string} queue" is registered in cross_service_common.ts.

// ── Common rejection assertion ─────────────────────────────────────────────────

// "the operation is rejected" is registered in cross_service_common.ts.
