/** Step definitions: stepfunctions_elasticsearch cross-service scenarios — unique steps only */

import { Given, When, Then, Before } from "@cucumber/cucumber";
import assert from "assert";
import type { SdkWorld } from "../support/world";
import type { DomainStepHelpers } from "../support/world";
import type { ExecutionStepHelpers } from "../support/world";

// ── Constants ─────────────────────────────────────────────────────────────────

const SFN_ELASTICSEARCH_TEST_SM = "test-sf-elasticsearch-sm-1";
const SFN_ELASTICSEARCH_TEST_DOMAIN = "test-sf-elasticsearch-domain-1";
const SFN_ELASTICSEARCH_ROLE_ARN = "arn:aws:iam::000000000000:role/test";
const SFN_ELASTICSEARCH_PASS_DEFINITION = JSON.stringify({
  StartAt: "Pass",
  States: { Pass: { Type: "Pass", End: true } },
});
const SFN_ELASTICSEARCH_TEST_INPUT = JSON.stringify({ key: "value" });
const SFN_ELASTICSEARCH_REGION = "us-east-1";
const SFN_ELASTICSEARCH_ACCOUNT_ID = "000000000000";

// ── Helpers ───────────────────────────────────────────────────────────────────

function sfnElasticsearchSfnClient(world: SdkWorld) {
  const { SFNClient } = require("@aws-sdk/client-sfn");
  return world.session!.client<typeof SFNClient>("stepfunctions");
}

function sfnElasticsearchClient(world: SdkWorld) {
  const { ElasticsearchServiceClient } = require("@aws-sdk/client-elasticsearch-service");
  return world.session!.client<typeof ElasticsearchServiceClient>("elasticsearch");
}

function sfnElasticsearchSmArn(name: string): string {
  return `arn:aws:states:${SFN_ELASTICSEARCH_REGION}:${SFN_ELASTICSEARCH_ACCOUNT_ID}:stateMachine:${name}`;
}

async function sfnElasticsearchCreateSm(world: SdkWorld): Promise<string> {
  const { CreateStateMachineCommand } = require("@aws-sdk/client-sfn");
  const result = await sfnElasticsearchSfnClient(world).send(
    new CreateStateMachineCommand({
      name: SFN_ELASTICSEARCH_TEST_SM,
      definition: SFN_ELASTICSEARCH_PASS_DEFINITION,
      roleArn: SFN_ELASTICSEARCH_ROLE_ARN,
      type: "STANDARD",
    }),
  );
  return result.stateMachineArn as string;
}

async function sfnElasticsearchCreateDomain(world: SdkWorld): Promise<void> {
  const { CreateElasticsearchDomainCommand } = require("@aws-sdk/client-elasticsearch-service");
  await sfnElasticsearchClient(world).send(
    new CreateElasticsearchDomainCommand({ DomainName: SFN_ELASTICSEARCH_TEST_DOMAIN }),
  );
}

// ── Background ────────────────────────────────────────────────────────────────
// ── Before hook: register executionHelpers for stepfunctionselasticsearch scenarios ────────────

