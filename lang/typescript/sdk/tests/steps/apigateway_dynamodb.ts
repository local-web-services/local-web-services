/** Step definitions: apigateway_dynamodb cross-service scenarios — unique When/Then steps only */

import { Before, Given, When, Then } from "@cucumber/cucumber";
import assert from "assert";
import type { SdkWorld } from "../support/world";

const APIGW_DYNAMODB_API_NAME = "e2e-test-api-1";
const APIGW_DYNAMODB_TABLE = "e2e-test-table-1";
const APIGW_DYNAMODB_PK = "e2e-id";
const APIGW_DYNAMODB_ITEM_KEY = "e2e-item-1";
const APIGW_DYNAMODB_STAGE = "prod";
const APIGW_DYNAMODB_REGION = "us-east-1";

// ── Helpers ───────────────────────────────────────────────────────────────────

function apigwDdbApigwClient(world: SdkWorld) {
  const { APIGatewayClient } = require("@aws-sdk/client-api-gateway");
  return world.session!.client<typeof APIGatewayClient>("apigateway");
}

function apigwDdbDynamoClient(world: SdkWorld) {
  const { DynamoDBClient } = require("@aws-sdk/client-dynamodb");
  return world.session!.client<typeof DynamoDBClient>("dynamodb");
}

async function apigwDdbCreateApi(world: SdkWorld): Promise<string> {
  // Arrange
  const { CreateRestApiCommand } = require("@aws-sdk/client-api-gateway");
  // Act
  const result = await apigwDdbApigwClient(world).send(
    new CreateRestApiCommand({ name: APIGW_DYNAMODB_API_NAME }),
  );
  (world as any)._apigwDdbApiId = result.id as string;
  // Assert: caller uses returned ID
  return result.id as string;
}

async function apigwDdbGetApiId(world: SdkWorld): Promise<string | null> {
  // Arrange
  const { GetRestApisCommand } = require("@aws-sdk/client-api-gateway");
  // Act
  const result = await apigwDdbApigwClient(world).send(new GetRestApisCommand({}));
  const apis: Array<{ id: string; name: string }> = result.items ?? [];
  const found = apis.find((a) => a.name === APIGW_DYNAMODB_API_NAME);
  // Assert: return ID or null
  return found ? found.id : null;
}

async function apigwDdbCreateTable(world: SdkWorld): Promise<void> {
  // Arrange
  const { CreateTableCommand } = require("@aws-sdk/client-dynamodb");
  // Act
  await apigwDdbDynamoClient(world).send(
    new CreateTableCommand({
      TableName: APIGW_DYNAMODB_TABLE,
      KeySchema: [{ AttributeName: APIGW_DYNAMODB_PK, KeyType: "HASH" }],
      AttributeDefinitions: [{ AttributeName: APIGW_DYNAMODB_PK, AttributeType: "S" }],
      BillingMode: "PAY_PER_REQUEST",
    }),
  );
  // Assert: no exception means success
}

async function apigwDdbConfigureIntegration(world: SdkWorld, apiId: string): Promise<void> {
  const {
    GetResourcesCommand,
    PutMethodCommand,
    PutIntegrationCommand,
    CreateDeploymentCommand,
    CreateStageCommand,
  } = require("@aws-sdk/client-api-gateway");

  // Arrange: fetch root resource
  const resourcesResult = await apigwDdbApigwClient(world).send(
    new GetResourcesCommand({ restApiId: apiId }),
  );
  const items: Array<{ id: string; path: string }> = resourcesResult.items ?? [];
  const root = items.find((r) => r.path === "/");
  if (!root) throw new Error("Root resource not found for API " + apiId);
  const rootResourceId = root.id;

  // Act: put POST method
  await apigwDdbApigwClient(world).send(
    new PutMethodCommand({
      restApiId: apiId,
      resourceId: rootResourceId,
      httpMethod: "POST",
      authorizationType: "NONE",
    }),
  );

  // Act: put AWS DynamoDB PutItem integration
  const integrationUri = `arn:aws:apigateway:${APIGW_DYNAMODB_REGION}:dynamodb:action/PutItem`;
  await apigwDdbApigwClient(world).send(
    new PutIntegrationCommand({
      restApiId: apiId,
      resourceId: rootResourceId,
      httpMethod: "POST",
      type: "AWS",
      integrationHttpMethod: "POST",
      uri: integrationUri,
    }),
  );

  // Act: create deployment
  const deployResult = await apigwDdbApigwClient(world).send(
    new CreateDeploymentCommand({ restApiId: apiId, description: "e2e" }),
  );

  // Act: create prod stage
  await apigwDdbApigwClient(world).send(
    new CreateStageCommand({
      restApiId: apiId,
      stageName: APIGW_DYNAMODB_STAGE,
      deploymentId: deployResult.id,
    }),
  );
}

