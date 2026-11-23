import { describe, it, expect } from "vitest";
import { CapacityBuilder } from "../../src/builders/capacity.js";

describe("CapacityBuilder.build()", () => {
  it("defaults to unlimited slots", () => {
    // Arrange
    const builder = new CapacityBuilder("sqs", "http://localhost:9999");

    // Act
    const actualConfig = builder.build();

    // Assert
    expect(actualConfig).toEqual({ sqs: { slots: null } });
  });

  it("exhaust sets slots to 0", () => {
    // Arrange
    const builder = new CapacityBuilder("sqs", "http://localhost:9999");

    // Act
    const actualConfig = builder.exhaust().build();

    // Assert
    expect(actualConfig).toEqual({ sqs: { slots: 0 } });
  });

  it("slots sets explicit slot count", () => {
    // Arrange
    const builder = new CapacityBuilder("sqs", "http://localhost:9999");
    const expectedSlots = 5;

    // Act
    const actualConfig = builder.slots(expectedSlots).build();

    // Assert
    expect(actualConfig).toEqual({ sqs: { slots: expectedSlots } });
  });

  it("unlimited resets slots to null", () => {
    // Arrange
    const builder = new CapacityBuilder("sqs", "http://localhost:9999");

    // Act
    const actualConfig = builder.exhaust().unlimited().build();

    // Assert
    expect(actualConfig).toEqual({ sqs: { slots: null } });
  });

  it("uses the service name as the config key", () => {
    // Arrange
    const expectedService = "dynamodb";
    const builder = new CapacityBuilder(expectedService, "http://localhost:9999");

    // Act
    const actualConfig = builder.slots(3).build();

    // Assert
    expect(Object.keys(actualConfig)).toEqual([expectedService]);
  });

  it("methods are chainable and return the same builder", () => {
    // Arrange
    const builder = new CapacityBuilder("sqs", "http://localhost:9999");

    // Act
    const actualResult = builder.exhaust();

    // Assert
    expect(actualResult).toBe(builder);
  });
});
