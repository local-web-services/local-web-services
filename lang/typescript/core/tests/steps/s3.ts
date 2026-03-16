/** S3 step definitions. */

import { Given, When, Then } from "@cucumber/cucumber";
import assert from "assert";
import {
  CreateBucketCommand,
  DeleteBucketCommand,
  ListBucketsCommand,
  PutObjectCommand,
  GetObjectCommand,
  DeleteObjectCommand,
  DeleteObjectsCommand,
  HeadBucketCommand,
  HeadObjectCommand,
  ListObjectsV2Command,
  GetBucketLocationCommand,
  CopyObjectCommand,
  GetBucketTaggingCommand,
  PutBucketTaggingCommand,
  DeleteBucketTaggingCommand,
  PutBucketPolicyCommand,
  GetBucketPolicyCommand,
  GetBucketNotificationConfigurationCommand,
  PutBucketNotificationConfigurationCommand,
  CreateMultipartUploadCommand,
  UploadPartCommand,
  CompleteMultipartUploadCommand,
  AbortMultipartUploadCommand,
  ListPartsCommand,
  GetBucketWebsiteCommand,
  PutBucketWebsiteCommand,
  DeleteBucketWebsiteCommand,
} from "@aws-sdk/client-s3";
import { Readable } from "stream";
import * as fs from "fs";
import * as os from "os";
import * as path from "path";
import type { LwsWorld } from "../support/world";

async function createBucket(world: LwsWorld, bucketName: string): Promise<void> {
  const client = world.s3Client();
  await client.send(new CreateBucketCommand({ Bucket: bucketName }));
}

async function putObject(world: LwsWorld, bucket: string, key: string, content: string): Promise<void> {
  const client = world.s3Client();
  await client.send(
    new PutObjectCommand({ Bucket: bucket, Key: key, Body: Buffer.from(content) })
  );
}

// --- Given -----------------------------------------------------------------

Given("a bucket {string} was created", async function (this: LwsWorld, bucketName: string) {
  await createBucket(this, bucketName);
});

Given("an object {string} was put into bucket {string} with content {string}", async function (
  this: LwsWorld,
  key: string,
  bucket: string,
  content: string
) {
  await putObject(this, bucket, key, content);
});

Given("a file was created with content {string}", async function (
  this: LwsWorld,
  content: string
) {
  const tmpFile = path.join(os.tmpdir(), `lws-test-${Date.now()}.txt`);
  fs.writeFileSync(tmpFile, content);
  this.lastFile = tmpFile;
});

Given("tags were set on bucket {string} with key {string} and value {string}", async function (
  this: LwsWorld,
  bucket: string,
  tagKey: string,
  tagValue: string
) {
  const client = this.s3Client();
  await client.send(
    new PutBucketTaggingCommand({
      Bucket: bucket,
      Tagging: { TagSet: [{ Key: tagKey, Value: tagValue }] },
    })
  );
});

Given("a policy was set on bucket {string}", async function (this: LwsWorld, bucket: string) {
  const client = this.s3Client();
  const policy = JSON.stringify({
    Version: "2012-10-17",
    Statement: [{ Effect: "Allow", Principal: "*", Action: "s3:GetObject", Resource: `arn:aws:s3:::${bucket}/*` }],
  });
  await client.send(new PutBucketPolicyCommand({ Bucket: bucket, Policy: policy }));
});

Given("a multipart upload was created for key {string} in bucket {string}", async function (
  this: LwsWorld,
  key: string,
  bucket: string
) {
  const client = this.s3Client();
  const result = await client.send(
    new CreateMultipartUploadCommand({ Bucket: bucket, Key: key })
  );
  this.lastUploadId = result.UploadId;
  this.lastBucket = bucket;
  this.lastKey = key;
  this.lastETag = undefined;
});

Given("part {int} with content {string} was uploaded", async function (
  this: LwsWorld,
  partNumber: number,
  content: string
) {
  const client = this.s3Client();
  const result = await client.send(
    new UploadPartCommand({
      Bucket: this.lastBucket!,
      Key: this.lastKey!,
      UploadId: this.lastUploadId!,
      PartNumber: partNumber,
      Body: Buffer.from(content),
    })
  );
  // Store ETags for complete
  if (!this.lastETag) {
    this.lastETag = result.ETag ?? "";
  }
  // store all parts as JSON-encoded array in lastETag for simplicity
  const existingParts: Array<{ PartNumber: number; ETag: string }> = this.lastETag.startsWith("[")
    ? JSON.parse(this.lastETag)
    : [];
  existingParts.push({ PartNumber: partNumber, ETag: result.ETag ?? "" });
  this.lastETag = JSON.stringify(existingParts);
});

