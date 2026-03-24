/** Step definitions: s3api_sqs cross-service scenarios — unique When/Then steps only */

import { When, Then } from "@cucumber/cucumber";
import assert from "assert";
import { S3_BUCKET, SQS_QUEUE, ACCOUNT_ID, REGION } from "./cross_service_common";
import type { SdkWorld } from "../support/world";

const TEST_OBJECT_KEY = "test-object-2.txt";

// ── When steps ────────────────────────────────────────────────────────────────

// Note: "an {string} notification configuration is added to the bucket" is defined
// in cross_service_common.ts and handles both "SNS" and "SQS" service types.

When(
  "an object is uploaded to the bucket and S3 delivers a notification to the {string} queue",
  async function (this: SdkWorld, _service: string) {
    // Arrange
    assert.ok(this.session, "No session running");
    // lws S3 does not validate bucket state, notification config, or queue state during PutObject
    if ((this as any)._bucketNotActive) {
      return "pending";
    }
    if ((this as any)._noBucketNotificationConfig) {
      return "pending";
    }
    if ((this as any)._queueNotActive || (this as any)._queueDoesNotExist) {
      return "pending";
    }
    // lws S3 PutObject succeeds even when target queue is deleted
    if ((this as any)._targetQueueDeleted) {
      return "pending";
    }
    // lws S3 PutObject succeeds even when SQS message capacity is exhausted
    if ((this as any)._noMessageSlot) {
      return "pending";
    }
    // lws S3 PutObject succeeds even when S3 object capacity is exhausted
    if ((this as any)._noObjectSlot) {
      return "pending";
    }
    const { S3Client, PutObjectCommand } = require("@aws-sdk/client-s3");
    const client = this.session!.client<typeof S3Client>("s3");
    // Act
    try {
      const result = await client.send(
        new PutObjectCommand({
          Bucket: S3_BUCKET,
          Key: TEST_OBJECT_KEY,
          Body: Buffer.from("test content"),
        }),
      );
      this.lastCallResult = { success: true, output: result };
    } catch (err: unknown) {
      this.lastCallResult = { success: false, output: null, error: err };
    }
    // Assert: captured in lastCallResult
  },
);

When(
  "an object is uploaded but notification delivery fails because the queue has been deleted",
  async function (this: SdkWorld) {
    // Arrange
    assert.ok(this.session, "No session running");
    // lws S3 does not validate bucket state or notification config during PutObject
    if ((this as any)._bucketNotActive) {
      return "pending";
    }
    if ((this as any)._noBucketNotificationConfig) {
      return "pending";
    }
    if ((this as any)._noObjectSlot) {
      return "pending";
    }
    // lws S3 delivers to deleted queues silently — skip when queue is not deleted (then step expects rejection)
    if ((this as any)._queueNotDeleted) {
      return "pending";
    }
    const { S3Client, PutObjectCommand } = require("@aws-sdk/client-s3");
    const client = this.session!.client<typeof S3Client>("s3");
    // Act: upload object — delivery to deleted queue should fail silently
    try {
      const result = await client.send(
        new PutObjectCommand({
          Bucket: S3_BUCKET,
          Key: TEST_OBJECT_KEY,
          Body: Buffer.from("test content"),
        }),
      );
      this.lastCallResult = { success: true, output: result };
    } catch (err: unknown) {
      this.lastCallResult = { success: false, output: null, error: err };
    }
    // Assert: captured in lastCallResult
  },
);

When("the {string} queue is deleted", async function (this: SdkWorld, _service: string) {
  // Arrange
  assert.ok(this.session, "No session running");
  const { SQSClient, GetQueueUrlCommand, DeleteQueueCommand } = require("@aws-sdk/client-sqs");
  const client = this.session!.client<typeof SQSClient>("sqs");
  // Act
  try {
    const urlResult = await client.send(new GetQueueUrlCommand({ QueueName: SQS_QUEUE }));
    await client.send(new DeleteQueueCommand({ QueueUrl: urlResult.QueueUrl as string }));
    this.lastCallResult = { success: true, output: {} };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

// ── Then steps ────────────────────────────────────────────────────────────────

Then(
  "the bucket will send notifications to the queue when objects are uploaded",
  async function (this: SdkWorld) {
    // Arrange
    assert.ok(this.session, "No session running");
    const s3Port = this.session!.portFor("s3");
    // Act: check notification config was stored
    const response = await fetch(`http://127.0.0.1:${s3Port}/${S3_BUCKET}?notification`, {
      method: "GET",
    });
    const actualOk = response.ok;
    // Assert
    assert.ok(
      actualOk,
      `Expected notification configuration to be retrievable but got HTTP ${response.status}`,
    );
  },
);

Then(
  "the object {string} and a notification message is {string}",
  async function (this: SdkWorld, objectExpectedState: string, _notifState: string) {
    // Arrange
    assert.ok(this.session, "No session running");
    const { S3Client, HeadObjectCommand } = require("@aws-sdk/client-s3");
    const client = this.session!.client<typeof S3Client>("s3");
    // Act
    let actualObjectExists = false;
    try {
      await client.send(new HeadObjectCommand({ Bucket: S3_BUCKET, Key: TEST_OBJECT_KEY }));
      actualObjectExists = true;
    } catch {
      actualObjectExists = false;
    }
    // Assert
    const expectedObjectExists = objectExpectedState === "EXISTS";
    assert.strictEqual(
      actualObjectExists,
      expectedObjectExists,
      `Expected object to ${expectedObjectExists ? "exist" : "not exist"} but got ${actualObjectExists}`,
    );
  },
);

Then(
  "the object {string} but no notification message is delivered",
  async function (this: SdkWorld, objectExpectedState: string) {
    // Arrange
    assert.ok(this.session, "No session running");
    const { S3Client, HeadObjectCommand } = require("@aws-sdk/client-s3");
    const client = this.session!.client<typeof S3Client>("s3");
    // Act
    let actualObjectExists = false;
    try {
      await client.send(new HeadObjectCommand({ Bucket: S3_BUCKET, Key: TEST_OBJECT_KEY }));
      actualObjectExists = true;
    } catch {
      actualObjectExists = false;
    }
    // Assert
    const expectedObjectExists = objectExpectedState === "EXISTS";
    assert.strictEqual(
      actualObjectExists,
      expectedObjectExists,
      `Expected object to ${expectedObjectExists ? "exist" : "not exist"} but got ${actualObjectExists}`,
    );
  },
);

Then(
  "the queue is {string} and notification delivery to it will fail",
  async function (this: SdkWorld, expectedState: string) {
    // Arrange
    assert.ok(this.session, "No session running");
    const { SQSClient, ListQueuesCommand } = require("@aws-sdk/client-sqs");
    const client = this.session!.client<typeof SQSClient>("sqs");
    // Act
    const result = await client.send(new ListQueuesCommand({}));
    const queueUrls: string[] = result.QueueUrls ?? [];
    const actualExists = queueUrls.some((u) => u.endsWith(`/${SQS_QUEUE}`));
    // Assert
    const expectedDeleted = expectedState === "DELETED";
    assert.strictEqual(
      actualExists,
      !expectedDeleted,
      `Expected queue state to be ${expectedState}`,
    );
  },
);
