import { describe, it, expect } from "vitest";
import {
  LwsSession,
  DynamoTable,
  SqsQueue,
  S3Bucket,
  SnsTopic,
  SsmParameter,
  Secret,
  StateMachine,
  ChaosBuilder,
  FakeBuilder,
  lwsSessionFixture,
  discoverFromCdk,
  discoverFromHcl,
} from "local-web-services-typescript-sdk";

describe("JavaScript SDK re-exports all TypeScript SDK symbols", () => {
  it("exports LwsSession class", () => {
    // Arrange (uses top-level import)

    // Act
    const actualValue = LwsSession;

    // Assert
    expect(actualValue).toBeDefined();
  });

  it("exports all resource spec classes", () => {
    // Arrange
    const expectedClasses = [
      DynamoTable,
      SqsQueue,
      S3Bucket,
      SnsTopic,
      SsmParameter,
      Secret,
      StateMachine,
    ];

    // Act
    const actualDefined = expectedClasses.map((cls) => cls !== undefined);

    // Assert
    expect(actualDefined.every(Boolean)).toBe(true);
  });

  it("exports ChaosBuilder class", () => {
    // Arrange (uses top-level import)

    // Act
    const actualValue = ChaosBuilder;

    // Assert
    expect(actualValue).toBeDefined();
  });

  it("exports FakeBuilder class", () => {
    // Arrange (uses top-level import)

    // Act
    const actualValue = FakeBuilder;

    // Assert
    expect(actualValue).toBeDefined();
  });

  it("exports lwsSessionFixture function", () => {
    // Arrange (uses top-level import)

    // Act
    const actualValue = lwsSessionFixture;

    // Assert
    expect(actualValue).toBeDefined();
  });

  it("exports discoverFromCdk function", () => {
    // Arrange (uses top-level import)

    // Act
    const actualValue = discoverFromCdk;

    // Assert
    expect(actualValue).toBeDefined();
  });

  it("exports discoverFromHcl function", () => {
    // Arrange (uses top-level import)

    // Act
    const actualValue = discoverFromHcl;

    // Assert
    expect(actualValue).toBeDefined();
  });

  it("LwsSession can be instantiated with resource specs", () => {
    // Arrange
    const expectedQueue = new SqsQueue("MyQueue");

    // Act
    const actualSession = new LwsSession(expectedQueue);

    // Assert
    expect(actualSession).toBeInstanceOf(LwsSession);
  });
});
