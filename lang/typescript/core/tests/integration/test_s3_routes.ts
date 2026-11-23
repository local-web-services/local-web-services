import { describe, it, expect, beforeEach, afterEach } from "vitest";
import Fastify from "fastify";
import type { FastifyInstance } from "fastify";
import { S3Provider } from "../../src/providers/s3/provider.js";
import { s3RoutesPlugin } from "../../src/providers/s3/routes.js";

async function buildS3App(): Promise<FastifyInstance> {
  const provider = new S3Provider([]);
  await provider.start();
  const app = Fastify({ logger: false });
  await app.register(s3RoutesPlugin, { provider });
  await app.ready();
  return app;
}

describe("S3 routes — CreateBucket / DeleteBucket", () => {
  let app: FastifyInstance;

  beforeEach(async () => {
    app = await buildS3App();
  });

  afterEach(async () => {
    await app.close();
  });

  it("PUT /:bucket creates a bucket (200)", async () => {
    // Arrange
    const expectedStatus = 200;

    // Act
    const actualResult = await app.inject({ method: "PUT", url: "/my-bucket" });

    // Assert
    expect(actualResult.statusCode).toBe(expectedStatus);
  });

  it("PUT /:bucket twice returns 409 BucketAlreadyExists", async () => {
    // Arrange
    await app.inject({ method: "PUT", url: "/dup-bucket" });
    const expectedStatus = 409;

    // Act
    const actualResult = await app.inject({ method: "PUT", url: "/dup-bucket" });

    // Assert
    expect(actualResult.statusCode).toBe(expectedStatus);
    expect(actualResult.body).toContain("BucketAlreadyExists");
  });

  it("GET / lists buckets", async () => {
    // Arrange
    await app.inject({ method: "PUT", url: "/list-bucket" });

    // Act
    const actualResult = await app.inject({ method: "GET", url: "/" });

    // Assert
    expect(actualResult.statusCode).toBe(200);
    expect(actualResult.body).toContain("list-bucket");
  });

  it("DELETE /:bucket removes the bucket (204)", async () => {
    // Arrange
    await app.inject({ method: "PUT", url: "/del-bucket" });
    const expectedStatus = 204;

    // Act
    const actualResult = await app.inject({ method: "DELETE", url: "/del-bucket" });

    // Assert
    expect(actualResult.statusCode).toBe(expectedStatus);
  });
});

describe("S3 routes — PutObject / GetObject", () => {
  let app: FastifyInstance;

  beforeEach(async () => {
    app = await buildS3App();
    await app.inject({ method: "PUT", url: "/test-bucket" });
  });

  afterEach(async () => {
    await app.close();
  });

  it("PUT /:bucket/:key stores an object (200)", async () => {
    // Arrange
    const expectedStatus = 200;

    // Act
    const actualResult = await app.inject({
      method: "PUT",
      url: "/test-bucket/hello.txt",
      headers: { "content-type": "text/plain" },
      payload: Buffer.from("hello world"),
    });

    // Assert
    expect(actualResult.statusCode).toBe(expectedStatus);
    expect(actualResult.headers["etag"]).toBeTruthy();
  });

  it("GET /:bucket/:key returns the stored object body", async () => {
    // Arrange
    const expectedBody = "get-me-content";
    await app.inject({
      method: "PUT",
      url: "/test-bucket/get-me.txt",
      headers: { "content-type": "text/plain" },
      payload: Buffer.from(expectedBody),
    });

    // Act
    const actualResult = await app.inject({ method: "GET", url: "/test-bucket/get-me.txt" });

    // Assert
    expect(actualResult.statusCode).toBe(200);
    expect(actualResult.body).toBe(expectedBody);
  });

  it("GET /:bucket/:key returns 404 for a missing object", async () => {
    // Arrange
    const expectedStatus = 404;

    // Act
    const actualResult = await app.inject({ method: "GET", url: "/test-bucket/nonexistent.txt" });

    // Assert
    expect(actualResult.statusCode).toBe(expectedStatus);
    expect(actualResult.body).toContain("NoSuchKey");
  });

  it("DELETE /:bucket/:key removes the object (204)", async () => {
    // Arrange
    await app.inject({
      method: "PUT",
      url: "/test-bucket/to-delete.txt",
      payload: Buffer.from("bye"),
    });
    const expectedStatus = 204;

    // Act
    const actualResult = await app.inject({ method: "DELETE", url: "/test-bucket/to-delete.txt" });

    // Assert
    expect(actualResult.statusCode).toBe(expectedStatus);
  });

  it("GET /:bucket?list-type=2 lists objects in the bucket", async () => {
    // Arrange
    await app.inject({ method: "PUT", url: "/test-bucket/a.txt", payload: Buffer.from("a") });
    await app.inject({ method: "PUT", url: "/test-bucket/b.txt", payload: Buffer.from("b") });

    // Act
    const actualResult = await app.inject({ method: "GET", url: "/test-bucket?list-type=2" });

    // Assert
    expect(actualResult.statusCode).toBe(200);
    expect(actualResult.body).toContain("a.txt");
    expect(actualResult.body).toContain("b.txt");
  });

  it("HEAD /:bucket/:key returns metadata headers", async () => {
    // Arrange
    await app.inject({
      method: "PUT",
      url: "/test-bucket/head-me.txt",
      headers: { "content-type": "text/plain" },
      payload: Buffer.from("head content"),
    });

    // Act
    const actualResult = await app.inject({ method: "HEAD", url: "/test-bucket/head-me.txt" });

    // Assert
    expect(actualResult.statusCode).toBe(200);
    expect(actualResult.headers["content-type"]).toBe("text/plain");
    expect(actualResult.headers["etag"]).toBeTruthy();
  });
});
