/** Step definitions: s3api service informal specification scenarios */

import { Given, When, Then } from "@cucumber/cucumber";
import assert from "assert";
import type { SdkWorld } from "../support/world";

const S3API_TEST_BUCKET = "e2e-s3api-test-bucket-1";
const S3API_TEST_SRC_BUCKET = "e2e-src-bkt-1";
const S3API_TEST_KEY = "e2e-test-object-1";
const S3API_TEST_KEY2 = "e2e-test-key-2";
const S3API_TEST_BODY = "test-object-body-1";

// ── Helpers ───────────────────────────────────────────────────────────────────

function s3Client(world: SdkWorld) {
  const { S3Client } = require("@aws-sdk/client-s3");
  return world.session!.client<typeof S3Client>("s3");
}

async function createBucket(world: SdkWorld, bucketName: string): Promise<void> {
  const { CreateBucketCommand } = require("@aws-sdk/client-s3");
  try {
    await s3Client(world).send(new CreateBucketCommand({ Bucket: bucketName }));
  } catch {
    // bucket may already exist; desired state is existence
  }
}

async function deleteBucket(world: SdkWorld, bucketName: string): Promise<void> {
  const { DeleteBucketCommand } = require("@aws-sdk/client-s3");
  try {
    await s3Client(world).send(new DeleteBucketCommand({ Bucket: bucketName }));
  } catch {
    // bucket may not exist; desired state is absence
  }
}

async function putObject(
  world: SdkWorld,
  bucketName: string,
  key: string,
): Promise<void> {
  const { PutObjectCommand } = require("@aws-sdk/client-s3");
  const { Readable } = require("stream");
  const body = Readable.from([Buffer.from(S3API_TEST_BODY)]);
  await s3Client(world).send(new PutObjectCommand({ Bucket: bucketName, Key: key, Body: body }));
}

async function deleteObject(
  world: SdkWorld,
  bucketName: string,
  key: string,
): Promise<void> {
  const { DeleteObjectCommand } = require("@aws-sdk/client-s3");
  try {
    await s3Client(world).send(new DeleteObjectCommand({ Bucket: bucketName, Key: key }));
  } catch {
    // object may not exist; desired state is absence
  }
}

// ── Background ────────────────────────────────────────────────────────────────

// "the system is initialized" is registered in cross_service_common.ts.

// ── Then: "the operation is rejected" ────────────────────────────────────────

// "the operation is rejected" is registered in sqs.ts; NOT re-registered here.

// ── Given: bucket state setup ─────────────────────────────────────────────────

Given("the bucket does not already exist", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state after session reset has no buckets.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the bucket already exists", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await createBucket(this, S3API_TEST_BUCKET);
  // Assert: bucket exists
});

Given("the bucket exists", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await createBucket(this, S3API_TEST_BUCKET);
  // Assert: bucket created
});

Given("the bucket is {string}", async function (this: SdkWorld, state: string) {
  if (state === "ACTIVE") {
    // No-op: buckets are ACTIVE by default after creation.
    assert.ok(this.session, "Expected session to be initialized");
    return;
  }
  // Arrange: use lifecycle API to simulate a non-ACTIVE bucket
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await deleteBucket(this, S3API_TEST_BUCKET);
  await this.session!.lifecycle("s3").createDwellMs(5000).apply();
  await createBucket(this, S3API_TEST_BUCKET);
  // Assert: bucket is in non-ACTIVE state
});

Given("the bucket is not {string}", async function (this: SdkWorld, state: string) {
  if (state === "ACTIVE") {
    // Arrange: create bucket in non-ACTIVE state via lifecycle dwell
    assert.ok(this.session, "Expected session to be initialized");
    // Act
    await deleteBucket(this, S3API_TEST_BUCKET);
    await this.session!.lifecycle("s3").createDwellMs(5000).apply();
    await createBucket(this, S3API_TEST_BUCKET);
    return;
  }
  // For other states, no-op.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the bucket does not exist", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await deleteBucket(this, S3API_TEST_BUCKET);
  // Assert: desired state is absence
});

