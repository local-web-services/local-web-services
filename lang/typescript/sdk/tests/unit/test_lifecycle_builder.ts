import { describe, it, expect } from "vitest";
import { LifecycleBuilder } from "../../src/builders/lifecycle.js";

describe("LifecycleBuilder.build()", () => {
  it("defaults to enabled with zero dwell times", () => {
    // Arrange
    const builder = new LifecycleBuilder("sqs", "http://localhost:9999");

    // Act
    const actualConfig = builder.build();

    // Assert
    expect(actualConfig).toEqual({ sqs: { enabled: true } });
  });

  it("createDwellMs sets create dwell time", () => {
    // Arrange
    const builder = new LifecycleBuilder("sqs", "http://localhost:9999");
    const expectedMs = 100;

    // Act
    const actualConfig = builder.createDwellMs(expectedMs).build();

    // Assert
    expect(actualConfig["sqs"]?.create_dwell_ms).toBe(expectedMs);
  });

  it("deleteDwellMs sets delete dwell time", () => {
    // Arrange
    const builder = new LifecycleBuilder("sqs", "http://localhost:9999");
    const expectedMs = 200;

    // Act
    const actualConfig = builder.deleteDwellMs(expectedMs).build();

    // Assert
    expect(actualConfig["sqs"]?.delete_dwell_ms).toBe(expectedMs);
  });

  it("modifyDwellMs sets modify dwell time", () => {
    // Arrange
    const builder = new LifecycleBuilder("sqs", "http://localhost:9999");
    const expectedMs = 300;

    // Act
    const actualConfig = builder.modifyDwellMs(expectedMs).build();

    // Assert
    expect(actualConfig["sqs"]?.modify_dwell_ms).toBe(expectedMs);
  });

  it("all dwell times can be set together", () => {
    // Arrange
    const builder = new LifecycleBuilder("sqs", "http://localhost:9999");

    // Act
    const actualConfig = builder.createDwellMs(10).deleteDwellMs(20).modifyDwellMs(30).build();

    // Assert
    expect(actualConfig["sqs"]).toMatchObject({
      enabled: true,
      create_dwell_ms: 10,
      delete_dwell_ms: 20,
      modify_dwell_ms: 30,
    });
  });

  it("uses the service name as the config key", () => {
    // Arrange
    const expectedService = "dynamodb";
    const builder = new LifecycleBuilder(expectedService, "http://localhost:9999");

    // Act
    const actualConfig = builder.build();

    // Assert
    expect(Object.keys(actualConfig)).toEqual([expectedService]);
  });

  it("methods are chainable and return the same builder", () => {
    // Arrange
    const builder = new LifecycleBuilder("sqs", "http://localhost:9999");

    // Act
    const actualResult = builder.createDwellMs(50);

    // Assert
    expect(actualResult).toBe(builder);
  });
});
