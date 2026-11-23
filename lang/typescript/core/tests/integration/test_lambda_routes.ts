import { describe, it, expect, beforeEach, afterEach } from "vitest";
import Fastify from "fastify";
import type { FastifyInstance } from "fastify";
import { LambdaProvider } from "../../src/providers/lambda/provider.js";
import { lambdaRoutesPlugin } from "../../src/providers/lambda/routes.js";

async function buildLambdaApp(): Promise<FastifyInstance> {
  const provider = new LambdaProvider([]);
  await provider.start();
  const app = Fastify({ logger: false });
  await app.register(lambdaRoutesPlugin, { provider });
  await app.ready();
  return app;
}

async function lambdaRequest(
  app: FastifyInstance,
  operation: string,
  payload: Record<string, unknown>,
): Promise<{ status: number; body: Record<string, unknown> }> {
  const response = await app.inject({
    method: "POST",
    url: "/",
    headers: {
      "content-type": "application/x-amz-json-1.1",
      "x-amz-target": `AWSLambda.${operation}`,
    },
    payload: JSON.stringify(payload),
  });
  return { status: response.statusCode, body: JSON.parse(response.body) as Record<string, unknown> };
}

describe("Lambda routes — CreateFunction / ListFunctions", () => {
  let app: FastifyInstance;

  beforeEach(async () => { app = await buildLambdaApp(); });
  afterEach(async () => { await app.close(); });

  it("CreateFunction returns a function ARN", async () => {
    // Arrange
    const expectedFunctionName = "integration-function";

    // Act
    const actual = await lambdaRequest(app, "CreateFunction", {
      FunctionName: expectedFunctionName,
      Handler: "index.handler",
      Runtime: "nodejs20.x",
      Role: "arn:aws:iam::123456789012:role/lambda-role",
      Code: { ZipFile: "dummyzip" },
    });

    // Assert
    expect(actual.status).toBe(201);
    expect(actual.body["FunctionName"]).toBe(expectedFunctionName);
    expect((actual.body["FunctionArn"] as string)).toContain(expectedFunctionName);
  });

  it("ListFunctions returns created function", async () => {
    // Arrange
    const expectedFunctionName = "list-function";
    await lambdaRequest(app, "CreateFunction", {
      FunctionName: expectedFunctionName,
      Handler: "index.handler",
      Runtime: "nodejs20.x",
      Role: "arn:aws:iam::123456789012:role/lambda-role",
      Code: { ZipFile: "dummyzip" },
    });

    // Act
    const actual = await lambdaRequest(app, "ListFunctions", {});

    // Assert
    expect(actual.status).toBe(200);
    const fns = (actual.body["Functions"] as Record<string, unknown>[]);
    const actualNames = fns.map((f) => f["FunctionName"]);
    expect(actualNames).toContain(expectedFunctionName);
  });

  it("CreateFunction returns 409 for duplicate function name", async () => {
    // Arrange
    const expectedStatus = 409;
    await lambdaRequest(app, "CreateFunction", {
      FunctionName: "dup-function",
      Handler: "index.handler",
      Runtime: "nodejs20.x",
      Role: "arn:aws:iam::123456789012:role/lambda-role",
      Code: { ZipFile: "dummyzip" },
    });

    // Act
    const actual = await lambdaRequest(app, "CreateFunction", {
      FunctionName: "dup-function",
      Handler: "index.handler",
      Runtime: "nodejs20.x",
      Role: "arn:aws:iam::123456789012:role/lambda-role",
      Code: { ZipFile: "dummyzip" },
    });

    // Assert
    expect(actual.status).toBe(expectedStatus);
    expect((actual.body["__type"] as string)).toContain("ResourceConflictException");
  });

  it("DeleteFunction removes function", async () => {
    // Arrange
    const expectedAbsentName = "delete-function";
    await lambdaRequest(app, "CreateFunction", {
      FunctionName: expectedAbsentName,
      Handler: "index.handler",
      Runtime: "nodejs20.x",
      Role: "arn:aws:iam::123456789012:role/lambda-role",
      Code: { ZipFile: "dummyzip" },
    });

    // Act
    const deleteResponse = await app.inject({
      method: "POST",
      url: "/",
      headers: {
        "content-type": "application/x-amz-json-1.1",
        "x-amz-target": "AWSLambda.DeleteFunction",
      },
      payload: JSON.stringify({ FunctionName: expectedAbsentName }),
    });
    const actual = await lambdaRequest(app, "ListFunctions", {});

    // Assert
    expect(deleteResponse.statusCode).toBe(204);
    const actualNames = (actual.body["Functions"] as Record<string, unknown>[]).map((f) => f["FunctionName"]);
    expect(actualNames).not.toContain(expectedAbsentName);
  });
});

describe("Lambda routes — Invoke", () => {
  let app: FastifyInstance;

  beforeEach(async () => { app = await buildLambdaApp(); });
  afterEach(async () => { await app.close(); });

  it("POST invocations path returns 200 for RequestResponse", async () => {
    // Arrange
    await lambdaRequest(app, "CreateFunction", {
      FunctionName: "invoke-fn",
      Handler: "index.handler",
      Runtime: "nodejs20.x",
      Role: "arn:aws:iam::123456789012:role/lambda-role",
      Code: { ZipFile: "dummyzip" },
    });
    const expectedStatusCode = 200;

    // Act
    const response = await app.inject({
      method: "POST",
      url: "/2015-03-31/functions/invoke-fn/invocations",
      headers: {
        "content-type": "application/json",
        "x-amz-invocation-type": "RequestResponse",
      },
      payload: JSON.stringify({ key: "value" }),
    });

    // Assert
    expect(response.statusCode).toBe(expectedStatusCode);
  });

  it("POST invocations path returns 202 for Event invocation type", async () => {
    // Arrange
    await lambdaRequest(app, "CreateFunction", {
      FunctionName: "event-invoke-fn",
      Handler: "index.handler",
      Runtime: "nodejs20.x",
      Role: "arn:aws:iam::123456789012:role/lambda-role",
      Code: { ZipFile: "dummyzip" },
    });
    const expectedStatusCode = 202;

    // Act
    const response = await app.inject({
      method: "POST",
      url: "/2015-03-31/functions/event-invoke-fn/invocations",
      headers: {
        "content-type": "application/json",
        "x-amz-invocation-type": "Event",
      },
      payload: "{}",
    });

    // Assert
    expect(response.statusCode).toBe(expectedStatusCode);
  });

  it("POST invocations path returns 404 for unknown function", async () => {
    // Arrange
    const expectedStatusCode = 404;

    // Act
    const response = await app.inject({
      method: "POST",
      url: "/2015-03-31/functions/ghost-fn/invocations",
      headers: { "content-type": "application/json" },
      payload: "{}",
    });

    // Assert
    expect(response.statusCode).toBe(expectedStatusCode);
  });
});
