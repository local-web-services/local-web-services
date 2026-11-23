import { describe, it, expect, beforeEach, afterEach } from "vitest";
import Fastify from "fastify";
import type { FastifyInstance } from "fastify";
import { SecretsProvider } from "../../src/providers/secrets/provider.js";
import { secretsRoutesPlugin } from "../../src/providers/secrets/routes.js";

async function buildSecretsApp(): Promise<FastifyInstance> {
  const provider = new SecretsProvider([]);
  await provider.start();
  const app = Fastify({ logger: false });
  await app.register(secretsRoutesPlugin, { provider });
  await app.ready();
  return app;
}

async function secretsRequest(
  app: FastifyInstance,
  operation: string,
  payload: Record<string, unknown>,
): Promise<{ status: number; body: Record<string, unknown> }> {
  const response = await app.inject({
    method: "POST",
    url: "/",
    headers: {
      "content-type": "application/x-amz-json-1.1",
      "x-amz-target": `secretsmanager.${operation}`,
    },
    payload: JSON.stringify(payload),
  });
  return { status: response.statusCode, body: JSON.parse(response.body) as Record<string, unknown> };
}

describe("Secrets Manager routes — CreateSecret / GetSecretValue", () => {
  let app: FastifyInstance;

  beforeEach(async () => {
    app = await buildSecretsApp();
  });

  afterEach(async () => {
    await app.close();
  });

  it("CreateSecret then GetSecretValue returns the stored value", async () => {
    // Arrange
    const expectedValue = "super-secret-token";
    await secretsRequest(app, "CreateSecret", { Name: "my-token", SecretString: expectedValue });

    // Act
    const actualResult = await secretsRequest(app, "GetSecretValue", { SecretId: "my-token" });

    // Assert
    expect(actualResult.body["SecretString"]).toBe(expectedValue);
  });

  it("GetSecretValue returns 400 for a missing secret", async () => {
    // Arrange
    const expectedStatus = 400;

    // Act
    const actualResult = await secretsRequest(app, "GetSecretValue", { SecretId: "nonexistent" });

    // Assert
    expect(actualResult.status).toBe(expectedStatus);
  });

  it("CreateSecret returns 400 for a duplicate name", async () => {
    // Arrange
    await secretsRequest(app, "CreateSecret", { Name: "dup-secret", SecretString: "v1" });
    const expectedStatus = 400;

    // Act
    const actualResult = await secretsRequest(app, "CreateSecret", { Name: "dup-secret", SecretString: "v2" });

    // Assert
    expect(actualResult.status).toBe(expectedStatus);
  });

  it("PutSecretValue updates the secret value", async () => {
    // Arrange
    await secretsRequest(app, "CreateSecret", { Name: "updatable", SecretString: "original" });
    const expectedValue = "updated-value";

    // Act
    await secretsRequest(app, "PutSecretValue", { SecretId: "updatable", SecretString: expectedValue });
    const actualResult = await secretsRequest(app, "GetSecretValue", { SecretId: "updatable" });

    // Assert
    expect(actualResult.body["SecretString"]).toBe(expectedValue);
  });

  it("DeleteSecret removes the secret", async () => {
    // Arrange
    await secretsRequest(app, "CreateSecret", { Name: "to-delete", SecretString: "bye" });
    const expectedStatus = 400;

    // Act
    await secretsRequest(app, "DeleteSecret", { SecretId: "to-delete" });
    const actualGetResult = await secretsRequest(app, "GetSecretValue", { SecretId: "to-delete" });

    // Assert
    expect(actualGetResult.status).toBe(expectedStatus);
  });

  it("ListSecrets returns all created secrets", async () => {
    // Arrange
    await secretsRequest(app, "CreateSecret", { Name: "s1", SecretString: "v1" });
    await secretsRequest(app, "CreateSecret", { Name: "s2", SecretString: "v2" });
    const expectedCount = 2;

    // Act
    const actualResult = await secretsRequest(app, "ListSecrets", {});

    // Assert
    const actualList = actualResult.body["SecretList"] as unknown[];
    expect(actualList).toHaveLength(expectedCount);
  });
});
