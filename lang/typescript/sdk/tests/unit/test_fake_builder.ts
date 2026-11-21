import { describe, it, expect } from "vitest";
import { FakeBuilder } from "../../src/builders/fake.js";

describe("FakeBuilder configuration", () => {
  it("builds payload with operation and status", () => {
    // Arrange
    const expectedStatus = 500;

    // Act
    const actual = new FakeBuilder("dynamodb", 9999)
      .operation("PutItem")
      .respond(expectedStatus, { __type: "ProvisionedThroughputExceededException" })
      .build();

    // Assert
    const rule = actual["dynamodb"]?.rules[0];
    expect(rule?.operation).toBe("PutItem");
    expect(rule?.response.status).toBe(expectedStatus);
    expect(actual["dynamodb"]?.enabled).toBe(true);
  });

  it("encodes dict body as JSON string", () => {
    // Arrange
    const expectedBody = { __type: "ResourceNotFoundException", message: "not found" };

    // Act
    const actual = new FakeBuilder("dynamodb", 9999)
      .operation("GetItem")
      .respond(404, expectedBody)
      .build();

    // Assert
    const rule = actual["dynamodb"]?.rules[0];
    const actualBody = JSON.parse(rule?.response.body ?? "{}") as Record<string, unknown>;
    expect(actualBody["__type"]).toBe("ResourceNotFoundException");
  });

  it("supports header matching", () => {
    // Arrange
    const expectedHeaderName = "x-custom-header";
    const expectedHeaderValue = "test-value";

    // Act
    const actual = new FakeBuilder("sqs", 9999)
      .operation("SendMessage")
      .withHeader(expectedHeaderName, expectedHeaderValue)
      .respond(400, "")
      .build();

    // Assert
    const rule = actual["sqs"]?.rules[0];
    expect(rule?.match_headers[expectedHeaderName]).toBe(expectedHeaderValue);
  });

  it("supports delay_ms in rule builder", () => {
    // Arrange
    const expectedDelayMs = 500;

    // Act
    const actual = new FakeBuilder("sqs", 9999)
      .operation("ReceiveMessage")
      .delayMs(expectedDelayMs)
      .respond(200, "")
      .build();

    // Assert
    const rule = actual["sqs"]?.rules[0];
    expect(rule?.response.delay_ms).toBe(expectedDelayMs);
  });

  it("builds error shorthand with correct structure", () => {
    // Arrange
    const expectedErrorType = "AccessDeniedException";
    const expectedMessage = "not allowed";

    // Act
    const actual = new FakeBuilder("iam", 9999)
      .operation("ListRoles")
      .error(expectedErrorType, expectedMessage)
      .build();

    // Assert
    const rule = actual["iam"]?.rules[0];
    const body = JSON.parse(rule?.response.body ?? "{}") as Record<string, unknown>;
    expect(body["__type"]).toBe(expectedErrorType);
    expect(body["message"]).toBe(expectedMessage);
    expect(rule?.response.status).toBe(400);
  });

  it("stacks multiple rules for the same service", () => {
    // Arrange
    const builder = new FakeBuilder("sqs", 9999);

    // Act
    builder.operation("SendMessage").respond(500, "");
    builder.operation("ReceiveMessage").respond(400, "");
    const actual = builder.build();

    // Assert
    expect(actual["sqs"]?.rules).toHaveLength(2);
  });
});