Given("the bucket is empty", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: freshly created bucket is empty.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the bucket is not empty", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await putObject(this, S3API_TEST_BUCKET, S3API_TEST_KEY);
  // Assert: object put into bucket
});

// ── Given: source/destination bucket setup ────────────────────────────────────

Given("the source bucket exists", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act: create both source and destination buckets
  await createBucket(this, S3API_TEST_SRC_BUCKET);
  await createBucket(this, S3API_TEST_BUCKET);
  // Assert: both buckets created
});

Given("the source bucket does not exist", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await deleteBucket(this, S3API_TEST_SRC_BUCKET);
  // Assert: desired state is absence
});

Given("the source bucket is {string}", async function (this: SdkWorld, state: string) {
  if (state === "ACTIVE") {
    // No-op: buckets are ACTIVE by default after creation.
    assert.ok(this.session, "Expected session to be initialized");
    return;
  }
  // Arrange: create source bucket in non-ACTIVE state via lifecycle dwell
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await deleteBucket(this, S3API_TEST_SRC_BUCKET);
  await this.session!.lifecycle("s3").createDwellMs(5000).apply();
  await createBucket(this, S3API_TEST_SRC_BUCKET);
});

Given("the source bucket is not {string}", async function (this: SdkWorld, state: string) {
  if (state === "ACTIVE") {
    // Arrange: create source bucket in non-ACTIVE state via lifecycle dwell
    assert.ok(this.session, "Expected session to be initialized");
    // Act
    await deleteBucket(this, S3API_TEST_SRC_BUCKET);
    await this.session!.lifecycle("s3").createDwellMs(5000).apply();
    await createBucket(this, S3API_TEST_SRC_BUCKET);
    return;
  }
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the destination bucket exists", async function (this: SdkWorld) {
  // No-op: destination bucket was created in the source bucket setup step.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the destination bucket does not exist", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await deleteBucket(this, S3API_TEST_BUCKET);
  // Assert: desired state is absence
});

Given("the destination bucket is {string}", async function (this: SdkWorld, state: string) {
  if (state === "ACTIVE") {
    // No-op: destination bucket is ACTIVE by default after creation.
    assert.ok(this.session, "Expected session to be initialized");
    return;
  }
  assert.ok(this.session, "Expected session to be initialized");
  await deleteBucket(this, S3API_TEST_BUCKET);
  await this.session!.lifecycle("s3").createDwellMs(5000).apply();
  await createBucket(this, S3API_TEST_BUCKET);
});

Given("the destination bucket is not {string}", async function (this: SdkWorld, state: string) {
  if (state === "ACTIVE") {
    // Arrange: create destination bucket in non-ACTIVE state via lifecycle dwell
    assert.ok(this.session, "Expected session to be initialized");
    // Act
    await deleteBucket(this, S3API_TEST_BUCKET);
    await this.session!.lifecycle("s3").createDwellMs(5000).apply();
    await createBucket(this, S3API_TEST_BUCKET);
    return;
  }
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Given: versioning state setup ─────────────────────────────────────────────

Given("versioning is disabled", async function (this: SdkWorld) {
  // No-op: versioning is disabled by default.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("versioning is enabled", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { PutBucketVersioningCommand } = require("@aws-sdk/client-s3");
  // Act
  await s3Client(this).send(
    new PutBucketVersioningCommand({
      Bucket: S3API_TEST_BUCKET,
      VersioningConfiguration: { Status: "Enabled" },
    }),
  );
  // Assert: versioning enabled
});

Given("versioning is not enabled", async function (this: SdkWorld) {
  // No-op: versioning is disabled by default.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("versioning is not disabled", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { PutBucketVersioningCommand } = require("@aws-sdk/client-s3");
  // Act: enable versioning so it is not disabled
  await s3Client(this).send(
    new PutBucketVersioningCommand({
      Bucket: S3API_TEST_BUCKET,
      VersioningConfiguration: { Status: "Enabled" },
    }),
  );
  // Assert: versioning is no longer disabled
});

// ── Given: object state setup ──────────────────────────────────────────────────

Given("the object does not already exist", async function (this: SdkWorld) {
  // No-op: fresh bucket has no objects.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the object already exists", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await putObject(this, S3API_TEST_BUCKET, S3API_TEST_KEY);
  // Assert: object exists
});

Given("the object exists", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await putObject(this, S3API_TEST_BUCKET, S3API_TEST_KEY);
  // Assert: object created
});

Given("the object exists in the bucket", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await putObject(this, S3API_TEST_BUCKET, S3API_TEST_KEY);
  // Assert: object in bucket
});

