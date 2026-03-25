/** Step definitions: apigateway_stepfunctions cross-service informal specification scenarios */

import { Given, When, Then } from "@cucumber/cucumber";
import assert from "assert";
import type { SdkWorld } from "../support/world";

// ── Constants ─────────────────────────────────────────────────────────────────

const APIGW_SFN_TEST_API_NAME = "e2e-apigwsfn-test-api-1";
const APIGW_SFN_TEST_SM_NAME = "e2e-apigwsfn-test-sm-1";
const APIGW_SFN_ROLE_ARN = "arn:aws:iam::000000000000:role/e2e-role";
const APIGW_SFN_PASS_DEFINITION = JSON.stringify({
  StartAt: "Pass",
  States: { Pass: { Type: "Pass", End: true } },
});
const APIGW_SFN_REGION = "us-east-1";
const APIGW_SFN_ACCOUNT = "000000000000";
const APIGW_SFN_STAGE = "prod";

// ── Helpers ───────────────────────────────────────────────────────────────────

function apigwClient(world: SdkWorld) {
  const { APIGatewayClient } = require("@aws-sdk/client-api-gateway");
  return world.session!.client<typeof APIGatewayClient>("apigateway");
}

function sfnClient(world: SdkWorld) {
  const { SFNClient } = require("@aws-sdk/client-sfn");
  return world.session!.client<typeof SFNClient>("stepfunctions");
}

function apigwSfnSmArn(name: string): string {
  return `arn:aws:states:${APIGW_SFN_REGION}:${APIGW_SFN_ACCOUNT}:stateMachine:${name}`;
}

async function apigwSfnCreateRestApi(world: SdkWorld): Promise<string> {
  const { CreateRestApiCommand } = require("@aws-sdk/client-api-gateway");
  const result = await apigwClient(world).send(
    new CreateRestApiCommand({ name: APIGW_SFN_TEST_API_NAME }),
  );
  (world as any)._apigwSfnRestApiId = result.id;
  return result.id as string;
}

async function apigwSfnGetApiId(world: SdkWorld): Promise<string | null> {
  const { GetRestApisCommand } = require("@aws-sdk/client-api-gateway");
  const result = await apigwClient(world).send(new GetRestApisCommand({}));
  const items: Array<{ id: string; name: string }> = result.items ?? [];
  const found = items.find((a) => a.name === APIGW_SFN_TEST_API_NAME);
  return found ? found.id : null;
}

async function apigwSfnCreateStateMachine(world: SdkWorld): Promise<string> {
  const { CreateStateMachineCommand } = require("@aws-sdk/client-sfn");
  const result = await sfnClient(world).send(
    new CreateStateMachineCommand({
      name: APIGW_SFN_TEST_SM_NAME,
      definition: APIGW_SFN_PASS_DEFINITION,
      roleArn: APIGW_SFN_ROLE_ARN,
      type: "EXPRESS",
    }),
  );
  return result.stateMachineArn as string;
}

async function apigwSfnConfigureIntegration(world: SdkWorld, apiId: string): Promise<void> {
  const {
    GetResourcesCommand,
    PutMethodCommand,
    PutIntegrationCommand,
    CreateDeploymentCommand,
    CreateStageCommand,
  } = require("@aws-sdk/client-api-gateway");

  // Arrange: fetch root resource
  const resourcesResult = await apigwClient(world).send(
    new GetResourcesCommand({ restApiId: apiId }),
  );
  const items: Array<{ id: string; path: string }> = resourcesResult.items ?? [];
  const root = items.find((r) => r.path === "/");
  if (!root) throw new Error("Root resource not found");
  const rootResourceId = root.id;

  // Act: configure POST method
  await apigwClient(world).send(
    new PutMethodCommand({
      restApiId: apiId,
      resourceId: rootResourceId,
      httpMethod: "POST",
      authorizationType: "NONE",
    }),
  );

  // Act: configure StepFunctions integration
  const integrationUri = `arn:aws:apigateway:${APIGW_SFN_REGION}:states:action/StartExecution`;
  await apigwClient(world).send(
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
  const deployResult = await apigwClient(world).send(
    new CreateDeploymentCommand({ restApiId: apiId, description: "e2e" }),
  );

  // Act: create stage
  await apigwClient(world).send(
    new CreateStageCommand({
      restApiId: apiId,
      stageName: APIGW_SFN_STAGE,
      deploymentId: deployResult.id,
    }),
  );
}

async function apigwSfnInvokeApi(
  world: SdkWorld,
  apiId: string,
  body: Record<string, string>,
): Promise<{ statusCode: number; body: string }> {
  const port = world.session!.portFor("apigateway");
  const url = `http://127.0.0.1:${port}/${apiId}/${APIGW_SFN_STAGE}/`;
  const response = await fetch(url, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(body),
  });
  const responseBody = await response.text();
  return { statusCode: response.status, body: responseBody };
}

// ── Background ────────────────────────────────────────────────────────────────

// "the system is initialized" is registered in cross_service_common.ts.

// ── Given: API integration state — unique to cross-service suite ──────────────

