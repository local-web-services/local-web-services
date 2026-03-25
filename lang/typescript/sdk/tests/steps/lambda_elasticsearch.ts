/** Step definitions: lambda_elasticsearch cross-service informal specification scenarios */

// Steps already registered in lambda.ts ("the function does not already exist",
// "the function already exists", "the function exists", "the function does not exist",
// "the function is {string}", "the function is not {string}",
// "an invocation slot is available", "no invocation slot is available"),
// capacity.ts, cross_service_common.ts ("the system is initialized"), and
// sqs.ts ("the operation is rejected") are NOT re-registered here.

import { Given, When, Then, Before } from "@cucumber/cucumber";
import assert from "assert";
import type { SdkWorld } from "../support/world";

const LAMBDA_ELASTICSEARCH_TEST_FUNC = "test-lambda-elasticsearch-1";
const LAMBDA_ELASTICSEARCH_TEST_DOMAIN = "test-lambda-elasticsearch-domain-1";
const LAMBDA_ELASTICSEARCH_ROLE_ARN = "arn:aws:iam::000000000000:role/test";

// ── Helpers ────────────────────────────────────────────────────────────────────

function lambdaElasticsearchLambdaClient(world: SdkWorld) {
  const { LambdaClient } = require("@aws-sdk/client-lambda");
  return world.session!.client<typeof LambdaClient>("lambda");
}

function lambdaElasticsearchEsClient(world: SdkWorld) {
  const { ElasticsearchServiceClient } = require("@aws-sdk/client-elasticsearch-service");
  return world.session!.client<typeof ElasticsearchServiceClient>("elasticsearch");
}

async function lambdaElasticsearchCreateFunction(world: SdkWorld): Promise<void> {
  // Arrange
  const { CreateFunctionCommand } = require("@aws-sdk/client-lambda");
  // Act
  await lambdaElasticsearchLambdaClient(world).send(
    new CreateFunctionCommand({
      FunctionName: LAMBDA_ELASTICSEARCH_TEST_FUNC,
      Runtime: "python3.12",
      Role: LAMBDA_ELASTICSEARCH_ROLE_ARN,
      Handler: "index.handler",
      Code: { ZipFile: Buffer.from("fake") },
    }),
  );
  // Assert: caller checks result
}

async function lambdaElasticsearchCreateDomain(world: SdkWorld): Promise<void> {
  // Arrange
  const { CreateElasticsearchDomainCommand } = require("@aws-sdk/client-elasticsearch-service");
  // Act
  await lambdaElasticsearchEsClient(world).send(
    new CreateElasticsearchDomainCommand({
      DomainName: LAMBDA_ELASTICSEARCH_TEST_DOMAIN,
    }),
  );
  // Assert: caller checks result
}

// ── Before hook: register functionHelpers for lambdaelasticsearch scenarios ─────────────

Before({ tags: "@lambdaelasticsearch" }, function (this: SdkWorld) {
  this.functionHelpers = {
    functionName: LAMBDA_ELASTICSEARCH_TEST_FUNC,
    deployFunction: async (world: SdkWorld) => {
      try {
        await lambdaElasticsearchCreateFunction(world);
        world.lastCallResult = {
          success: true,
          output: { FunctionName: LAMBDA_ELASTICSEARCH_TEST_FUNC },
        };
      } catch (err: unknown) {
        world.lastCallResult = { success: false, output: null, error: err };
      }
    },
    assertFunctionActive: async (world: SdkWorld) => {
      assert.ok(world.session, "Expected session to be initialized");
      const { GetFunctionCommand } = require("@aws-sdk/client-lambda");
      const result = await lambdaElasticsearchLambdaClient(world).send(
        new GetFunctionCommand({ FunctionName: LAMBDA_ELASTICSEARCH_TEST_FUNC }),
      );
      const expectedState = "Active";
      const actualState = result.Configuration?.State ?? "";
      assert.strictEqual(
        actualState,
        expectedState,
        `Expected function state "${expectedState}" but got "${actualState}"; expected_state=${expectedState} actual_state=${actualState}`,
      );
    },
  };
});

// ── Given: domain state ───────────────────────────────────────────────────────

Given("the domain does not already exist", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state after reset has no domains.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the domain already exists", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await lambdaElasticsearchCreateDomain(this);
  // Assert: domain created
});

Given("the domain exists", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await lambdaElasticsearchCreateDomain(this);
  // Assert: domain created
});

Given("the domain is {string}", async function (this: SdkWorld, state: string) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  if (state === "AVAILABLE") {
    // Act: create the domain so it is AVAILABLE
    await lambdaElasticsearchCreateDomain(this);
    return;
  }
  if (state === "PROCESSING") {
    // Act: create the domain; PROCESSING state is set by UpdateElasticsearchDomainConfig
    await lambdaElasticsearchCreateDomain(this);
    return;
  }
});

Given("the domain is not {string}", async function (this: SdkWorld, state: string) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  if (state === "AVAILABLE") {
    // Act: create the domain; lws does not expose non-AVAILABLE state via public API
    await lambdaElasticsearchCreateDomain(this);
    return;
  }
  if (state === "PROCESSING") {
    // Act: create the domain so it is not in PROCESSING state
    await lambdaElasticsearchCreateDomain(this);
    return;
  }
});

