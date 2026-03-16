/** Step Functions step definitions. */

import { Given, When, Then } from "@cucumber/cucumber";
import assert from "assert";
import {
  CreateStateMachineCommand,
  DeleteStateMachineCommand,
  DescribeStateMachineCommand,
  ListStateMachinesCommand,
  StartExecutionCommand,
  StartSyncExecutionCommand,
  StopExecutionCommand,
  DescribeExecutionCommand,
  GetExecutionHistoryCommand,
  ListExecutionsCommand,
  ListStateMachineVersionsCommand,
  TagResourceCommand,
  UntagResourceCommand,
  ListTagsForResourceCommand,
  UpdateStateMachineCommand,
  ValidateStateMachineDefinitionCommand,
} from "@aws-sdk/client-sfn";
import type { LwsWorld } from "../support/world";

const ACCOUNT = "000000000000";
const REGION = "us-east-1";

const PASS_DEFINITION = JSON.stringify({
  Comment: "A simple pass state machine",
  StartAt: "Pass",
  States: { Pass: { Type: "Pass", End: true } },
});

function smArn(smName: string): string {
  return `arn:aws:states:${REGION}:${ACCOUNT}:stateMachine:${smName}`;
}

async function createStateMachine(world: LwsWorld, smName: string, type = "STANDARD"): Promise<string> {
  const client = world.sfnClient();
  const result = await client.send(
    new CreateStateMachineCommand({
      name: smName,
      definition: PASS_DEFINITION,
      roleArn: `arn:aws:iam::${ACCOUNT}:role/dummy-role`,
      type: type as "STANDARD" | "EXPRESS",
    })
  );
  return result.stateMachineArn!;
}

// --- Given -----------------------------------------------------------------

Given("a state machine {string} was created with a Pass definition", async function (
  this: LwsWorld,
  smName: string
) {
  const arn = await createStateMachine(this, smName);
  this.lastStateMachineArn = arn;
});

Given("an EXPRESS state machine {string} was created with a Pass definition", async function (
  this: LwsWorld,
  smName: string
) {
  const arn = await createStateMachine(this, smName, "EXPRESS");
  this.lastStateMachineArn = arn;
});

Given("an execution was started on state machine {string} with input {string}", async function (
  this: LwsWorld,
  smName: string,
  input: string
) {
  const client = this.sfnClient();
  const arn = smArn(smName);
  const result = await client.send(
    new StartExecutionCommand({ stateMachineArn: arn, input })
  );
  this.lastExecutionArn = result.executionArn;
});

// --- When ------------------------------------------------------------------