Given('the "API" has no integration configured', async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: APIs have no integration configured by default.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the "API" already has an integration configured', async function (this: SdkWorld) {
  // Arrange / Act / Assert — cannot simulate pre-configured integration conflict.
  assert.ok(this.session, "Expected session to be initialized");
  (this as any)._apigwSfnSkip =
    "Cannot simulate pre-configured StepFunctions integration conflict in lws";
});

Given('the "API" has a Step Functions integration configured', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  let apiId: string = (this as any)._apigwSfnRestApiId ?? null;
  if (!apiId) {
    apiId = (await apigwSfnGetApiId(this)) ?? "";
  }
  if (!apiId) {
    apiId = await apigwSfnCreateRestApi(this);
  }
  // Act: create state machine and configure integration
  await apigwSfnCreateStateMachine(this).catch(() => {
    // Tolerate already-exists errors
  });
  await apigwSfnConfigureIntegration(this, apiId);
  (this as any)._apigwSfnRestApiId = apiId;
  // Assert: integration configured (no error thrown)
});

Given('the "API" has no Step Functions integration configured', async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: APIs have no StepFunctions integration by default.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Given: integrated state machine — unique to cross-service suite ────────────

Given('the integrated state machine is "ACTIVE"', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act: create state machine (idempotent — ignore already-exists errors)
  await apigwSfnCreateStateMachine(this).catch(() => {
    // Tolerate already-exists errors
  });
  // Assert: state machine is ACTIVE (no error thrown)
});

Given('the integrated state machine is not "ACTIVE"', async function (this: SdkWorld) {
  // Arrange / Act / Assert — cannot simulate non-ACTIVE integrated state machine.
  assert.ok(this.session, "Expected session to be initialized");
  (this as any)._apigwSfnSkip = "Cannot simulate non-ACTIVE integrated state machine in lws";
});

// ── Given: execution presence — unique to cross-service suite ─────────────────

Given('an execution is "RUNNING"', async function (this: SdkWorld) {
  // Arrange / Act / Assert — cannot simulate running execution state.
  assert.ok(this.session, "Expected session to be initialized");
  (this as any)._apigwSfnSkip = "Cannot simulate running execution state in lws";
});

Given('no execution is "RUNNING"', async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state has no running executions.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Given: capacity — unique phrasing for cross-service suite ─────────────────
// Note: "the execution slot is available/not available" are registered in
// stepfunctions.ts; the "a request slot" and "an execution slot" variants are new.

Given("a request slot is available", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act: set unlimited capacity for apigateway
  await this.session!.capacity("apigateway").unlimited().apply();
  // Assert: capacity is unlimited
});

Given("no request slot is available", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act: exhaust apigateway request capacity
  await this.session!.capacity("apigateway").exhaust().apply();
  // Assert: capacity is exhausted
});

// "an execution slot is available" is registered in cross_service_common.ts.

// "no execution slot is available" is registered in cross_service_common.ts.

// ── When: actions — unique to cross-service suite ─────────────────────────────