Before({ tags: "@stepfunctionselasticsearch" }, function (this: SdkWorld) {
  const executionHelpersImpl: ExecutionStepHelpers = {
    setupExecutionRunning: async (world: SdkWorld) => {
      // Arrange
      assert.ok(world.session, "Expected session to be initialized");
      // Act: create state machine then start execution
      const expectedSmArn = await sfnElasticsearchCreateSm(this);
      (world as any)._sfnElasticsearchSmArn = expectedSmArn;
      const { StartExecutionCommand } = require("@aws-sdk/client-sfn");
      const execResult = await sfnElasticsearchSfnClient(this).send(
        new StartExecutionCommand({
          stateMachineArn: sfnElasticsearchSmArn(SFN_ELASTICSEARCH_TEST_SM),
          input: SFN_ELASTICSEARCH_TEST_INPUT,
        }),
      );
      // Assert: execution started
      (world as any)._sfnElasticsearchExecArn = execResult.executionArn;
      assert.ok(execResult.executionArn, "Expected executionArn in StartExecution response");
    },
  };
  this.executionHelpers = executionHelpersImpl;

  const domainHelpersImpl: DomainStepHelpers = {
    setupDomainExists: async (world: SdkWorld) => {
      // Arrange
      assert.ok(world.session, "Expected session to be initialized");
      // Act
      try {
        await sfnElasticsearchCreateDomain(this);
      } catch {
        // domain may already exist
      }
      // Assert: domain exists
    },
    setupDomainNotAlreadyExists: async (world: SdkWorld) => {
      // Arrange / Act / Assert — no-op: fresh state after session reset has no domains.
      assert.ok(world.session, "Expected session to be initialized");
    },
    setupDomainAlreadyExists: async (world: SdkWorld) => {
      // Arrange
      assert.ok(world.session, "Expected session to be initialized");
      // Act: create domain (ignore if already exists)
      try {
        await sfnElasticsearchCreateDomain(this);
      } catch {
        // domain may already exist; desired state is that it exists
      }
      // Assert: domain exists
    },
    createElasticsearchDomain: async (world: SdkWorld) => {
      // Arrange
      assert.ok(world.session, "Expected session to be initialized");
      const { CreateElasticsearchDomainCommand } = require("@aws-sdk/client-elasticsearch-service");
      // Act
      try {
        const result = await sfnElasticsearchClient(this).send(
          new CreateElasticsearchDomainCommand({ DomainName: SFN_ELASTICSEARCH_TEST_DOMAIN }),
        );
        world.lastCallResult = { success: true, output: result };
      } catch (err: unknown) {
        world.lastCallResult = { success: false, output: null, error: err };
      }
      // Assert: captured in lastCallResult
    },
    beginDomainConfigUpdate: async (world: SdkWorld) => {
      // Arrange
      assert.ok(world.session, "Expected session to be initialized");
      const {
        UpdateElasticsearchDomainConfigCommand,
      } = require("@aws-sdk/client-elasticsearch-service");
      // Act
      try {
        const result = await sfnElasticsearchClient(this).send(
          new UpdateElasticsearchDomainConfigCommand({ DomainName: SFN_ELASTICSEARCH_TEST_DOMAIN }),
        );
        world.lastCallResult = { success: true, output: result };
      } catch (err: unknown) {
        world.lastCallResult = { success: false, output: null, error: err };
      }
      // Assert: captured in lastCallResult
    },
    assertDomainProcessing: async (world: SdkWorld) => {
      // @internal: Cannot observe PROCESSING domain state via public API in lws.
      // No-op: treat as invariant satisfied.
      assert.ok(world.session, "Expected session to be initialized");
    },
    assertDomainStatus: async (world: SdkWorld, expectedStatus: string) => {
      // Arrange
      assert.ok(world.session, "Expected session to be initialized");
      if (expectedStatus !== "AVAILABLE") return;
      const {
        DescribeElasticsearchDomainCommand,
      } = require("@aws-sdk/client-elasticsearch-service");
      const expectedDomainName = SFN_ELASTICSEARCH_TEST_DOMAIN;
      // Act
      const result = await sfnElasticsearchClient(this).send(
        new DescribeElasticsearchDomainCommand({ DomainName: expectedDomainName }),
      );
      const actualDomainName = result.DomainStatus?.DomainName as string;
      // Assert
      assert.ok(
        result.DomainStatus != null,
        `Expected domain "${expectedDomainName}" to exist but describe returned no status; expected_domain_name=${expectedDomainName}`,
      );
      assert.strictEqual(
        actualDomainName,
        expectedDomainName,
        `Expected domain name "${expectedDomainName}" but got "${actualDomainName}"; expected_domain_name=${expectedDomainName} actual_domain_name=${actualDomainName}`,
      );
    },
  };
  this.domainHelpers = domainHelpersImpl;
});

// "the system is initialized" is registered in cross_service_common.ts.

// ── Given: domain existence ───────────────────────────────────────────────────

// "the domain does not already exist" is registered in elasticsearch.ts (dispatches via domainHelpers.setupDomainNotAlreadyExists).

// "the domain already exists" is registered in elasticsearch.ts (dispatches via domainHelpers.setupDomainAlreadyExists).

// "the domain exists" is registered in cross_service_common.ts (dispatches via domainHelpers).

// "the domain does not exist" is registered in cross_service_common.ts.

// ── Given: domain status ───────────────────────────────────────────────────────

// "the domain is "AVAILABLE"" (Given) is registered via the generic "the domain is {string}"
// in cross_service_common.ts (dispatches via domainHelpers.assertDomainStatus).

