import { describe, it, expect, beforeEach } from "vitest";
import { LambdaProvider } from "../../../../src/providers/lambda/provider.js";

describe("LambdaProvider tagging", () => {
  let provider: LambdaProvider;

  beforeEach(async () => {
    provider = new LambdaProvider([{ functionName: "my-fn", handler: "index.handler" }]);
    await provider.start();
  });

  it("tagFunction stores tags retrievable via listFunctionTags", () => {
    // Arrange
    const expectedKey = "env";
    const expectedValue = "prod";

    // Act
    provider.tagFunction("my-fn", { [expectedKey]: expectedValue });
    const actualTags = provider.listFunctionTags("my-fn");

    // Assert
    expect(actualTags[expectedKey]).toBe(expectedValue);
  });

  it("untagFunction removes a specific tag", () => {
    // Arrange
    provider.tagFunction("my-fn", { env: "prod", team: "platform" });
    const expectedAbsentKey = "env";
    const expectedRemainingKey = "team";
    const expectedRemainingValue = "platform";

    // Act
    provider.untagFunction("my-fn", [expectedAbsentKey]);
    const actualTags = provider.listFunctionTags("my-fn");

    // Assert
    expect(actualTags[expectedAbsentKey]).toBeUndefined();
    expect(actualTags[expectedRemainingKey]).toBe(expectedRemainingValue);
  });

  it("tagFunction resolves function name from ARN", () => {
    // Arrange
    const expectedValue = "staging";
    const arn = "arn:aws:lambda:us-east-1:000000000000:function:my-fn";

    // Act
    provider.tagFunction(arn, { stage: expectedValue });
    const actualTags = provider.listFunctionTags("my-fn");

    // Assert
    expect(actualTags["stage"]).toBe(expectedValue);
  });
});

describe("LambdaProvider permissions", () => {
  let provider: LambdaProvider;

  beforeEach(async () => {
    provider = new LambdaProvider([{ functionName: "my-fn", handler: "index.handler" }]);
    await provider.start();
  });

  it("addPermission stores a statement retrievable via getPolicy", () => {
    // Arrange
    const expectedSid = "AllowSNS";

    // Act
    provider.addPermission("my-fn", { Sid: expectedSid, Effect: "Allow", Action: "lambda:InvokeFunction", Principal: "sns.amazonaws.com", Resource: "*" });
    const actualPolicy = provider.getPolicy("my-fn");

    // Assert
    expect(actualPolicy).not.toBeNull();
    const parsed = JSON.parse(actualPolicy!.Policy);
    const actualSid = parsed.Statement[0].Sid;
    expect(actualSid).toBe(expectedSid);
  });

  it("removePermission removes a statement", () => {
    // Arrange
    const expectedSidAbsent = "ToRemove";
    provider.addPermission("my-fn", { Sid: expectedSidAbsent, Effect: "Allow", Action: "lambda:InvokeFunction", Principal: "*", Resource: "*" });

    // Act
    provider.removePermission("my-fn", expectedSidAbsent);
    const actualPolicy = provider.getPolicy("my-fn");

    // Assert
    expect(actualPolicy).toBeNull();
  });

  it("getPolicy returns null when no statements exist", () => {
    // Arrange (no permissions added)

    // Act
    const actualPolicy = provider.getPolicy("my-fn");

    // Assert
    expect(actualPolicy).toBeNull();
  });
});

describe("LambdaProvider event source mappings", () => {
  let provider: LambdaProvider;

  beforeEach(async () => {
    provider = new LambdaProvider([{ functionName: "my-fn", handler: "index.handler" }]);
    await provider.start();
  });

  it("createEventSourceMapping stores a mapping retrievable via getEventSourceMapping", () => {
    // Arrange
    const expectedArn = "arn:aws:sqs:us-east-1:000000000000:my-queue";
    const expectedState = "Enabled";

    // Act
    const created = provider.createEventSourceMapping({ EventSourceArn: expectedArn, FunctionName: "my-fn" });
    const actualMapping = provider.getEventSourceMapping(created.UUID);

    // Assert
    expect(actualMapping.EventSourceArn).toBe(expectedArn);
    expect(actualMapping.State).toBe(expectedState);
  });

  it("deleteEventSourceMapping marks mapping as Deleting", () => {
    // Arrange
    const expectedState = "Deleting";
    const created = provider.createEventSourceMapping({ EventSourceArn: "arn:aws:sqs:us-east-1:000000000000:q", FunctionName: "my-fn" });

    // Act
    const actualResult = provider.deleteEventSourceMapping(created.UUID);

    // Assert
    expect(actualResult.State).toBe(expectedState);
  });

  it("listEventSourceMappings returns all mappings", () => {
    // Arrange
    provider.createEventSourceMapping({ EventSourceArn: "arn:aws:sqs:us-east-1:000000000000:q1", FunctionName: "my-fn" });
    provider.createEventSourceMapping({ EventSourceArn: "arn:aws:sqs:us-east-1:000000000000:q2", FunctionName: "my-fn" });
    const expectedCount = 2;

    // Act
    const actualResult = provider.listEventSourceMappings();

    // Assert
    expect(actualResult.EventSourceMappings).toHaveLength(expectedCount);
  });
});

describe("LambdaProvider function URLs", () => {
  let provider: LambdaProvider;

  beforeEach(async () => {
    provider = new LambdaProvider([{ functionName: "my-fn", handler: "index.handler" }]);
    await provider.start();
  });

  it("createFunctionUrlConfig stores config retrievable via getFunctionUrlConfig", () => {
    // Arrange
    const expectedAuthType = "NONE";

    // Act
    provider.createFunctionUrlConfig("my-fn", expectedAuthType);
    const actualConfig = provider.getFunctionUrlConfig("my-fn");

    // Assert
    expect(actualConfig).toBeDefined();
    expect(actualConfig!.AuthType).toBe(expectedAuthType);
  });

  it("deleteFunctionUrlConfig removes config", () => {
    // Arrange
    provider.createFunctionUrlConfig("my-fn", "NONE");

    // Act
    provider.deleteFunctionUrlConfig("my-fn");
    const actualConfig = provider.getFunctionUrlConfig("my-fn");

    // Assert
    expect(actualConfig).toBeUndefined();
  });
});