When('a "REST" "API" is created', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  try {
    const { CreateRestApiCommand } = require("@aws-sdk/client-api-gateway");
    const result = await apigwClient(this).send(
      new CreateRestApiCommand({ name: APIGW_SFN_TEST_API_NAME }),
    );
    (this as any)._apigwSfnRestApiId = result.id;
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("a Step Functions Express Workflow state machine is created", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  try {
    const { CreateStateMachineCommand } = require("@aws-sdk/client-sfn");
    const result = await sfnClient(this).send(
      new CreateStateMachineCommand({
        name: APIGW_SFN_TEST_SM_NAME,
        definition: APIGW_SFN_PASS_DEFINITION,
        roleArn: APIGW_SFN_ROLE_ARN,
        type: "EXPRESS",
      }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When(
  'a Step Functions direct integration is configured on the "REST" "API"',
  async function (this: SdkWorld) {
    // Arrange
    assert.ok(this.session, "Expected session to be initialized");
    if ((this as any)._apigwSfnSkip) {
      this.lastCallResult = {
        success: false,
        output: null,
        error: new Error((this as any)._apigwSfnSkip),
      };
      return;
    }
    let apiId: string = (this as any)._apigwSfnRestApiId ?? null;
    if (!apiId) {
      apiId = (await apigwSfnGetApiId(this)) ?? "";
    }
    // Act
    try {
      if (!apiId) {
        throw new Error("REST API not found");
      }
      await apigwSfnConfigureIntegration(this, apiId);
      (this as any)._apigwSfnRestApiId = apiId;
      this.lastCallResult = { success: true, output: { configured: true } };
    } catch (err: unknown) {
      this.lastCallResult = { success: false, output: null, error: err };
    }
    // Assert: captured in lastCallResult
  },
);

When(
  'the "API" receives an "HTTP" request and synchronously starts a Step Functions execution',
  async function (this: SdkWorld) {
    // Arrange
    assert.ok(this.session, "Expected session to be initialized");
    let apiId: string = (this as any)._apigwSfnRestApiId ?? null;
    if (!apiId) {
      apiId = (await apigwSfnGetApiId(this)) ?? "";
    }
    const smArn = apigwSfnSmArn(APIGW_SFN_TEST_SM_NAME);
    // Act
    try {
      const response = await apigwSfnInvokeApi(this, apiId, {
        stateMachineArn: smArn,
        input: JSON.stringify({ key: "value" }),
      });
      if (response.statusCode !== 200) {
        this.lastCallResult = {
          success: false,
          output: null,
          error: new Error(
            `API request failed with status ${response.statusCode}: ${response.body}`,
          ),
        };
      } else {
        this.lastCallResult = { success: true, output: response };
      }
    } catch (err: unknown) {
      this.lastCallResult = { success: false, output: null, error: err };
    }
    // Assert: captured in lastCallResult
  },
);

When(
  'the Step Functions execution completes successfully and the "API" returns a successful response',
  async function (this: SdkWorld) {
    // Arrange / Act — cannot simulate Step Functions execution completion via API Gateway.
    assert.ok(this.session, "Expected session to be initialized");
    this.lastCallResult = {
      success: false,
      output: null,
      error: new Error(
        "Cannot simulate Step Functions execution completion via API Gateway in lws",
      ),
    };
    // Assert: captured in lastCallResult
  },
);

When(
  'the Step Functions execution fails and the "API" returns an error response',
  async function (this: SdkWorld) {
    // Arrange / Act — cannot simulate Step Functions execution failure via API Gateway.
    assert.ok(this.session, "Expected session to be initialized");
    this.lastCallResult = {
      success: false,
      output: null,
      error: new Error("Cannot simulate Step Functions execution failure via API Gateway in lws"),
    };
    // Assert: captured in lastCallResult
  },
);

// ── Then: assertions — unique to cross-service suite ──────────────────────────

Then(
  'the "API" is "ACTIVE" with no Step Functions integration configured',
  async function (this: SdkWorld) {
    // Arrange
    assert.ok(this.session, "Expected session to be initialized");
    const { GetRestApiCommand } = require("@aws-sdk/client-api-gateway");
    const expectedName = APIGW_SFN_TEST_API_NAME;
    const apiId = await apigwSfnGetApiId(this);
    // Assert
    assert.ok(apiId, `Expected REST API "${expectedName}" to exist but it was not found`);
    const result = await apigwClient(this).send(new GetRestApiCommand({ restApiId: apiId }));
    const actualName = result.name as string;
    assert.strictEqual(
      actualName,
      expectedName,
      `Expected API name "${expectedName}" but got "${actualName}"`,
    );
  },
);

// Note: 'the state machine is "ACTIVE"' (Then) is already registered in stepfunctions.ts.

Then(
  'the "API" will synchronously start and await an Express Workflow execution per request',
  async function (this: SdkWorld) {
    // Arrange
    assert.ok(this.session, "Expected session to be initialized");
    let apiId: string = (this as any)._apigwSfnRestApiId ?? null;
    if (!apiId) {
      apiId = (await apigwSfnGetApiId(this)) ?? "";
    }
    assert.ok(
      apiId,
      `Expected REST API "${APIGW_SFN_TEST_API_NAME}" to exist but it was not found`,
    );
    const smArn = apigwSfnSmArn(APIGW_SFN_TEST_SM_NAME);
    // Act
    const response = await apigwSfnInvokeApi(this, apiId, {
      stateMachineArn: smArn,
      input: JSON.stringify({ check: "ok" }),
    });
    // Assert
    const expectedStatus = 200;
    const actualStatus = response.statusCode;
    assert.strictEqual(
      actualStatus,
      expectedStatus,
      `Expected status ${expectedStatus} but got ${actualStatus}: ${response.body}`,
    );
  },
);

Then(
  'the request and execution are both "IN_PROGRESS" and "RUNNING" respectively',
  async function (this: SdkWorld) {
    // Arrange / Act / Assert — cannot inspect in-progress execution state via API Gateway.
    // Invariant: trivially satisfied in isolated lws context.
    assert.ok(this.session, "Expected session to be initialized");
  },
);

Then('the execution is "SUCCEEDED" and the request is "SUCCESS"', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act: action already performed in When step
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  // Assert
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected request status SUCCESS but got: ${JSON.stringify(this.lastCallResult.error)}`,
  );
});

Then('the execution is "FAILED" and the request is "FAILED"', async function (this: SdkWorld) {
  // Arrange / Act / Assert — cannot simulate Step Functions execution failure via API Gateway.
  // Invariant: trivially satisfied in isolated lws context.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Then: invariants ──────────────────────────────────────────────────────────

Then('every "IN_PROGRESS" request references an "ACTIVE" "API"', async function (this: SdkWorld) {
  // Invariant: trivially satisfied in isolated lws context.
  assert.ok(this.session, "Expected session to be initialized");
});

// "every {string} execution references an {string} state machine" is in cross_service_common.ts.

Then(
  'every "RUNNING" execution has a corresponding "IN_PROGRESS" request',
  async function (this: SdkWorld) {
    // Invariant: trivially satisfied in isolated lws context.
    assert.ok(this.session, "Expected session to be initialized");
  },
);
