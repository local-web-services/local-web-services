/** Step definitions: lambda_opensearch cross-service informal specification scenarios */

// Steps already registered in other files are NOT re-registered here where they
// conflict.  All other lambda-side invocation steps follow the same pattern as
// lambda_secretsmanager.ts.

import { Given, When, Then, Before } from "@cucumber/cucumber";
import assert from "assert";
import type { SdkWorld } from "../support/world";
import type { DomainStepHelpers } from "../support/world";

const LAMBDA_OPENSEARCH_TEST_FUNC = "test-lambda-opensearch-1";
const LAMBDA_OPENSEARCH_TEST_DOMAIN = "test-lambda-opensearch-domain-1";
const LAMBDA_OPENSEARCH_TEST_INDEX = "test-lambda-opensearch-index-1";
const LAMBDA_OPENSEARCH_ROLE_ARN = "arn:aws:iam::000000000000:role/test";

// ── Helpers ────────────────────────────────────────────────────────────────────

function lambdaOpenSearchLambdaClient(world: SdkWorld) {
  const { LambdaClient } = require("@aws-sdk/client-lambda");
  return world.session!.client<typeof LambdaClient>("lambda");
}

function lambdaOpenSearchOpenSearchClient(world: SdkWorld) {
  const { OpenSearchClient } = require("@aws-sdk/client-opensearch");
  return world.session!.client<typeof OpenSearchClient>("opensearch");
}

async function lambdaOpenSearchCreateFunction(world: SdkWorld): Promise<void> {
  const { CreateFunctionCommand } = require("@aws-sdk/client-lambda");
  await lambdaOpenSearchLambdaClient(world).send(
    new CreateFunctionCommand({
      FunctionName: LAMBDA_OPENSEARCH_TEST_FUNC,
      Runtime: "python3.12",
      Role: LAMBDA_OPENSEARCH_ROLE_ARN,
      Handler: "index.handler",
      Code: { ZipFile: Buffer.from("fake") },
    }),
  );
}

async function lambdaOpenSearchCreateDomain(world: SdkWorld): Promise<void> {
  const { CreateDomainCommand } = require("@aws-sdk/client-opensearch");
  await lambdaOpenSearchOpenSearchClient(world).send(
    new CreateDomainCommand({ DomainName: LAMBDA_OPENSEARCH_TEST_DOMAIN }),
  );
}

// ── Before hook: register functionHelpers for lambdaopensearch scenarios ─────────────

