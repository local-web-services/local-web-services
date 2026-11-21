import { describe, it, expect } from "vitest";
import { ChaosBuilder } from "../../src/builders/chaos.js";

describe("ChaosBuilder configuration", () => {
  it("builds payload with error rate", () => {
    // Arrange
    const expectedErrorRate = 0.5;

    // Act
    const actual = new ChaosBuilder("sqs", 9999).errorRate(expectedErrorRate).build();

    // Assert
    expect(actual["sqs"]?.error_rate).toBe(expectedErrorRate);
    expect(actual["sqs"]?.enabled).toBe(true);
  });

  it("builds payload with latency range", () => {
    // Arrange
    const expectedMinMs = 50;
    const expectedMaxMs = 200;

    // Act
    const actual = new ChaosBuilder("dynamodb", 9999)
      .latency(expectedMinMs, expectedMaxMs)
      .build();

    // Assert
    expect(actual["dynamodb"]?.latency_min_ms).toBe(expectedMinMs);
    expect(actual["dynamodb"]?.latency_max_ms).toBe(expectedMaxMs);
  });

  it("builds payload with connection reset rate", () => {
    // Arrange
    const expectedRate = 0.1;

    // Act
    const actual = new ChaosBuilder("s3", 9999).connectionResetRate(expectedRate).build();

    // Assert
    expect(actual["s3"]?.connection_reset_rate).toBe(expectedRate);
  });

  it("builds payload with timeout rate", () => {
    // Arrange
    const expectedRate = 0.2;

    // Act
    const actual = new ChaosBuilder("sns", 9999).timeoutRate(expectedRate).build();

    // Assert
    expect(actual["sns"]?.timeout_rate).toBe(expectedRate);
  });

  it("supports method chaining", () => {
    // Arrange
    const expectedErrorRate = 0.3;
    const expectedMinMs = 10;
    const expectedMaxMs = 50;
    const expectedTimeoutRate = 0.05;
    const builder = new ChaosBuilder("sqs", 9999);

    // Act
    const actual = builder.errorRate(expectedErrorRate).latency(expectedMinMs, expectedMaxMs).timeoutRate(expectedTimeoutRate).build();

    // Assert
    expect(actual["sqs"]?.error_rate).toBe(expectedErrorRate);
    expect(actual["sqs"]?.latency_min_ms).toBe(expectedMinMs);
    expect(actual["sqs"]?.latency_max_ms).toBe(expectedMaxMs);
    expect(actual["sqs"]?.timeout_rate).toBe(expectedTimeoutRate);
  });

  it("includes service name as key in built payload", () => {
    // Arrange
    const expectedService = "events";

    // Act
    const actual = new ChaosBuilder(expectedService, 9999).errorRate(1.0).build();

    // Assert
    expect(Object.keys(actual)).toContain(expectedService);
  });
});
