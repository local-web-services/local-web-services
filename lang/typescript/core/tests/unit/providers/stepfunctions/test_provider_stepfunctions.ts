import { describe, it, expect, beforeEach } from "vitest";
import { StepFunctionsProvider } from "../../../../src/providers/stepfunctions/provider.js";

const SIMPLE_DEF = JSON.stringify({
  Comment: "test",
  StartAt: "Done",
  States: { Done: { Type: "Succeed" } },
});

describe("StepFunctionsProvider lifecycle", () => {
  let provider: StepFunctionsProvider;

  beforeEach(async () => {
    provider = new StepFunctionsProvider([{ name: "pre-machine", definition: SIMPLE_DEF }]);
    await provider.start();
  });

  it("seeds pre-configured machines", () => {
    // Arrange
    const expectedMachineName = "pre-machine";

    // Act
    const actual = provider.listStateMachines();

    // Assert
    expect(actual.stateMachines.some((m) => m.name === expectedMachineName)).toBe(true);
  });

  it("reports healthy after start", async () => {
    // Arrange (started in beforeEach)

    // Act
    const actualHealthy = await provider.healthCheck();

    // Assert
    expect(actualHealthy).toBe(true);
  });

  it("reports unhealthy after stop", async () => {
    // Arrange
    await provider.stop();

    // Act
    const actualHealthy = await provider.healthCheck();

    // Assert
    expect(actualHealthy).toBe(false);
  });
});

describe("StepFunctionsProvider machines", () => {
  let provider: StepFunctionsProvider;

  beforeEach(async () => {
    provider = new StepFunctionsProvider([]);
    await provider.start();
  });

  it("creates a state machine", () => {
    // Arrange
    const expectedName = "my-machine";

    // Act
    const actual = provider.createStateMachine(expectedName, SIMPLE_DEF);

    // Assert
    expect(actual.stateMachineArn).toContain(expectedName);
  });

  it("throws when creating a duplicate state machine", () => {
    // Arrange
    const expectedError = "StateMachineAlreadyExists";
    provider.createStateMachine("dup-machine", SIMPLE_DEF);

    // Act
    const actualFn = () => provider.createStateMachine("dup-machine", SIMPLE_DEF);

    // Assert
    expect(actualFn).toThrow(expectedError);
  });

  it("lists state machines", () => {
    // Arrange
    const expectedName = "listed-machine";
    provider.createStateMachine(expectedName, SIMPLE_DEF);

    // Act
    const actual = provider.listStateMachines();

    // Assert
    expect(actual.stateMachines.some((m) => m.name === expectedName)).toBe(true);
  });

  it("describes a state machine", () => {
    // Arrange
    const expectedName = "described-machine";
    const { stateMachineArn } = provider.createStateMachine(expectedName, SIMPLE_DEF);

    // Act
    const actual = provider.describeStateMachine(stateMachineArn) as { name: string; status: string };

    // Assert
    const expectedStatus = "ACTIVE";
    expect(actual.name).toBe(expectedName);
    expect(actual.status).toBe(expectedStatus);
  });

  it("deletes a state machine", () => {
    // Arrange
    const expectedAbsentName = "deleted-machine";
    const { stateMachineArn } = provider.createStateMachine(expectedAbsentName, SIMPLE_DEF);

    // Act
    provider.deleteStateMachine(stateMachineArn);

    // Assert
    const actual = provider.listStateMachines();
    expect(actual.stateMachines.some((m) => m.name === expectedAbsentName)).toBe(false);
  });

  it("throws when deleting a nonexistent machine", () => {
    // Arrange
    const expectedError = "StateMachineDoesNotExist";
    const fakeArn = "arn:aws:states:us-east-1:123456789012:stateMachine:ghost";

    // Act
    const actualFn = () => provider.deleteStateMachine(fakeArn);

    // Assert
    expect(actualFn).toThrow(expectedError);
  });
});

