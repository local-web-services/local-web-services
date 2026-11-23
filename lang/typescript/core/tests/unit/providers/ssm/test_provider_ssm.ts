import { describe, it, expect, beforeEach } from "vitest";
import { SsmProvider } from "../../../../src/providers/ssm/provider.js";

describe("SsmProvider lifecycle", () => {
  it("starts and reports healthy", async () => {
    // Arrange
    const provider = new SsmProvider([]);

    // Act
    await provider.start();

    // Assert
    const actualHealthy = await provider.healthCheck();
    expect(actualHealthy).toBe(true);
    await provider.stop();
  });

  it("stops and reports unhealthy", async () => {
    // Arrange
    const provider = new SsmProvider([]);
    await provider.start();

    // Act
    await provider.stop();

    // Assert
    const actualHealthy = await provider.healthCheck();
    expect(actualHealthy).toBe(false);
  });

  it("pre-seeds parameters from config", async () => {
    // Arrange
    const expectedName = "/app/db-url";
    const expectedValue = "postgres://localhost/test";
    const provider = new SsmProvider([{ name: expectedName, value: expectedValue }]);
    await provider.start();

    // Act
    const actualParam = provider.getParameter(expectedName);

    // Assert
    expect(actualParam.Value).toBe(expectedValue);
    await provider.stop();
  });
});

describe("SsmProvider putParameter / getParameter", () => {
  let provider: SsmProvider;

  beforeEach(async () => {
    provider = new SsmProvider([]);
    await provider.start();
  });

  it("stores a parameter and retrieves it", () => {
    // Arrange
    const expectedName = "/test/param";
    const expectedValue = "hello-world";

    // Act
    provider.putParameter(expectedName, expectedValue, "String", false);
    const actualParam = provider.getParameter(expectedName);

    // Assert
    expect(actualParam.Value).toBe(expectedValue);
    expect(actualParam.Name).toBe(expectedName);
  });

  it("throws ParameterNotFound for missing parameter", () => {
    // Arrange
    const expectedError = "ParameterNotFound";

    // Act
    const actualFn = () => provider.getParameter("/missing/param");

    // Assert
    expect(actualFn).toThrow(expectedError);
  });

  it("throws ParameterAlreadyExists when overwrite is false", () => {
    // Arrange
    const expectedError = "ParameterAlreadyExists";
    provider.putParameter("/dup", "v1", "String", false);

    // Act
    const actualFn = () => provider.putParameter("/dup", "v2", "String", false);

    // Assert
    expect(actualFn).toThrow(expectedError);
  });

  it("allows overwrite when flag is true", () => {
    // Arrange
    provider.putParameter("/ow", "original", "String", false);
    const expectedValue = "updated";

    // Act
    provider.putParameter("/ow", expectedValue, "String", true);
    const actualParam = provider.getParameter("/ow");

    // Assert
    expect(actualParam.Value).toBe(expectedValue);
  });

  it("increments version on overwrite", () => {
    // Arrange
    provider.putParameter("/ver", "v1", "String", false);
    const expectedVersion = 2;

    // Act
    const actualVersion = provider.putParameter("/ver", "v2", "String", true);

    // Assert
    expect(actualVersion).toBe(expectedVersion);
  });
});

describe("SsmProvider getParametersByPath", () => {
  let provider: SsmProvider;

  beforeEach(async () => {
    provider = new SsmProvider([]);
    await provider.start();
    provider.putParameter("/app/db/host", "localhost", "String", false);
    provider.putParameter("/app/db/port", "5432", "String", false);
    provider.putParameter("/app/cache/url", "redis://localhost", "String", false);
    provider.putParameter("/other/param", "x", "String", false);
  });

  it("returns parameters under a path prefix", () => {
    // Arrange
    const expectedCount = 2;

    // Act
    const actualParams = provider.getParametersByPath("/app/db", false);

    // Assert
    expect(actualParams).toHaveLength(expectedCount);
  });

  it("returns all nested params when recursive is true", () => {
    // Arrange
    const expectedCount = 3;

    // Act
    const actualParams = provider.getParametersByPath("/app", true);

    // Assert
    expect(actualParams).toHaveLength(expectedCount);
  });
});

describe("SsmProvider deleteParameter / reset", () => {
  let provider: SsmProvider;

  beforeEach(async () => {
    provider = new SsmProvider([{ name: "/seeded/param", value: "seed" }]);
    await provider.start();
  });

  it("deletes a parameter so it no longer exists", () => {
    // Arrange
    provider.putParameter("/temp/p", "v", "String", false);
    const expectedError = "ParameterNotFound";

    // Act
    provider.deleteParameter("/temp/p");
    const actualFn = () => provider.getParameter("/temp/p");

    // Assert
    expect(actualFn).toThrow(expectedError);
  });

  it("throws ParameterNotFound when deleting a missing parameter", () => {
    // Arrange
    const expectedError = "ParameterNotFound";

    // Act
    const actualFn = () => provider.deleteParameter("/ghost");

    // Assert
    expect(actualFn).toThrow(expectedError);
  });

  it("reset removes dynamic params but preserves seeded ones", async () => {
    // Arrange
    provider.putParameter("/dynamic/p", "v", "String", false);
    const expectedPresentName = "/seeded/param";
    const expectedAbsentName = "/dynamic/p";

    // Act
    await provider.reset();
    const actualAll = provider.describeParameters().map((p) => p.Name);

    // Assert
    expect(actualAll).toContain(expectedPresentName);
    expect(actualAll).not.toContain(expectedAbsentName);
  });
});

describe("SsmProvider tagging", () => {
  let provider: SsmProvider;

  beforeEach(async () => {
    provider = new SsmProvider([{ name: "/p", value: "v" }]);
    await provider.start();
  });

  it("tagResource stores tags retrievable via listTagsForResource", () => {
    // Arrange
    const expectedArn = "arn:aws:ssm:us-east-1:000000000000:parameter/p";
    const expectedKey = "env";
    const expectedValue = "prod";

    // Act
    provider.tagResource(expectedArn, [{ Key: expectedKey, Value: expectedValue }]);
    const actualTags = provider.listTagsForResource(expectedArn);

    // Assert
    expect(actualTags).toContainEqual({ Key: expectedKey, Value: expectedValue });
  });

  it("untagResource removes a specific tag", () => {
    // Arrange
    const expectedArn = "arn:aws:ssm:us-east-1:000000000000:parameter/p";
    provider.tagResource(expectedArn, [
      { Key: "env", Value: "prod" },
      { Key: "team", Value: "platform" },
    ]);
    const expectedAbsentKey = "env";

    // Act
    provider.untagResource(expectedArn, [expectedAbsentKey]);
    const actualTags = provider.listTagsForResource(expectedArn);

    // Assert
    expect(actualTags.map((t) => t.Key)).not.toContain(expectedAbsentKey);
  });

  it("listTagsForResource returns empty array for untagged resource", () => {
    // Arrange
    const expectedCount = 0;

    // Act
    const actualTags = provider.listTagsForResource("arn:aws:ssm:us-east-1:000000000000:parameter/untagged");

    // Assert
    expect(actualTags).toHaveLength(expectedCount);
  });
});
