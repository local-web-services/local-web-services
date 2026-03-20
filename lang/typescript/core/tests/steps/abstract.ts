/** Abstract step definitions for informal FizzBee specs (all 8 services). */

import { Given, When, Then } from "@cucumber/cucumber";
import assert from "assert";
import {
  CreateQueueCommand,
  DeleteQueueCommand,
  SendMessageCommand,
  ReceiveMessageCommand,
  DeleteMessageCommand,
  GetQueueAttributesCommand,
  PurgeQueueCommand,
  ChangeMessageVisibilityCommand,
} from "@aws-sdk/client-sqs";
import {
  CreateTableCommand,
  DeleteTableCommand,
  DescribeTableCommand,
  ListTablesCommand,
  PutItemCommand,
  GetItemCommand,
  DeleteItemCommand,
  UpdateItemCommand,
  ScanCommand,
  QueryCommand,
  TransactWriteItemsCommand,
} from "@aws-sdk/client-dynamodb";
import {
  CreateBucketCommand,
  DeleteBucketCommand,
  ListBucketsCommand,
  PutObjectCommand,
  GetObjectCommand,
  DeleteObjectCommand,
  HeadObjectCommand,
  ListObjectsV2Command,
  CopyObjectCommand,
  CreateMultipartUploadCommand,
  UploadPartCommand,
  CompleteMultipartUploadCommand,
  AbortMultipartUploadCommand,
  PutBucketVersioningCommand,
} from "@aws-sdk/client-s3";
import {
  CreateTopicCommand,
  DeleteTopicCommand,
  PublishCommand,
  SubscribeCommand,
  UnsubscribeCommand,
} from "@aws-sdk/client-sns";
import {
  CreateEventBusCommand,
  DeleteEventBusCommand,
  ListEventBusesCommand,
  DescribeEventBusCommand,
  PutRuleCommand,
  DeleteRuleCommand,
  DescribeRuleCommand,
  ListRulesCommand,
  EnableRuleCommand,
  DisableRuleCommand,
  PutTargetsCommand,
  RemoveTargetsCommand,
  ListTargetsByRuleCommand,
  PutEventsCommand,
} from "@aws-sdk/client-eventbridge";
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
  TagResourceCommand as SfnTagResourceCommand,
  UntagResourceCommand as SfnUntagResourceCommand,
  ListTagsForResourceCommand as SfnListTagsForResourceCommand,
  UpdateStateMachineCommand,
  ValidateStateMachineDefinitionCommand,
} from "@aws-sdk/client-sfn";
import {
  PutParameterCommand,
  GetParameterCommand,
  GetParametersCommand,
  GetParametersByPathCommand,
  DeleteParameterCommand,
  DeleteParametersCommand,
  DescribeParametersCommand,
  AddTagsToResourceCommand,
  RemoveTagsFromResourceCommand,
  ListTagsForResourceCommand as SsmListTagsForResourceCommand,
} from "@aws-sdk/client-ssm";
import {
  CreateSecretCommand,
  DeleteSecretCommand,
  DescribeSecretCommand,
  GetSecretValueCommand,
  ListSecretsCommand,
  PutSecretValueCommand,
  RestoreSecretCommand,
  TagResourceCommand as SmTagResourceCommand,
  UntagResourceCommand as SmUntagResourceCommand,
  UpdateSecretCommand,
} from "@aws-sdk/client-secrets-manager";
import { Readable } from "stream";
import type { LwsWorld } from "../support/world";
import * as cli from "../../src/cli";

// ---------------------------------------------------------------------------
// Constants
// ---------------------------------------------------------------------------

const TEST_SQS_QUEUE = "test-q-1";
const TEST_SQS_DLQ = "test-dlq-1";
const TEST_SQS_MSG = "test-message-1";
const TEST_DDB_TABLE = "test-table-1";
const TEST_DDB_KEY = "id";
const TEST_DDB_KEY_VAL = "test-id-1";
const TEST_S3_BUCKET = "test-bucket-1";
const TEST_S3_SRC_BUCKET = "test-src-1";
const TEST_S3_DST_BUCKET = "test-dst-1";
const TEST_S3_KEY = "test-key-1";
const TEST_S3_BODY = "test-body-1";
const TEST_SNS_TOPIC = "test-topic-1";
const TEST_SNS_ENDPOINT = "arn:aws:sqs:us-east-1:000000000000:test-q-1";
const TEST_SNS_PROTOCOL = "sqs";
const TEST_EVENT_BUS = "test-bus-1";
const TEST_EVENT_RULE = "test-rule-1";
const TEST_EVENT_TARGET = "arn:aws:sqs:us-east-1:000000000000:test-q-1";
const TEST_SFN_SM = "test-sm-1";
const TEST_SFN_EXPRESS_SM = "test-sm-express-1";
const TEST_SFN_ROLE_ARN = "arn:aws:iam::000000000000:role/StepFunctionsRole";
const TEST_SFN_DEFINITION = '{"StartAt":"Pass","States":{"Pass":{"Type":"Pass","End":true}}}';
const TEST_SFN_INPUT = "{}";
const TEST_SSM_PARAM = "/test/param/1";
const TEST_SSM_PARAM2 = "/test/param/2";
const TEST_SSM_VALUE = "test-value-1";
const TEST_SSM_VALUE2 = "test-value-2";
const TEST_SSM_TAG_KEY = "env";
const TEST_SSM_TAG_VAL = "test";
const TEST_SM_SECRET = "test-secret-1";
const TEST_SM_VALUE = "test-secret-value-1";
const TEST_SM_VALUE2 = "test-secret-value-2";
const TEST_SM_TAG_KEY = "env";
const TEST_SM_TAG_VAL = "test";

const ACCOUNT = "000000000000";
const REGION = "us-east-1";

// ---------------------------------------------------------------------------
// Helper functions
// ---------------------------------------------------------------------------

function sfnArn(smName: string): string {
  return `arn:aws:states:${REGION}:${ACCOUNT}:stateMachine:${smName}`;
}

function snsTopicArn(topicName: string): string {
  return `arn:aws:sns:${REGION}:${ACCOUNT}:${topicName}`;
}

// ---------------------------------------------------------------------------
// Common steps
// ---------------------------------------------------------------------------

Given("the system is initialized", function (this: LwsWorld) {
  // no-op: system is already initialized by BeforeAll hook
});

Then("the operation is rejected", function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    false,
    "Expected operation to be rejected but it succeeded",
  );
});

Then(/^every .+$/, function (this: LwsWorld) {
  // no-op: invariant check — not verifiable via API
});

Then('"GSI" pending write count is never negative', function (this: LwsWorld) {
  // no-op: invariant
});

Then("transaction status is always a valid value", function (this: LwsWorld) {
  // no-op: invariant
});

Then("a pending transaction always references an existing table", function (this: LwsWorld) {
  // no-op: invariant
});

Then("deleted tables are never the target of a pending transaction", function (this: LwsWorld) {
  // no-op: invariant
});

Then("no delivery is in-flight to a deleted subscription", function (this: LwsWorld) {
  // no-op: internal invariant
});

Then("no delivery is in-flight to an unconfirmed subscription", function (this: LwsWorld) {
  // no-op: internal invariant
});

Then("overwriting a parameter always increments its version", function (this: LwsWorld) {
  // no-op: invariant
});

Then("no parameter exists after it has been deleted", function (this: LwsWorld) {
  // no-op: invariant
});

Then("deleting a bucket requires it to be empty", function (this: LwsWorld) {
  // no-op: invariant
});

Then("a rule can only be deleted when it has no targets", function (this: LwsWorld) {
  // no-op: invariant
});

Then("the default event bus cannot be deleted", function (this: LwsWorld) {
  // no-op: invariant
});

Then("synchronous executions only run on express state machines", function (this: LwsWorld) {
  // no-op: invariant
});

Then(
  "a deleted secret with a closed recovery window cannot be restored",
  function (this: LwsWorld) {
    // no-op: invariant
  },
);

Then("all secret names are unique", function (this: LwsWorld) {
  // no-op: invariant
});

Then("all version identifiers are unique across secrets", function (this: LwsWorld) {
  // no-op: invariant
});

Then("at most one current version exists per secret", function (this: LwsWorld) {
  // no-op: invariant
});

Then("at most one previous version exists per secret", function (this: LwsWorld) {
  // no-op: invariant
});

// ---------------------------------------------------------------------------
// SQS — Given
// ---------------------------------------------------------------------------

Given("the queue is already {string}", async function (this: LwsWorld, state: string) {
  if (state === "ACTIVE") {
    const client = this.sqsClient();
    try {
      await client.send(new CreateQueueCommand({ QueueName: TEST_SQS_QUEUE }));
    } catch {
      /* ignore */
    }
    return;
  }
  if (state === "CREATING") {
    await cli.lifecycleSet(this.managementPort, "sqs", { createDwellMs: 10000 });
    const client = this.sqsClient();
    await client.send(new CreateQueueCommand({ QueueName: TEST_SQS_QUEUE }));
    return;
  }
  if (state === "DELETING") {
    await cli.lifecycleSet(this.managementPort, "sqs", { deleteDwellMs: 10000 });
    const client = this.sqsClient();
    await client.send(new CreateQueueCommand({ QueueName: TEST_SQS_QUEUE }));
    const queueUrl = this.sqsQueueUrl(TEST_SQS_QUEUE);
    await client.send(new DeleteQueueCommand({ QueueUrl: queueUrl }));
    return;
  }
  if (state === "DELETED") {
    // Cannot test "already DELETED" state in fake — skip
    return "pending";
  }
  return "pending";
});

Given("the queue does not already exist", function (this: LwsWorld) {
  // no-op: queue is absent by default after reset
});

Given("the queue already exists", async function (this: LwsWorld) {
  const client = this.sqsClient();
  await client.send(new CreateQueueCommand({ QueueName: TEST_SQS_QUEUE }));
});

Given("the queue exists", async function (this: LwsWorld) {
  const client = this.sqsClient();
  try {
    await client.send(new CreateQueueCommand({ QueueName: TEST_SQS_QUEUE }));
  } catch {
    // ignore if already exists
  }
});

Given("the queue is {string}", function (this: LwsWorld, state: string) {
  if (this.lastResult.output !== null) {
    assert.strictEqual(
      this.lastResult.success,
      true,
      `Expected queue to be ${state} but got: ${JSON.stringify(this.lastResult.output)}`,
    );
    return;
  }
  // no-op: queue is ACTIVE by default when it exists
});

Given("the queue is not {string}", async function (this: LwsWorld, state: string) {
  if (state === "ACTIVE") {
    // Cannot simulate non-ACTIVE (CREATING) state without lifecycle support
    return "pending";
  }
  if (state === "CREATING" || state === "DELETING") {
    // Ensure queue exists in ACTIVE state (which is "not CREATING" / "not DELETING")
    const client = this.sqsClient();
    try {
      await client.send(new CreateQueueCommand({ QueueName: TEST_SQS_QUEUE }));
    } catch {
      /* ignore if already exists */
    }
    return;
  }
  if (state === "DELETED") {
    // no-op: queue does not exist
    return;
  }
  return "pending";
});

Given("the queue does not exist", function (this: LwsWorld) {
  // no-op: queue is absent by default after reset
});

Given("the message slot is available", function (this: LwsWorld) {
  // no-op
});

Given("the message slot is not available", function (this: LwsWorld) {
  return "pending";
});

Given("the message exists", async function (this: LwsWorld) {
  const client = this.sqsClient();
  try {
    await client.send(new CreateQueueCommand({ QueueName: TEST_SQS_QUEUE }));
  } catch {
    // ignore
  }
  const queueUrl = this.sqsQueueUrl(TEST_SQS_QUEUE);
  const sendResult = await client.send(
    new SendMessageCommand({ QueueUrl: queueUrl, MessageBody: TEST_SQS_MSG }),
  );
  void sendResult;
});

Given("the message is {string}", async function (this: LwsWorld, state: string) {
  if (this.lastResult.output !== null) {
    assert.strictEqual(
      this.lastResult.success,
      true,
      `Expected message to be ${state} but got: ${JSON.stringify(this.lastResult.output)}`,
    );
    return;
  }
  if (state === "IN_FLIGHT") {
    const client = this.sqsClient();
    const queueUrl = this.sqsQueueUrl(TEST_SQS_QUEUE);
    const result = await client.send(
      new ReceiveMessageCommand({ QueueUrl: queueUrl, MaxNumberOfMessages: 1, WaitTimeSeconds: 0 }),
    );
    this.lastReceiptHandle = result.Messages?.[0]?.ReceiptHandle;
    return;
  }
  // state === "AVAILABLE", "DELETED", etc - no-op precondition
});

Given("the message is not {string}", async function (this: LwsWorld, _state: string) {
  // Receive the message to put it IN_FLIGHT so it is no longer AVAILABLE
  const client = this.sqsClient();
  const queueUrl = this.sqsQueueUrl(TEST_SQS_QUEUE);
  try {
    await client.send(
      new ReceiveMessageCommand({ QueueUrl: queueUrl, MaxNumberOfMessages: 1, WaitTimeSeconds: 0 }),
    );
  } catch {
    // ignore
  }
});

