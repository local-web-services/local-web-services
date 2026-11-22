import { describe, it, expect, beforeEach, afterEach } from "vitest";
import Fastify from "fastify";
import type { FastifyInstance } from "fastify";
import { SsmProvider } from "../../src/providers/ssm/provider.js";
import { ssmRoutesPlugin } from "../../src/providers/ssm/routes.js";

async function buildSsmApp(): Promise<FastifyInstance> {
  const provider = new SsmProvider([]);
  await provider.start();
  const app = Fastify({ logger: false });
  await app.register(ssmRoutesPlugin, { provider });
  await app.ready();
  return app;
}

async function ssmRequest(
  app: FastifyInstance,
  operation: string,
  payload: Record<string, unknown>,
): Promise<{ status: number; body: Record<string, unknown> }> {
  const response = await app.inject({
    method: "POST",
    url: "/",
    headers: {
      "content-type": "application/x-amz-json-1.1",
      "x-amz-target": `AmazonSSM.${operation}`,
    },
    payload: JSON.stringify(payload),
  });
  return { status: response.statusCode, body: JSON.parse(response.body) as Record<string, unknown> };
}

describe("SSM routes — PutParameter / GetParameter", () => {
  let app: FastifyInstance;

  beforeEach(async () => {
    app = await buildSsmApp();
  });

  afterEach(async () => {
    await app.close();
  });

  it("PutParameter then GetParameter returns the stored value", async () => {
    // Arrange
    const expectedValue = "postgres://localhost/test";
    await ssmRequest(app, "PutParameter", { Name: "/db/url", Value: expectedValue, Type: "String" });

    // Act
    const actualResult = await ssmRequest(app, "GetParameter", { Name: "/db/url" });

    // Assert
    const actualParam = (actualResult.body["Parameter"] as Record<string, unknown> | undefined);
    expect(actualParam?.["Value"]).toBe(expectedValue);
  });

  it("GetParameter returns 400 for a missing parameter", async () => {
    // Arrange
    const expectedStatus = 400;

    // Act
    const actualResult = await ssmRequest(app, "GetParameter", { Name: "/missing/param" });

    // Assert
    expect(actualResult.status).toBe(expectedStatus);
  });

  it("PutParameter returns 400 when parameter already exists without overwrite", async () => {
    // Arrange
    await ssmRequest(app, "PutParameter", { Name: "/dup", Value: "v1", Type: "String" });
    const expectedStatus = 400;

    // Act
    const actualResult = await ssmRequest(app, "PutParameter", { Name: "/dup", Value: "v2", Type: "String" });

    // Assert
    expect(actualResult.status).toBe(expectedStatus);
  });

  it("PutParameter with Overwrite=true succeeds for an existing parameter", async () => {
    // Arrange
    await ssmRequest(app, "PutParameter", { Name: "/overwrite-me", Value: "v1", Type: "String" });
    const expectedStatus = 200;

    // Act
    const actualResult = await ssmRequest(app, "PutParameter", {
      Name: "/overwrite-me",
      Value: "v2",
      Type: "String",
      Overwrite: true,
    });

    // Assert
    expect(actualResult.status).toBe(expectedStatus);
  });

  it("GetParametersByPath returns parameters matching the path", async () => {
    // Arrange
    await ssmRequest(app, "PutParameter", { Name: "/app/db/host", Value: "localhost", Type: "String" });
    await ssmRequest(app, "PutParameter", { Name: "/app/db/port", Value: "5432", Type: "String" });
    await ssmRequest(app, "PutParameter", { Name: "/other/x", Value: "y", Type: "String" });
    const expectedCount = 2;

    // Act
    const actualResult = await ssmRequest(app, "GetParametersByPath", { Path: "/app/db", Recursive: false });

    // Assert
    const actualParams = actualResult.body["Parameters"] as unknown[];
    expect(actualParams).toHaveLength(expectedCount);
  });

  it("DeleteParameter removes the parameter", async () => {
    // Arrange
    await ssmRequest(app, "PutParameter", { Name: "/to-delete", Value: "v", Type: "String" });
    const expectedStatus = 400;

    // Act
    await ssmRequest(app, "DeleteParameter", { Name: "/to-delete" });
    const actualGetResult = await ssmRequest(app, "GetParameter", { Name: "/to-delete" });

    // Assert
    expect(actualGetResult.status).toBe(expectedStatus);
  });
});