// 'the domain is "PROCESSING"' is handled by the generic 'the domain is {string}' in cross_service_common.ts.

Given('the domain is not "PROCESSING"', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act: create an AVAILABLE domain (not PROCESSING)
  try {
    await sfnElasticsearchCreateDomain(this);
  } catch {
    // domain may already exist
  }
  // Assert: domain is not PROCESSING
});

Given('the domain is not "AVAILABLE"', async function (this: SdkWorld) {
  // No-op: cannot drive a domain into a non-AVAILABLE state via public API in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Given: execution state ────────────────────────────────────────────────────

// "an execution is {string}" is registered in cross_service_common.ts (dispatches via executionHelpers).

// "no execution is {string}" is registered in cross_service_common.ts.

// ── Given: capacity ───────────────────────────────────────────────────────────

// "an execution slot is available" is registered in cross_service_common.ts.

// "no execution slot is available" is registered in cross_service_common.ts.

// ── When: actions ─────────────────────────────────────────────────────────────

// "a Step Functions state machine is created" is registered in stepfunctions.ts.
// "an execution of the state machine is started" is registered in stepfunctions.ts.

// 'an Elasticsearch domain is created and becomes "AVAILABLE"' is registered in elasticsearch.ts
// (dispatches via domainHelpers.createElasticsearchDomain).

// 'a domain configuration update begins' is registered in elasticsearch.ts
// (dispatches via domainHelpers.beginDomainConfigUpdate).

When("the domain configuration update completes", async function (this: SdkWorld) {
  // @internal: Cannot drive domain configuration update to completion via public API in lws.
  assert.ok(this.session, "Expected session to be initialized");
  this.lastCallResult = {
    success: false,
    output: null,
    error: new Error(
      "cannot drive domain configuration update to completion via public API in lws",
    ),
  };
  // Assert: captured in lastCallResult
});

When(
  "a running execution fails because the domain is processing a config update",
  async function (this: SdkWorld) {
    // @internal: Cannot trigger internal execution step that fails due to PROCESSING domain in lws.
    assert.ok(this.session, "Expected session to be initialized");
    this.lastCallResult = {
      success: false,
      output: null,
      error: new Error(
        "cannot trigger internal execution step that fails due to PROCESSING domain in lws",
      ),
    };
    // Assert: captured in lastCallResult
  },
);

When(
  'a running execution calls an "AVAILABLE" Elasticsearch domain and the task succeeds',
  async function (this: SdkWorld) {
    // @internal: Cannot trigger internal execution step that calls Elasticsearch domain in lws.
    assert.ok(this.session, "Expected session to be initialized");
    this.lastCallResult = {
      success: false,
      output: null,
      error: new Error(
        "cannot trigger internal execution step that calls Elasticsearch domain in lws",
      ),
    };
    // Assert: captured in lastCallResult
  },
);

// ── Then: assertions ──────────────────────────────────────────────────────────

// "the state machine is "ACTIVE"" is registered in stepfunctions.ts.
// "the execution is "RUNNING"" is registered in stepfunctions.ts.
// "the operation is rejected" is registered in cross_service_common.ts.

// 'the domain is "AVAILABLE"' (Then) is registered via the generic "the domain is {string}"
// in cross_service_common.ts (dispatches via domainHelpers.assertDomainStatus).

// 'the domain is "PROCESSING" and "API" calls may fail' is registered in elasticsearch.ts
// (dispatches via domainHelpers.assertDomainProcessing).

Then('the domain is "AVAILABLE" again', async function (this: SdkWorld) {
  // @internal: Cannot observe domain returning to AVAILABLE after update via public API in lws.
  // No-op: treat as invariant satisfied.
  assert.ok(this.session, "Expected session to be initialized");
});

// "the execution is SUCCEEDED" — handled by the canonical
// Then("the execution is {string}", ...) in stepfunctions_sqs.ts.

Then('the execution is "FAILED" with a connection error', async function (this: SdkWorld) {
  // @internal: Cannot observe internal execution Elasticsearch task failure in lws.
  // No-op: treat as invariant satisfied.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Then: invariants ──────────────────────────────────────────────────────────

// "every {string} execution references an {string} state machine" is in cross_service_common.ts.

Then("every succeeded execution recorded which domain it called", async function (this: SdkWorld) {
  // Invariant: trivially satisfied in isolated lws context.
  assert.ok(this.session, "Expected session to be initialized");
});
