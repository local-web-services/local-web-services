import { describe, it, expect, beforeEach, afterEach } from "vitest";
import { S3Provider } from "../../../../src/providers/s3/provider.js";

describe("S3Provider lifecycle", () => {
  it("starts and reports healthy", async () => {
    // Arrange
    const provider = new S3Provider([]);

    // Act
    await provider.start();

    // Assert
    const actualHealthy = await provider.healthCheck();
    expect(actualHealthy).toBe(true);
    await provider.stop();
  });

  it("pre-creates buckets from config", async () => {
    // Arrange
    const expectedBucket = "my-bucket";
    const provider = new S3Provider([{ name: expectedBucket }]);
    await provider.start();

    // Act
    const actualBuckets = provider.listBuckets().map((b) => b.Name);

    // Assert
    expect(actualBuckets).toContain(expectedBucket);
    await provider.stop();
  });

  it("cleans up temp directory on stop", async () => {
    // Arrange
    const provider = new S3Provider([]);
    await provider.start();
    provider.createBucket("temp-bucket");

    // Act
    await provider.stop();

    // Assert
    const actualBuckets = provider.listBuckets();
    expect(actualBuckets).toHaveLength(0);
  });
});

describe("S3Provider createBucket / deleteBucket", () => {
  let provider: S3Provider;

  beforeEach(async () => {
    provider = new S3Provider([]);
    await provider.start();
  });

  afterEach(async () => {
    await provider.stop();
  });

  it("creates a bucket so it appears in listBuckets", () => {
    // Arrange
    const expectedBucket = "new-bucket";

    // Act
    provider.createBucket(expectedBucket);
    const actualBuckets = provider.listBuckets().map((b) => b.Name);

    // Assert
    expect(actualBuckets).toContain(expectedBucket);
  });

  it("throws BucketAlreadyExists when creating a duplicate", () => {
    // Arrange
    const expectedError = "BucketAlreadyExists";
    provider.createBucket("dup-bucket");

    // Act
    const actualFn = () => provider.createBucket("dup-bucket");

    // Assert
    expect(actualFn).toThrow(expectedError);
  });

  it("deletes a bucket so it no longer appears in listBuckets", () => {
    // Arrange
    provider.createBucket("to-delete");
    const expectedAbsentBucket = "to-delete";

    // Act
    provider.deleteBucket(expectedAbsentBucket);
    const actualBuckets = provider.listBuckets().map((b) => b.Name);

    // Assert
    expect(actualBuckets).not.toContain(expectedAbsentBucket);
  });

  it("throws NoSuchBucket when deleting non-existent bucket", () => {
    // Arrange
    const expectedError = "NoSuchBucket";

    // Act
    const actualFn = () => provider.deleteBucket("ghost");

    // Assert
    expect(actualFn).toThrow(expectedError);
  });
});

describe("S3Provider putObject / getObject", () => {
  let provider: S3Provider;

  beforeEach(async () => {
    provider = new S3Provider([{ name: "test-bucket" }]);
    await provider.start();
  });

  afterEach(async () => {
    await provider.stop();
  });

  it("stores and retrieves an object", () => {
    // Arrange
    const expectedKey = "dir/file.txt";
    const expectedContent = "hello world";
    const expectedContentType = "text/plain";
    const body = Buffer.from(expectedContent);

    // Act
    provider.putObject("test-bucket", expectedKey, body, expectedContentType);
    const actualObj = provider.getObject("test-bucket", expectedKey);

    // Assert
    expect(actualObj.Body.toString("utf-8")).toBe(expectedContent);
    expect(actualObj.ContentType).toBe(expectedContentType);
  });

  it("throws NoSuchKey for a missing object", () => {
    // Arrange
    const expectedError = "NoSuchKey";

    // Act
    const actualFn = () => provider.getObject("test-bucket", "missing.txt");

    // Assert
    expect(actualFn).toThrow(expectedError);
  });

  it("deletes an object so getObject throws", () => {
    // Arrange
    provider.putObject("test-bucket", "del.txt", Buffer.from("x"));
    const expectedError = "NoSuchKey";

    // Act
    provider.deleteObject("test-bucket", "del.txt");
    const actualFn = () => provider.getObject("test-bucket", "del.txt");

    // Assert
    expect(actualFn).toThrow(expectedError);
  });

  it("lists objects in the bucket", () => {
    // Arrange
    provider.putObject("test-bucket", "a.txt", Buffer.from("a"));
    provider.putObject("test-bucket", "b.txt", Buffer.from("b"));
    const expectedCount = 2;

    // Act
    const actualResult = provider.listObjectsV2("test-bucket");

    // Assert
    expect(actualResult.Contents).toHaveLength(expectedCount);
  });

  it("filters by prefix in listObjectsV2", () => {
    // Arrange
    provider.putObject("test-bucket", "prefix/a.txt", Buffer.from("a"));
    provider.putObject("test-bucket", "other/b.txt", Buffer.from("b"));
    const expectedCount = 1;

    // Act
    const actualResult = provider.listObjectsV2("test-bucket", "prefix/");

    // Assert
    expect(actualResult.Contents).toHaveLength(expectedCount);
  });
});