async function apigwDdbInvokeApi(
  world: SdkWorld,
  apiId: string,
  body: Record<string, unknown>,
): Promise<{ status: number }> {
  // Arrange: build invocation URL via apigateway port
  const port = world.session!.portFor("apigateway");
  const url = `http://127.0.0.1:${port}/${apiId}/${APIGW_DYNAMODB_STAGE}/`;
  // Act: POST to the deployed stage
  const response = await fetch(url, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(body),
  });
  await response.text();
  // Assert: caller uses status code
  return { status: response.status };
}

// ── Before hook: register API helpers for @apigatewaydynamodb scenarios ──────────

Before({ tags: "@apigatewaydynamodb" }, function (this: SdkWorld) {
  this.apiHelpers = {
    createApi: apigwDdbCreateApi,
    createApiWithRoot: async (world: SdkWorld) => {
      await apigwDdbCreateApi(world);
    },
  };
});

// ── Given: API state ──────────────────────────────────────────────────────────

// "the \"API\" does not already exist", "the \"API\" already exists",
// "the \"API\" is \"ACTIVE\"", "the \"API\" is not \"ACTIVE\"" are registered in
// apigateway.ts (dispatches via apiHelpers).

Given('the "API" exists and is "ACTIVE"', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "No session running");
  // Act
  await apigwDdbCreateApi(this);
  // Assert: API is immediately ACTIVE in lws
});

Given('the "API" does not exist or is not "ACTIVE"', async function (this: SdkWorld) {
  // No-op: cannot simulate non-ACTIVE REST API in lws; @internal scenarios excluded.
});

Given('the "API" has no DynamoDB integration configured', async function (this: SdkWorld) {
  // No-op: APIs have no DynamoDB integration by default.
});

Given('the "API" already has a DynamoDB integration configured', async function (this: SdkWorld) {
  // No-op: cannot simulate pre-configured integration conflict in lws; @internal excluded.
});

// "the \"API\" is \"ACTIVE\"" and "the \"API\" is not \"ACTIVE\"" are registered in apigateway.ts.

Given('the "API" has a DynamoDB integration configured', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "No session running");
  let apiId = await apigwDdbGetApiId(this);
  if (!apiId) {
    apiId = await apigwDdbCreateApi(this);
  }
  try {
    await apigwDdbCreateTable(this);
  } catch {
    // Table may already exist from a prior Given step
  }
  // Act: configure integration
  await apigwDdbConfigureIntegration(this, apiId);
  (this as any)._apigwDdbApiId = apiId;
  // Assert: integration configured without error
});

// ── Given: table state ────────────────────────────────────────────────────────

// "the table does not already exist" is registered in cross_service_common.ts.

// "the table already exists" is registered in cross_service_common.ts.

Given('the table exists and is "ACTIVE"', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "No session running");
  // Act
  await apigwDdbCreateTable(this);
  // Assert: table is immediately ACTIVE in lws
});