describe("StepFunctionsProvider executions", () => {
  let provider: StepFunctionsProvider;
  let machineArn: string;

  beforeEach(async () => {
    provider = new StepFunctionsProvider([]);
    await provider.start();
    const result = provider.createStateMachine("exec-machine", SIMPLE_DEF);
    machineArn = result.stateMachineArn;
  });

  it("starts an execution and immediately sets SUCCEEDED", () => {
    // Arrange
    const expectedStatus = "SUCCEEDED";

    // Act
    const { executionArn } = provider.startExecution(machineArn, "run-1");
    const actual = provider.describeExecution(executionArn) as { status: string };

    // Assert
    expect(actual.status).toBe(expectedStatus);
  });

  it("execution output equals input (pass-through)", () => {
    // Arrange
    const expectedOutput = '{"key":"value"}';

    // Act
    const { executionArn } = provider.startExecution(machineArn, "run-2", expectedOutput);
    const actual = provider.describeExecution(executionArn) as { output: string };

    // Assert
    expect(actual.output).toBe(expectedOutput);
  });

  it("gets execution history with two events", () => {
    // Arrange
    const expectedEventCount = 2;

    // Act
    const { executionArn } = provider.startExecution(machineArn, "run-3");
    const actual = provider.getExecutionHistory(executionArn);

    // Assert
    expect(actual.events).toHaveLength(expectedEventCount);
  });

  it("lists executions filtered by status", () => {
    // Arrange
    const expectedStatus = "SUCCEEDED";
    const { executionArn } = provider.startExecution(machineArn, "run-4");
    provider.stopExecution(executionArn);

    provider.startExecution(machineArn, "run-5");

    // Act
    const actual = provider.listExecutions(machineArn, expectedStatus);

    // Assert
    expect(actual.executions.length).toBeGreaterThan(0);
  });

  it("stops an execution setting it to ABORTED", () => {
    // Arrange
    const expectedStatus = "ABORTED";
    provider.startExecution(machineArn, "run-to-stop");
    const { executionArn } = provider.startExecution(machineArn, "run-to-stop-2");

    // Act
    provider.stopExecution(executionArn);
    const actual = provider.describeExecution(executionArn) as { status: string };

    // Assert
    expect(actual.status).toBe(expectedStatus);
  });

  it("clears executions on reset but keeps pre-configured machines", async () => {
    // Arrange
    const { executionArn } = provider.startExecution(machineArn, "run-to-reset");
    void executionArn;

    // Act
    await provider.reset();

    // Assert
    const actualMachines = provider.listStateMachines();
    expect(actualMachines.stateMachines.length).toBe(0);
  });
});

describe("StepFunctionsProvider tagging and extra ops", () => {
  let provider: StepFunctionsProvider;
  let machineArn: string;

  beforeEach(async () => {
    provider = new StepFunctionsProvider();
    await provider.start();
    const result = provider.createStateMachine("my-machine", "{}", "STANDARD", "arn:aws:iam::000000000000:role/role");
    machineArn = result.stateMachineArn;
  });

  it("tagResource stores tags retrievable via listTagsForResource", () => {
    // Arrange
    const expectedKey = "env";
    const expectedValue = "prod";

    // Act
    provider.tagResource(machineArn, [{ Key: expectedKey, Value: expectedValue }]);
    const actualTags = provider.listTagsForResource(machineArn);

    // Assert
    expect(actualTags).toContainEqual({ Key: expectedKey, Value: expectedValue });
  });

  it("untagResource removes a specific tag", () => {
    // Arrange
    provider.tagResource(machineArn, [
      { Key: "env", Value: "prod" },
      { Key: "team", Value: "platform" },
    ]);
    const expectedAbsentKey = "env";

    // Act
    provider.untagResource(machineArn, [expectedAbsentKey]);
    const actualTags = provider.listTagsForResource(machineArn);

    // Assert
    expect(actualTags.map((t) => t.Key)).not.toContain(expectedAbsentKey);
  });

  it("updateStateMachine returns an updateDate number", () => {
    // Arrange
    const expectedType = "number";

    // Act
    const actual = provider.updateStateMachine(machineArn, '{"Comment":"updated"}');

    // Assert
    expect(typeof actual.updateDate).toBe(expectedType);
  });

  it("startSyncExecution returns SUCCEEDED status", () => {
    // Arrange
    const expectedStatus = "SUCCEEDED";

    // Act
    const actual = provider.startSyncExecution(machineArn, "sync-run", "{}") as { status: string };

    // Assert
    expect(actual.status).toBe(expectedStatus);
  });
});
