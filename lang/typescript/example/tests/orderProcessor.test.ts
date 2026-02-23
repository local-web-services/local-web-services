import { SFNClient, CreateStateMachineCommand, ListStateMachinesCommand } from "@aws-sdk/client-sfn";
import { LwsSession } from "local-web-services-typescript-sdk";
import { processOrder } from "../src/orderProcessor";

const STATE_MACHINE_DEFINITION = JSON.stringify({
  Comment: "Simple order processor — passes input through as output",
  StartAt: "ProcessOrder",
  States: {
    ProcessOrder: { Type: "Pass", End: true },
  },
});

let session: LwsSession;
let sfnClient: SFNClient;
let stateMachineArn: string;

beforeAll(async () => {
  // Arrange — start local services
  session = await LwsSession.create({});

  // session.client() returns a pre-configured client pointing at the local emulator
  sfnClient = session.client<SFNClient>("stepfunctions");

  const response = await sfnClient.send(
    new CreateStateMachineCommand({
      name: "OrderProcessor",
      definition: STATE_MACHINE_DEFINITION,
      roleArn: "arn:aws:iam::000000000000:role/StepFunctionsRole",
      type: "STANDARD",
    })
  );
  stateMachineArn = response.stateMachineArn!;
});

afterAll(async () => {
  await session.close();
});

test("processOrder returns the order ID in the result", async () => {
  // Arrange
  const expectedOrderId = "order-123";

  // Act — pass the local SFN client so processOrder hits the emulator
  const actualResult = await processOrder(expectedOrderId, stateMachineArn, sfnClient);

  // Assert
  expect(actualResult.orderId).toBe(expectedOrderId);
});

test("processOrder handles multiple different orders", async () => {
  // Arrange
  const expectedOrderIds = ["order-1", "order-2", "order-3"];

  for (const expectedOrderId of expectedOrderIds) {
    // Act
    const actualResult = await processOrder(expectedOrderId, stateMachineArn, sfnClient);

    // Assert
    expect(actualResult.orderId).toBe(expectedOrderId);
  }
});

const MOCK_STATE_MACHINE_ARN = "arn:aws:states:us-east-1:000000000000:stateMachine:OrderProcessor";
const MOCK_EXECUTION_ARN = "arn:aws:states:us-east-1:000000000000:execution:OrderProcessor:mock-exec";

test("processOrder succeeds with mocked SFN responses", async () => {
  // Arrange — mock both SFN calls so no real state machine is needed
  await session.mock("stepfunctions").operation("start-execution").respond({
    body: {
      executionArn: MOCK_EXECUTION_ARN,
      startDate: 1704067200.0,
    },
  });
  await session.mock("stepfunctions").operation("describe-execution").respond({
    body: {
      executionArn: MOCK_EXECUTION_ARN,
      stateMachineArn: MOCK_STATE_MACHINE_ARN,
      name: "mock-exec",
      status: "SUCCEEDED",
      startDate: 1704067200.0,
      output: JSON.stringify({ orderId: "order-mock" }),
    },
  });

  // Act
  const actualResult = await processOrder("order-mock", MOCK_STATE_MACHINE_ARN, sfnClient);

  // Assert
  expect(actualResult.orderId).toBe("order-mock");

  // Cleanup — clear the mock so subsequent tests are unaffected
  await session.mock("stepfunctions").clear();
});

test("processOrder throws when AWS returns ExecutionLimitExceeded", async () => {
  // Arrange — mock StartExecution to return an AWS error
  await session.mock("stepfunctions").operation("start-execution").error(
    "ExecutionLimitExceeded",
    "You have exceeded the maximum number of running executions."
  );

  try {
    // Act + Assert — AWS SDK v3 surfaces the error type in error.name
    await expect(
      processOrder("order-999", MOCK_STATE_MACHINE_ARN, sfnClient)
    ).rejects.toMatchObject({ name: "ExecutionLimitExceeded" });
  } finally {
    // Cleanup — always clear even if the assertion above fails
    await session.mock("stepfunctions").clear();
  }
});

test("processOrder uses state machine provisioned from Terraform HCL", async () => {
  // Arrange — start ldk from the Terraform config; it reads terraform/main.tf
  // and provisions the OrderProcessor state machine automatically
  const tfSession = await LwsSession.fromHcl("terraform");
  try {
    const tfSfnClient = tfSession.client<SFNClient>("stepfunctions");
    const expectedOrderId = "order-tf";

    const { stateMachines } = await tfSfnClient.send(new ListStateMachinesCommand({}));
    const stateMachineArn = stateMachines![0].stateMachineArn!;

    // Act
    const actualResult = await processOrder(expectedOrderId, stateMachineArn, tfSfnClient);

    // Assert
    expect(actualResult.orderId).toBe(expectedOrderId);
  } finally {
    await tfSession.close();
  }
});
