import { Given, When, Then } from "@cucumber/cucumber";
import {
  CreateBucketCommand,
  PutObjectCommand,
  GetObjectCommand,
  DeleteObjectCommand,
  ListObjectsV2Command,
  HeadObjectCommand,
  ListBucketsCommand,
} from "@aws-sdk/client-s3";
import type { S3World } from "../support/world.js";
import { TEST_BUCKET_NAME, TEST_OBJECT_KEY, TEST_OBJECT_BODY } from "../support/world.js";

Given("the s3 system is initialized", async function (this: S3World) {
  // Session started in BeforeAll
});

Given('the "s3" "bucket" exists', async function (this: S3World) {
  // Pre-seeded in BeforeAll via S3Bucket spec; recreated by reset()
});

Given('an object is stored in the "s3" "bucket"', async function (this: S3World) {
  await this.s3Client.send(
    new PutObjectCommand({
      Bucket: TEST_BUCKET_NAME,
      Key: TEST_OBJECT_KEY,
      Body: TEST_OBJECT_BODY,
      ContentType: "text/plain",
    }),
  );
});

Given('the "s3" "object" does not exist', async function (this: S3World) {
  // After reset(), no dynamic objects remain
});

When('a "s3" "bucket" is created', async function (this: S3World) {
  try {
    this.result = await this.s3Client.send(
      new CreateBucketCommand({ Bucket: "lws-e2e-dynamic-bucket" }),
    );
  } catch (err) {
    this.error = err instanceof Error ? err : new Error(String(err));
  }
});

When('a "s3" "object" is put into the "s3" "bucket"', async function (this: S3World) {
  try {
    this.result = await this.s3Client.send(
      new PutObjectCommand({
        Bucket: TEST_BUCKET_NAME,
        Key: TEST_OBJECT_KEY,
        Body: TEST_OBJECT_BODY,
        ContentType: "text/plain",
      }),
    );
  } catch (err) {
    this.error = err instanceof Error ? err : new Error(String(err));
  }
});

When('the "s3" "object" is retrieved', async function (this: S3World) {
  try {
    const response = await this.s3Client.send(
      new GetObjectCommand({ Bucket: TEST_BUCKET_NAME, Key: TEST_OBJECT_KEY }),
    );
    this.result = await response.Body?.transformToString();
  } catch (err) {
    this.error = err instanceof Error ? err : new Error(String(err));
  }
});

When('the "s3" "object" is deleted', async function (this: S3World) {
  try {
    this.result = await this.s3Client.send(
      new DeleteObjectCommand({ Bucket: TEST_BUCKET_NAME, Key: TEST_OBJECT_KEY }),
    );
  } catch (err) {
    this.error = err instanceof Error ? err : new Error(String(err));
  }
});

When('the objects in the "s3" "bucket" are listed', async function (this: S3World) {
  try {
    this.result = await this.s3Client.send(
      new ListObjectsV2Command({ Bucket: TEST_BUCKET_NAME }),
    );
  } catch (err) {
    this.error = err instanceof Error ? err : new Error(String(err));
  }
});

Then('the "s3" "bucket" will exist', async function (this: S3World) {
  const listResult = await this.s3Client.send(new ListBucketsCommand({}));
  const expectedBucketName = "lws-e2e-dynamic-bucket";
  const actualBuckets = listResult.Buckets ?? [];
  const found = actualBuckets.some((b) => b.Name === expectedBucketName);
  if (!found) {
    throw new Error(`Expected bucket '${expectedBucketName}' in ListBuckets but it was absent`);
  }
});

Then('the "s3" "object" will exist in the "s3" "bucket"', async function (this: S3World) {
  const expectedKey = TEST_OBJECT_KEY;
  await this.s3Client.send(new HeadObjectCommand({ Bucket: TEST_BUCKET_NAME, Key: expectedKey }));
});

Then('the "s3" "object" body will be returned', function (this: S3World) {
  const expectedBody = TEST_OBJECT_BODY;
  const actualBody = this.result as string | null | undefined;
  if (actualBody !== expectedBody) {
    throw new Error(`Expected object body '${expectedBody}' but got '${actualBody}'`);
  }
});

Then('the "s3" "object" will not exist in the "s3" "bucket"', async function (this: S3World) {
  let actualError: Error | null = null;
  try {
    await this.s3Client.send(
      new HeadObjectCommand({ Bucket: TEST_BUCKET_NAME, Key: TEST_OBJECT_KEY }),
    );
  } catch (err) {
    actualError = err instanceof Error ? err : new Error(String(err));
  }
  if (actualError === null) {
    throw new Error("Expected object to not exist but HeadObject succeeded");
  }
});

Then('the "s3" "object" will appear in the listing', function (this: S3World) {
  const expectedKey = TEST_OBJECT_KEY;
  const listResult = this.result as { Contents?: Array<{ Key?: string }> } | null;
  const actualContents = listResult?.Contents ?? [];
  const found = actualContents.some((obj) => obj.Key === expectedKey);
  if (!found) {
    throw new Error(`Expected key '${expectedKey}' in ListObjectsV2 but it was absent`);
  }
});

Then("the s3 operation is rejected", function (this: S3World) {
  if (this.error === null) {
    throw new Error("Expected an error but none was thrown");
  }
});