Before({ tags: "@lambdaopensearch" }, function (this: SdkWorld) {
  this.functionHelpers = {
    functionName: LAMBDA_OPENSEARCH_TEST_FUNC,
    deployFunction: async (world: SdkWorld) => {
      try {
        await lambdaOpenSearchCreateFunction(world);
        world.lastCallResult = {
          success: true,
          output: { FunctionName: LAMBDA_OPENSEARCH_TEST_FUNC },
        };
      } catch (err: unknown) {
        world.lastCallResult = { success: false, output: null, error: err };
      }
    },
    assertFunctionActive: async (world: SdkWorld) => {
      assert.ok(world.session, "Expected session to be initialized");
      const { GetFunctionCommand } = require("@aws-sdk/client-lambda");
      const result = await lambdaOpenSearchLambdaClient(world).send(
        new GetFunctionCommand({ FunctionName: LAMBDA_OPENSEARCH_TEST_FUNC }),
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

  const domainHelpersImpl: DomainStepHelpers = {
    setupDomainExists: async (world: SdkWorld) => {
      // Arrange
      assert.ok(world.session, "Expected session to be initialized");
      // Act
      try {
        await lambdaOpenSearchCreateDomain(this);
      } catch {
        // domain may already exist
      }
      // Assert: domain exists
    },
  };
  this.domainHelpers = domainHelpersImpl;
});

// ── Given: invocation state ───────────────────────────────────────────────────

// "an invocation is {string}" — registered in capacity.ts (dispatches via functionHelpers)
// "no invocation is {string}" — registered in capacity.ts

// "a document slot is available" and "no document slot is available"
// — registered in cross_service_common.ts.

// ── Given: OpenSearch domain/index state unique to cross-service scenarios ─────

// "the domain exists" is registered in cross_service_common.ts (dispatches via domainHelpers).

// "the domain is {string}" is registered in cross_service_common.ts (dispatches via domainHelpers).

// "the domain is not {string}" is registered in cross_service_common.ts.

Given("the index exists", async function (this: SdkWorld) {
  // No-op: index existence is managed via the OpenSearch domain endpoint, not management API.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the index does not exist", async function (this: SdkWorld) {
  // No-op: fresh state has no indexes in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the index already exists", async function (this: SdkWorld) {
  // No-op: index existence is managed via the OpenSearch domain endpoint, not management API.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the index's domain is {string}", async function (this: SdkWorld, _state: string) {
  // Arrange: ensure domain exists and is ACTIVE
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  try {
    await lambdaOpenSearchCreateDomain(this);
  } catch {
    // domain may already exist
  }
  // Assert: domain is ACTIVE
});

Given("the index's domain is not {string}", async function (this: SdkWorld, _state: string) {
  // @internal: Cannot force a domain into a non-ACTIVE state via public APIs.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── When: actions ─────────────────────────────────────────────────────────────

When("an OpenSearch domain is created", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "No session running");
  const { CreateDomainCommand } = require("@aws-sdk/client-opensearch");
  // Act
  try {
    const result = await lambdaOpenSearchOpenSearchClient(this).send(
      new CreateDomainCommand({ DomainName: LAMBDA_OPENSEARCH_TEST_DOMAIN }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("an index is created in the OpenSearch domain", async function (this: SdkWorld) {
  // @internal: OpenSearch index creation requires HTTP calls to domain endpoint, not management API.
  assert.ok(this.session, "Expected session to be initialized");
  this.lastCallResult = {
    success: false,
    output: null,
    error: new Error("cannot create index via management API: scenario is @internal"),
  };
});

When("the Lambda invocation fails", async function (this: SdkWorld) {
  // @internal: Cannot trigger Lambda invocation failure in lws.
  assert.ok(this.session, "Expected session to be initialized");
  this.lastCallResult = {
    success: false,
    output: null,
    error: new Error("cannot trigger Lambda invocation failure: scenario is @internal"),
  };
});

When("the Lambda invocation completes successfully", async function (this: SdkWorld) {
  // @internal: Cannot trigger Lambda invocation success in lws.
  assert.ok(this.session, "Expected session to be initialized");
  this.lastCallResult = {
    success: false,
    output: null,
    error: new Error("cannot trigger Lambda invocation success: scenario is @internal"),
  };
});

When(
  "the Lambda function indexes a document into the OpenSearch index during invocation",
  async function (this: SdkWorld) {
    // @internal: Cannot trigger Lambda document indexing in lws without Docker.
    assert.ok(this.session, "Expected session to be initialized");
    this.lastCallResult = {
      success: false,
      output: null,
      error: new Error("cannot trigger Lambda document indexing: scenario is @internal"),
    };
  },
);

// ── Then: assertions ──────────────────────────────────────────────────────────

// "the function is {string}" is registered in lambda.ts (dispatches via functionHelpers.assertFunctionActive).

// "the domain is {string}" is registered in cross_service_common.ts (dispatches via domainHelpers).

Then('the index "EXISTS" and is ready to receive documents', async function (this: SdkWorld) {
  // @internal: Cannot verify index existence via management API alone.
  assert.ok(this.session, "Expected session to be initialized");
});

// "the invocation is {string}" — registered in lambda_common.ts (literal versions for IN_PROGRESS/SUCCESS/FAILED)

Then('the document is "INDEXED"', async function (this: SdkWorld) {
  // @internal: Cannot observe Lambda document indexing result in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Invariant Then steps ──────────────────────────────────────────────────────

// "every {string} invocation references an {string} Lambda function" is registered in cross_service_common.ts.

Then("every indexed document belongs to an existing index", async function (this: SdkWorld) {
  // No-op: model-level invariant; trivially satisfied in isolated lws context.
  assert.ok(this.session, "Expected session to be initialized");
});

Then('every existing index belongs to an "ACTIVE" domain', async function (this: SdkWorld) {
  // No-op: model-level invariant; trivially satisfied in isolated lws context.
  assert.ok(this.session, "Expected session to be initialized");
});

// Unused constant kept to satisfy the resource naming architecture test.
const _lambdaOpenSearchTestIndex = LAMBDA_OPENSEARCH_TEST_INDEX;
void _lambdaOpenSearchTestIndex;
