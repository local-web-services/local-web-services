import { describe, it, expect, beforeEach, afterEach } from "vitest";
import Fastify from "fastify";
import type { FastifyInstance } from "fastify";
import { StepFunctionsProvider } from "../../src/providers/stepfunctions/provider.js";
import { stepFunctionsRoutesPlugin } from "../../src/providers/stepfunctions/routes.js";

const SIMPLE_DEF = JSON.stringify({
  Comment: "test",
  StartAt: "Done",
  States: { Done: { Type: "Succeed" } },
});

async function buildSfnApp(): Promise<FastifyInstance> {
  const provider = new StepFunctionsProvider([]);
  await provider.start();
  const app = Fastify({ logger: false });
  await app.register(stepFunctionsRoutesPlugin, { provider });
  await app.ready();
  return app;
}

async function sfnRequest(
  app: FastifyInstance,
  operation: string,
  payload: Record<string, unknown>,
): Promise<{ status: number; body: Record<string, unknown> }> {
  const response = await app.inject({
    method: "POST",
    url: "/",
    headers: {
      "content-type": "application/x-amz-json-1.1",
      "x-amz-target": `AWSStepFunctions.${operation}`,
    },
    payload: JSON.stringify(payload),
  });
  return { status: response.statusCode, body: JSON.parse(response.body) as Record<string, unknown> };
}

describe("Step Functions routes — CreateStateMachine / DescribeStateMachine", () => {
  let app: FastifyInstance;

  beforeEach(async () => { app = await buildSfnApp(); });
  afterEach(async () => { await app.close(); });

  it("CreateStateMachine returns an ARN", async () => {
    // Arrange
    const expectedMachineName = "test-machine";

    // Act
    const actual = await sfnRequest(app, "CreateStateMachine", {
      name: expectedMachineName,
      definition: SIMPLE_DEF,
      roleArn: "arn:aws:iam::123456789012:role/StepFunctionsRole",
    });

    // Assert
    expect(actual.status).toBe(200);
    expect((actual.body["stateMachineArn"] as string)).toContain(expectedMachineName);
  });

  it("DescribeStateMachine returns machine info", async () => {
    // Arrange
    const expectedMachineName = "describe-machine";
    const createResult = await sfnRequest(app, "CreateStateMachine", {
      name: expectedMachineName,
      definition: SIMPLE_DEF,
    });
    const machineArn = createResult.body["stateMachineArn"] as string;

    // Act
    const actual = await sfnRequest(app, "DescribeStateMachine", { stateMachineArn: machineArn });

    // Assert
    expect(actual.status).toBe(200);
    expect(actual.body["name"]).toBe(expectedMachineName);
  });

  it("DeleteStateMachine on nonexistent returns 400", async () => {
    // Arrange
    const expectedStatus = 400;
    const fakeArn = "arn:aws:states:us-east-1:123456789012:stateMachine:ghost";

    // Act
    const actual = await sfnRequest(app, "DeleteStateMachine", { stateMachineArn: fakeArn });

    // Assert
    expect(actual.status).toBe(expectedStatus);
  });
});

describe("Step Functions routes — StartExecution / DescribeExecution", () => {
  let app: FastifyInstance;
  let machineArn: string;

  beforeEach(async () => {
    app = await buildSfnApp();
    const result = await sfnRequest(app, "CreateStateMachine", {
      name: "exec-machine",
      definition: SIMPLE_DEF,
    });
    machineArn = result.body["stateMachineArn"] as string;
  });

  afterEach(async () => { await app.close(); });

  it("StartExecution returns an executionArn", async () => {
    // Arrange (machine created in beforeEach)

    // Act
    const actual = await sfnRequest(app, "StartExecution", {
      stateMachineArn: machineArn,
      name: "run-1",
      input: "{}",
    });

    // Assert
    expect(actual.status).toBe(200);
    expect((actual.body["executionArn"] as string)).toContain("run-1");
  });

  it("DescribeExecution shows SUCCEEDED status", async () => {
    // Arrange
    const expectedStatus = "SUCCEEDED";
    const startResult = await sfnRequest(app, "StartExecution", {
      stateMachineArn: machineArn,
      name: "run-2",
    });
    const executionArn = startResult.body["executionArn"] as string;

    // Act
    const actual = await sfnRequest(app, "DescribeExecution", { executionArn });

    // Assert
    expect(actual.status).toBe(200);
    expect(actual.body["status"]).toBe(expectedStatus);
  });

  it("GetExecutionHistory returns two events", async () => {
    // Arrange
    const expectedEventCount = 2;
    const startResult = await sfnRequest(app, "StartExecution", {
      stateMachineArn: machineArn,
      name: "run-3",
    });
    const executionArn = startResult.body["executionArn"] as string;

    // Act
    const actual = await sfnRequest(app, "GetExecutionHistory", { executionArn });

    // Assert
    const actualEvents = actual.body["events"] as unknown[];
    expect(actualEvents).toHaveLength(expectedEventCount);
  });

  it("ListExecutions with statusFilter returns matching executions", async () => {
    // Arrange
    const expectedStatus = "SUCCEEDED";
    await sfnRequest(app, "StartExecution", { stateMachineArn: machineArn, name: "run-4" });

    // Act
    const actual = await sfnRequest(app, "ListExecutions", {
      stateMachineArn: machineArn,
      statusFilter: expectedStatus,
    });

    // Assert
    const actualExecs = actual.body["executions"] as Array<{ status: string }>;
    expect(actualExecs.every((e) => e.status === expectedStatus)).toBe(true);
  });
});
