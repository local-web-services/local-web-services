/**
 * Unit tests for the CLI HTTP helper functions.
 */

import { describe, it, expect, afterEach, beforeEach } from "vitest";
import Fastify from "fastify";
import type { FastifyInstance } from "fastify";
import { fetchStatus, fetchResources, postShutdown, postReset, waitUntilReady } from "../../../src/cli/http.js";

const TEST_PORT = 19600;

function buildStubServer(running: boolean): FastifyInstance {
  const app = Fastify({ logger: false });
  app.get("/_ldk/status", () => ({
    running,
    providers: [{ name: "sqs", healthy: true }],
  }));
  app.get("/_ldk/resources", () => ({
    services: { sqs: { port: 19601, resources: [] } },
  }));
  app.post("/_ldk/shutdown", () => ({ ok: true }));
  app.post("/_ldk/reset", () => ({ ok: true }));
  return app;
}

describe("fetchStatus", () => {
  let app: FastifyInstance;

  beforeEach(async () => {
    app = buildStubServer(true);
    await app.listen({ port: TEST_PORT, host: "127.0.0.1" });
  });

  afterEach(async () => {
    await app.close();
  });

  it("returns the running flag from the server", async () => {
    // Arrange
    const expectedRunning = true;

    // Act
    const actualStatus = await fetchStatus(TEST_PORT);

    // Assert
    expect(actualStatus.running).toBe(expectedRunning);
  });

  it("returns provider list from the server", async () => {
    // Arrange
    const expectedProviderName = "sqs";

    // Act
    const actualStatus = await fetchStatus(TEST_PORT);

    // Assert
    expect(actualStatus.providers[0]?.name).toBe(expectedProviderName);
  });
});

describe("fetchResources", () => {
  let app: FastifyInstance;

  beforeEach(async () => {
    app = buildStubServer(true);
    await app.listen({ port: TEST_PORT + 1, host: "127.0.0.1" });
  });

  afterEach(async () => {
    await app.close();
  });

  it("returns the services map from the server", async () => {
    // Arrange
    const expectedServiceName = "sqs";

    // Act
    const actualResources = await fetchResources(TEST_PORT + 1);

    // Assert
    expect(Object.keys(actualResources.services)).toContain(expectedServiceName);
  });
});

describe("postShutdown", () => {
  let app: FastifyInstance;

  beforeEach(async () => {
    app = buildStubServer(true);
    await app.listen({ port: TEST_PORT + 2, host: "127.0.0.1" });
  });

  afterEach(async () => {
    await app.close();
  });

  it("resolves without error when server accepts the request", async () => {
    // Arrange (stub server registered in beforeEach)

    // Act
    const actualPromise = postShutdown(TEST_PORT + 2);

    // Assert
    await expect(actualPromise).resolves.toBeUndefined();
  });
});

describe("postReset", () => {
  let app: FastifyInstance;

  beforeEach(async () => {
    app = buildStubServer(true);
    await app.listen({ port: TEST_PORT + 3, host: "127.0.0.1" });
  });

  afterEach(async () => {
    await app.close();
  });

  it("resolves without error when server accepts the request", async () => {
    // Arrange (stub server registered in beforeEach)

    // Act
    const actualPromise = postReset(TEST_PORT + 3);

    // Assert
    await expect(actualPromise).resolves.toBeUndefined();
  });
});

describe("waitUntilReady", () => {
  let app: FastifyInstance;

  beforeEach(async () => {
    app = buildStubServer(true);
    await app.listen({ port: TEST_PORT + 4, host: "127.0.0.1" });
  });

  afterEach(async () => {
    await app.close();
  });

  it("returns true when server is immediately ready", async () => {
    // Arrange
    const expectedResult = true;

    // Act
    const actualResult = await waitUntilReady(TEST_PORT + 4, 5000);

    // Assert
    expect(actualResult).toBe(expectedResult);
  });

  it("returns false when no server is running within the timeout", async () => {
    // Arrange
    const expectedResult = false;
    const unusedPort = TEST_PORT + 99;

    // Act
    const actualResult = await waitUntilReady(unusedPort, 300);

    // Assert
    expect(actualResult).toBe(expectedResult);
  });
});
