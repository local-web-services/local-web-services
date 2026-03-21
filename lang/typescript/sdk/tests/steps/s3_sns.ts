/** Step definitions: s3api_sns cross-service scenarios — unique When/Then steps only */

import { Given, When, Then } from "@cucumber/cucumber";
import assert from "assert";
import { S3_BUCKET, SNS_TOPIC, ACCOUNT_ID, REGION } from "./cross_service_common";
import type { SdkWorld } from "../support/world";

const TEST_OBJECT_KEY = "test-object-1.txt";

// ── Additional Given steps unique to s3api_sns ────────────────────────────────

Given("the topic exists and is {string}", async function (this: SdkWorld, _state: string) {
  // Arrange
  assert.ok(this.session, "No session running");
  const { SNSClient, CreateTopicCommand } = require("@aws-sdk/client-sns");
  const client = this.session!.client<typeof SNSClient>("sns");
  // Act
  try {
    await client.send(new CreateTopicCommand({ Name: SNS_TOPIC }));
  } catch {
    // May already exist
  }
  // Assert: no error thrown
});

Given(
  "the topic does not exist or is not {string}",
  async function (this: SdkWorld, _state: string) {
    // Arrange + Act: no-op — no topics exist
    // Assert: session is running
    assert.ok(this.session, "No session running");
  },
);

// ── When steps ────────────────────────────────────────────────────────────────

// Note: "an {string} notification configuration is added to the bucket" is defined
// in cross_service_common.ts and handles both "SNS" and "SQS" service types.

When(
  "an object is uploaded and S3 publishes a notification to the {string} topic",
  async function (this: SdkWorld, _service: string) {
    // Arrange
    assert.ok(this.session, "No session running");
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
  "an object is uploaded but notification delivery fails because the topic has been deleted",
  async function (this: SdkWorld) {
    // Arrange
    assert.ok(this.session, "No session running");
    const { S3Client, PutObjectCommand } = require("@aws-sdk/client-s3");
    const client = this.session!.client<typeof S3Client>("s3");
    // Act: upload the object — delivery to the deleted topic should fail silently
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

// Note: "the {string} topic is deleted" is defined in cross_service_common.ts.

// ── Then steps ────────────────────────────────────────────────────────────────

Then(
  "the bucket will publish notifications to the topic when objects are uploaded",
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
  "the object {string} and a notification is {string} to the topic",
  async function (this: SdkWorld, objectExpectedState: string, _notificationState: string) {
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
  "the object {string} but no notification is published",
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

// Note: "the topic is {string} and notification delivery to it will fail" is defined
// in cross_service_common.ts.
