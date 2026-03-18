/** Step definitions: log_capture */

import { When, Then } from "@cucumber/cucumber";
import assert from "assert";
import type { SdkWorld } from "../support/world";

// ── Helper: make a service call ────────────────────────────────────────────────

async function makeCall(world: SdkWorld, service: string, operation: string): Promise<unknown> {
  assert.ok(world.session, "No session");

  if (service === "stepfunctions" && operation === "StartExecution") {
    const { SFNClient, StartExecutionCommand } = require("@aws-sdk/client-sfn");
    const client = world.session!.client<typeof SFNClient>("stepfunctions");
    const arn = await world.getStateMachineArn("OrderProcessor");
    return client.send(
      new StartExecutionCommand({
        stateMachineArn: arn,
        input: JSON.stringify({ test: true }),
      }),
    );
  }

  if (service === "dynamodb" && operation === "ListTables") {
    const { DynamoDBClient, ListTablesCommand } = require("@aws-sdk/client-dynamodb");
    const client = world.session!.client<typeof DynamoDBClient>("dynamodb");
    return client.send(new ListTablesCommand({}));
  }

  if (service === "stepfunctions" && operation === "ListStateMachines") {
    const { SFNClient, ListStateMachinesCommand } = require("@aws-sdk/client-sfn");
    const client = world.session!.client<typeof SFNClient>("stepfunctions");
    return client.send(new ListStateMachinesCommand({}));
  }

  throw new Error(`No log-capture call implementation for "${service}" "${operation}"`);
}

// ── Log capture steps ──────────────────────────────────────────────────────────

When(
  "I start log capture and call {string} {string}",
  async function (this: SdkWorld, service: string, operation: string) {
    assert.ok(this.session, "No session");
    const capture = await this.session!.captureLogsStart();
    try {
      await makeCall(this, service, operation);
    } finally {
      await capture.stop();
    }
    this.lastLogCapture = capture;
  },
);

When(
  "I start log capture and call both {string} {string} and {string} {string}",
  async function (
    this: SdkWorld,
    service1: string,
    operation1: string,
    service2: string,
    operation2: string,
  ) {
    assert.ok(this.session, "No session");
    const capture = await this.session!.captureLogsStart();
    try {
      await makeCall(this, service1, operation1);
      await makeCall(this, service2, operation2);
    } finally {
      await capture.stop();
    }
    this.lastLogCapture = capture;
  },
);

When(
  "I start log capture and call {string} {string} twice",
  async function (this: SdkWorld, service: string, operation: string) {
    assert.ok(this.session, "No session");
    const capture = await this.session!.captureLogsStart();
    try {
      await makeCall(this, service, operation);
      await makeCall(this, service, operation);
    } finally {
      await capture.stop();
    }
    this.lastLogCapture = capture;
  },
);

// ── Log assertions ─────────────────────────────────────────────────────────────

Then(
  "the log capture will contain a {string} {string} entry",
  function (this: SdkWorld, service: string, operation: string) {
    assert.ok(this.lastLogCapture, "No log capture available");
    this.lastLogCapture!.assertCalled(service, operation);
  },
);

Then("no errors will appear in the log capture", function (this: SdkWorld) {
  assert.ok(this.lastLogCapture, "No log capture available");
  this.lastLogCapture!.assertNoErrors();
});

Then(
  "filtering by service {string} returns only stepfunctions entries",
  function (this: SdkWorld, service: string) {
    assert.ok(this.lastLogCapture, "No log capture available");
    const entries = this.lastLogCapture!.forService(service);
    assert.ok(entries.length > 0, `Expected at least one ${service} entry but found none`);
    for (const entry of entries) {
      const entryService = (entry.service ?? "").toLowerCase();
      assert.strictEqual(
        entryService,
        service.toLowerCase(),
        `Expected all entries to be for "${service}" but found "${entryService}"`,
      );
    }
  },
);

Then(
  "filtering by service {string} returns only dynamodb entries",
  function (this: SdkWorld, service: string) {
    assert.ok(this.lastLogCapture, "No log capture available");
    const entries = this.lastLogCapture!.forService(service);
    assert.ok(entries.length > 0, `Expected at least one ${service} entry but found none`);
    for (const entry of entries) {
      const entryService = (entry.service ?? "").toLowerCase();
      assert.strictEqual(
        entryService,
        service.toLowerCase(),
        `Expected all entries to be for "${service}" but found "${entryService}"`,
      );
    }
  },
);

Then(
  "filtering by operation {string} returns at least one entry",
  function (this: SdkWorld, operation: string) {
    assert.ok(this.lastLogCapture, "No log capture available");
    const entries = this.lastLogCapture!.forOperation(operation);
    assert.ok(
      entries.length > 0,
      `Expected at least one "${operation}" entry but found none. All entries: ${JSON.stringify(
        this.lastLogCapture!.all,
      )}`,
    );
  },
);

Then(
  "the log capture will contain exactly {int} {string} {string} entries",
  function (this: SdkWorld, expectedCount: number, service: string, operation: string) {
    assert.ok(this.lastLogCapture, "No log capture available");
    const entries = this.lastLogCapture!.all.filter(
      (e) => (e.service ?? "").toLowerCase() === service.toLowerCase() && e.operation === operation,
    );
    assert.strictEqual(
      entries.length,
      expectedCount,
      `Expected exactly ${expectedCount} "${service}" "${operation}" entries but found ${
        entries.length
      }. All: ${JSON.stringify(this.lastLogCapture!.all)}`,
    );
  },
);

Then("recent logs are non-empty", async function (this: SdkWorld) {
  assert.ok(this.session, "No session");
  const port = (this.session as any)._basePort;
  const response = await fetch(`http://127.0.0.1:${port}/_ldk/logs`);
  assert.ok(response.ok, `Expected logs endpoint to respond OK but got ${response.status}`);
  const body = (await response.json()) as unknown;
  const logs = Array.isArray(body) ? body : ((body as any)?.logs ?? []);
  assert.ok(logs.length > 0, "Expected recent logs to be non-empty");
});