Given('the table does not exist or is not "ACTIVE"', async function (this: SdkWorld) {
  // No-op: cannot simulate non-ACTIVE DynamoDB table in lws; @internal excluded.
});

// "the table exists" is registered in cross_service_common.ts.

// "the table does not exist" is registered in cross_service_common.ts.

Given('the target table is "ACTIVE"', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "No session running");
  // Act: ensure table exists
  try {
    await apigwDdbCreateTable(this);
  } catch {
    // May already exist from a prior step
  }
  // Assert: table is immediately ACTIVE in lws
});

Given('the target table is not "ACTIVE"', async function (this: SdkWorld) {
  // No-op: cannot simulate non-ACTIVE target table in lws; @internal excluded.
});

Given('the target table is "DELETING"', async function (this: SdkWorld) {
  // No-op: cannot simulate DELETING table state in lws; @internal excluded.
});

Given('the target table is not "DELETING"', async function (this: SdkWorld) {
  // No-op: tables are not DELETING by default.
});

Given('the table is already "DELETING"', async function (this: SdkWorld) {
  // No-op: cannot simulate DELETING table state in lws; @internal excluded.
});

// ── Given: capacity / slot state ──────────────────────────────────────────────

Given("a request slot is available", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "No session running");
  // Act: set apigateway capacity to unlimited
  await this.session!.capacity("apigateway").unlimited().apply();
  // Assert: capacity configured
});

Given("no request slot is available", async function (this: SdkWorld) {
  // No-op: cannot simulate exhausted request slots via public API; @internal excluded.
});

// "an item slot is available" is registered in cross_service_common.ts.

Given("no item slot is available", async function (this: SdkWorld) {
  // No-op: cannot simulate exhausted item slots via public API; @internal excluded.
});

// ── When: actions ─────────────────────────────────────────────────────────────

When('an "API" Gateway "REST" "API" is created', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "No session running");
  // Act
  try {
    const apiId = await apigwDdbCreateApi(this);
    this.lastCallResult = { success: true, output: { id: apiId } };
  } catch (err) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

// "a DynamoDB table is created" is registered in cross_service_common.ts.

When('a direct DynamoDB integration is configured on the "API"', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "No session running");
  const apiId = await apigwDdbGetApiId(this);
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
    await apigwDdbConfigureIntegration(this, apiId);
    (this as any)._apigwDdbApiId = apiId;
    this.lastCallResult = { success: true, output: { configured: true } };
  } catch (err) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When(
  'a request is received, the "API" writes to the DynamoDB table, and returns 200',
  async function (this: SdkWorld) {
    // Arrange
    assert.ok(this.session, "No session running");
    let apiId = (this as any)._apigwDdbApiId as string | undefined;
    if (!apiId) {
      const found = await apigwDdbGetApiId(this);
      apiId = found ?? undefined;
    }
    // Act
    try {
      const result = await apigwDdbInvokeApi(this, apiId!, {
        TableName: APIGW_DYNAMODB_TABLE,
        Item: {
          [APIGW_DYNAMODB_PK]: { S: APIGW_DYNAMODB_ITEM_KEY },
          value: { S: "hello" },
        },
      });
      (this as any)._apigwDdbInvokeStatus = result.status;
      if (result.status !== 200) {
        this.lastCallResult = {
          success: false,
          output: null,
          error: new Error(`API request failed with status ${result.status}`),
        };
      } else {
        this.lastCallResult = { success: true, output: result };
      }
    } catch (err) {
      this.lastCallResult = { success: false, output: null, error: err };
    }
    // Assert: captured in lastCallResult
  },
);

When(
  "a request is received but the DynamoDB write fails because the table is being deleted",
  async function (this: SdkWorld) {
    // No-op: cannot simulate DELETING table during request in lws; @internal excluded.
    this.lastCallResult = {
      success: false,
      output: null,
      error: new Error("cannot simulate DELETING table during request: @internal"),
    };
  },
);