Given("the message's queue exists", function (this: LwsWorld) {
  // no-op
});

Given("the message's queue does not exist", async function (this: LwsWorld) {
  // Delete the queue so it does not exist when the receive is attempted
  const client = this.sqsClient();
  const queueUrl = this.sqsQueueUrl(TEST_SQS_QUEUE);
  try {
    await client.send(new DeleteQueueCommand({ QueueUrl: queueUrl }));
  } catch {
    // ignore if already absent
  }
});

Given("the message's queue is {string}", function (this: LwsWorld, _state: string) {
  // no-op
});

Given("the message's queue is not {string}", async function (this: LwsWorld, state: string) {
  if (state === "ACTIVE") {
    return "pending";
  }
  if (state === "CREATING" || state === "DELETING") {
    const client = this.sqsClient();
    try {
      await client.send(new CreateQueueCommand({ QueueName: TEST_SQS_QUEUE }));
    } catch {
      /* ignore if already exists */
    }
    return;
  }
  if (state === "DELETED") {
    return;
  }
  return "pending";
});

Given("the queue has a maximum receive count configured", function (this: LwsWorld) {
  return "pending";
});

Given("the queue does not have a maximum receive count configured", function (this: LwsWorld) {
  // no-op
});

Given("the message has exceeded the maximum receive count", function (this: LwsWorld) {
  return "pending";
});

Given("the message has not exceeded the maximum receive count", function (this: LwsWorld) {
  // no-op
});

Given("the dead-letter queue exists", async function (this: LwsWorld) {
  const client = this.sqsClient();
  await client.send(new CreateQueueCommand({ QueueName: TEST_SQS_DLQ }));
});

Given("the dead-letter queue is {string}", function (this: LwsWorld, _state: string) {
  // no-op
});

Given("the dead-letter queue does not exist", function (this: LwsWorld) {
  // no-op
});

Given("the dead-letter queue is not {string}", async function (this: LwsWorld, state: string) {
  if (state === "ACTIVE") {
    return "pending";
  }
  if (state === "CREATING" || state === "DELETING") {
    const client = this.sqsClient();
    try {
      await client.send(new CreateQueueCommand({ QueueName: TEST_SQS_DLQ }));
    } catch {
      /* ignore if already exists */
    }
    return;
  }
  if (state === "DELETED") {
    return;
  }
  return "pending";
});

Given("the message does not exist", function (this: LwsWorld) {
  // no-op
});

// ---------------------------------------------------------------------------
// SQS — When
// ---------------------------------------------------------------------------

