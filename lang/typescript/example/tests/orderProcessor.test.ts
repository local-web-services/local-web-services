import {
  SFNClient,
  CreateStateMachineCommand,
  ListStateMachinesCommand,
} from "@aws-sdk/client-sfn";
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
  // Arrange — start local services with DynamoDB table and SQS queue
  session = await LwsSession.create({
    tables: [{ name: "Orders", partitionKey: "orderId" }],
    queues: ["OrderQueue"],
  });

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

const FAKE_STATE_MACHINE_ARN = "arn:aws:states:us-east-1:000000000000:stateMachine:OrderProcessor";
const FAKE_EXECUTION_ARN = "arn:aws:states:us-east-1:000000000000:execution:OrderProcessor:fake-exec";

test("processOrder succeeds with faked SFN responses", async () => {
  // Arrange — fake both SFN calls so no real state machine is needed
  await session.fake("stepfunctions").operation("start-execution").respond({
    body: {
      executionArn: FAKE_EXECUTION_ARN,
      startDate: 1704067200.0,
    },
  });
  await session.fake("stepfunctions").operation("describe-execution").respond({
    body: {
      executionArn: FAKE_EXECUTION_ARN,
      stateMachineArn: FAKE_STATE_MACHINE_ARN,
      name: "fake-exec",
      status: "SUCCEEDED",
      startDate: 1704067200.0,
      output: JSON.stringify({ orderId: "order-fake" }),
    },
  });

  // Act
  const actualResult = await processOrder("order-fake", FAKE_STATE_MACHINE_ARN, sfnClient);

  // Assert
  expect(actualResult.orderId).toBe("order-fake");

  // Cleanup — clear the fake so subsequent tests are unaffected
  await session.fake("stepfunctions").clear();
});

test("processOrder throws when AWS returns ExecutionLimitExceeded", async () => {
  // Arrange — fake StartExecution to return an AWS error
  await session.fake("stepfunctions").operation("start-execution").error(
    "ExecutionLimitExceeded",
    "You have exceeded the maximum number of running executions."
  );

  try {
    // Act + Assert — AWS SDK v3 surfaces the error type in error.name
    await expect(
      processOrder("order-999", FAKE_STATE_MACHINE_ARN, sfnClient)
    ).rejects.toMatchObject({ name: "ExecutionLimitExceeded" });
  } finally {
    // Cleanup — always clear even if the assertion above fails
    await session.fake("stepfunctions").clear();
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

test("processOrder fails when stepfunctions chaos is set to 100% error rate", async () => {
  // Arrange — set 100% error rate on stepfunctions
  await session.chaos("stepfunctions").errorRate(1.0).apply();

  try {
    // Act + Assert — should throw due to chaos error injection
    await expect(
      processOrder("order-chaos", stateMachineArn, sfnClient)
    ).rejects.toThrow();
  } finally {
    // Cleanup
    await session.chaos("stepfunctions").clear();
  }
});

test("processOrder succeeds with IAM enforce mode and wildcard allow policy", async () => {
  // Arrange — register identity and switch to enforce mode
  await session.iam
    .identity("test-user")
    .allow(["states:*"])
    .apply()
    .mode("enforce")
    .defaultIdentity("test-user")
    .apply();

  try {
    // Act
    const expectedOrderId = "order-iam-001";
    const actualResult = await processOrder(expectedOrderId, stateMachineArn, sfnClient);

    // Assert
    expect(actualResult.orderId).toBe(expectedOrderId);
  } finally {
    // Cleanup — return IAM to disabled mode
    await session.iam.mode("disabled").apply();
  }
});

test("session remains functional after reset", async () => {
  // Arrange — process an order before reset
  await processOrder("order-before-reset", stateMachineArn, sfnClient);

  // Act — reset session state
  await session.reset();

  // Assert — session accepts a second reset without error
  await session.reset();
});

test("log capture records StartExecution call", async () => {
  // Arrange
  const logs = await session.captureLogsStart();

  // Act
  await processOrder("order-logged", stateMachineArn, sfnClient);
  await logs.stop();

  // Assert
  logs.assertCalled("stepfunctions", "StartExecution");
  logs.assertNoErrors();
});

test("DynamoDB helper seeds an item and asserts it exists", async () => {
  // Arrange
  const db = session.dynamodb("Orders");
  const expectedItem = {
    orderId: { S: "order-helper-001" },
    status: { S: "pending" },
  };

  // Act
  await db.put(expectedItem);

  // Assert
  await db.assertItemCount(1);
  await db.assertItemExists({ orderId: { S: "order-helper-001" } });

  // Cleanup
  await session.reset();
});

test("SQS helper sends a message and receives it back", async () => {
  // Arrange
  const queue = session.sqs("OrderQueue");
  const expectedBody = "order-sqs-001";

  // Act
  await queue.send(expectedBody);

  // Assert
  const actualMessages = await queue.receive(1);
  expect(actualMessages).toHaveLength(1);
  expect(actualMessages[0].Body).toBe(expectedBody);

  // Cleanup
  await session.reset();
});