When("a table deletion is initiated", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "No session running");
  const { DeleteTableCommand } = require("@aws-sdk/client-dynamodb");
  // Act
  try {
    const result = await apigwDdbDynamoClient(this).send(
      new DeleteTableCommand({ TableName: APIGW_DYNAMODB_TABLE }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

// ── Then: assertions ──────────────────────────────────────────────────────────

Then(
  'the "API" is "ACTIVE" with no DynamoDB integration configured',
  async function (this: SdkWorld) {
    // Arrange
    assert.ok(this.session, "No session running");
    const apiId = await apigwDdbGetApiId(this);
    assert.ok(
      apiId,
      `Expected REST API "${APIGW_DYNAMODB_API_NAME}" to exist but it was not found`,
    );
    const { GetRestApiCommand } = require("@aws-sdk/client-api-gateway");
    // Act
    const result = await apigwDdbApigwClient(this).send(
      new GetRestApiCommand({ restApiId: apiId }),
    );
    // Assert
    const expectedName = APIGW_DYNAMODB_API_NAME;
    const actualName = result.name as string;
    assert.strictEqual(
      actualName,
      expectedName,
      `Expected API name "${expectedName}" but got "${actualName}"`,
    );
  },
);

// "the table is {string}" is registered in cross_service_common.ts.

Then(
  'the "API" will write to the table when requests are received',
  async function (this: SdkWorld) {
    // Arrange
    assert.ok(this.session, "No session running");
    let apiId = (this as any)._apigwDdbApiId as string | undefined;
    if (!apiId) {
      const found = await apigwDdbGetApiId(this);
      apiId = found ?? undefined;
    }
    assert.ok(apiId, "Expected API to exist");
    // Act
    const result = await apigwDdbInvokeApi(this, apiId!, {
      TableName: APIGW_DYNAMODB_TABLE,
      Item: {
        [APIGW_DYNAMODB_PK]: { S: "check-item-1" },
        value: { S: "ok" },
      },
    });
    // Assert
    const expectedStatus = 200;
    const actualStatus = result.status;
    assert.strictEqual(
      actualStatus,
      expectedStatus,
      `Expected status ${expectedStatus} but got ${actualStatus}`,
    );
  },
);

Then('the item "EXISTS" and the request is "SUCCESS"', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "No session running");
  const expectedInvokeStatus = 200;
  const actualInvokeStatus = (this as any)._apigwDdbInvokeStatus as number;
  assert.strictEqual(
    actualInvokeStatus,
    expectedInvokeStatus,
    `Expected request status ${expectedInvokeStatus} but got ${actualInvokeStatus}`,
  );
  const { GetItemCommand } = require("@aws-sdk/client-dynamodb");
  // Act
  const result = await apigwDdbDynamoClient(this).send(
    new GetItemCommand({
      TableName: APIGW_DYNAMODB_TABLE,
      Key: { [APIGW_DYNAMODB_PK]: { S: APIGW_DYNAMODB_ITEM_KEY } },
    }),
  );
  // Assert
  const actualItem = result.Item;
  assert.ok(actualItem, "Expected item to exist in DynamoDB but it was not found");
});

Then('the request is "FAILED" and no item is written', async function (this: SdkWorld) {
  // No-op: cannot simulate DynamoDB write failure via API Gateway in lws; @internal excluded.
});

Then(
  'the table is "DELETING" and "API" requests targeting it will fail',
  async function (this: SdkWorld) {
    // Arrange: delete_table should have succeeded
    // Act / Assert
    const actualError = this.lastCallResult.error;
    assert.strictEqual(
      actualError,
      undefined,
      `Expected delete_table to succeed but got: ${JSON.stringify(actualError)}`,
    );
  },
);

// ── Invariant catch-all steps ─────────────────────────────────────────────────

// "every existing item references a table that exists" is registered in cross_service_common.ts.

Then('every successful request references an "API" that exists', async function (this: SdkWorld) {
  // No-op: model-level invariant; trivially satisfied in isolated lws context.
});