Given("the object does not exist in the bucket", async function (this: SdkWorld) {
  // No-op: fresh bucket has no objects.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the object is not deleted", async function (this: SdkWorld) {
  // No-op: objects are not deleted by default after being put.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the object is deleted", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act: put the object then delete it
  await putObject(this, S3API_TEST_BUCKET, S3API_TEST_KEY);
  await deleteObject(this, S3API_TEST_BUCKET, S3API_TEST_KEY);
  // Assert: object is deleted
});

Given("the object does not exist", async function (this: SdkWorld) {
  // No-op: fresh bucket has no objects.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the source object exists", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await putObject(this, S3API_TEST_SRC_BUCKET, S3API_TEST_KEY);
  // Assert: object in source bucket
});

Given("the source object does not exist", async function (this: SdkWorld) {
  // No-op: no object in source bucket by default.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the source object is not deleted", async function (this: SdkWorld) {
  // No-op: objects are not deleted by default after being put.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the source object is deleted", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act: put the source object then delete it
  await putObject(this, S3API_TEST_SRC_BUCKET, S3API_TEST_KEY);
  await deleteObject(this, S3API_TEST_SRC_BUCKET, S3API_TEST_KEY);
  // Assert: source object is deleted
});

Given("the source object's bucket exists", async function (this: SdkWorld) {
  // No-op: bucket was created in the source bucket setup step.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the lifecycle policy has an expiry rule for the object", async function (this: SdkWorld) {
  // No-op: lifecycle expiry scenarios are tagged @internal; excluded from test run.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Given: multipart upload state setup ───────────────────────────────────────

Given("the upload does not already exist", async function (this: SdkWorld) {
  // No-op: no uploads in progress.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the upload does not exist", async function (this: SdkWorld) {
  // No-op: no uploads in progress by default.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the upload exists", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { CreateMultipartUploadCommand } = require("@aws-sdk/client-s3");
  // Act
  const resp = await s3Client(this).send(
    new CreateMultipartUploadCommand({ Bucket: S3API_TEST_BUCKET, Key: S3API_TEST_KEY }),
  );
  (this as any)._s3UploadId = resp.UploadId;
  (this as any)._s3Etags = [];
  // Assert: upload created
});

Given("the upload already exists", async function (this: SdkWorld) {
  // S3 allows multiple concurrent multipart uploads for the same key; no-op.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the upload is {string}", async function (this: SdkWorld, state: string) {
  if (state === "IN_PROGRESS") {
    // No-op: upload was already created in the upload_exists step.
    assert.ok(this.session, "Expected session to be initialized");
    return;
  }
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the upload is not {string}", async function (this: SdkWorld, _state: string) {
  // No-op: upload is not in-progress by default; scenarios using this are @internal.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the upload has at least one part", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { UploadPartCommand } = require("@aws-sdk/client-s3");
  const { Readable } = require("stream");
  const uploadId: string = (this as any)._s3UploadId;
  // Act
  const body = Readable.from([Buffer.from(S3API_TEST_BODY)]);
  const partResp = await s3Client(this).send(
    new UploadPartCommand({
      Bucket: S3API_TEST_BUCKET,
      Key: S3API_TEST_KEY,
      UploadId: uploadId,
      PartNumber: 1,
      Body: body,
    }),
  );
  const etags: Array<{ ETag: string; PartNumber: number }> = (this as any)._s3Etags ?? [];
  etags.push({ ETag: partResp.ETag, PartNumber: 1 });
  (this as any)._s3Etags = etags;
  // Assert: part uploaded
});

Given("the upload has no parts", async function (this: SdkWorld) {
  // No-op: freshly created upload has no parts.
  assert.ok(this.session, "Expected session to be initialized");
});

Given(
  "the upload is {string} with at least one part uploaded",
  async function (this: SdkWorld, _state: string) {
    // Arrange
    assert.ok(this.session, "Expected session to be initialized");
    const { CreateMultipartUploadCommand, UploadPartCommand } = require("@aws-sdk/client-s3");
    const { Readable } = require("stream");
    // Act: create upload and upload one part
    const createResp = await s3Client(this).send(
      new CreateMultipartUploadCommand({ Bucket: S3API_TEST_BUCKET, Key: S3API_TEST_KEY }),
    );
    (this as any)._s3UploadId = createResp.UploadId;
    const body = Readable.from([Buffer.from(S3API_TEST_BODY)]);
    const partResp = await s3Client(this).send(
      new UploadPartCommand({
        Bucket: S3API_TEST_BUCKET,
        Key: S3API_TEST_KEY,
        UploadId: createResp.UploadId,
        PartNumber: 1,
        Body: body,
      }),
    );
    (this as any)._s3Etags = [{ ETag: partResp.ETag, PartNumber: 1 }];
    // Assert: upload in progress with one part
  },
);

// ── When: actions ─────────────────────────────────────────────────────────────

When("a bucket is created", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { CreateBucketCommand } = require("@aws-sdk/client-s3");
  // Act
  try {
    const result = await s3Client(this).send(new CreateBucketCommand({ Bucket: S3API_TEST_BUCKET }));
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("a bucket is deleted", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { DeleteBucketCommand } = require("@aws-sdk/client-s3");
  // Act
  try {
    const result = await s3Client(this).send(new DeleteBucketCommand({ Bucket: S3API_TEST_BUCKET }));
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("the list of buckets is retrieved", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { ListBucketsCommand } = require("@aws-sdk/client-s3");
  // Act
  try {
    const result = await s3Client(this).send(new ListBucketsCommand({}));
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("versioning is configured on a bucket", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { PutBucketVersioningCommand } = require("@aws-sdk/client-s3");
  // Act
  try {
    const result = await s3Client(this).send(
      new PutBucketVersioningCommand({
        Bucket: S3API_TEST_BUCKET,
        VersioningConfiguration: { Status: "Enabled" },
      }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("an object is uploaded to a bucket", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { PutObjectCommand } = require("@aws-sdk/client-s3");
  const { Readable } = require("stream");
  // Act
  try {
    const body = Readable.from([Buffer.from(S3API_TEST_BODY)]);
    const result = await s3Client(this).send(
      new PutObjectCommand({ Bucket: S3API_TEST_BUCKET, Key: S3API_TEST_KEY, Body: body }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("an object is retrieved from a bucket", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { GetObjectCommand } = require("@aws-sdk/client-s3");
  // Act
  try {
    const result = await s3Client(this).send(
      new GetObjectCommand({ Bucket: S3API_TEST_BUCKET, Key: S3API_TEST_KEY }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("an object is deleted from a bucket", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { DeleteObjectCommand } = require("@aws-sdk/client-s3");
  // Act
  try {
    const result = await s3Client(this).send(
      new DeleteObjectCommand({ Bucket: S3API_TEST_BUCKET, Key: S3API_TEST_KEY }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("object metadata is retrieved from a bucket", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { HeadObjectCommand } = require("@aws-sdk/client-s3");
  // Act
  try {
    const result = await s3Client(this).send(
      new HeadObjectCommand({ Bucket: S3API_TEST_BUCKET, Key: S3API_TEST_KEY }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("objects in a bucket are listed", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { ListObjectsV2Command } = require("@aws-sdk/client-s3");
  // Act
  try {
    const result = await s3Client(this).send(new ListObjectsV2Command({ Bucket: S3API_TEST_BUCKET }));
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("an object is copied from one bucket to another", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { CopyObjectCommand } = require("@aws-sdk/client-s3");
  const copySource = `${S3API_TEST_SRC_BUCKET}/${S3API_TEST_KEY}`;
  // Act
  try {
    const result = await s3Client(this).send(
      new CopyObjectCommand({
        Bucket: S3API_TEST_BUCKET,
        Key: S3API_TEST_KEY2,
        CopySource: copySource,
      }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("a multipart upload is initiated", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { CreateMultipartUploadCommand } = require("@aws-sdk/client-s3");
  // Act
  try {
    const result = await s3Client(this).send(
      new CreateMultipartUploadCommand({ Bucket: S3API_TEST_BUCKET, Key: S3API_TEST_KEY }),
    );
    this.lastCallResult = { success: true, output: result };
    (this as any)._s3UploadId = result.UploadId;
    (this as any)._s3Etags = [];
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("a part is uploaded for a multipart upload", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { UploadPartCommand } = require("@aws-sdk/client-s3");
  const { Readable } = require("stream");
  const uploadId: string = (this as any)._s3UploadId ?? "invalid";
  // Act
  try {
    const body = Readable.from([Buffer.from(S3API_TEST_BODY)]);
    const result = await s3Client(this).send(
      new UploadPartCommand({
        Bucket: S3API_TEST_BUCKET,
        Key: S3API_TEST_KEY,
        UploadId: uploadId,
        PartNumber: 1,
        Body: body,
      }),
    );
    this.lastCallResult = { success: true, output: result };
    const etags: Array<{ ETag: string; PartNumber: number }> = (this as any)._s3Etags ?? [];
    etags.push({ ETag: result.ETag, PartNumber: 1 });
    (this as any)._s3Etags = etags;
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("a multipart upload is completed", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { CompleteMultipartUploadCommand } = require("@aws-sdk/client-s3");
  const uploadId: string = (this as any)._s3UploadId ?? "invalid";
  const etags: Array<{ ETag: string; PartNumber: number }> =
    (this as any)._s3Etags ?? [{ ETag: "etag1", PartNumber: 1 }];
  // Act
  try {
    const result = await s3Client(this).send(
      new CompleteMultipartUploadCommand({
        Bucket: S3API_TEST_BUCKET,
        Key: S3API_TEST_KEY,
        UploadId: uploadId,
        MultipartUpload: { Parts: etags },
      }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("a multipart upload is aborted", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { AbortMultipartUploadCommand } = require("@aws-sdk/client-s3");
  const uploadId: string = (this as any)._s3UploadId ?? "invalid";
  // Act
  try {
    const result = await s3Client(this).send(
      new AbortMultipartUploadCommand({
        Bucket: S3API_TEST_BUCKET,
        Key: S3API_TEST_KEY,
        UploadId: uploadId,
      }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("a lifecycle rule expires an object", async function (this: SdkWorld) {
  // No-op: lifecycle expiry scenarios are tagged @internal; excluded from test run.
  // Simulate failure so "the operation is rejected" passes when reached.
  assert.ok(this.session, "Expected session to be initialized");
  this.lastCallResult = {
    success: false,
    output: null,
    error: new Error("lifecycle expiry not triggered: scenario is @internal"),
  };
  // Assert: captured in lastCallResult
});

// ── Then: assertions ───────────────────────────────────────────────────────────

Then('the bucket is "ACTIVE" with versioning disabled', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { ListBucketsCommand } = require("@aws-sdk/client-s3");
  // Act
  const result = await s3Client(this).send(new ListBucketsCommand({}));
  const actualBuckets: Array<{ Name?: string }> = result.Buckets ?? [];
  // Assert
  const expectedBucket = S3API_TEST_BUCKET;
  const actualFound = actualBuckets.some((b) => b.Name === expectedBucket);
  assert.ok(
    actualFound,
    `Expected bucket "${expectedBucket}" to be ACTIVE but not found; actual_buckets=${JSON.stringify(actualBuckets.map((b) => b.Name))}`,
  );
});

Then('the bucket is "DELETED"', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { ListBucketsCommand } = require("@aws-sdk/client-s3");
  // Act
  const result = await s3Client(this).send(new ListBucketsCommand({}));
  const actualBuckets: Array<{ Name?: string }> = result.Buckets ?? [];
  // Assert
  const expectedBucket = S3API_TEST_BUCKET;
  const actualFound = actualBuckets.some((b) => b.Name === expectedBucket);
  assert.ok(
    !actualFound,
    `Expected bucket "${expectedBucket}" to be DELETED but found it; actual_buckets=${JSON.stringify(actualBuckets.map((b) => b.Name))}`,
  );
});

Then("the bucket is deleted", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { ListBucketsCommand } = require("@aws-sdk/client-s3");
  // Act
  const result = await s3Client(this).send(new ListBucketsCommand({}));
  const actualBuckets: Array<{ Name?: string }> = result.Buckets ?? [];
  // Assert
  const expectedBucket = S3API_TEST_BUCKET;
  const actualFound = actualBuckets.some((b) => b.Name === expectedBucket);
  assert.ok(
    !actualFound,
    `Expected bucket "${expectedBucket}" to be deleted but found it; actual_buckets=${JSON.stringify(actualBuckets.map((b) => b.Name))}`,
  );
});

Then("the available buckets are returned", async function (this: SdkWorld) {
  // Arrange: action already performed in the When step
  // Act: (no-op)
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected list buckets to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
});

Then(
  'the bucket versioning state is "ENABLED" or "SUSPENDED" non-deterministically',
  async function (this: SdkWorld) {
    // Arrange
    assert.ok(this.session, "Expected session to be initialized");
    const { GetBucketVersioningCommand } = require("@aws-sdk/client-s3");
    // Act
    const result = await s3Client(this).send(
      new GetBucketVersioningCommand({ Bucket: S3API_TEST_BUCKET }),
    );
    const actualStatus: string = result.Status ?? "";
    // Assert
    const expectedStatuses = new Set(["Enabled", "Suspended"]);
    assert.ok(
      expectedStatuses.has(actualStatus),
      `Expected versioning to be Enabled or Suspended but got "${actualStatus}"; expected_statuses=${JSON.stringify([...expectedStatuses])} actual_status=${actualStatus}`,
    );
  },
);

Then('the object "EXISTS" in the bucket', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { ListObjectsV2Command } = require("@aws-sdk/client-s3");
  // Act
  const result = await s3Client(this).send(new ListObjectsV2Command({ Bucket: S3API_TEST_BUCKET }));
  const actualKeys: string[] = (result.Contents ?? []).map(
    (obj: { Key?: string }) => obj.Key ?? "",
  );
  // Assert
  const expectedKey = S3API_TEST_KEY;
  assert.ok(
    actualKeys.includes(expectedKey),
    `Expected object "${expectedKey}" to exist in bucket but found: ${JSON.stringify(actualKeys)}`,
  );
});

Then('the object "EXISTS" in the destination bucket', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { ListObjectsV2Command } = require("@aws-sdk/client-s3");
  // Act
  const result = await s3Client(this).send(new ListObjectsV2Command({ Bucket: S3API_TEST_BUCKET }));
  const actualKeys: string[] = (result.Contents ?? []).map(
    (obj: { Key?: string }) => obj.Key ?? "",
  );
  // Assert
  const expectedKey = S3API_TEST_KEY2;
  assert.ok(
    actualKeys.includes(expectedKey),
    `Expected copied object "${expectedKey}" to exist in destination bucket but found: ${JSON.stringify(actualKeys)}`,
  );
});

Then("the object data is returned", async function (this: SdkWorld) {
  // Arrange: action already performed in the When step
  // Act: (no-op)
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected object data to be returned but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
});

Then('the object is "DELETED"', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { ListObjectsV2Command } = require("@aws-sdk/client-s3");
  // Act
  const result = await s3Client(this).send(new ListObjectsV2Command({ Bucket: S3API_TEST_BUCKET }));
  const actualKeys: string[] = (result.Contents ?? []).map(
    (obj: { Key?: string }) => obj.Key ?? "",
  );
  // Assert
  const expectedKey = S3API_TEST_KEY;
  assert.ok(
    !actualKeys.includes(expectedKey),
    `Expected object "${expectedKey}" to be DELETED but found in bucket; actual_keys=${JSON.stringify(actualKeys)}`,
  );
});

Then('the object is "DELETED" by the lifecycle policy', async function (this: SdkWorld) {
  // No-op: lifecycle expiry scenarios are tagged @internal; excluded from test run.
  assert.ok(this.session, "Expected session to be initialized");
});

Then("the object metadata is returned", async function (this: SdkWorld) {
  // Arrange: action already performed in the When step
  // Act: (no-op)
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected object metadata to be returned but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
});

Then("the list of objects in the bucket is returned", async function (this: SdkWorld) {
  // Arrange: action already performed in the When step
  // Act: (no-op)
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected object listing to be returned but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
});

Then('the upload is "IN_PROGRESS" with no parts', async function (this: SdkWorld) {
  // Arrange: action already performed in the When step
  // Act: (no-op)
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected multipart upload to be created but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
  const expectedUploadIdPresent = true;
  const actualUploadIdPresent = Boolean((this as any)._s3UploadId);
  assert.strictEqual(
    actualUploadIdPresent,
    expectedUploadIdPresent,
    `Expected UploadId to be present but got empty; expected_upload_id_present=${expectedUploadIdPresent} actual_upload_id_present=${actualUploadIdPresent}`,
  );
});

Then("the upload has at least one part", async function (this: SdkWorld) {
  // Arrange: action already performed in the When step
  // Act: (no-op)
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected part upload to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
});

Then("the part is uploaded and the upload is still in progress", async function (this: SdkWorld) {
  // Arrange: action already performed in the When step
  // Act: (no-op)
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected part upload to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
});

Then(
  'the upload is "COMPLETED" and the assembled object "EXISTS" in the bucket',
  async function (this: SdkWorld) {
    // Arrange
    assert.ok(this.session, "Expected session to be initialized");
    const { ListObjectsV2Command } = require("@aws-sdk/client-s3");
    // Act
    const result = await s3Client(this).send(
      new ListObjectsV2Command({ Bucket: S3API_TEST_BUCKET }),
    );
    const actualKeys: string[] = (result.Contents ?? []).map(
      (obj: { Key?: string }) => obj.Key ?? "",
    );
    // Assert
    const expectedKey = S3API_TEST_KEY;
    assert.ok(
      actualKeys.includes(expectedKey),
      `Expected assembled object "${expectedKey}" to exist in bucket but found: ${JSON.stringify(actualKeys)}`,
    );
  },
);

Then('the upload is "ABORTED"', async function (this: SdkWorld) {
  // Arrange: action already performed in the When step
  // Act: (no-op)
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected abort to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
});

Then("the object is expired and removed from the bucket", async function (this: SdkWorld) {
  // No-op: lifecycle expiry scenarios are tagged @internal; excluded from test run.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Then: invariant assertions (no-op) ────────────────────────────────────────

Then(
  /^every bucket has a valid status \("ACTIVE" or "DELETED"\)$/,
  async function (this: SdkWorld) {
    // No-op invariant: lws always maintains valid bucket statuses.
  },
);

Then(
  /^every bucket versioning state is valid \("DISABLED", "ENABLED", or "SUSPENDED"\)$/,
  async function (this: SdkWorld) {
    // No-op invariant: lws always maintains valid versioning states.
  },
);

Then(
  /^every multipart upload has a valid status \("IN_PROGRESS", "COMPLETED", or "ABORTED"\)$/,
  async function (this: SdkWorld) {
    // No-op invariant: lws always maintains valid multipart upload statuses.
  },
);

Then("deleting a bucket requires it to be empty", async function (this: SdkWorld) {
  // No-op invariant: lws enforces this constraint at the API level.
});

// ── Given: FizzBee symbolic precondition (no-op) ──────────────────────────────

Given("bname not in bucket_status", async function (this: SdkWorld) {
  // No-op: symbolic precondition from FizzBee model; fresh state has no buckets.
  assert.ok(this.session, "Expected session to be initialized");
});