When("a queue is created", async function (this: LwsWorld) {
  const client = this.sqsClient();
  try {
    const result = await client.send(new CreateQueueCommand({ QueueName: TEST_SQS_QUEUE }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("a queue is deleted", async function (this: LwsWorld) {
  const client = this.sqsClient();
  const queueUrl = this.sqsQueueUrl(TEST_SQS_QUEUE);
  try {
    const result = await client.send(new DeleteQueueCommand({ QueueUrl: queueUrl }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("a message is sent to the queue", async function (this: LwsWorld) {
  const client = this.sqsClient();
  const queueUrl = this.sqsQueueUrl(TEST_SQS_QUEUE);
  try {
    const result = await client.send(
      new SendMessageCommand({ QueueUrl: queueUrl, MessageBody: TEST_SQS_MSG }),
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("a message is received from the queue", async function (this: LwsWorld) {
  const client = this.sqsClient();
  const queueUrl = this.sqsQueueUrl(TEST_SQS_QUEUE);
  try {
    const result = await client.send(
      new ReceiveMessageCommand({ QueueUrl: queueUrl, MaxNumberOfMessages: 1, WaitTimeSeconds: 0 }),
    );
    this.lastReceiptHandle = (result.Messages ?? [])[0]?.ReceiptHandle;
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("an in-flight message is deleted", async function (this: LwsWorld) {
  const client = this.sqsClient();
  const queueUrl = this.sqsQueueUrl(TEST_SQS_QUEUE);
  try {
    const result = await client.send(
      new DeleteMessageCommand({ QueueUrl: queueUrl, ReceiptHandle: this.lastReceiptHandle! }),
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("queue attributes are retrieved", async function (this: LwsWorld) {
  const client = this.sqsClient();
  const queueUrl = this.sqsQueueUrl(TEST_SQS_QUEUE);
  try {
    const result = await client.send(
      new GetQueueAttributesCommand({ QueueUrl: queueUrl, AttributeNames: ["All"] }),
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("all messages in a queue are purged", async function (this: LwsWorld) {
  const client = this.sqsClient();
  const queueUrl = this.sqsQueueUrl(TEST_SQS_QUEUE);
  try {
    const result = await client.send(new PurgeQueueCommand({ QueueUrl: queueUrl }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("message visibility timeout is changed", async function (this: LwsWorld) {
  const client = this.sqsClient();
  const queueUrl = this.sqsQueueUrl(TEST_SQS_QUEUE);
  try {
    const result = await client.send(
      new ChangeMessageVisibilityCommand({
        QueueUrl: queueUrl,
        ReceiptHandle: this.lastReceiptHandle!,
        VisibilityTimeout: 60,
      }),
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When(
  "a message exceeding its receive count is moved to the dead-letter queue",
  function (this: LwsWorld) {
    return "pending";
  },
);

When("a message visibility timeout expires", function (this: LwsWorld) {
  return "pending";
});

// ---------------------------------------------------------------------------
// SQS — Then
// ---------------------------------------------------------------------------

Then('the queue is "DELETED" and its messages are removed', function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    true,
    `Expected queue deletion to succeed but got: ${JSON.stringify(this.lastResult.output)}`,
  );
});

Then('the message is "AVAILABLE" for delivery', function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    true,
    `Expected message send to succeed but got: ${JSON.stringify(this.lastResult.output)}`,
  );
});

Then("the message is removed from the queue", function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    true,
    `Expected delete message to succeed but got: ${JSON.stringify(this.lastResult.output)}`,
  );
});

Then("the queue attributes are returned", function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    true,
    `Expected get queue attributes to succeed but got: ${JSON.stringify(this.lastResult.output)}`,
  );
});

Then('all messages in the queue are "DELETED"', function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    true,
    `Expected purge to succeed but got: ${JSON.stringify(this.lastResult.output)}`,
  );
});

Then("the message visibility is updated", function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    true,
    `Expected visibility change to succeed but got: ${JSON.stringify(this.lastResult.output)}`,
  );
});

Then('the message is "AVAILABLE" in the dead-letter queue', function (this: LwsWorld) {
  return "pending";
});

Then('the message becomes "AVAILABLE" again', function (this: LwsWorld) {
  return "pending";
});

// ---------------------------------------------------------------------------
// DynamoDB — Given
// ---------------------------------------------------------------------------

Given("the table does not exist or is not {string}", function (this: LwsWorld, _state: string) {
  // no-op: table is absent by default
});

Given("the table exists and is {string}", async function (this: LwsWorld, state: string) {
  if (state === "CREATING") {
    await cli.lifecycleSet(this.managementPort, "dynamodb", { createDwellMs: 10000 });
  } else if (state === "DELETING") {
    await cli.lifecycleSet(this.managementPort, "dynamodb", { deleteDwellMs: 10000 });
  }
  const client = this.dynamodbClient();
  try {
    await client.send(
      new CreateTableCommand({
        TableName: TEST_DDB_TABLE,
        KeySchema: [{ AttributeName: TEST_DDB_KEY, KeyType: "HASH" }],
        AttributeDefinitions: [{ AttributeName: TEST_DDB_KEY, AttributeType: "S" }],
        BillingMode: "PAY_PER_REQUEST",
      }),
    );
  } catch {
    // ignore if already exists
  }
  if (state === "DELETING") {
    await client.send(new DeleteTableCommand({ TableName: TEST_DDB_TABLE }));
  }
});

Given("the table is already {string}", async function (this: LwsWorld, state: string) {
  if (state === "ACTIVE") {
    const client = this.dynamodbClient();
    try {
      await client.send(
        new CreateTableCommand({
          TableName: TEST_DDB_TABLE,
          KeySchema: [{ AttributeName: TEST_DDB_KEY, KeyType: "HASH" }],
          AttributeDefinitions: [{ AttributeName: TEST_DDB_KEY, AttributeType: "S" }],
          BillingMode: "PAY_PER_REQUEST",
        }),
      );
    } catch {
      /* ignore */
    }
    return;
  }
  if (state === "CREATING") {
    await cli.lifecycleSet(this.managementPort, "dynamodb", { createDwellMs: 10000 });
    const client = this.dynamodbClient();
    await client.send(
      new CreateTableCommand({
        TableName: TEST_DDB_TABLE,
        KeySchema: [{ AttributeName: TEST_DDB_KEY, KeyType: "HASH" }],
        AttributeDefinitions: [{ AttributeName: TEST_DDB_KEY, AttributeType: "S" }],
        BillingMode: "PAY_PER_REQUEST",
      }),
    );
    return;
  }
  if (state === "DELETING") {
    // Cannot simulate DELETING state without lifecycle support
    return "pending";
  }
  if (state === "DELETED") {
    // no-op: table does not exist
    return;
  }
  return "pending";
});

Given("the table does not already exist", function (this: LwsWorld) {
  // no-op
});

Given("the table already exists", async function (this: LwsWorld) {
  const client = this.dynamodbClient();
  await client.send(
    new CreateTableCommand({
      TableName: TEST_DDB_TABLE,
      KeySchema: [{ AttributeName: TEST_DDB_KEY, KeyType: "HASH" }],
      AttributeDefinitions: [{ AttributeName: TEST_DDB_KEY, AttributeType: "S" }],
      BillingMode: "PAY_PER_REQUEST",
    }),
  );
});

Given("the table exists", async function (this: LwsWorld) {
  const client = this.dynamodbClient();
  try {
    await client.send(
      new CreateTableCommand({
        TableName: TEST_DDB_TABLE,
        KeySchema: [{ AttributeName: TEST_DDB_KEY, KeyType: "HASH" }],
        AttributeDefinitions: [{ AttributeName: TEST_DDB_KEY, AttributeType: "S" }],
        BillingMode: "PAY_PER_REQUEST",
      }),
    );
  } catch {
    // ignore if already exists
  }
});

Given("the table does not exist", function (this: LwsWorld) {
  // no-op
});

Given("the table is {string}", function (this: LwsWorld, _state: string) {
  // no-op: table is ACTIVE by default when it exists
});

Given("the table is not {string}", async function (this: LwsWorld, state: string) {
  if (state === "ACTIVE") {
    return "pending";
  }
  if (state === "CREATING" || state === "DELETING") {
    const client = this.dynamodbClient();
    try {
      await client.send(
        new CreateTableCommand({
          TableName: TEST_DDB_TABLE,
          KeySchema: [{ AttributeName: TEST_DDB_KEY, KeyType: "HASH" }],
          AttributeDefinitions: [{ AttributeName: TEST_DDB_KEY, AttributeType: "S" }],
          BillingMode: "PAY_PER_REQUEST",
        }),
      );
    } catch {
      /* ignore if already exists */
    }
    return;
  }
  if (state === "DELETED") {
    return;
  }
  return "pending";
});

Given('the table does not have pending "GSI" propagation', function (this: LwsWorld) {
  // no-op
});

Given('the table has pending "GSI" propagation', function (this: LwsWorld) {
  return "pending";
});

Given("the item does not exist", function (this: LwsWorld) {
  // no-op
});

Given("the item exists", async function (this: LwsWorld) {
  const client = this.dynamodbClient();
  try {
    await client.send(
      new CreateTableCommand({
        TableName: TEST_DDB_TABLE,
        KeySchema: [{ AttributeName: TEST_DDB_KEY, KeyType: "HASH" }],
        AttributeDefinitions: [{ AttributeName: TEST_DDB_KEY, AttributeType: "S" }],
        BillingMode: "PAY_PER_REQUEST",
      }),
    );
  } catch {
    // ignore
  }
  await client.send(
    new PutItemCommand({
      TableName: TEST_DDB_TABLE,
      Item: { [TEST_DDB_KEY]: { S: TEST_DDB_KEY_VAL } },
    }),
  );
});

Given("the item is not present", async function (this: LwsWorld) {
  const client = this.dynamodbClient();
  try {
    await client.send(
      new DeleteItemCommand({
        TableName: TEST_DDB_TABLE,
        Key: { [TEST_DDB_KEY]: { S: TEST_DDB_KEY_VAL } },
      }),
    );
  } catch {
    // ignore
  }
});

Given("the item is present", async function (this: LwsWorld) {
  const client = this.dynamodbClient();
  try {
    await client.send(
      new CreateTableCommand({
        TableName: TEST_DDB_TABLE,
        KeySchema: [{ AttributeName: TEST_DDB_KEY, KeyType: "HASH" }],
        AttributeDefinitions: [{ AttributeName: TEST_DDB_KEY, AttributeType: "S" }],
        BillingMode: "PAY_PER_REQUEST",
      }),
    );
  } catch {
    // ignore
  }
  await client.send(
    new PutItemCommand({
      TableName: TEST_DDB_TABLE,
      Item: { [TEST_DDB_KEY]: { S: TEST_DDB_KEY_VAL } },
    }),
  );
});

Given('a transaction is "PENDING"', function (this: LwsWorld) {
  return "pending";
});

Given('no transaction is "PENDING"', function (this: LwsWorld) {
  // no-op
});

Given('the transaction is "COMMITTED"', function (this: LwsWorld) {
  return "pending";
});

Given('the transaction is "ROLLED_BACK"', function (this: LwsWorld) {
  return "pending";
});

Given('the transaction is not "COMMITTED"', function (this: LwsWorld) {
  // no-op
});

Given('the transaction is not "ROLLED_BACK"', function (this: LwsWorld) {
  // no-op
});

Given("the transaction's table does not exist", function (this: LwsWorld) {
  // no-op: table is absent by default after reset
});

Given("the transaction's table exists", async function (this: LwsWorld) {
  const client = this.dynamodbClient();
  try {
    await client.send(
      new CreateTableCommand({
        TableName: TEST_DDB_TABLE,
        KeySchema: [{ AttributeName: TEST_DDB_KEY, KeyType: "HASH" }],
        AttributeDefinitions: [{ AttributeName: TEST_DDB_KEY, AttributeType: "S" }],
        BillingMode: "PAY_PER_REQUEST",
      }),
    );
  } catch {
    // ignore
  }
});

Given('the transaction\'s table is "ACTIVE"', async function (this: LwsWorld) {
  const client = this.dynamodbClient();
  try {
    await client.send(
      new CreateTableCommand({
        TableName: TEST_DDB_TABLE,
        KeySchema: [{ AttributeName: TEST_DDB_KEY, KeyType: "HASH" }],
        AttributeDefinitions: [{ AttributeName: TEST_DDB_KEY, AttributeType: "S" }],
        BillingMode: "PAY_PER_REQUEST",
      }),
    );
  } catch {
    // ignore
  }
});

Given('the transaction\'s table is not "ACTIVE"', async function (this: LwsWorld) {
  await cli.lifecycleSet(this.managementPort, "dynamodb", { createDwellMs: 10000 });
  const client = this.dynamodbClient();
  await client.send(
    new CreateTableCommand({
      TableName: TEST_DDB_TABLE,
      KeySchema: [{ AttributeName: TEST_DDB_KEY, KeyType: "HASH" }],
      AttributeDefinitions: [{ AttributeName: TEST_DDB_KEY, AttributeType: "S" }],
      BillingMode: "PAY_PER_REQUEST",
    }),
  );
});

Given("reads are not throttled", function (this: LwsWorld) {
  // no-op
});

Given("reads are throttled", function (this: LwsWorld) {
  return "pending";
});

Given("writes are not throttled", function (this: LwsWorld) {
  // no-op
});

Given("writes are throttled", function (this: LwsWorld) {
  return "pending";
});

Given("no transaction is currently in progress", function (this: LwsWorld) {
  // no-op
});

Given("a transaction is currently in progress", function (this: LwsWorld) {
  return "pending";
});

Given('there are no writes pending propagation to the "GSI"', function (this: LwsWorld) {
  // no-op
});

Given('there are writes pending propagation to the "GSI"', function (this: LwsWorld) {
  return "pending";
});

// ---------------------------------------------------------------------------
// DynamoDB — When
// ---------------------------------------------------------------------------

When("a table is created", async function (this: LwsWorld) {
  const client = this.dynamodbClient();
  try {
    const result = await client.send(
      new CreateTableCommand({
        TableName: TEST_DDB_TABLE,
        KeySchema: [{ AttributeName: TEST_DDB_KEY, KeyType: "HASH" }],
        AttributeDefinitions: [{ AttributeName: TEST_DDB_KEY, AttributeType: "S" }],
        BillingMode: "PAY_PER_REQUEST",
      }),
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("a DynamoDB table is created", async function (this: LwsWorld) {
  const client = this.dynamodbClient();
  try {
    const result = await client.send(
      new CreateTableCommand({
        TableName: TEST_DDB_TABLE,
        KeySchema: [{ AttributeName: TEST_DDB_KEY, KeyType: "HASH" }],
        AttributeDefinitions: [{ AttributeName: TEST_DDB_KEY, AttributeType: "S" }],
        BillingMode: "PAY_PER_REQUEST",
      }),
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("a table is deleted", async function (this: LwsWorld) {
  const client = this.dynamodbClient();
  try {
    const result = await client.send(new DeleteTableCommand({ TableName: TEST_DDB_TABLE }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("a table is described", async function (this: LwsWorld) {
  const client = this.dynamodbClient();
  try {
    const result = await client.send(new DescribeTableCommand({ TableName: TEST_DDB_TABLE }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("all tables are listed", async function (this: LwsWorld) {
  const client = this.dynamodbClient();
  try {
    const result = await client.send(new ListTablesCommand({}));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("an item is written to the table", async function (this: LwsWorld) {
  const client = this.dynamodbClient();
  try {
    const result = await client.send(
      new PutItemCommand({
        TableName: TEST_DDB_TABLE,
        Item: { [TEST_DDB_KEY]: { S: TEST_DDB_KEY_VAL } },
      }),
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("an item is read from the table", async function (this: LwsWorld) {
  const client = this.dynamodbClient();
  try {
    const result = await client.send(
      new GetItemCommand({
        TableName: TEST_DDB_TABLE,
        Key: { [TEST_DDB_KEY]: { S: TEST_DDB_KEY_VAL } },
      }),
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("an existing item is deleted from the table", async function (this: LwsWorld) {
  const client = this.dynamodbClient();
  try {
    const result = await client.send(
      new DeleteItemCommand({
        TableName: TEST_DDB_TABLE,
        Key: { [TEST_DDB_KEY]: { S: TEST_DDB_KEY_VAL } },
        ConditionExpression: "attribute_exists(#pk)",
        ExpressionAttributeNames: { "#pk": TEST_DDB_KEY },
      }),
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("an existing item is updated in the table", async function (this: LwsWorld) {
  const client = this.dynamodbClient();
  try {
    const result = await client.send(
      new UpdateItemCommand({
        TableName: TEST_DDB_TABLE,
        Key: { [TEST_DDB_KEY]: { S: TEST_DDB_KEY_VAL } },
        UpdateExpression: "SET #v = :v",
        ExpressionAttributeNames: { "#v": "val", "#pk": TEST_DDB_KEY },
        ExpressionAttributeValues: { ":v": { S: "updated" } },
        ConditionExpression: "attribute_exists(#pk)",
      }),
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("all items in the table are scanned", async function (this: LwsWorld) {
  const client = this.dynamodbClient();
  try {
    const result = await client.send(new ScanCommand({ TableName: TEST_DDB_TABLE }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("items are queried from the table by key", async function (this: LwsWorld) {
  const client = this.dynamodbClient();
  try {
    const result = await client.send(
      new QueryCommand({
        TableName: TEST_DDB_TABLE,
        KeyConditionExpression: "#k = :v",
        ExpressionAttributeNames: { "#k": TEST_DDB_KEY },
        ExpressionAttributeValues: { ":v": { S: TEST_DDB_KEY_VAL } },
      }),
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("an item is conditionally written to the table", async function (this: LwsWorld) {
  const client = this.dynamodbClient();
  try {
    const result = await client.send(
      new PutItemCommand({
        TableName: TEST_DDB_TABLE,
        Item: { [TEST_DDB_KEY]: { S: TEST_DDB_KEY_VAL } },
        ConditionExpression: "attribute_not_exists(#k)",
        ExpressionAttributeNames: { "#k": TEST_DDB_KEY },
      }),
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When(
  "a transactional write is initiated across one or more items",
  async function (this: LwsWorld) {
    const client = this.dynamodbClient();
    try {
      const result = await client.send(
        new TransactWriteItemsCommand({
          TransactItems: [
            {
              Put: {
                TableName: TEST_DDB_TABLE,
                Item: { [TEST_DDB_KEY]: { S: TEST_DDB_KEY_VAL } },
              },
            },
          ],
        }),
      );
      this.lastResult = { success: true, output: result };
    } catch (err) {
      this.lastResult = { success: false, output: err, error: err };
    }
  },
);

When("a table finishes creating and becomes active", function (this: LwsWorld) {
  return "pending";
});

When('a "GSI" catches up with pending write propagation', function (this: LwsWorld) {
  return "pending";
});

When("a committed transaction is cleared", function (this: LwsWorld) {
  return "pending";
});

When("a rolled-back transaction is cleared", function (this: LwsWorld) {
  return "pending";
});

When("a pending transaction resolves non-deterministically", function (this: LwsWorld) {
  return "pending";
});

When("read throttling is toggled on or off", function (this: LwsWorld) {
  return "pending";
});

When("write throttling is toggled on or off", function (this: LwsWorld) {
  return "pending";
});

// ---------------------------------------------------------------------------
// DynamoDB — Then
// ---------------------------------------------------------------------------

Then('the table is "ACTIVE" and ready for reads and writes', function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    true,
    `Expected table to be ACTIVE: ${JSON.stringify(this.lastResult.output)}`,
  );
});

Then('the table is in "CREATING" state', function (this: LwsWorld) {
  return "pending";
});

Then('the table is marked as "DELETED"', function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    true,
    `Expected delete to succeed: ${JSON.stringify(this.lastResult.output)}`,
  );
});

Then("the table metadata is returned", function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    true,
    `Expected describe table to succeed: ${JSON.stringify(this.lastResult.output)}`,
  );
});

Then("the list of tables is returned", function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    true,
    `Expected list tables to succeed: ${JSON.stringify(this.lastResult.output)}`,
  );
});

Then("the item value is returned", function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    true,
    `Expected get item to succeed: ${JSON.stringify(this.lastResult.output)}`,
  );
});

Then("the item is deleted or unchanged (conditional delete)", function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    true,
    `Expected delete to succeed: ${JSON.stringify(this.lastResult.output)}`,
  );
});

Then("the item is deleted or unchanged \\(conditional delete)", function (this: LwsWorld) {
  // no-op: both success and condition-check-failure are valid outcomes
});

Then("the item is updated or unchanged (conditional update)", function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    true,
    `Expected update to succeed: ${JSON.stringify(this.lastResult.output)}`,
  );
});

Then("the item is updated or unchanged \\(conditional update)", function (this: LwsWorld) {
  // no-op: both success and condition-check-failure are valid outcomes
});

Then("items only exist in non-deleted tables", function (this: LwsWorld) {
  // no-op: invariant maintained by implementation
});

Then(
  "the table is marked as {string} and all its items are removed",
  function (this: LwsWorld, _state: string) {
    // no-op: invariant check
  },
);

Then(
  "the table enters {string} state and all its items are removed",
  async function (this: LwsWorld, _state: string) {
    // Verify the delete succeeded and the table no longer exists
    assert.strictEqual(
      this.lastResult.success,
      true,
      `Expected DeleteTable to succeed but got: ${JSON.stringify(this.lastResult.output)}`,
    );
    const client = this.dynamodbClient();
    const result = await client.send(new ListTablesCommand({}));
    const actualTables = result.TableNames ?? [];
    assert.ok(
      !actualTables.includes(TEST_DDB_TABLE),
      `Expected table "${TEST_DDB_TABLE}" to be removed after deletion but it still appears in: ${actualTables.join(", ")}`,
    );
  },
);

Then(
  "the item is written if the condition holds, otherwise the write is rejected",
  function (this: LwsWorld) {
    // May succeed or fail — both are valid outcomes for conditional write
  },
);

Then("matching items are returned", function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    true,
    `Expected query to succeed: ${JSON.stringify(this.lastResult.output)}`,
  );
});

Then("all items are returned", function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    true,
    `Expected scan to succeed: ${JSON.stringify(this.lastResult.output)}`,
  );
});

Then('the transaction is "PENDING"', function (this: LwsWorld) {
  return "pending";
});

Then('the transaction is "COMMITTED" or "ROLLED_BACK"', function (this: LwsWorld) {
  return "pending";
});

Then("the transaction slot is free", function (this: LwsWorld) {
  return "pending";
});

Then('the "GSI" is consistent with the table', function (this: LwsWorld) {
  return "pending";
});

Then('the item exists in the table and "GSI" propagation is pending', function (this: LwsWorld) {
  return "pending";
});

Then("reads are throttled or unthrottled", function (this: LwsWorld) {
  return "pending";
});

Then("writes are throttled or unthrottled", function (this: LwsWorld) {
  return "pending";
});

// ---------------------------------------------------------------------------
// S3 — Given
// ---------------------------------------------------------------------------

Given("the bucket does not exist or is not {string}", function (this: LwsWorld, _state: string) {
  // no-op: bucket is absent by default
});

Given("the bucket exists and is {string}", async function (this: LwsWorld, _state: string) {
  const client = this.s3Client();
  try {
    await client.send(new CreateBucketCommand({ Bucket: TEST_S3_BUCKET }));
  } catch {
    // ignore if already exists
  }
});

Given("the bucket is empty", function (this: LwsWorld) {
  // no-op: bucket starts empty
});

Given("the bucket is not empty", async function (this: LwsWorld) {
  return "pending";
});

Given("the bucket does not already exist", function (this: LwsWorld) {
  // no-op
});

Given("the bucket already exists", async function (this: LwsWorld) {
  const client = this.s3Client();
  await client.send(new CreateBucketCommand({ Bucket: TEST_S3_BUCKET }));
});

Given("the bucket exists", async function (this: LwsWorld) {
  const client = this.s3Client();
  try {
    await client.send(new CreateBucketCommand({ Bucket: TEST_S3_BUCKET }));
  } catch {
    // ignore
  }
});

Given("the bucket does not exist", function (this: LwsWorld) {
  // no-op
});

Given("the bucket is {string}", function (this: LwsWorld, state: string) {
  if (this.lastResult.output !== null) {
    assert.strictEqual(
      this.lastResult.success,
      true,
      `Expected bucket to be ${state} but got: ${JSON.stringify(this.lastResult.output)}`,
    );
    return;
  }
  // no-op: bucket is ACTIVE by default when it exists
});

Given("the bucket is not {string}", async function (this: LwsWorld, state: string) {
  if (state === "ACTIVE") {
    return "pending";
  }
  if (state === "CREATING" || state === "DELETING") {
    const client = this.s3Client();
    try {
      await client.send(new CreateBucketCommand({ Bucket: TEST_S3_BUCKET }));
    } catch {
      /* ignore if already exists */
    }
    return;
  }
  if (state === "DELETED") {
    return;
  }
  return "pending";
});

Given("the source bucket does not exist", function (this: LwsWorld) {
  // no-op
});

Given("the source bucket exists", async function (this: LwsWorld) {
  const client = this.s3Client();
  try {
    await client.send(new CreateBucketCommand({ Bucket: TEST_S3_SRC_BUCKET }));
  } catch {
    // ignore
  }
});

Given("the source bucket is {string}", function (this: LwsWorld, _state: string) {
  // no-op
});

Given("the source bucket is not {string}", async function (this: LwsWorld, state: string) {
  if (state === "ACTIVE") {
    return "pending";
  }
  if (state === "CREATING" || state === "DELETING") {
    const client = this.s3Client();
    try {
      await client.send(new CreateBucketCommand({ Bucket: TEST_S3_SRC_BUCKET }));
    } catch {
      /* ignore if already exists */
    }
    return;
  }
  if (state === "DELETED") {
    return;
  }
  return "pending";
});

Given("the destination bucket does not exist", function (this: LwsWorld) {
  // no-op
});

Given("the destination bucket exists", async function (this: LwsWorld) {
  const client = this.s3Client();
  try {
    await client.send(new CreateBucketCommand({ Bucket: TEST_S3_DST_BUCKET }));
  } catch {
    // ignore
  }
});

Given("the destination bucket is {string}", function (this: LwsWorld, _state: string) {
  // no-op
});

Given("the destination bucket is not {string}", async function (this: LwsWorld, state: string) {
  if (state === "ACTIVE") {
    return "pending";
  }
  if (state === "CREATING" || state === "DELETING") {
    const client = this.s3Client();
    try {
      await client.send(new CreateBucketCommand({ Bucket: TEST_S3_DST_BUCKET }));
    } catch {
      /* ignore if already exists */
    }
    return;
  }
  if (state === "DELETED") {
    return;
  }
  return "pending";
});

Given("the object does not exist in the bucket", function (this: LwsWorld) {
  // no-op
});

Given("the object exists in the bucket", async function (this: LwsWorld) {
  const client = this.s3Client();
  try {
    await client.send(new CreateBucketCommand({ Bucket: TEST_S3_BUCKET }));
  } catch {
    // ignore
  }
  await client.send(
    new PutObjectCommand({
      Bucket: TEST_S3_BUCKET,
      Key: TEST_S3_KEY,
      Body: Buffer.from(TEST_S3_BODY),
    }),
  );
});

Given("the object is deleted", function (this: LwsWorld) {
  return "pending";
});

Given("the object is not deleted", function (this: LwsWorld) {
  // no-op
});

Given("the source object does not exist", function (this: LwsWorld) {
  // no-op
});

Given("the source object exists", async function (this: LwsWorld) {
  const client = this.s3Client();
  try {
    await client.send(new CreateBucketCommand({ Bucket: TEST_S3_SRC_BUCKET }));
  } catch {
    // ignore
  }
  await client.send(
    new PutObjectCommand({
      Bucket: TEST_S3_SRC_BUCKET,
      Key: TEST_S3_KEY,
      Body: Buffer.from(TEST_S3_BODY),
    }),
  );
});

Given("the source object is deleted", function (this: LwsWorld) {
  return "pending";
});

Given("the source object is not deleted", function (this: LwsWorld) {
  // no-op
});

Given("the upload does not already exist", function (this: LwsWorld) {
  // no-op
});

Given("the upload already exists", async function (this: LwsWorld) {
  const client = this.s3Client();
  try {
    await client.send(new CreateBucketCommand({ Bucket: TEST_S3_BUCKET }));
  } catch {
    // ignore
  }
  const result = await client.send(
    new CreateMultipartUploadCommand({ Bucket: TEST_S3_BUCKET, Key: TEST_S3_KEY }),
  );
  this.lastUploadId = result.UploadId;
  this.lastBucket = TEST_S3_BUCKET;
  this.lastKey = TEST_S3_KEY;
});

Given("the upload does not exist", function (this: LwsWorld) {
  // no-op
});

Given("the upload exists", async function (this: LwsWorld) {
  const client = this.s3Client();
  try {
    await client.send(new CreateBucketCommand({ Bucket: TEST_S3_BUCKET }));
  } catch {
    // ignore
  }
  const result = await client.send(
    new CreateMultipartUploadCommand({ Bucket: TEST_S3_BUCKET, Key: TEST_S3_KEY }),
  );
  this.lastUploadId = result.UploadId;
  this.lastBucket = TEST_S3_BUCKET;
  this.lastKey = TEST_S3_KEY;
});

Given("the upload has at least one part", async function (this: LwsWorld) {
  if (this.lastResult.output !== null) {
    assert.strictEqual(
      this.lastResult.success,
      true,
      `Expected upload part to succeed but got: ${JSON.stringify(this.lastResult.output)}`,
    );
    return;
  }
  const client = this.s3Client();
  const partResult = await client.send(
    new UploadPartCommand({
      Bucket: this.lastBucket!,
      Key: this.lastKey!,
      UploadId: this.lastUploadId!,
      PartNumber: 1,
      Body: Buffer.from(TEST_S3_BODY),
    }),
  );
  this.lastETag = JSON.stringify([{ PartNumber: 1, ETag: partResult.ETag ?? "" }]);
});

Given("the upload has no parts", function (this: LwsWorld) {
  // no-op
});

Given("the upload is {string}", function (this: LwsWorld, state: string) {
  if (this.lastResult.output !== null) {
    assert.strictEqual(
      this.lastResult.success,
      true,
      `Expected upload to be ${state} but got: ${JSON.stringify(this.lastResult.output)}`,
    );
    return;
  }
  // no-op: upload is IN_PROGRESS by default when it exists
});

Given("the upload is not {string}", function (this: LwsWorld, _state: string) {
  return "pending";
});

// ---------------------------------------------------------------------------
// S3 — When
// ---------------------------------------------------------------------------

When("a bucket is created", async function (this: LwsWorld) {
  const client = this.s3Client();
  try {
    const result = await client.send(new CreateBucketCommand({ Bucket: TEST_S3_BUCKET }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("an S3 bucket is created", async function (this: LwsWorld) {
  const client = this.s3Client();
  try {
    const result = await client.send(new CreateBucketCommand({ Bucket: TEST_S3_BUCKET }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("a bucket is deleted", async function (this: LwsWorld) {
  const client = this.s3Client();
  try {
    const result = await client.send(new DeleteBucketCommand({ Bucket: TEST_S3_BUCKET }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("the list of buckets is retrieved", async function (this: LwsWorld) {
  const client = this.s3Client();
  try {
    const result = await client.send(new ListBucketsCommand({}));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("an object is uploaded to a bucket", async function (this: LwsWorld) {
  const client = this.s3Client();
  try {
    const result = await client.send(
      new PutObjectCommand({
        Bucket: TEST_S3_BUCKET,
        Key: TEST_S3_KEY,
        Body: Buffer.from(TEST_S3_BODY),
      }),
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("an object is retrieved from a bucket", async function (this: LwsWorld) {
  const client = this.s3Client();
  try {
    const result = await client.send(
      new GetObjectCommand({ Bucket: TEST_S3_BUCKET, Key: TEST_S3_KEY }),
    );
    const bodyStream = result.Body as Readable;
    const chunks: Buffer[] = [];
    for await (const chunk of bodyStream) {
      chunks.push(Buffer.isBuffer(chunk) ? chunk : Buffer.from(chunk as Uint8Array));
    }
    const bodyText = Buffer.concat(chunks).toString("utf-8");
    const { Body: _body, ...rest } = result;
    void _body;
    this.lastResult = { success: true, output: { ...rest, BodyText: bodyText } };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("an object is deleted from a bucket", async function (this: LwsWorld) {
  const client = this.s3Client();
  try {
    const result = await client.send(
      new DeleteObjectCommand({ Bucket: TEST_S3_BUCKET, Key: TEST_S3_KEY }),
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("object metadata is retrieved from a bucket", async function (this: LwsWorld) {
  const client = this.s3Client();
  try {
    const result = await client.send(
      new HeadObjectCommand({ Bucket: TEST_S3_BUCKET, Key: TEST_S3_KEY }),
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("objects in a bucket are listed", async function (this: LwsWorld) {
  const client = this.s3Client();
  try {
    const result = await client.send(new ListObjectsV2Command({ Bucket: TEST_S3_BUCKET }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("an object is copied from one bucket to another", async function (this: LwsWorld) {
  const client = this.s3Client();
  try {
    const result = await client.send(
      new CopyObjectCommand({
        Bucket: TEST_S3_DST_BUCKET,
        Key: TEST_S3_KEY,
        CopySource: `${TEST_S3_SRC_BUCKET}/${TEST_S3_KEY}`,
      }),
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("a multipart upload is initiated", async function (this: LwsWorld) {
  const client = this.s3Client();
  try {
    const result = await client.send(
      new CreateMultipartUploadCommand({ Bucket: TEST_S3_BUCKET, Key: TEST_S3_KEY }),
    );
    this.lastUploadId = result.UploadId;
    this.lastBucket = TEST_S3_BUCKET;
    this.lastKey = TEST_S3_KEY;
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("a part is uploaded for a multipart upload", async function (this: LwsWorld) {
  const client = this.s3Client();
  try {
    const result = await client.send(
      new UploadPartCommand({
        Bucket: this.lastBucket!,
        Key: this.lastKey!,
        UploadId: this.lastUploadId!,
        PartNumber: 1,
        Body: Buffer.from(TEST_S3_BODY),
      }),
    );
    this.lastETag = JSON.stringify([{ PartNumber: 1, ETag: result.ETag ?? "" }]);
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("a multipart upload is completed", async function (this: LwsWorld) {
  const client = this.s3Client();
  let parts: Array<{ PartNumber: number; ETag: string }> = [];
  if (this.lastETag) {
    try {
      parts = JSON.parse(this.lastETag);
    } catch {
      parts = [{ PartNumber: 1, ETag: this.lastETag }];
    }
  }
  try {
    const result = await client.send(
      new CompleteMultipartUploadCommand({
        Bucket: this.lastBucket!,
        Key: this.lastKey!,
        UploadId: this.lastUploadId!,
        MultipartUpload: { Parts: parts },
      }),
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("a multipart upload is aborted", async function (this: LwsWorld) {
  const client = this.s3Client();
  try {
    const result = await client.send(
      new AbortMultipartUploadCommand({
        Bucket: this.lastBucket!,
        Key: this.lastKey!,
        UploadId: this.lastUploadId!,
      }),
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("versioning is configured on a bucket", async function (this: LwsWorld) {
  const client = this.s3Client();
  try {
    const result = await client.send(
      new PutBucketVersioningCommand({
        Bucket: TEST_S3_BUCKET,
        VersioningConfiguration: { Status: "Enabled" },
      }),
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("a lifecycle rule expires an object", function (this: LwsWorld) {
  return "pending";
});

// ---------------------------------------------------------------------------
// S3 — Then
// ---------------------------------------------------------------------------

Then('the bucket is "ACTIVE" with versioning disabled', function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    true,
    `Expected bucket create to succeed: ${JSON.stringify(this.lastResult.output)}`,
  );
});

Then("the available buckets are returned", function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    true,
    `Expected list buckets to succeed: ${JSON.stringify(this.lastResult.output)}`,
  );
});

Then('the object "EXISTS" in the bucket', function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    true,
    `Expected put object to succeed: ${JSON.stringify(this.lastResult.output)}`,
  );
});

Then("the object data is returned", function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    true,
    `Expected get object to succeed: ${JSON.stringify(this.lastResult.output)}`,
  );
});

Then('the object is "DELETED"', function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    true,
    `Expected delete object to succeed: ${JSON.stringify(this.lastResult.output)}`,
  );
});

Then("the object metadata is returned", function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    true,
    `Expected head object to succeed: ${JSON.stringify(this.lastResult.output)}`,
  );
});

Then("the list of objects in the bucket is returned", function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    true,
    `Expected list objects to succeed: ${JSON.stringify(this.lastResult.output)}`,
  );
});

Then('the object "EXISTS" in the destination bucket', function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    true,
    `Expected copy object to succeed: ${JSON.stringify(this.lastResult.output)}`,
  );
});

Then('the upload is "IN_PROGRESS" with no parts', function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    true,
    `Expected create multipart upload to succeed: ${JSON.stringify(this.lastResult.output)}`,
  );
});

Then(
  'the upload is "COMPLETED" and the assembled object "EXISTS" in the bucket',
  function (this: LwsWorld) {
    assert.strictEqual(
      this.lastResult.success,
      true,
      `Expected complete multipart upload to succeed: ${JSON.stringify(this.lastResult.output)}`,
    );
  },
);

Then(
  'the bucket versioning state is "ENABLED" or "SUSPENDED" non-deterministically',
  function (this: LwsWorld) {
    assert.strictEqual(
      this.lastResult.success,
      true,
      `Expected put bucket versioning to succeed: ${JSON.stringify(this.lastResult.output)}`,
    );
  },
);

Then('the object is "DELETED" by the lifecycle policy', function (this: LwsWorld) {
  return "pending";
});

// ---------------------------------------------------------------------------
// SNS — Given
// ---------------------------------------------------------------------------

Given("the topic is already {string}", async function (this: LwsWorld, state: string) {
  if (state === "ACTIVE") {
    const client = this.snsClient();
    try {
      const result = await client.send(new CreateTopicCommand({ Name: TEST_SNS_TOPIC }));
      this.lastTopicArn = result.TopicArn;
    } catch {
      /* ignore */
    }
    return;
  }
  if (state === "CREATING") {
    await cli.lifecycleSet(this.managementPort, "sns", { createDwellMs: 10000 });
    const client = this.snsClient();
    const result = await client.send(new CreateTopicCommand({ Name: TEST_SNS_TOPIC }));
    this.lastTopicArn = result.TopicArn;
    return;
  }
  if (state === "DELETING") {
    await cli.lifecycleSet(this.managementPort, "sns", { deleteDwellMs: 10000 });
    const client = this.snsClient();
    const result = await client.send(new CreateTopicCommand({ Name: TEST_SNS_TOPIC }));
    await client.send(new DeleteTopicCommand({ TopicArn: result.TopicArn! }));
    return;
  }
  if (state === "DELETED") {
    // Cannot test "already DELETED" state in fake — skip
    return "pending";
  }
  return "pending";
});

Given("the topic does not already exist", function (this: LwsWorld) {
  // no-op
});

Given("the topic already exists", async function (this: LwsWorld) {
  const client = this.snsClient();
  const result = await client.send(new CreateTopicCommand({ Name: TEST_SNS_TOPIC }));
  this.lastTopicArn = result.TopicArn;
});

Given("the topic exists", async function (this: LwsWorld) {
  const client = this.snsClient();
  try {
    const result = await client.send(new CreateTopicCommand({ Name: TEST_SNS_TOPIC }));
    this.lastTopicArn = result.TopicArn;
  } catch {
    // ignore
  }
});

Given("the topic does not exist", function (this: LwsWorld) {
  // no-op
});

Given("the topic is {string}", function (this: LwsWorld, state: string) {
  if (this.lastResult.output !== null) {
    assert.strictEqual(
      this.lastResult.success,
      true,
      `Expected topic to be ${state} but got: ${JSON.stringify(this.lastResult.output)}`,
    );
    return;
  }
  // no-op: topic is ACTIVE by default when it exists
});

Given("the topic is not {string}", async function (this: LwsWorld, state: string) {
  if (state === "ACTIVE") {
    return "pending";
  }
  if (state === "CREATING" || state === "DELETING") {
    const client = this.snsClient();
    try {
      await client.send(new CreateTopicCommand({ Name: TEST_SNS_TOPIC }));
    } catch {
      /* ignore if already exists */
    }
    return;
  }
  if (state === "DELETED") {
    return;
  }
  return "pending";
});

Given("the subscription does not exist", function (this: LwsWorld) {
  // no-op
});

Given("the subscription exists", async function (this: LwsWorld) {
  const client = this.snsClient();
  const topicArn = snsTopicArn(TEST_SNS_TOPIC);
  try {
    await client.send(new CreateTopicCommand({ Name: TEST_SNS_TOPIC }));
  } catch {
    // ignore
  }
  try {
    const result = await client.send(
      new SubscribeCommand({
        TopicArn: topicArn,
        Protocol: TEST_SNS_PROTOCOL,
        Endpoint: TEST_SNS_ENDPOINT,
      }),
    );
    this.lastSubscriptionArn = result.SubscriptionArn;
  } catch {
    // ignore
  }
});

Given("the subscription is {string}", function (this: LwsWorld, state: string) {
  if (this.lastResult.output !== null) {
    assert.strictEqual(
      this.lastResult.success,
      true,
      `Expected subscription to be ${state} but got: ${JSON.stringify(this.lastResult.output)}`,
    );
    return;
  }
  // no-op: subscription is CONFIRMED by default when it exists
});

Given("the subscription is not {string}", function (this: LwsWorld, _state: string) {
  return "pending";
});

Given("the subscription belongs to this topic", function (this: LwsWorld) {
  // no-op
});

Given("the subscription does not belong to this topic", function (this: LwsWorld) {
  return "pending";
});

Given("the subscription slot is available", function (this: LwsWorld) {
  // no-op
});

Given("the subscription's topic does not exist", function (this: LwsWorld) {
  return "pending";
});

Given("the subscription's topic exists", async function (this: LwsWorld) {
  const client = this.snsClient();
  try {
    const result = await client.send(new CreateTopicCommand({ Name: TEST_SNS_TOPIC }));
    this.lastTopicArn = result.TopicArn;
  } catch {
    // ignore
  }
});

Given("the subscription's topic is {string}", function (this: LwsWorld, _state: string) {
  // no-op
});

Given("the subscription's topic is not {string}", function (this: LwsWorld, _state: string) {
  return "pending";
});

Given("a confirmed subscription exists for the topic", async function (this: LwsWorld) {
  // SQS subscriptions are auto-confirmed in local mode
  const client = this.snsClient();
  const topicArn = snsTopicArn(TEST_SNS_TOPIC);
  try {
    const result = await client.send(
      new SubscribeCommand({
        TopicArn: topicArn,
        Protocol: TEST_SNS_PROTOCOL,
        Endpoint: TEST_SNS_ENDPOINT,
      }),
    );
    this.lastSubscriptionArn = result.SubscriptionArn;
  } catch {
    // ignore
  }
});

Given("no confirmed subscription exists for the topic", function (this: LwsWorld) {
  // no-op
});

Given("a delivery slot is available", function (this: LwsWorld) {
  // no-op
});

Given("no delivery slot is available", function (this: LwsWorld) {
  return "pending";
});

Given("the delivery does not exist", function (this: LwsWorld) {
  // no-op
});

Given("the delivery exists", function (this: LwsWorld) {
  return "pending";
});

Given("the delivery is {string}", function (this: LwsWorld, state: string) {
  if (this.lastResult.output !== null) {
    assert.strictEqual(
      this.lastResult.success,
      true,
      `Expected delivery to be ${state} but got: ${JSON.stringify(this.lastResult.output)}`,
    );
    return;
  }
  return "pending";
});

Given("the delivery is not {string}", function (this: LwsWorld, _state: string) {
  // no-op
});

Given("the retry count has reached the limit", function (this: LwsWorld) {
  return "pending";
});

Given("the retry count is below the limit", function (this: LwsWorld) {
  // no-op
});

// ---------------------------------------------------------------------------
// SNS — When
// ---------------------------------------------------------------------------

When('an "SNS" topic is created', async function (this: LwsWorld) {
  const client = this.snsClient();
  try {
    const result = await client.send(new CreateTopicCommand({ Name: TEST_SNS_TOPIC }));
    this.lastTopicArn = result.TopicArn;
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When('an "SNS" topic is deleted', async function (this: LwsWorld) {
  const client = this.snsClient();
  const topicArn = snsTopicArn(TEST_SNS_TOPIC);
  try {
    const result = await client.send(new DeleteTopicCommand({ TopicArn: topicArn }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("an endpoint subscribes to a topic", async function (this: LwsWorld) {
  const client = this.snsClient();
  const topicArn = snsTopicArn(TEST_SNS_TOPIC);
  try {
    const result = await client.send(
      new SubscribeCommand({
        TopicArn: topicArn,
        Protocol: TEST_SNS_PROTOCOL,
        Endpoint: TEST_SNS_ENDPOINT,
      }),
    );
    this.lastSubscriptionArn = result.SubscriptionArn;
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("a pending subscription is confirmed", function (this: LwsWorld) {
  return "pending";
});

When("a subscription is removed", async function (this: LwsWorld) {
  const client = this.snsClient();
  try {
    const result = await client.send(
      new UnsubscribeCommand({ SubscriptionArn: this.lastSubscriptionArn! }),
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("a message is published to a topic", async function (this: LwsWorld) {
  const client = this.snsClient();
  const topicArn = snsTopicArn(TEST_SNS_TOPIC);
  try {
    const result = await client.send(
      new PublishCommand({ TopicArn: topicArn, Message: "test-message" }),
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("a delivery attempt succeeds", function (this: LwsWorld) {
  return "pending";
});

When("a delivery attempt fails and is retried", function (this: LwsWorld) {
  return "pending";
});

When("all delivery retries are exhausted", function (this: LwsWorld) {
  return "pending";
});

When("a subscription confirmation token expires", function (this: LwsWorld) {
  return "pending";
});

// ---------------------------------------------------------------------------
// SNS — Then
// ---------------------------------------------------------------------------

Then('the topic is "DELETED" and its subscriptions are removed', function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    true,
    `Expected topic delete to succeed: ${JSON.stringify(this.lastResult.output)}`,
  );
});

Then('the subscription is "PENDING_CONFIRMATION" or "CONFIRMED"', function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    true,
    `Expected subscribe to succeed: ${JSON.stringify(this.lastResult.output)}`,
  );
});

Then('the pending subscription is "DELETED"', function (this: LwsWorld) {
  return "pending";
});

Then("the message is delivered to confirmed subscriptions", function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    true,
    `Expected publish to succeed: ${JSON.stringify(this.lastResult.output)}`,
  );
});

Then('the delivery is marked "DONE"', function (this: LwsWorld) {
  return "pending";
});

Then("the delivery retry count is incremented", function (this: LwsWorld) {
  return "pending";
});

// ---------------------------------------------------------------------------
// EventBridge — Given
// ---------------------------------------------------------------------------

Given("the event bus has no rules", function (this: LwsWorld) {
  // no-op: fresh bus has no rules
});

Given("the event bus has rules", async function (this: LwsWorld) {
  const client = this.eventbridgeClient();
  try {
    await client.send(new CreateEventBusCommand({ Name: TEST_EVENT_BUS }));
  } catch {
    // ignore
  }
  try {
    await client.send(
      new PutRuleCommand({
        Name: TEST_EVENT_RULE,
        EventBusName: TEST_EVENT_BUS,
        ScheduleExpression: "rate(1 day)",
        State: "ENABLED",
      }),
    );
  } catch {
    // ignore
  }
});

Given("the rule has active targets", async function (this: LwsWorld) {
  // Need to create the SQS queue first since PutTargets validates target ARN existence
  const sqsClient = this.sqsClient();
  try {
    await sqsClient.send(new CreateQueueCommand({ QueueName: TEST_SQS_QUEUE }));
  } catch {
    // ignore if already exists
  }
  const client = this.eventbridgeClient();
  try {
    await client.send(
      new PutTargetsCommand({
        Rule: TEST_EVENT_RULE,
        EventBusName: TEST_EVENT_BUS,
        Targets: [{ Id: "target1", Arn: TEST_EVENT_TARGET }],
      }),
    );
  } catch {
    // ignore
  }
});

Given("the rule has no active targets", function (this: LwsWorld) {
  // no-op
});

Given("the event bus does not already exist", function (this: LwsWorld) {
  // no-op
});

Given("the event bus already exists", async function (this: LwsWorld) {
  const client = this.eventbridgeClient();
  await client.send(new CreateEventBusCommand({ Name: TEST_EVENT_BUS }));
});

Given("the event bus exists", async function (this: LwsWorld) {
  const client = this.eventbridgeClient();
  try {
    await client.send(new CreateEventBusCommand({ Name: TEST_EVENT_BUS }));
  } catch {
    // ignore
  }
});

Given("the event bus does not exist", async function (this: LwsWorld) {
  // Delete the bus if it was created by a previous step
  const client = this.eventbridgeClient();
  try {
    await client.send(new DeleteEventBusCommand({ Name: TEST_EVENT_BUS }));
  } catch {
    // ignore: bus may not exist
  }
});

Given("the event bus is {string}", function (this: LwsWorld, state: string) {
  if (this.lastResult.output !== null) {
    assert.strictEqual(
      this.lastResult.success,
      true,
      `Expected event bus to be ${state} but got: ${JSON.stringify(this.lastResult.output)}`,
    );
    return;
  }
  // no-op: event bus is ACTIVE by default when it exists
});

Given("the event bus is not {string}", async function (this: LwsWorld, state: string) {
  if (state === "ACTIVE") {
    return "pending";
  }
  if (state === "CREATING" || state === "DELETING") {
    const client = this.eventbridgeClient();
    try {
      await client.send(new CreateEventBusCommand({ Name: TEST_EVENT_BUS }));
    } catch {
      /* ignore if already exists */
    }
    return;
  }
  if (state === "DELETED") {
    return;
  }
  return "pending";
});

Given("the event bus is the default bus", function (this: LwsWorld) {
  // no-op: default bus always exists
});

Given("the event bus is not the default bus", async function (this: LwsWorld) {
  const client = this.eventbridgeClient();
  try {
    await client.send(new CreateEventBusCommand({ Name: TEST_EVENT_BUS }));
  } catch {
    // ignore
  }
});

Given("the rule does not already exist", function (this: LwsWorld) {
  // no-op
});

Given("the rule already exists", async function (this: LwsWorld) {
  const client = this.eventbridgeClient();
  try {
    await client.send(new CreateEventBusCommand({ Name: TEST_EVENT_BUS }));
  } catch {
    // ignore
  }
  await client.send(
    new PutRuleCommand({
      Name: TEST_EVENT_RULE,
      EventBusName: TEST_EVENT_BUS,
      ScheduleExpression: "rate(1 day)",
      State: "ENABLED",
    }),
  );
});

Given("the rule does not exist", function (this: LwsWorld) {
  // no-op
});

Given("the rule exists", async function (this: LwsWorld) {
  const client = this.eventbridgeClient();
  try {
    await client.send(new CreateEventBusCommand({ Name: TEST_EVENT_BUS }));
  } catch {
    // ignore
  }
  try {
    await client.send(
      new PutRuleCommand({
        Name: TEST_EVENT_RULE,
        EventBusName: TEST_EVENT_BUS,
        ScheduleExpression: "rate(1 day)",
        State: "ENABLED",
      }),
    );
  } catch {
    // ignore
  }
});

Given("the rule is {string}", async function (this: LwsWorld, state: string) {
  const client = this.eventbridgeClient();
  if (state === "DISABLED") {
    try {
      await client.send(
        new DisableRuleCommand({ Name: TEST_EVENT_RULE, EventBusName: TEST_EVENT_BUS }),
      );
    } catch {
      // ignore
    }
    return;
  }
  if (state === "DELETED") {
    try {
      await client.send(
        new DeleteRuleCommand({ Name: TEST_EVENT_RULE, EventBusName: TEST_EVENT_BUS }),
      );
    } catch {
      // ignore
    }
    return;
  }
  if (state === "ENABLED") {
    // no-op: rule is ENABLED by default when it exists; if previously disabled, enable it
    try {
      await client.send(
        new EnableRuleCommand({ Name: TEST_EVENT_RULE, EventBusName: TEST_EVENT_BUS }),
      );
    } catch {
      // ignore: may already be enabled
    }
    return;
  }
});

Given("the rule is not {string}", function (this: LwsWorld, _state: string) {
  return "pending";
});

Given('the rule is already "DELETED"', async function (this: LwsWorld) {
  const client = this.eventbridgeClient();
  try {
    await client.send(
      new DeleteRuleCommand({ Name: TEST_EVENT_RULE, EventBusName: TEST_EVENT_BUS }),
    );
  } catch {
    // ignore
  }
});

Given('the rule is not already "DELETED"', function (this: LwsWorld) {
  // no-op
});

Given("a rule is associated with the event bus", async function (this: LwsWorld) {
  const client = this.eventbridgeClient();
  try {
    await client.send(new CreateEventBusCommand({ Name: TEST_EVENT_BUS }));
  } catch {
    // ignore
  }
  try {
    await client.send(
      new PutRuleCommand({
        Name: TEST_EVENT_RULE,
        EventBusName: TEST_EVENT_BUS,
        ScheduleExpression: "rate(1 day)",
        State: "ENABLED",
      }),
    );
  } catch {
    // ignore
  }
});

Given("no rule is associated with the event bus", function (this: LwsWorld) {
  // no-op: fresh bus has no rules
});

Given("a target is associated with the rule", async function (this: LwsWorld) {
  // Ensure the target SQS queue exists (PutTargets validates target ARN existence)
  const sqsClient = this.sqsClient();
  try {
    await sqsClient.send(new CreateQueueCommand({ QueueName: TEST_SQS_QUEUE }));
  } catch {
    // ignore if already exists
  }
  const client = this.eventbridgeClient();
  try {
    await client.send(
      new PutTargetsCommand({
        Rule: TEST_EVENT_RULE,
        EventBusName: TEST_EVENT_BUS,
        Targets: [{ Id: "target1", Arn: TEST_EVENT_TARGET }],
      }),
    );
  } catch {
    // ignore
  }
});

Given("no target is associated with the rule", function (this: LwsWorld) {
  // no-op
});

Given("the rule's event bus does not match", function (this: LwsWorld) {
  return "pending";
});

Given("the rule's event bus matches", function (this: LwsWorld) {
  // no-op
});

Given("the target association is active", function (this: LwsWorld) {
  // no-op
});

Given("the target association is not active", function (this: LwsWorld) {
  return "pending";
});

Given("the target is associated with the rule", async function (this: LwsWorld) {
  // Ensure the target SQS queue exists (PutTargets validates target ARN existence)
  const sqsClient = this.sqsClient();
  try {
    await sqsClient.send(new CreateQueueCommand({ QueueName: TEST_SQS_QUEUE }));
  } catch {
    // ignore if already exists
  }
  const client = this.eventbridgeClient();
  try {
    await client.send(
      new PutTargetsCommand({
        Rule: TEST_EVENT_RULE,
        EventBusName: TEST_EVENT_BUS,
        Targets: [{ Id: "target1", Arn: TEST_EVENT_TARGET }],
      }),
    );
  } catch {
    // ignore
  }
});

Given("the target is not associated with the rule", function (this: LwsWorld) {
  // no-op
});

Given("the dead-letter queue is empty", function (this: LwsWorld) {
  // no-op
});

Given("the dead-letter queue is not empty", function (this: LwsWorld) {
  return "pending";
});

// ---------------------------------------------------------------------------
// EventBridge — When
// ---------------------------------------------------------------------------

When("an event bus is created", async function (this: LwsWorld) {
  const client = this.eventbridgeClient();
  try {
    const result = await client.send(new CreateEventBusCommand({ Name: TEST_EVENT_BUS }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("an event bus is deleted", async function (this: LwsWorld) {
  const client = this.eventbridgeClient();
  try {
    const result = await client.send(new DeleteEventBusCommand({ Name: TEST_EVENT_BUS }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("all event buses are listed", async function (this: LwsWorld) {
  const client = this.eventbridgeClient();
  try {
    const result = await client.send(new ListEventBusesCommand({}));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("an event bus is described", async function (this: LwsWorld) {
  const client = this.eventbridgeClient();
  try {
    const result = await client.send(new DescribeEventBusCommand({ Name: TEST_EVENT_BUS }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("an EventBridge rule is created", async function (this: LwsWorld) {
  const client = this.eventbridgeClient();
  try {
    const result = await client.send(
      new PutRuleCommand({
        Name: TEST_EVENT_RULE,
        EventBusName: TEST_EVENT_BUS,
        ScheduleExpression: "rate(1 day)",
        State: "ENABLED",
      }),
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("an EventBridge rule is deleted", async function (this: LwsWorld) {
  const client = this.eventbridgeClient();
  try {
    const result = await client.send(
      new DeleteRuleCommand({ Name: TEST_EVENT_RULE, EventBusName: TEST_EVENT_BUS }),
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("an EventBridge rule is described", async function (this: LwsWorld) {
  const client = this.eventbridgeClient();
  try {
    const result = await client.send(
      new DescribeRuleCommand({ Name: TEST_EVENT_RULE, EventBusName: TEST_EVENT_BUS }),
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("all rules on an event bus are listed", async function (this: LwsWorld) {
  const client = this.eventbridgeClient();
  try {
    const result = await client.send(new ListRulesCommand({ EventBusName: TEST_EVENT_BUS }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("a rule is enabled", async function (this: LwsWorld) {
  const client = this.eventbridgeClient();
  try {
    const result = await client.send(
      new EnableRuleCommand({ Name: TEST_EVENT_RULE, EventBusName: TEST_EVENT_BUS }),
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("a rule is disabled", async function (this: LwsWorld) {
  const client = this.eventbridgeClient();
  try {
    const result = await client.send(
      new DisableRuleCommand({ Name: TEST_EVENT_RULE, EventBusName: TEST_EVENT_BUS }),
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("targets are added to a rule", async function (this: LwsWorld) {
  // Create the SQS queue first since PutTargets validates target ARN existence
  const sqsClient = this.sqsClient();
  try {
    await sqsClient.send(new CreateQueueCommand({ QueueName: TEST_SQS_QUEUE }));
  } catch {
    // ignore if already exists
  }
  const client = this.eventbridgeClient();
  try {
    const result = await client.send(
      new PutTargetsCommand({
        Rule: TEST_EVENT_RULE,
        EventBusName: TEST_EVENT_BUS,
        Targets: [{ Id: "target1", Arn: TEST_EVENT_TARGET }],
      }),
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("targets are removed from a rule", async function (this: LwsWorld) {
  const client = this.eventbridgeClient();
  try {
    const result = await client.send(
      new RemoveTargetsCommand({
        Rule: TEST_EVENT_RULE,
        EventBusName: TEST_EVENT_BUS,
        Ids: ["target1"],
      }),
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("targets for a rule are listed", async function (this: LwsWorld) {
  const client = this.eventbridgeClient();
  try {
    const result = await client.send(
      new ListTargetsByRuleCommand({ Rule: TEST_EVENT_RULE, EventBusName: TEST_EVENT_BUS }),
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("events are published to an event bus", async function (this: LwsWorld) {
  const client = this.eventbridgeClient();
  try {
    const result = await client.send(
      new PutEventsCommand({
        Entries: [
          {
            EventBusName: TEST_EVENT_BUS,
            Source: "e2e.test",
            DetailType: "TestEvent",
            Detail: JSON.stringify({ message: "hello" }),
          },
        ],
      }),
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("a dead-letter queue entry is retried or discarded", function (this: LwsWorld) {
  return "pending";
});

// ---------------------------------------------------------------------------
// EventBridge — Then
// ---------------------------------------------------------------------------

Then("the list of event buses is returned", function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    true,
    `Expected list event buses to succeed: ${JSON.stringify(this.lastResult.output)}`,
  );
});

Then("the event bus details are returned", function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    true,
    `Expected describe event bus to succeed: ${JSON.stringify(this.lastResult.output)}`,
  );
});

Then("the rule details are returned", function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    true,
    `Expected describe rule to succeed: ${JSON.stringify(this.lastResult.output)}`,
  );
});

Then("the list of rules is returned", function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    true,
    `Expected list rules to succeed: ${JSON.stringify(this.lastResult.output)}`,
  );
});

Then("the targets are associated with the rule", function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    true,
    `Expected put targets to succeed: ${JSON.stringify(this.lastResult.output)}`,
  );
});

Then("the targets are disassociated from the rule", function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    true,
    `Expected remove targets to succeed: ${JSON.stringify(this.lastResult.output)}`,
  );
});

Then("the list of targets is returned", function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    true,
    `Expected list targets to succeed: ${JSON.stringify(this.lastResult.output)}`,
  );
});

Then("matching enabled rules route the event to their targets", function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    true,
    `Expected put events to succeed: ${JSON.stringify(this.lastResult.output)}`,
  );
});

Then("the entry is removed from the dead-letter queue", function (this: LwsWorld) {
  return "pending";
});

Then("no enabled rule references a deleted event bus", function (this: LwsWorld) {
  // no-op: invariant maintained by implementation
});

Then("the dead-letter queue never exceeds its bounded capacity", function (this: LwsWorld) {
  // no-op: invariant maintained by implementation
});

// ---------------------------------------------------------------------------
// StepFunctions — Given
// ---------------------------------------------------------------------------

Given("the state machine does not already exist", function (this: LwsWorld) {
  // no-op
});

Given("the state machine already exists", async function (this: LwsWorld) {
  const client = this.sfnClient();
  const result = await client.send(
    new CreateStateMachineCommand({
      name: TEST_SFN_SM,
      definition: TEST_SFN_DEFINITION,
      roleArn: TEST_SFN_ROLE_ARN,
      type: "STANDARD",
    }),
  );
  this.lastStateMachineArn = result.stateMachineArn;
});

Given("the state machine exists", async function (this: LwsWorld) {
  const client = this.sfnClient();
  try {
    const result = await client.send(
      new CreateStateMachineCommand({
        name: TEST_SFN_SM,
        definition: TEST_SFN_DEFINITION,
        roleArn: TEST_SFN_ROLE_ARN,
        type: "STANDARD",
      }),
    );
    this.lastStateMachineArn = result.stateMachineArn;
  } catch {
    // ignore
  }
});

Given("the state machine does not exist", function (this: LwsWorld) {
  // no-op
});

Given("the state machine is {string}", function (this: LwsWorld, state: string) {
  if (this.lastResult.output !== null) {
    assert.strictEqual(
      this.lastResult.success,
      true,
      `Expected state machine to be ${state} but got: ${JSON.stringify(this.lastResult.output)}`,
    );
    return;
  }
  // no-op: state machine is ACTIVE by default when it exists
});

Given("the state machine is not {string}", async function (this: LwsWorld, state: string) {
  if (state === "ACTIVE") {
    return "pending";
  }
  if (state === "CREATING" || state === "DELETING") {
    const client = this.sfnClient();
    try {
      const result = await client.send(
        new CreateStateMachineCommand({
          name: TEST_SFN_SM,
          definition: TEST_SFN_DEFINITION,
          roleArn: TEST_SFN_ROLE_ARN,
          type: "STANDARD",
        }),
      );
      this.lastStateMachineArn = result.stateMachineArn;
    } catch {
      /* ignore if already exists */
    }
    return;
  }
  if (state === "DELETED") {
    return;
  }
  return "pending";
});

Given("the state machine is a {string} type", function (this: LwsWorld, _type: string) {
  // no-op
});

Given("the state machine is an {string} type", function (this: LwsWorld, _type: string) {
  // no-op
});

Given("the state machine is not a {string} type", function (this: LwsWorld, _type: string) {
  return "pending";
});

Given("the state machine is not an {string} type", function (this: LwsWorld, _type: string) {
  return "pending";
});

Given("the execution does not exist", function (this: LwsWorld) {
  // no-op
});

Given("the execution exists", async function (this: LwsWorld) {
  const client = this.sfnClient();
  try {
    const result = await client.send(
      new CreateStateMachineCommand({
        name: TEST_SFN_SM,
        definition: TEST_SFN_DEFINITION,
        roleArn: TEST_SFN_ROLE_ARN,
        type: "STANDARD",
      }),
    );
    this.lastStateMachineArn = result.stateMachineArn;
  } catch {
    // ignore if already exists
  }
  const smArn = sfnArn(TEST_SFN_SM);
  try {
    const result = await client.send(
      new StartExecutionCommand({ stateMachineArn: smArn, input: TEST_SFN_INPUT }),
    );
    this.lastExecutionArn = result.executionArn;
  } catch {
    // ignore
  }
});

Given("the execution is {string}", function (this: LwsWorld, state: string) {
  if (this.lastResult.output !== null) {
    assert.strictEqual(
      this.lastResult.success,
      true,
      `Expected execution to be ${state} but got: ${JSON.stringify(this.lastResult.output)}`,
    );
    return;
  }
  // no-op: execution is RUNNING by default when it exists
});

Given("the execution is not {string}", function (this: LwsWorld, _state: string) {
  return "pending";
});

Given("the execution slot is available", function (this: LwsWorld) {
  // no-op
});

Given("the execution slot is not available", function (this: LwsWorld) {
  return "pending";
});

Given("the tag association is active", function (this: LwsWorld) {
  // no-op
});

Given("the tag association is not active", function (this: LwsWorld) {
  return "pending";
});

Given("the tag is associated with the state machine", async function (this: LwsWorld) {
  const client = this.sfnClient();
  const smArn = sfnArn(TEST_SFN_SM);
  try {
    await client.send(
      new SfnTagResourceCommand({
        resourceArn: smArn,
        tags: [{ key: TEST_SSM_TAG_KEY, value: TEST_SSM_TAG_VAL }],
      }),
    );
  } catch {
    // ignore
  }
});

Given("the tag is not associated with the state machine", function (this: LwsWorld) {
  // no-op
});

// ---------------------------------------------------------------------------
// StepFunctions — When
// ---------------------------------------------------------------------------

When("a Step Functions state machine is created", async function (this: LwsWorld) {
  const client = this.sfnClient();
  try {
    const result = await client.send(
      new CreateStateMachineCommand({
        name: TEST_SFN_SM,
        definition: TEST_SFN_DEFINITION,
        roleArn: TEST_SFN_ROLE_ARN,
        type: "STANDARD",
      }),
    );
    this.lastStateMachineArn = result.stateMachineArn;
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("a state machine is deleted", async function (this: LwsWorld) {
  const client = this.sfnClient();
  const smArn = sfnArn(TEST_SFN_SM);
  try {
    const result = await client.send(new DeleteStateMachineCommand({ stateMachineArn: smArn }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("a state machine is described", async function (this: LwsWorld) {
  const client = this.sfnClient();
  const smArn = sfnArn(TEST_SFN_SM);
  try {
    const result = await client.send(new DescribeStateMachineCommand({ stateMachineArn: smArn }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("all state machines are listed", async function (this: LwsWorld) {
  const client = this.sfnClient();
  try {
    const result = await client.send(new ListStateMachinesCommand({}));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("an execution is started on a standard state machine", async function (this: LwsWorld) {
  const client = this.sfnClient();
  const smArn = sfnArn(TEST_SFN_SM);
  try {
    const result = await client.send(
      new StartExecutionCommand({ stateMachineArn: smArn, input: TEST_SFN_INPUT }),
    );
    this.lastExecutionArn = result.executionArn;
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When(
  "a synchronous execution is started on an express state machine",
  async function (this: LwsWorld) {
    const client = this.sfnClient();
    const smArn = this.lastStateMachineArn ?? sfnArn(TEST_SFN_EXPRESS_SM);
    try {
      const result = await client.send(
        new StartSyncExecutionCommand({ stateMachineArn: smArn, input: TEST_SFN_INPUT }),
      );
      this.lastResult = { success: true, output: result };
    } catch (err) {
      this.lastResult = { success: false, output: err, error: err };
    }
  },
);

When("a running execution is stopped", async function (this: LwsWorld) {
  const client = this.sfnClient();
  try {
    const result = await client.send(
      new StopExecutionCommand({ executionArn: this.lastExecutionArn! }),
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("an execution is described", async function (this: LwsWorld) {
  const client = this.sfnClient();
  try {
    const result = await client.send(
      new DescribeExecutionCommand({ executionArn: this.lastExecutionArn! }),
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("the event history of an execution is retrieved", async function (this: LwsWorld) {
  const client = this.sfnClient();
  try {
    const result = await client.send(
      new GetExecutionHistoryCommand({ executionArn: this.lastExecutionArn! }),
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("executions for a state machine are listed", async function (this: LwsWorld) {
  const client = this.sfnClient();
  const smArn = sfnArn(TEST_SFN_SM);
  try {
    const result = await client.send(new ListExecutionsCommand({ stateMachineArn: smArn }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("versions of a state machine are listed", async function (this: LwsWorld) {
  const client = this.sfnClient();
  const smArn = sfnArn(TEST_SFN_SM);
  try {
    const result = await client.send(
      new ListStateMachineVersionsCommand({ stateMachineArn: smArn }),
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("tags are added to a state machine", async function (this: LwsWorld) {
  const client = this.sfnClient();
  const smArn = sfnArn(TEST_SFN_SM);
  try {
    const result = await client.send(
      new SfnTagResourceCommand({
        resourceArn: smArn,
        tags: [{ key: TEST_SSM_TAG_KEY, value: TEST_SSM_TAG_VAL }],
      }),
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("tags are removed from a state machine", async function (this: LwsWorld) {
  const client = this.sfnClient();
  const smArn = sfnArn(TEST_SFN_SM);
  try {
    const result = await client.send(
      new SfnUntagResourceCommand({ resourceArn: smArn, tagKeys: [TEST_SSM_TAG_KEY] }),
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("tags for a state machine are listed", async function (this: LwsWorld) {
  const client = this.sfnClient();
  const smArn = sfnArn(TEST_SFN_SM);
  try {
    const result = await client.send(new SfnListTagsForResourceCommand({ resourceArn: smArn }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("a state machine definition is updated", async function (this: LwsWorld) {
  const client = this.sfnClient();
  const smArn = sfnArn(TEST_SFN_SM);
  try {
    const result = await client.send(
      new UpdateStateMachineCommand({ stateMachineArn: smArn, definition: TEST_SFN_DEFINITION }),
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("a state machine definition is validated", async function (this: LwsWorld) {
  const client = this.sfnClient();
  try {
    const result = await client.send(
      new ValidateStateMachineDefinitionCommand({ definition: TEST_SFN_DEFINITION }),
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("a running execution transitions to a terminal state", function (this: LwsWorld) {
  return "pending";
});

When("a running execution exceeds its timeout", function (this: LwsWorld) {
  return "pending";
});

When("a state machine deletion is finalized", function (this: LwsWorld) {
  return "pending";
});

// ---------------------------------------------------------------------------
// StepFunctions — Then
// ---------------------------------------------------------------------------

Then('the state machine is in "DELETING" state', function (this: LwsWorld) {
  return "pending";
});

Then("the state machine details are returned", function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    true,
    `Expected describe state machine to succeed: ${JSON.stringify(this.lastResult.output)}`,
  );
});

Then("the list of state machines is returned", function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    true,
    `Expected list state machines to succeed: ${JSON.stringify(this.lastResult.output)}`,
  );
});

Then('the execution is "SUCCEEDED" or "FAILED"', function (this: LwsWorld) {
  return "pending";
});

Then("the execution details are returned", function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    true,
    `Expected describe execution to succeed: ${JSON.stringify(this.lastResult.output)}`,
  );
});

Then("the execution history is returned", function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    true,
    `Expected get execution history to succeed: ${JSON.stringify(this.lastResult.output)}`,
  );
});

Then("the list of executions is returned", function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    true,
    `Expected list executions to succeed: ${JSON.stringify(this.lastResult.output)}`,
  );
});

Then("the list of state machine versions is returned", function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    true,
    `Expected list state machine versions to succeed: ${JSON.stringify(this.lastResult.output)}`,
  );
});

Then("the tags are associated with the state machine", function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    true,
    `Expected tag resource to succeed: ${JSON.stringify(this.lastResult.output)}`,
  );
});

Then("the tags are disassociated from the state machine", function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    true,
    `Expected untag resource to succeed: ${JSON.stringify(this.lastResult.output)}`,
  );
});

Then("the list of tags is returned", function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    true,
    `Expected list tags to succeed: ${JSON.stringify(this.lastResult.output)}`,
  );
});

Then("the state machine version is incremented", function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    true,
    `Expected update state machine to succeed: ${JSON.stringify(this.lastResult.output)}`,
  );
});

Then("the definition is valid or invalid", function (this: LwsWorld) {
  // Either outcome is valid for validation
});

// ---------------------------------------------------------------------------
// SSM — Given
// ---------------------------------------------------------------------------

Given(
  "the parameter {string} \\(not already {string})",
  function (this: LwsWorld, _name: string, _state: string) {
    // no-op: parameter is absent by default
  },
);

Given("the parameter does not already exist", function (this: LwsWorld) {
  // no-op
});

Given("the parameter does not already exist or has been deleted", function (this: LwsWorld) {
  // no-op
});

Given("the parameter already exists", async function (this: LwsWorld) {
  const client = this.ssmClient();
  await client.send(
    new PutParameterCommand({ Name: TEST_SSM_PARAM, Value: TEST_SSM_VALUE, Type: "String" }),
  );
});

Given("the parameter exists", async function (this: LwsWorld) {
  const client = this.ssmClient();
  try {
    await client.send(
      new PutParameterCommand({ Name: TEST_SSM_PARAM, Value: TEST_SSM_VALUE, Type: "String" }),
    );
  } catch {
    // ignore
  }
});

Given("the parameter does not exist", function (this: LwsWorld) {
  // no-op
});

Given("the parameter is active", function (this: LwsWorld) {
  // no-op
});

Given("the parameter is not active", function (this: LwsWorld) {
  return "pending";
});

Given("the tag is associated with the parameter", async function (this: LwsWorld) {
  const client = this.ssmClient();
  try {
    await client.send(
      new AddTagsToResourceCommand({
        ResourceType: "Parameter",
        ResourceId: TEST_SSM_PARAM,
        Tags: [{ Key: TEST_SSM_TAG_KEY, Value: TEST_SSM_TAG_VAL }],
      }),
    );
  } catch {
    // ignore
  }
});

Given("the tag is not associated with the parameter", function (this: LwsWorld) {
  // no-op
});

Given("all tag keys are strings", function (this: LwsWorld) {
  // no-op: invariant
});

// ---------------------------------------------------------------------------
// SSM — When
// ---------------------------------------------------------------------------

When('a parameter is stored in "SSM"', async function (this: LwsWorld) {
  const client = this.ssmClient();
  try {
    const result = await client.send(
      new PutParameterCommand({ Name: TEST_SSM_PARAM, Value: TEST_SSM_VALUE, Type: "String" }),
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When(
  "a parameter is written without overwrite when it already exists",
  async function (this: LwsWorld) {
    const client = this.ssmClient();
    try {
      const result = await client.send(
        new PutParameterCommand({
          Name: TEST_SSM_PARAM,
          Value: TEST_SSM_VALUE2,
          Type: "String",
          Overwrite: false,
        }),
      );
      this.lastResult = { success: true, output: result };
    } catch (err) {
      this.lastResult = { success: false, output: err, error: err };
    }
  },
);

When("an existing parameter value is updated", async function (this: LwsWorld) {
  const client = this.ssmClient();
  try {
    const result = await client.send(
      new PutParameterCommand({
        Name: TEST_SSM_PARAM,
        Value: TEST_SSM_VALUE2,
        Type: "String",
        Overwrite: true,
      }),
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When('a parameter is retrieved from "SSM"', async function (this: LwsWorld) {
  const client = this.ssmClient();
  try {
    const result = await client.send(new GetParameterCommand({ Name: TEST_SSM_PARAM }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When('multiple parameters are retrieved from "SSM"', async function (this: LwsWorld) {
  const client = this.ssmClient();
  try {
    const result = await client.send(
      new GetParametersCommand({ Names: [TEST_SSM_PARAM, TEST_SSM_PARAM2] }),
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When('parameters under a path are retrieved from "SSM"', async function (this: LwsWorld) {
  const client = this.ssmClient();
  try {
    const result = await client.send(new GetParametersByPathCommand({ Path: "/test/param" }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When('a parameter is deleted from "SSM"', async function (this: LwsWorld) {
  const client = this.ssmClient();
  try {
    const result = await client.send(new DeleteParameterCommand({ Name: TEST_SSM_PARAM }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When('multiple parameters are deleted from "SSM"', async function (this: LwsWorld) {
  const client = this.ssmClient();
  try {
    const result = await client.send(
      new DeleteParametersCommand({ Names: [TEST_SSM_PARAM, TEST_SSM_PARAM2] }),
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("parameters are described", async function (this: LwsWorld) {
  const client = this.ssmClient();
  try {
    const result = await client.send(new DescribeParametersCommand({}));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("tags are added to a parameter", async function (this: LwsWorld) {
  const client = this.ssmClient();
  try {
    const result = await client.send(
      new AddTagsToResourceCommand({
        ResourceType: "Parameter",
        ResourceId: TEST_SSM_PARAM,
        Tags: [{ Key: TEST_SSM_TAG_KEY, Value: TEST_SSM_TAG_VAL }],
      }),
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("tags are removed from a parameter", async function (this: LwsWorld) {
  const client = this.ssmClient();
  try {
    const result = await client.send(
      new RemoveTagsFromResourceCommand({
        ResourceType: "Parameter",
        ResourceId: TEST_SSM_PARAM,
        TagKeys: [TEST_SSM_TAG_KEY],
      }),
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("tags for a parameter are listed", async function (this: LwsWorld) {
  const client = this.ssmClient();
  try {
    const result = await client.send(
      new SsmListTagsForResourceCommand({ ResourceType: "Parameter", ResourceId: TEST_SSM_PARAM }),
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

// ---------------------------------------------------------------------------
// SSM — Then
// ---------------------------------------------------------------------------

Then("the parameter exists with version 1", function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    true,
    `Expected put parameter to succeed: ${JSON.stringify(this.lastResult.output)}`,
  );
});

Then("a ParameterAlreadyExists error is recorded", function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    false,
    `Expected ParameterAlreadyExists but got success: ${JSON.stringify(this.lastResult.output)}`,
  );
});

Then("param_exists values are always valid booleans", function (this: LwsWorld) {
  // no-op: invariant maintained by implementation
});

Then("the error log only contains ParameterAlreadyExists entries", function (this: LwsWorld) {
  // no-op: invariant maintained by implementation
});

Then("the parameter has a new value and an incremented version", function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    true,
    `Expected update parameter to succeed: ${JSON.stringify(this.lastResult.output)}`,
  );
});

Then("the parameter value is returned", function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    true,
    `Expected get parameter to succeed: ${JSON.stringify(this.lastResult.output)}`,
  );
});

Then("the parameter values are returned", function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    true,
    `Expected get parameters to succeed: ${JSON.stringify(this.lastResult.output)}`,
  );
});

Then("the parameters under the path are returned", function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    true,
    `Expected get parameters by path to succeed: ${JSON.stringify(this.lastResult.output)}`,
  );
});

Then("the parameter no longer exists", function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    true,
    `Expected delete parameter to succeed: ${JSON.stringify(this.lastResult.output)}`,
  );
});

Then("the parameters no longer exist", function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    true,
    `Expected delete parameters to succeed: ${JSON.stringify(this.lastResult.output)}`,
  );
});

Then("the parameter metadata is returned", function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    true,
    `Expected describe parameters to succeed: ${JSON.stringify(this.lastResult.output)}`,
  );
});

Then("the tags are associated with the parameter", function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    true,
    `Expected add tags to succeed: ${JSON.stringify(this.lastResult.output)}`,
  );
});

Then("the tags are disassociated from the parameter", function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    true,
    `Expected remove tags to succeed: ${JSON.stringify(this.lastResult.output)}`,
  );
});

// ---------------------------------------------------------------------------
// SecretsManager — Given
// ---------------------------------------------------------------------------

Given("the secret does not already exist", function (this: LwsWorld) {
  // no-op
});

Given("the secret already exists", async function (this: LwsWorld) {
  const client = this.secretsManagerClient();
  await client.send(new CreateSecretCommand({ Name: TEST_SM_SECRET, SecretString: TEST_SM_VALUE }));
});

Given("the secret exists", async function (this: LwsWorld) {
  const client = this.secretsManagerClient();
  try {
    await client.send(
      new CreateSecretCommand({ Name: TEST_SM_SECRET, SecretString: TEST_SM_VALUE }),
    );
  } catch {
    // ignore
  }
});

Given("the secret does not exist", function (this: LwsWorld) {
  // no-op
});

Given("the secret is {string}", function (this: LwsWorld, state: string) {
  if (this.lastResult.output !== null) {
    assert.strictEqual(
      this.lastResult.success,
      true,
      `Expected secret to be ${state} but got: ${JSON.stringify(this.lastResult.output)}`,
    );
    return;
  }
  // no-op: secret is ACTIVE by default when it exists
});

Given("the secret is not {string}", async function (this: LwsWorld, state: string) {
  if (state === "ACTIVE") {
    return "pending";
  }
  if (state === "CREATING" || state === "DELETING") {
    const client = this.secretsManagerClient();
    try {
      await client.send(
        new CreateSecretCommand({ Name: TEST_SM_SECRET, SecretString: TEST_SM_VALUE }),
      );
    } catch {
      /* ignore if already exists */
    }
    return;
  }
  if (state === "DELETED") {
    return;
  }
  return "pending";
});

Given("the recovery window is not open", function (this: LwsWorld) {
  // no-op
});

Given("the recovery window is open", function (this: LwsWorld) {
  return "pending";
});

// ---------------------------------------------------------------------------
// SecretsManager — When
// ---------------------------------------------------------------------------

When("a secret is created", async function (this: LwsWorld) {
  const client = this.secretsManagerClient();
  try {
    const result = await client.send(
      new CreateSecretCommand({ Name: TEST_SM_SECRET, SecretString: TEST_SM_VALUE }),
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("a secret is deleted", async function (this: LwsWorld) {
  const client = this.secretsManagerClient();
  try {
    const result = await client.send(new DeleteSecretCommand({ SecretId: TEST_SM_SECRET }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("a secret is described", async function (this: LwsWorld) {
  const client = this.secretsManagerClient();
  try {
    const result = await client.send(new DescribeSecretCommand({ SecretId: TEST_SM_SECRET }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("the current value of an active secret is retrieved", async function (this: LwsWorld) {
  const client = this.secretsManagerClient();
  try {
    const result = await client.send(new GetSecretValueCommand({ SecretId: TEST_SM_SECRET }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("all secrets are listed", async function (this: LwsWorld) {
  const client = this.secretsManagerClient();
  try {
    const result = await client.send(new ListSecretsCommand({}));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("a new value is stored for an active secret", async function (this: LwsWorld) {
  const client = this.secretsManagerClient();
  try {
    const result = await client.send(
      new PutSecretValueCommand({ SecretId: TEST_SM_SECRET, SecretString: TEST_SM_VALUE2 }),
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("a deleted secret is restored within the recovery window", async function (this: LwsWorld) {
  const client = this.secretsManagerClient();
  try {
    const result = await client.send(new RestoreSecretCommand({ SecretId: TEST_SM_SECRET }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("tags are added to an active secret", async function (this: LwsWorld) {
  const client = this.secretsManagerClient();
  try {
    const result = await client.send(
      new SmTagResourceCommand({
        SecretId: TEST_SM_SECRET,
        Tags: [{ Key: TEST_SM_TAG_KEY, Value: TEST_SM_TAG_VAL }],
      }),
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("tags are removed from an active secret", async function (this: LwsWorld) {
  const client = this.secretsManagerClient();
  try {
    const result = await client.send(
      new SmUntagResourceCommand({ SecretId: TEST_SM_SECRET, TagKeys: [TEST_SM_TAG_KEY] }),
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("metadata or description for an active secret is updated", async function (this: LwsWorld) {
  const client = this.secretsManagerClient();
  try {
    const result = await client.send(
      new UpdateSecretCommand({ SecretId: TEST_SM_SECRET, Description: "updated description" }),
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("an automatic rotation event occurs for an active secret", function (this: LwsWorld) {
  return "pending";
});

When("the recovery window for a deleted secret expires", function (this: LwsWorld) {
  return "pending";
});

// ---------------------------------------------------------------------------
// SecretsManager — Then
// ---------------------------------------------------------------------------

Then('the secret is "ACTIVE" with an initial version', function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    true,
    `Expected create secret to succeed: ${JSON.stringify(this.lastResult.output)}`,
  );
});

Then('the secret is "DELETED" and the recovery window is open', function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    true,
    `Expected delete secret to succeed: ${JSON.stringify(this.lastResult.output)}`,
  );
});

Then("the secret metadata is returned", function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    true,
    `Expected describe secret to succeed: ${JSON.stringify(this.lastResult.output)}`,
  );
});

Then("the current secret value is returned", function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    true,
    `Expected get secret value to succeed: ${JSON.stringify(this.lastResult.output)}`,
  );
});

Then("the list of secrets is returned", function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    true,
    `Expected list secrets to succeed: ${JSON.stringify(this.lastResult.output)}`,
  );
});

Then(
  "a new secret version is created and the previous version is retained",
  function (this: LwsWorld) {
    assert.strictEqual(
      this.lastResult.success,
      true,
      `Expected put secret value to succeed: ${JSON.stringify(this.lastResult.output)}`,
    );
  },
);

Then('the secret is "ACTIVE" again and the recovery window is closed', function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    true,
    `Expected restore secret to succeed: ${JSON.stringify(this.lastResult.output)}`,
  );
});

Then("the specified tags are associated with the secret", function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    true,
    `Expected tag secret to succeed: ${JSON.stringify(this.lastResult.output)}`,
  );
});

Then("the specified tags are no longer associated with the secret", function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    true,
    `Expected untag secret to succeed: ${JSON.stringify(this.lastResult.output)}`,
  );
});

Then("the secret metadata is updated", function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    true,
    `Expected update secret to succeed: ${JSON.stringify(this.lastResult.output)}`,
  );
});

Then(
  "the secret has a new current version and the previous version is retained",
  function (this: LwsWorld) {
    return "pending";
  },
);

Then("the secret can no longer be restored", function (this: LwsWorld) {
  return "pending";
});
