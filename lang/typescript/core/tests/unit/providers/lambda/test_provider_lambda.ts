import { describe, it, expect, beforeEach } from "vitest";
import { LambdaProvider } from "../../../../src/providers/lambda/provider.js";

describe("LambdaProvider lifecycle", () => {
  it("healthCheck returns true after start", async () => {
    // Arrange
    const provider = new LambdaProvider([]);

    // Act
    await provider.start();
    const actualHealth = await provider.healthCheck();

    // Assert
    const expectedHealth = true;
    expect(actualHealth).toBe(expectedHealth);

    await provider.stop();
  });
});

describe("LambdaProvider functions", () => {
  let provider: LambdaProvider;

  beforeEach(async () => {
    provider = new LambdaProvider([]);
    await provider.start();
  });

  it("createFunction returns a function with correct name", () => {
    // Arrange
    const expectedName = "my-function";

    // Act
    const actual = provider.createFunction({ functionName: expectedName, handler: "index.handler" });

    // Assert
    const expectedState = "Active";
    expect(actual.FunctionName).toBe(expectedName);
    expect(actual.State).toBe(expectedState);
  });

  it("listFunctions includes created function", () => {
    // Arrange
    const expectedName = "list-fn";
    provider.createFunction({ functionName: expectedName, handler: "index.handler" });

    // Act
    const actual = provider.listFunctions();

    // Assert
    const actualNames = actual.Functions.map((f) => f.FunctionName);
    expect(actualNames).toContain(expectedName);
  });

  it("getFunction returns configuration for existing function", () => {
    // Arrange
    const expectedName = "get-fn";
    provider.createFunction({ functionName: expectedName, handler: "index.handler" });

    // Act
    const actual = provider.getFunction(expectedName);

    // Assert
    expect(actual.Configuration.FunctionName).toBe(expectedName);
  });

  it("deleteFunction removes function from list", () => {
    // Arrange
    const expectedAbsentName = "delete-fn";
    provider.createFunction({ functionName: expectedAbsentName, handler: "index.handler" });

    // Act
    provider.deleteFunction(expectedAbsentName);

    // Assert
    const actualNames = provider.listFunctions().Functions.map((f) => f.FunctionName);
    expect(actualNames).not.toContain(expectedAbsentName);
  });

  it("deleteFunction throws ResourceNotFoundException for unknown function", () => {
    // Arrange
    const expectedError = "ResourceNotFoundException";

    // Act
    const actualFn = () => provider.deleteFunction("ghost-fn");

    // Assert
    expect(actualFn).toThrow(expectedError);
  });

  it("createFunction throws ResourceConflictException if function already exists", () => {
    // Arrange
    const expectedError = "ResourceConflictException";
    provider.createFunction({ functionName: "dup-fn", handler: "index.handler" });

    // Act
    const actualFn = () => provider.createFunction({ functionName: "dup-fn", handler: "index.handler" });

    // Assert
    expect(actualFn).toThrow(expectedError);
  });

  it("invoke returns mock payload for function without codeDir", async () => {
    // Arrange
    provider.createFunction({ functionName: "mock-fn", handler: "index.handler" });
    const expectedStatusCode = 200;

    // Act
    const actual = await provider.invoke("mock-fn", '{"key":"value"}');

    // Assert
    const expectedPayloadType = "string";
    expect(actual.StatusCode).toBe(expectedStatusCode);
    expect(typeof actual.Payload).toBe(expectedPayloadType);
  });

  it("invoke returns 202 for Event invocation type", async () => {
    // Arrange
    provider.createFunction({ functionName: "event-fn", handler: "index.handler" });
    const expectedStatusCode = 202;

    // Act
    const actual = await provider.invoke("event-fn", "{}", "Event");

    // Assert
    expect(actual.StatusCode).toBe(expectedStatusCode);
  });

  it("invoke returns 204 for DryRun invocation type", async () => {
    // Arrange
    provider.createFunction({ functionName: "dryrun-fn", handler: "index.handler" });
    const expectedStatusCode = 204;

    // Act
    const actual = await provider.invoke("dryrun-fn", "{}", "DryRun");

    // Assert
    expect(actual.StatusCode).toBe(expectedStatusCode);
  });

  it("updateFunctionConfiguration updates handler and runtime", () => {
    // Arrange
    provider.createFunction({ functionName: "update-fn", handler: "index.handler", runtime: "nodejs18.x" });
    const expectedHandler = "app.main";
    const expectedRuntime = "nodejs20.x";

    // Act
    const actual = provider.updateFunctionConfiguration("update-fn", {
      handler: expectedHandler,
      runtime: expectedRuntime,
    });

    // Assert
    expect(actual.Handler).toBe(expectedHandler);
    expect(actual.Runtime).toBe(expectedRuntime);
  });

  it("reset clears dynamic functions but keeps preconfigured ones", async () => {
    // Arrange
    const staticProvider = new LambdaProvider([{ functionName: "static-fn", handler: "index.handler" }]);
    await staticProvider.start();
    staticProvider.createFunction({ functionName: "dynamic-fn", handler: "index.handler" });
    const expectedPresentName = "static-fn";
    const expectedAbsentName = "dynamic-fn";

    // Act
    await staticProvider.reset();

    // Assert
    const actualNames = staticProvider.listFunctions().Functions.map((f) => f.FunctionName);
    expect(actualNames).toContain(expectedPresentName);
    expect(actualNames).not.toContain(expectedAbsentName);

    await staticProvider.stop();
  });
});