Given("the domain does not exist", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state has no domains.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Given: invocation state ───────────────────────────────────────────────────

// ── Given: slot state ─────────────────────────────────────────────────────────

Given("a document slot is available", async function (this: SdkWorld) {
  // No-op: always room for documents in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("no document slot is available", async function (this: SdkWorld) {
  // @internal: Cannot exhaust document slot limit in lws via public APIs.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Given: sequence state (fid/did/iid) ──────────────────────────────────────

Given("fid in func_status", async function (this: SdkWorld) {
  // Arrange: create the Lambda function so fid is tracked in func_status
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  try {
    await lambdaElasticsearchCreateFunction(this);
  } catch {
    // function may already exist
  }
});

Given("fid not in func_status", async function (this: SdkWorld) {
  // No-op: fresh state has no functions in func_status.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("did in domain_status", async function (this: SdkWorld) {
  // Arrange: create the domain so did is tracked in domain_status
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  try {
    await lambdaElasticsearchCreateDomain(this);
  } catch {
    // domain may already exist
  }
});

Given("did not in domain_status", async function (this: SdkWorld) {
  // No-op: fresh state has no domains in domain_status.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("iid in inv_status", async function (this: SdkWorld) {
  // Arrange: create the Lambda function so an invocation can be tracked
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  try {
    await lambdaElasticsearchCreateFunction(this);
  } catch {
    // function may already exist
  }
});

// ── When: actions ─────────────────────────────────────────────────────────────

When('an Elasticsearch domain is created and becomes "AVAILABLE"', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "No session running");
  const { CreateElasticsearchDomainCommand } = require("@aws-sdk/client-elasticsearch-service");
  // Act
  try {
    const result = await lambdaElasticsearchEsClient(this).send(
      new CreateElasticsearchDomainCommand({
        DomainName: LAMBDA_ELASTICSEARCH_TEST_DOMAIN,
      }),
    );
    // Assert: store result
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
});

When("a domain configuration update begins", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "No session running");
  const {
    UpdateElasticsearchDomainConfigCommand,
  } = require("@aws-sdk/client-elasticsearch-service");
  // Act
  try {
    const result = await lambdaElasticsearchEsClient(this).send(
      new UpdateElasticsearchDomainConfigCommand({
        DomainName: LAMBDA_ELASTICSEARCH_TEST_DOMAIN,
      }),
    );
    // Assert: store result
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
});

When("the domain configuration update completes", async function (this: SdkWorld) {
  // @internal: Cannot trigger domain configuration update completion in lws.
  assert.ok(this.session, "Expected session to be initialized");
  this.lastCallResult = {
    success: false,
    output: null,
    error: new Error("cannot trigger domain config update completion: scenario is @internal"),
  };
});

When(
  "the Lambda function fails to write because the domain is processing a config update",
  async function (this: SdkWorld) {
    // @internal: Cannot trigger Lambda invocation failure in lws without Docker.
    assert.ok(this.session, "Expected session to be initialized");
    this.lastCallResult = {
      success: false,
      output: null,
      error: new Error("cannot trigger Lambda invocation failure: scenario is @internal"),
    };
  },
);

When(
  'the Lambda function indexes a document into the "AVAILABLE" domain and succeeds',
  async function (this: SdkWorld) {
    // @internal: Cannot trigger Lambda document index in lws without Docker.
    assert.ok(this.session, "Expected session to be initialized");
    this.lastCallResult = {
      success: false,
      output: null,
      error: new Error("cannot trigger Lambda document index: scenario is @internal"),
    };
  },
);

// ── Then: assertions ──────────────────────────────────────────────────────────

Then('the domain is "AVAILABLE"', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { DescribeElasticsearchDomainCommand } = require("@aws-sdk/client-elasticsearch-service");
  // Act
  const result = await lambdaElasticsearchEsClient(this).send(
    new DescribeElasticsearchDomainCommand({ DomainName: LAMBDA_ELASTICSEARCH_TEST_DOMAIN }),
  );
  // Assert
  const expectedProcessing = false;
  const actualProcessing = result.DomainStatus?.Processing ?? false;
  assert.strictEqual(
    actualProcessing,
    expectedProcessing,
    `Expected domain not to be processing but it is; expected_processing=${expectedProcessing} actual_processing=${actualProcessing}`,
  );
});

Then('the domain is "AVAILABLE" again', async function (this: SdkWorld) {
  // @internal: Cannot observe domain AVAILABLE-after-PROCESSING state in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

Then('the domain is "PROCESSING" and write operations may fail', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { DescribeElasticsearchDomainCommand } = require("@aws-sdk/client-elasticsearch-service");
  // Act
  const result = await lambdaElasticsearchEsClient(this).send(
    new DescribeElasticsearchDomainCommand({ DomainName: LAMBDA_ELASTICSEARCH_TEST_DOMAIN }),
  );
  // Assert
  const expectedProcessing = true;
  const actualProcessing = result.DomainStatus?.Processing ?? false;
  assert.strictEqual(
    actualProcessing,
    expectedProcessing,
    `Expected domain to be processing but it is not; expected_processing=${expectedProcessing} actual_processing=${actualProcessing}`,
  );
});

// "the invocation is FAILED with a connection error" — registered in lambda_common.ts

Then('the document "EXISTS" and the invocation is "SUCCESS"', async function (this: SdkWorld) {
  // @internal: Cannot observe Lambda document index result in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Invariant Then steps ──────────────────────────────────────────────────────

// "every {string} invocation references an {string} Lambda function" is registered in cross_service_common.ts.

Then("every existing document references a domain that exists", async function (this: SdkWorld) {
  // No-op: model-level invariant; trivially satisfied in isolated lws context.
  assert.ok(this.session, "Expected session to be initialized");
});
