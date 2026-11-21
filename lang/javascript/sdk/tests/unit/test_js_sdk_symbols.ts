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
    // Arrange + Act + Assert
    expect(LwsSession).toBeDefined();
    expect(typeof LwsSession).toBe("function");
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

    // Act + Assert
    for (const cls of expectedClasses) {
      expect(cls).toBeDefined();
      expect(typeof cls).toBe("function");
    }
  });

  it("exports ChaosBuilder class", () => {
    // Arrange + Act + Assert
    expect(ChaosBuilder).toBeDefined();
    expect(typeof ChaosBuilder).toBe("function");
  });

  it("exports FakeBuilder class", () => {
    // Arrange + Act + Assert
    expect(FakeBuilder).toBeDefined();
    expect(typeof FakeBuilder).toBe("function");
  });

  it("exports lwsSessionFixture function", () => {
    // Arrange + Act + Assert
    expect(lwsSessionFixture).toBeDefined();
    expect(typeof lwsSessionFixture).toBe("function");
  });

  it("exports discoverFromCdk function", () => {
    // Arrange + Act + Assert
    expect(discoverFromCdk).toBeDefined();
    expect(typeof discoverFromCdk).toBe("function");
  });

  it("exports discoverFromHcl function", () => {
    // Arrange + Act + Assert
    expect(discoverFromHcl).toBeDefined();
    expect(typeof discoverFromHcl).toBe("function");
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
