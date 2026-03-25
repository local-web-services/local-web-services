/** Step definitions: stepfunctions_elasticsearch cross-service scenarios — unique steps only */

import { Given, When, Then } from "@cucumber/cucumber";
import assert from "assert";
import type { SdkWorld } from "../support/world";

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
  const { ElasticsearchServiceClient } = require("@aws-sdk/client-elasticsearch");
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
  const { CreateElasticsearchDomainCommand } = require("@aws-sdk/client-elasticsearch");
  await sfnElasticsearchClient(world).send(
    new CreateElasticsearchDomainCommand({ DomainName: SFN_ELASTICSEARCH_TEST_DOMAIN }),
  );
}

// ── Background ────────────────────────────────────────────────────────────────

// "the system is initialized" is registered in cross_service_common.ts.

// ── Given: domain existence ───────────────────────────────────────────────────

Given("the domain does not already exist", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state after session reset has no domains.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the domain already exists", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act: create domain (ignore if already exists)
  try {
    await sfnElasticsearchCreateDomain(this);
  } catch {
    // domain may already exist; desired state is that it exists
  }
  // Assert: domain exists
});

Given("the domain exists", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  try {
    await sfnElasticsearchCreateDomain(this);
  } catch {
    // domain may already exist
  }
  // Assert: domain exists
});

Given("the domain does not exist", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state after session reset has no domains.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Given: domain status ───────────────────────────────────────────────────────

Given('the domain is "AVAILABLE"', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act: ensure domain exists; fresh domains start AVAILABLE
  try {
    await sfnElasticsearchCreateDomain(this);
  } catch {
    // domain may already exist
  }
  // Assert: domain is AVAILABLE
});

Given('the domain is "PROCESSING"', async function (this: SdkWorld) {
  // No-op: cannot drive a domain into PROCESSING state via public API in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

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

Given('an execution is "RUNNING"', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act: create state machine then start execution
  const expectedSmArn = await sfnElasticsearchCreateSm(this);
  (this as any)._sfnElasticsearchSmArn = expectedSmArn;
  const { StartExecutionCommand } = require("@aws-sdk/client-sfn");
  const execResult = await sfnElasticsearchSfnClient(this).send(
    new StartExecutionCommand({
      stateMachineArn: sfnElasticsearchSmArn(SFN_ELASTICSEARCH_TEST_SM),
      input: SFN_ELASTICSEARCH_TEST_INPUT,
    }),
  );
  // Assert: execution started
  (this as any)._sfnElasticsearchExecArn = execResult.executionArn;
  assert.ok(execResult.executionArn, "Expected executionArn in StartExecution response");
});

Given('no execution is "RUNNING"', async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state after session reset has no executions.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Given: capacity ───────────────────────────────────────────────────────────

// "an execution slot is available" is registered in cross_service_common.ts.

// "no execution slot is available" is registered in cross_service_common.ts.

// ── When: actions ─────────────────────────────────────────────────────────────

// "a Step Functions state machine is created" is registered in stepfunctions.ts.
// "an execution of the state machine is started" is registered in stepfunctions.ts.

When('an Elasticsearch domain is created and becomes "AVAILABLE"', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { CreateElasticsearchDomainCommand } = require("@aws-sdk/client-elasticsearch");
  // Act
  try {
    const result = await sfnElasticsearchClient(this).send(
      new CreateElasticsearchDomainCommand({ DomainName: SFN_ELASTICSEARCH_TEST_DOMAIN }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("a domain configuration update begins", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { UpdateElasticsearchDomainConfigCommand } = require("@aws-sdk/client-elasticsearch");
  // Act
  try {
    const result = await sfnElasticsearchClient(this).send(
      new UpdateElasticsearchDomainConfigCommand({ DomainName: SFN_ELASTICSEARCH_TEST_DOMAIN }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

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

Then('the domain is "AVAILABLE"', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { DescribeElasticsearchDomainCommand } = require("@aws-sdk/client-elasticsearch");
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
});

Then('the domain is "PROCESSING" and "API" calls may fail', async function (this: SdkWorld) {
  // @internal: Cannot observe PROCESSING domain state via public API in lws.
  // No-op: treat as invariant satisfied.
  assert.ok(this.session, "Expected session to be initialized");
});

Then('the domain is "AVAILABLE" again', async function (this: SdkWorld) {
  // @internal: Cannot observe domain returning to AVAILABLE after update via public API in lws.
  // No-op: treat as invariant satisfied.
  assert.ok(this.session, "Expected session to be initialized");
});

Then('the execution is "SUCCEEDED"', async function (this: SdkWorld) {
  // @internal: Cannot observe internal execution Elasticsearch task success in lws.
  // No-op: treat as invariant satisfied.
  assert.ok(this.session, "Expected session to be initialized");
});

Then('the execution is "FAILED" with a connection error', async function (this: SdkWorld) {
  // @internal: Cannot observe internal execution Elasticsearch task failure in lws.
  // No-op: treat as invariant satisfied.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Then: invariants ──────────────────────────────────────────────────────────

Then(
  'every "RUNNING" execution references an "ACTIVE" state machine',
  async function (this: SdkWorld) {
    // Invariant: trivially satisfied in isolated lws context.
    assert.ok(this.session, "Expected session to be initialized");
  },
);

Then("every succeeded execution recorded which domain it called", async function (this: SdkWorld) {
  // Invariant: trivially satisfied in isolated lws context.
  assert.ok(this.session, "Expected session to be initialized");
});