When("I create a state machine named {string} with a Pass definition", async function (
  this: LwsWorld,
  smName: string
) {
  const client = this.sfnClient();
  try {
    const result = await client.send(
      new CreateStateMachineCommand({
        name: smName,
        definition: PASS_DEFINITION,
        roleArn: `arn:aws:iam::${ACCOUNT}:role/dummy-role`,
        type: "STANDARD",
      })
    );
    this.lastStateMachineArn = result.stateMachineArn;
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I delete state machine {string}", async function (this: LwsWorld, smName: string) {
  const client = this.sfnClient();
  const arn = smArn(smName);
  try {
    const result = await client.send(new DeleteStateMachineCommand({ stateMachineArn: arn }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I describe state machine {string}", async function (this: LwsWorld, smName: string) {
  const client = this.sfnClient();
  const arn = smArn(smName);
  try {
    const result = await client.send(new DescribeStateMachineCommand({ stateMachineArn: arn }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I list state machines", async function (this: LwsWorld) {
  const client = this.sfnClient();
  try {
    const result = await client.send(new ListStateMachinesCommand({}));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I start an execution on state machine {string} with input {string}", async function (
  this: LwsWorld,
  smName: string,
  input: string
) {
  const client = this.sfnClient();
  const arn = smArn(smName);
  try {
    const result = await client.send(new StartExecutionCommand({ stateMachineArn: arn, input }));
    this.lastExecutionArn = result.executionArn;
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I start a sync execution on state machine {string} with input {string}", async function (
  this: LwsWorld,
  smName: string,
  input: string
) {
  const client = this.sfnClient();
  const arn = smArn(smName);
  try {
    const result = await client.send(
      new StartSyncExecutionCommand({ stateMachineArn: arn, input })
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I stop the started execution", async function (this: LwsWorld) {
  const client = this.sfnClient();
  try {
    const result = await client.send(
      new StopExecutionCommand({ executionArn: this.lastExecutionArn! })
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I describe the started execution", async function (this: LwsWorld) {
  const client = this.sfnClient();
  try {
    const result = await client.send(
      new DescribeExecutionCommand({ executionArn: this.lastExecutionArn! })
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I get execution history for the started execution", async function (this: LwsWorld) {
  const client = this.sfnClient();
  try {
    const result = await client.send(
      new GetExecutionHistoryCommand({ executionArn: this.lastExecutionArn! })
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I list executions for state machine {string}", async function (
  this: LwsWorld,
  smName: string
) {
  const client = this.sfnClient();
  const arn = smArn(smName);
  try {
    const result = await client.send(new ListExecutionsCommand({ stateMachineArn: arn }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I list state machine versions for {string}", async function (
  this: LwsWorld,
  smName: string
) {
  const client = this.sfnClient();
  const arn = smArn(smName);
  try {
    const result = await client.send(
      new ListStateMachineVersionsCommand({ stateMachineArn: arn })
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I list tags for state machine {string}", async function (
  this: LwsWorld,
  smName: string
) {
  const client = this.sfnClient();
  const arn = smArn(smName);
  try {
    const result = await client.send(new ListTagsForResourceCommand({ resourceArn: arn }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I tag state machine {string} with tags [\\{{string}: {string}, {string}: {string}}]", async function (
  this: LwsWorld,
  smName: string,
  _k1: string,
  _v1: string,
  _k2: string,
  _v2: string
) {
  const client = this.sfnClient();
  const arn = smArn(smName);
  try {
    const result = await client.send(
      new TagResourceCommand({ resourceArn: arn, tags: [{ key: "env", value: "test" }] })
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

Given("state machine {string} was tagged with tags [\\{{string}: {string}, {string}: {string}}]", async function (
  this: LwsWorld,
  smName: string,
  _k1: string,
  _v1: string,
  _k2: string,
  _v2: string
) {
  const client = this.sfnClient();
  const arn = smArn(smName);
  await client.send(
    new TagResourceCommand({ resourceArn: arn, tags: [{ key: "env", value: "test" }] })
  );
});

When("I untag state machine {string} with tag keys [{string}]", async function (
  this: LwsWorld,
  smName: string,
  _tagKeysStr: string
) {
  const client = this.sfnClient();
  const arn = smArn(smName);
  try {
    const result = await client.send(
      new UntagResourceCommand({ resourceArn: arn, tagKeys: ["env"] })
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I update state machine {string} with an updated definition", async function (
  this: LwsWorld,
  smName: string
) {
  const client = this.sfnClient();
  const arn = smArn(smName);
  const updatedDefinition = JSON.stringify({
    Comment: "Updated pass state machine",
    StartAt: "Pass",
    States: { Pass: { Type: "Pass", End: true } },
  });
  try {
    const result = await client.send(
      new UpdateStateMachineCommand({ stateMachineArn: arn, definition: updatedDefinition })
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I validate a Pass state machine definition", async function (this: LwsWorld) {
  const client = this.sfnClient();
  try {
    const result = await client.send(
      new ValidateStateMachineDefinitionCommand({ definition: PASS_DEFINITION })
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I tag state machine {string} with tags [{string}]", async function (
  this: LwsWorld,
  smName: string,
  _tagsStr: string
) {
  const client = this.sfnClient();
  const arn = smArn(smName);
  try {
    const result = await client.send(
      new TagResourceCommand({ resourceArn: arn, tags: [{ key: "env", value: "test" }] })
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

// Timed variant
When("I list Step Functions state machines with timing", async function (this: LwsWorld) {
  const client = this.sfnClient();
  const start = Date.now();
  try {
    const result = await client.send(new ListStateMachinesCommand({}));
    this.timedResult = { success: true, output: result, elapsedMs: Date.now() - start };
  } catch (err) {
    this.timedResult = { success: false, output: err, elapsedMs: Date.now() - start };
  }
});

When("I list Step Functions state machines", async function (this: LwsWorld) {
  const client = this.sfnClient();
  try {
    const result = await client.send(new ListStateMachinesCommand({}));
    this.lastResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

// --- Then ------------------------------------------------------------------

Then("state machine {string} will exist", async function (this: LwsWorld, smName: string) {
  const client = this.sfnClient();
  const arn = smArn(smName);
  const result = await client.send(new DescribeStateMachineCommand({ stateMachineArn: arn }));
  assert.ok(result.name, "Expected state machine to exist");
});

Then("state machine {string} will not appear in list-state-machines", async function (
  this: LwsWorld,
  smName: string
) {
  const client = this.sfnClient();
  const result = await client.send(new ListStateMachinesCommand({}));
  const names = (result.stateMachines ?? []).map((sm) => sm.name ?? "");
  assert.ok(!names.includes(smName), `Expected state machine "${smName}" to not be in list`);
});

Then("the state machine list will include {string}", function (this: LwsWorld, smName: string) {
  const output = this.lastResult.output as { stateMachines?: Array<{ name?: string }> };
  const names = (output?.stateMachines ?? []).map((sm) => sm.name ?? "");
  assert.ok(names.includes(smName), `Expected state machine list to include "${smName}"`);
});

Then("the output will contain state machine name {string}", function (
  this: LwsWorld,
  smName: string
) {
  const actualOutput = JSON.stringify(this.lastResult.output);
  assert.ok(actualOutput.includes(smName), `Expected output to contain "${smName}"`);
});

Then("the output will contain an execution ARN", function (this: LwsWorld) {
  const output = this.lastResult.output as { executionArn?: string };
  assert.ok(output?.executionArn, "Expected output to contain an executionArn");
});

Then("the output will contain the execution ARN", function (this: LwsWorld) {
  const output = this.lastResult.output as { executionArn?: string };
  assert.ok(output?.executionArn, "Expected output to contain the executionArn");
});

Then("the output will contain a status field", function (this: LwsWorld) {
  const output = this.lastResult.output as { status?: string };
  assert.ok(output?.status, "Expected output to contain a status field");
});

Then("the started execution will have a status", async function (this: LwsWorld) {
  const client = this.sfnClient();
  const result = await client.send(
    new DescribeExecutionCommand({ executionArn: this.lastExecutionArn! })
  );
  assert.ok(result.status, "Expected execution to have a status");
});

Then("the stopped execution will have status {string}", async function (
  this: LwsWorld,
  expectedStatus: string
) {
  const client = this.sfnClient();
  const result = await client.send(
    new DescribeExecutionCommand({ executionArn: this.lastExecutionArn! })
  );
  assert.strictEqual(result.status, expectedStatus);
});

Then("the executions list will have at least {int} entry", function (
  this: LwsWorld,
  minCount: number
) {
  const output = this.lastResult.output as { executions?: unknown[] };
  const count = (output?.executions ?? []).length;
  assert.ok(count >= minCount, `Expected at least ${minCount} executions but got ${count}`);
});

Then("state machine {string} will have tag {string} with value {string}", async function (
  this: LwsWorld,
  smName: string,
  tagKey: string,
  expectedValue: string
) {
  const client = this.sfnClient();
  const arn = smArn(smName);
  const result = await client.send(new ListTagsForResourceCommand({ resourceArn: arn }));
  const tags = result.tags ?? [];
  const tag = tags.find((t) => t.key === tagKey);
  assert.strictEqual(tag?.value, expectedValue);
});

Then("state machine {string} will not have tag {string}", async function (
  this: LwsWorld,
  smName: string,
  tagKey: string
) {
  const client = this.sfnClient();
  const arn = smArn(smName);
  const result = await client.send(new ListTagsForResourceCommand({ resourceArn: arn }));
  const tags = result.tags ?? [];
  const tag = tags.find((t) => t.key === tagKey);
  assert.ok(!tag, `Expected tag "${tagKey}" to not exist`);
});

Then("state machine {string} will have the updated definition", async function (
  this: LwsWorld,
  smName: string
) {
  const client = this.sfnClient();
  const arn = smArn(smName);
  const result = await client.send(new DescribeStateMachineCommand({ stateMachineArn: arn }));
  assert.ok(result.definition, "Expected state machine to have a definition");
});