Given("website configuration was set on bucket {string} with index {string}", async function (
  this: LwsWorld,
  bucket: string,
  indexDoc: string
) {
  const client = this.s3Client();
  await client.send(
    new PutBucketWebsiteCommand({
      Bucket: bucket,
      WebsiteConfiguration: { IndexDocument: { Suffix: indexDoc } },
    })
  );
});

// --- When ------------------------------------------------------------------

When("I create bucket {string}", async function (this: LwsWorld, bucketName: string) {
  const client = this.s3Client();
  try {
    const result = await client.send(new CreateBucketCommand({ Bucket: bucketName }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I delete bucket {string}", async function (this: LwsWorld, bucketName: string) {
  const client = this.s3Client();
  try {
    const result = await client.send(new DeleteBucketCommand({ Bucket: bucketName }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I list buckets", async function (this: LwsWorld) {
  const client = this.s3Client();
  try {
    const result = await client.send(new ListBucketsCommand({}));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I put object {string} into bucket {string} from the file", async function (
  this: LwsWorld,
  key: string,
  bucket: string
) {
  const client = this.s3Client();
  try {
    const content = fs.readFileSync(this.lastFile!);
    const result = await client.send(
      new PutObjectCommand({ Bucket: bucket, Key: key, Body: content })
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I get object {string} from bucket {string}", async function (
  this: LwsWorld,
  key: string,
  bucket: string
) {
  const client = this.s3Client();
  try {
    const result = await client.send(new GetObjectCommand({ Bucket: bucket, Key: key }));
    // Read the body
    const bodyStream = result.Body as Readable;
    const chunks: Buffer[] = [];
    for await (const chunk of bodyStream) {
      chunks.push(Buffer.isBuffer(chunk) ? chunk : Buffer.from(chunk as Uint8Array));
    }
    const bodyText = Buffer.concat(chunks).toString("utf-8");
    // Exclude Body from spread to avoid circular reference (IncomingMessage has circular refs)
    const { Body: _body, ...resultWithoutBody } = result;
    void _body;
    this.lastResult = { success: true, output: { ...resultWithoutBody, BodyText: bodyText } };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I delete object {string} from bucket {string}", async function (
  this: LwsWorld,
  key: string,
  bucket: string
) {
  const client = this.s3Client();
  try {
    const result = await client.send(new DeleteObjectCommand({ Bucket: bucket, Key: key }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I delete objects {string} and {string} from bucket {string}", async function (
  this: LwsWorld,
  key1: string,
  key2: string,
  bucket: string
) {
  const client = this.s3Client();
  try {
    const result = await client.send(
      new DeleteObjectsCommand({
        Bucket: bucket,
        Delete: { Objects: [{ Key: key1 }, { Key: key2 }] },
      })
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I head bucket {string}", async function (this: LwsWorld, bucketName: string) {
  const client = this.s3Client();
  try {
    const result = await client.send(new HeadBucketCommand({ Bucket: bucketName }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I head object {string} in bucket {string}", async function (
  this: LwsWorld,
  key: string,
  bucket: string
) {
  const client = this.s3Client();
  try {
    const result = await client.send(new HeadObjectCommand({ Bucket: bucket, Key: key }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I list objects in bucket {string}", async function (this: LwsWorld, bucket: string) {
  const client = this.s3Client();
  try {
    const result = await client.send(new ListObjectsV2Command({ Bucket: bucket }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I get the location of bucket {string}", async function (this: LwsWorld, bucket: string) {
  const client = this.s3Client();
  try {
    const result = await client.send(new GetBucketLocationCommand({ Bucket: bucket }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I copy object {string} in bucket {string} from source {string}", async function (
  this: LwsWorld,
  destKey: string,
  destBucket: string,
  source: string
) {
  const client = this.s3Client();
  try {
    const result = await client.send(
      new CopyObjectCommand({ Bucket: destBucket, Key: destKey, CopySource: source })
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I get tags from bucket {string}", async function (this: LwsWorld, bucket: string) {
  const client = this.s3Client();
  try {
    const result = await client.send(new GetBucketTaggingCommand({ Bucket: bucket }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I put tags on bucket {string} with key {string} and value {string}", async function (
  this: LwsWorld,
  bucket: string,
  tagKey: string,
  tagValue: string
) {
  const client = this.s3Client();
  try {
    const result = await client.send(
      new PutBucketTaggingCommand({
        Bucket: bucket,
        Tagging: { TagSet: [{ Key: tagKey, Value: tagValue }] },
      })
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I delete tags from bucket {string}", async function (this: LwsWorld, bucket: string) {
  const client = this.s3Client();
  try {
    const result = await client.send(new DeleteBucketTaggingCommand({ Bucket: bucket }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I get the policy of bucket {string}", async function (this: LwsWorld, bucket: string) {
  const client = this.s3Client();
  try {
    const result = await client.send(new GetBucketPolicyCommand({ Bucket: bucket }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I put a policy on bucket {string}", async function (this: LwsWorld, bucket: string) {
  const client = this.s3Client();
  const policy = JSON.stringify({
    Version: "2012-10-17",
    Statement: [{ Effect: "Allow", Principal: "*", Action: "s3:GetObject", Resource: `arn:aws:s3:::${bucket}/*` }],
  });
  try {
    const result = await client.send(new PutBucketPolicyCommand({ Bucket: bucket, Policy: policy }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I get the notification configuration of bucket {string}", async function (
  this: LwsWorld,
  bucket: string
) {
  const client = this.s3Client();
  try {
    const result = await client.send(
      new GetBucketNotificationConfigurationCommand({ Bucket: bucket })
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I put a notification configuration on bucket {string}", async function (
  this: LwsWorld,
  bucket: string
) {
  const client = this.s3Client();
  try {
    const result = await client.send(
      new PutBucketNotificationConfigurationCommand({
        Bucket: bucket,
        NotificationConfiguration: {},
      })
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I create a multipart upload for key {string} in bucket {string}", async function (
  this: LwsWorld,
  key: string,
  bucket: string
) {
  const client = this.s3Client();
  try {
    const result = await client.send(
      new CreateMultipartUploadCommand({ Bucket: bucket, Key: key })
    );
    this.lastUploadId = result.UploadId;
    this.lastBucket = bucket;
    this.lastKey = key;
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I upload part {int} with content {string}", async function (
  this: LwsWorld,
  partNumber: number,
  content: string
) {
  const client = this.s3Client();
  try {
    const result = await client.send(
      new UploadPartCommand({
        Bucket: this.lastBucket!,
        Key: this.lastKey!,
        UploadId: this.lastUploadId!,
        PartNumber: partNumber,
        Body: Buffer.from(content),
      })
    );
    this.lastETag = result.ETag ?? "";
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I complete the multipart upload", async function (this: LwsWorld) {
  const client = this.s3Client();
  // Parse accumulated parts from lastETag
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
      })
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I abort the multipart upload", async function (this: LwsWorld) {
  const client = this.s3Client();
  try {
    const result = await client.send(
      new AbortMultipartUploadCommand({
        Bucket: this.lastBucket!,
        Key: this.lastKey!,
        UploadId: this.lastUploadId!,
      })
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I list parts of the multipart upload", async function (this: LwsWorld) {
  const client = this.s3Client();
  try {
    const result = await client.send(
      new ListPartsCommand({
        Bucket: this.lastBucket!,
        Key: this.lastKey!,
        UploadId: this.lastUploadId!,
      })
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I get website configuration from bucket {string}", async function (
  this: LwsWorld,
  bucket: string
) {
  const client = this.s3Client();
  try {
    const result = await client.send(new GetBucketWebsiteCommand({ Bucket: bucket }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I put website configuration on bucket {string} with index {string}", async function (
  this: LwsWorld,
  bucket: string,
  indexDoc: string
) {
  const client = this.s3Client();
  try {
    const result = await client.send(
      new PutBucketWebsiteCommand({
        Bucket: bucket,
        WebsiteConfiguration: { IndexDocument: { Suffix: indexDoc } },
      })
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I delete website configuration from bucket {string}", async function (
  this: LwsWorld,
  bucket: string
) {
  const client = this.s3Client();
  try {
    const result = await client.send(new DeleteBucketWebsiteCommand({ Bucket: bucket }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

// Timed variant
When("I list S3 buckets with timing", async function (this: LwsWorld) {
  const client = this.s3Client();
  const start = Date.now();
  try {
    const result = await client.send(new ListBucketsCommand({}));
    this.timedResult = { success: true, output: result, elapsedMs: Date.now() - start };
  } catch (err) {
    this.timedResult = { success: false, output: err, elapsedMs: Date.now() - start };
  }
});

When("I list S3 buckets", async function (this: LwsWorld) {
  const client = this.s3Client();
  try {
    const result = await client.send(new ListBucketsCommand({}));
    this.lastResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

// --- Then ------------------------------------------------------------------

Then("bucket {string} will exist", async function (this: LwsWorld, bucketName: string) {
  const client = this.s3Client();
  const result = await client.send(new ListBucketsCommand({}));
  const names = (result.Buckets ?? []).map((b) => b.Name);
  assert.ok(names.includes(bucketName), `Expected bucket "${bucketName}" to exist`);
});

Then("bucket {string} will not appear in list-buckets", async function (
  this: LwsWorld,
  bucketName: string
) {
  const client = this.s3Client();
  const result = await client.send(new ListBucketsCommand({}));
  const names = (result.Buckets ?? []).map((b) => b.Name);
  assert.ok(!names.includes(bucketName), `Expected bucket "${bucketName}" to not exist`);
});

Then("the bucket list will include {string}", function (this: LwsWorld, bucketName: string) {
  const output = this.lastResult.output as { Buckets?: Array<{ Name?: string }> };
  const names = (output?.Buckets ?? []).map((b) => b.Name);
  assert.ok(names.includes(bucketName), `Expected bucket list to include "${bucketName}"`);
});

Then("the object list will include {string}", function (this: LwsWorld, key: string) {
  const output = this.lastResult.output as { Contents?: Array<{ Key?: string }> };
  const keys = (output?.Contents ?? []).map((o) => o.Key);
  assert.ok(keys.includes(key), `Expected object list to include "${key}"`);
});

Then("object {string} in bucket {string} will have content {string}", async function (
  this: LwsWorld,
  key: string,
  bucket: string,
  expectedContent: string
) {
  const client = this.s3Client();
  const result = await client.send(new GetObjectCommand({ Bucket: bucket, Key: key }));
  const bodyStream = result.Body as Readable;
  const chunks: Buffer[] = [];
  for await (const chunk of bodyStream) {
    chunks.push(Buffer.isBuffer(chunk) ? chunk : Buffer.from(chunk as Uint8Array));
  }
  const actualContent = Buffer.concat(chunks).toString("utf-8");
  assert.strictEqual(actualContent, expectedContent);
});

Then("object {string} in bucket {string} will have binary content {string}", async function (
  this: LwsWorld,
  key: string,
  bucket: string,
  expectedContent: string
) {
  const client = this.s3Client();
  const result = await client.send(new GetObjectCommand({ Bucket: bucket, Key: key }));
  const bodyStream = result.Body as Readable;
  const chunks: Buffer[] = [];
  for await (const chunk of bodyStream) {
    chunks.push(Buffer.isBuffer(chunk) ? chunk : Buffer.from(chunk as Uint8Array));
  }
  const actualContent = Buffer.concat(chunks).toString("utf-8");
  assert.strictEqual(actualContent, expectedContent);
});

Then("the downloaded file will have content {string}", function (
  this: LwsWorld,
  expectedContent: string
) {
  const output = this.lastResult.output as { BodyText?: string };
  assert.strictEqual(output?.BodyText, expectedContent);
});

Then("bucket {string} will have {int} objects", async function (
  this: LwsWorld,
  bucket: string,
  expectedCount: number
) {
  const client = this.s3Client();
  const result = await client.send(new ListObjectsV2Command({ Bucket: bucket }));
  const actualCount = result.KeyCount ?? 0;
  assert.strictEqual(actualCount, expectedCount);
});

Then("the output will contain an upload ID", function (this: LwsWorld) {
  const output = this.lastResult.output as { UploadId?: string };
  assert.ok(output?.UploadId, "Expected output to contain an UploadId");
});

Then("the output will contain an ETag", function (this: LwsWorld) {
  const output = this.lastResult.output as { ETag?: string };
  assert.ok(output?.ETag, "Expected output to contain an ETag");
});

// Note: "the output will contain {string}" is handled by common.ts

Then("the output will contain website index document {string}", function (
  this: LwsWorld,
  indexDoc: string
) {
  const output = this.lastResult.output as { IndexDocument?: { Suffix?: string } };
  assert.strictEqual(output?.IndexDocument?.Suffix, indexDoc);
});

Then("bucket {string} will have website index document {string}", async function (
  this: LwsWorld,
  bucket: string,
  indexDoc: string
) {
  const client = this.s3Client();
  const result = await client.send(new GetBucketWebsiteCommand({ Bucket: bucket }));
  assert.strictEqual(result.IndexDocument?.Suffix, indexDoc);
});

Then("bucket {string} will have no website configuration", async function (
  this: LwsWorld,
  bucket: string
) {
  const client = this.s3Client();
  try {
    await client.send(new GetBucketWebsiteCommand({ Bucket: bucket }));
    assert.fail("Expected no website configuration but got one");
  } catch (err: unknown) {
    // Expected — no website config
    const errMsg = String(err);
    const isExpectedError =
      errMsg.includes("NoSuchWebsiteConfiguration") ||
      errMsg.includes("404") ||
      errMsg.includes("NoSuchKey");
    assert.ok(isExpectedError, `Expected NoSuchWebsiteConfiguration but got: ${errMsg}`);
  }
});
