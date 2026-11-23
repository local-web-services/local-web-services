import { Given, When, Then } from "@cucumber/cucumber";
import {
  CreateStateMachineCommand,
  DeleteStateMachineCommand,
  ListStateMachinesCommand,
  StartExecutionCommand,
  DescribeExecutionCommand,
  GetExecutionHistoryCommand,
} from "@aws-sdk/client-sfn";
import type { StepFunctionsWorld } from "../support/world.js";
import { TEST_MACHINE, SIMPLE_DEF } from "../support/world.js";

Given("the stepfunctions system is initialized", function (this: StepFunctionsWorld) {
  // Session started in BeforeAll
});

Given('the "stepfunctions" "state machine" did not already exist', function (this: StepFunctionsWorld) {
  // Not pre-seeded — reset in Before hook clears dynamic machines
  // The session was seeded with TEST_MACHINE, so reset + recreation needed
  // Actually after reset, the pre-configured machine is gone too — just do nothing
});

Given('the "stepfunctions" "state machine" already existed', async function (this: StepFunctionsWorld) {
  const result = await this.sfnClient.send(new CreateStateMachineCommand({
    name: TEST_MACHINE,
    definition: SIMPLE_DEF,
    roleArn: "arn:aws:iam::000000000000:role/StepFunctionsRole",
  }));
  this.machineArn = result.stateMachineArn ?? "";
});

Given('the "stepfunctions" "state machine" existed', async function (this: StepFunctionsWorld) {
  const result = await this.sfnClient.send(new CreateStateMachineCommand({
    name: TEST_MACHINE,
    definition: SIMPLE_DEF,
    roleArn: "arn:aws:iam::000000000000:role/StepFunctionsRole",
  }));
  this.machineArn = result.stateMachineArn ?? "";
});

Given('a "stepfunctions" "execution" was started', async function (this: StepFunctionsWorld) {
  const result = await this.sfnClient.send(new StartExecutionCommand({
    stateMachineArn: this.machineArn,
    name: "pre-exec",
    input: "{}",
  }));
  this.executionArn = result.executionArn ?? "";
});

When('a "stepfunctions" "state machine" is created', async function (this: StepFunctionsWorld) {
  try {
    const result = await this.sfnClient.send(new CreateStateMachineCommand({
      name: TEST_MACHINE,
      definition: SIMPLE_DEF,
      roleArn: "arn:aws:iam::000000000000:role/StepFunctionsRole",
    }));
    this.machineArn = result.stateMachineArn ?? "";
    this.result = result;
  } catch (err) {
    this.error = err instanceof Error ? err : new Error(String(err));
  }
});

When('a "stepfunctions" "state machine" is deleted', async function (this: StepFunctionsWorld) {
  const arnToDelete = this.machineArn !== ""
    ? this.machineArn
    : `arn:aws:states:us-east-1:123456789012:stateMachine:${TEST_MACHINE}`;
  try {
    this.result = await this.sfnClient.send(new DeleteStateMachineCommand({
      stateMachineArn: arnToDelete,
    }));
  } catch (err) {
    this.error = err instanceof Error ? err : new Error(String(err));
  }
});

When('a "stepfunctions" "execution" is started on the "stepfunctions" "state machine"', async function (this: StepFunctionsWorld) {
  try {
    const result = await this.sfnClient.send(new StartExecutionCommand({
      stateMachineArn: this.machineArn,
      name: "run-1",
      input: "{}",
    }));
    this.executionArn = result.executionArn ?? "";
    this.result = result;
  } catch (err) {
    this.error = err instanceof Error ? err : new Error(String(err));
  }
});

When('"stepfunctions" "execution" history is retrieved', async function (this: StepFunctionsWorld) {
  try {
    this.result = await this.sfnClient.send(new GetExecutionHistoryCommand({
      executionArn: this.executionArn,
    }));
  } catch (err) {
    this.error = err instanceof Error ? err : new Error(String(err));
  }
});

Then('the "stepfunctions" "state machine" will exist', async function (this: StepFunctionsWorld) {
  const listResult = await this.sfnClient.send(new ListStateMachinesCommand({}));
  const expectedMachineName = TEST_MACHINE;
  const actualMachines = listResult.stateMachines ?? [];
  const found = actualMachines.some((m) => m.name === expectedMachineName);
  if (!found) throw new Error(`Expected to find machine '${expectedMachineName}' but it was absent`);
});

Then('the "stepfunctions" "state machine" will not exist', async function (this: StepFunctionsWorld) {
  const listResult = await this.sfnClient.send(new ListStateMachinesCommand({}));
  const expectedAbsentMachine = TEST_MACHINE;
  const actualMachines = listResult.stateMachines ?? [];
  const found = actualMachines.some((m) => m.name === expectedAbsentMachine);
  if (found) throw new Error(`Expected machine '${expectedAbsentMachine}' to not exist but it was found`);
});

Then('the "stepfunctions" "execution" will be "SUCCEEDED"', async function (this: StepFunctionsWorld) {
  const descResult = await this.sfnClient.send(new DescribeExecutionCommand({
    executionArn: this.executionArn,
  }));
  const expectedStatus = "SUCCEEDED";
  const actualStatus = descResult.status;
  if (actualStatus !== expectedStatus) {
    throw new Error(`Expected execution status '${expectedStatus}' but got '${actualStatus}'`);
  }
});

Then('"stepfunctions" "execution" history will contain events', function (this: StepFunctionsWorld) {
  const actualResult = this.result as { events?: unknown[] } | null;
  const actualEvents = actualResult?.events ?? [];
  if (actualEvents.length === 0) throw new Error("Expected execution history to contain events but got none");
});

Then("the stepfunctions operation is rejected", function (this: StepFunctionsWorld) {
  if (this.error === null) throw new Error("Expected an error but no error was thrown");
});
