import { describe, it, expect, beforeEach } from "vitest";
import Fastify from "fastify";
import type { FastifyInstance } from "fastify";
import { managementPlugin } from "../../../src/api/management.js";

function buildMgmtApp(): FastifyInstance {
  const orch = {
    running: true,
    providers: new Map(),
    requestShutdown: () => {},
  };
  const app = Fastify({ logger: false });
  app.register(managementPlugin, { orchestrator: orch });
  return app;
}

describe("Management API — capacity routes", () => {
  let app: FastifyInstance;

  beforeEach(async () => {
    app = buildMgmtApp();
    await app.ready();
  });

  it("GET /_ldk/capacity returns empty object initially", async () => {
    // Arrange
    const expectedStatusCode = 200;

    // Act
    const actualResponse = await app.inject({ method: "GET", url: "/_ldk/capacity" });

    // Assert
    expect(actualResponse.statusCode).toBe(expectedStatusCode);
    expect(JSON.parse(actualResponse.body)).toEqual({});
  });

  it("POST /_ldk/capacity sets slots for a service", async () => {
    // Arrange
    const expectedSlots = 0;
    const expectedStatusCode = 200;

    // Act
    await app.inject({
      method: "POST",
      url: "/_ldk/capacity",
      payload: { sqs: { slots: expectedSlots } },
    });
    const actualResponse = await app.inject({ method: "GET", url: "/_ldk/capacity/sqs" });

    // Assert
    expect(actualResponse.statusCode).toBe(expectedStatusCode);
    expect(JSON.parse(actualResponse.body)).toEqual({ slots: expectedSlots });
  });

  it("GET /_ldk/capacity/:service returns null slots when not configured", async () => {
    // Arrange
    const expectedStatusCode = 200;

    // Act
    const actualResponse = await app.inject({ method: "GET", url: "/_ldk/capacity/dynamodb" });

    // Assert
    expect(actualResponse.statusCode).toBe(expectedStatusCode);
    expect(JSON.parse(actualResponse.body)).toEqual({ slots: null });
  });

  it("DELETE /_ldk/capacity/:service resets to unlimited", async () => {
    // Arrange
    await app.inject({
      method: "POST",
      url: "/_ldk/capacity",
      payload: { sqs: { slots: 0 } },
    });

    // Act
    await app.inject({ method: "DELETE", url: "/_ldk/capacity/sqs" });
    const actualResponse = await app.inject({ method: "GET", url: "/_ldk/capacity/sqs" });

    // Assert
    expect(JSON.parse(actualResponse.body)).toEqual({ slots: null });
  });
});

describe("Management API — lifecycle routes", () => {
  let app: FastifyInstance;

  beforeEach(async () => {
    app = buildMgmtApp();
    await app.ready();
  });

  it("GET /_ldk/lifecycle returns empty object initially", async () => {
    // Arrange
    const expectedStatusCode = 200;

    // Act
    const actualResponse = await app.inject({ method: "GET", url: "/_ldk/lifecycle" });

    // Assert
    expect(actualResponse.statusCode).toBe(expectedStatusCode);
    expect(JSON.parse(actualResponse.body)).toEqual({});
  });

  it("POST /_ldk/lifecycle sets config for a service", async () => {
    // Arrange
    const expectedDwellMs = 100;
    const expectedStatusCode = 200;

    // Act
    await app.inject({
      method: "POST",
      url: "/_ldk/lifecycle",
      payload: { sqs: { enabled: true, create_dwell_ms: expectedDwellMs } },
    });
    const actualResponse = await app.inject({ method: "GET", url: "/_ldk/lifecycle/sqs" });

    // Assert
    expect(actualResponse.statusCode).toBe(expectedStatusCode);
    const actualBody = JSON.parse(actualResponse.body) as Record<string, unknown>;
    expect(actualBody["create_dwell_ms"]).toBe(expectedDwellMs);
    expect(actualBody["enabled"]).toBe(true);
  });

  it("GET /_ldk/lifecycle/:service returns 404 when not configured", async () => {
    // Arrange
    const expectedStatusCode = 404;

    // Act
    const actualResponse = await app.inject({ method: "GET", url: "/_ldk/lifecycle/dynamodb" });

    // Assert
    expect(actualResponse.statusCode).toBe(expectedStatusCode);
  });

  it("DELETE /_ldk/lifecycle/:service removes the config", async () => {
    // Arrange
    const expectedStatusCode = 404;
    await app.inject({
      method: "POST",
      url: "/_ldk/lifecycle",
      payload: { sqs: { enabled: true } },
    });

    // Act
    await app.inject({ method: "DELETE", url: "/_ldk/lifecycle/sqs" });
    const actualResponse = await app.inject({ method: "GET", url: "/_ldk/lifecycle/sqs" });

    // Assert
    expect(actualResponse.statusCode).toBe(expectedStatusCode);
  });
});

describe("Management API — iam-auth routes", () => {
  let app: FastifyInstance;

  beforeEach(async () => {
    app = buildMgmtApp();
    await app.ready();
  });

  it("GET /_ldk/iam-auth returns default disabled config", async () => {
    // Arrange
    const expectedStatusCode = 200;
    const expectedMode = "disabled";
    const expectedDefaultIdentity = "admin";

    // Act
    const actualResponse = await app.inject({ method: "GET", url: "/_ldk/iam-auth" });

    // Assert
    expect(actualResponse.statusCode).toBe(expectedStatusCode);
    const actualBody = JSON.parse(actualResponse.body) as Record<string, unknown>;
    expect(actualBody["mode"]).toBe(expectedMode);
    expect(actualBody["default_identity"]).toBe(expectedDefaultIdentity);
  });

  it("POST /_ldk/iam-auth updates the mode", async () => {
    // Arrange
    const expectedMode = "enforce";

    // Act
    await app.inject({
      method: "POST",
      url: "/_ldk/iam-auth",
      payload: { mode: expectedMode },
    });
    const actualResponse = await app.inject({ method: "GET", url: "/_ldk/iam-auth" });

    // Assert
    const actualBody = JSON.parse(actualResponse.body) as Record<string, unknown>;
    expect(actualBody["mode"]).toBe(expectedMode);
  });

  it("POST /_ldk/iam-auth adds identities", async () => {
    // Arrange
    const expectedIdentity = "sender";

    // Act
    await app.inject({
      method: "POST",
      url: "/_ldk/iam-auth",
      payload: {
        identities: {
          [expectedIdentity]: { inline_policies: [{ actions: ["sqs:SendMessage"], effect: "Allow" }] },
        },
      },
    });
    const actualResponse = await app.inject({ method: "GET", url: "/_ldk/iam-auth" });

    // Assert
    const actualBody = JSON.parse(actualResponse.body) as { identities: Record<string, unknown> };
    expect(actualBody.identities[expectedIdentity]).toBeDefined();
  });

  it("DELETE /_ldk/iam-auth resets to defaults", async () => {
    // Arrange
    const expectedMode = "disabled";
    const expectedDefaultIdentity = "admin";
    await app.inject({
      method: "POST",
      url: "/_ldk/iam-auth",
      payload: { mode: "enforce", default_identity: "custom" },
    });

    // Act
    await app.inject({ method: "DELETE", url: "/_ldk/iam-auth" });
    const actualResponse = await app.inject({ method: "GET", url: "/_ldk/iam-auth" });

    // Assert
    const actualBody = JSON.parse(actualResponse.body) as Record<string, unknown>;
    expect(actualBody["mode"]).toBe(expectedMode);
    expect(actualBody["default_identity"]).toBe(expectedDefaultIdentity);
    expect(actualBody["identities"]).toEqual({});
  });
});
