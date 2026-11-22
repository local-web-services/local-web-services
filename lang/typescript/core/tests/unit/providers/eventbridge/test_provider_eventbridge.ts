import { describe, it, expect, beforeEach } from "vitest";
import { EventBridgeProvider } from "../../../../src/providers/eventbridge/provider.js";

describe("EventBridgeProvider lifecycle", () => {
  let provider: EventBridgeProvider;

  beforeEach(async () => {
    provider = new EventBridgeProvider([{ name: "pre-bus" }]);
    await provider.start();
  });

  it("seeds the default event bus on start", async () => {
    // Arrange
    const expectedBusName = "default";

    // Act
    const actualBuses = provider.listEventBuses();

    // Assert
    expect(actualBuses.EventBuses.some((b) => b.Name === expectedBusName)).toBe(true);
  });

  it("seeds pre-configured event buses on start", async () => {
    // Arrange
    const expectedBusName = "pre-bus";

    // Act
    const actualBuses = provider.listEventBuses();

    // Assert
    expect(actualBuses.EventBuses.some((b) => b.Name === expectedBusName)).toBe(true);
  });

  it("reports healthy after start", async () => {
    // Arrange (provider started in beforeEach)

    // Act
    const actualHealthy = await provider.healthCheck();

    // Assert
    expect(actualHealthy).toBe(true);
  });

  it("reports unhealthy after stop", async () => {
    // Arrange
    await provider.stop();

    // Act
    const actualHealthy = await provider.healthCheck();

    // Assert
    expect(actualHealthy).toBe(false);
  });
});

describe("EventBridgeProvider event buses", () => {
  let provider: EventBridgeProvider;

  beforeEach(async () => {
    provider = new EventBridgeProvider([]);
    await provider.start();
  });

  it("creates an event bus", () => {
    // Arrange
    const expectedBusName = "my-bus";

    // Act
    const actual = provider.createEventBus(expectedBusName);

    // Assert
    expect(actual.EventBusArn).toContain(expectedBusName);
  });

  it("throws when creating a duplicate event bus", () => {
    // Arrange
    const expectedError = "ResourceAlreadyExistsException";
    provider.createEventBus("dup-bus");

    // Act
    const actualFn = () => provider.createEventBus("dup-bus");

    // Assert
    expect(actualFn).toThrow(expectedError);
  });

  it("lists created event buses", () => {
    // Arrange
    const expectedBusName = "listed-bus";
    provider.createEventBus(expectedBusName);

    // Act
    const actualBuses = provider.listEventBuses();

    // Assert
    expect(actualBuses.EventBuses.some((b) => b.Name === expectedBusName)).toBe(true);
  });

  it("describes a specific event bus", () => {
    // Arrange
    const expectedBusName = "described-bus";
    provider.createEventBus(expectedBusName);

    // Act
    const actual = provider.describeEventBus(expectedBusName);

    // Assert
    expect(actual.Name).toBe(expectedBusName);
    expect(actual.Arn).toContain(expectedBusName);
  });

  it("deletes an event bus", () => {
    // Arrange
    const expectedAbsentBus = "deleted-bus";
    provider.createEventBus(expectedAbsentBus);

    // Act
    provider.deleteEventBus(expectedAbsentBus);

    // Assert
    const actualBuses = provider.listEventBuses();
    expect(actualBuses.EventBuses.some((b) => b.Name === expectedAbsentBus)).toBe(false);
  });

  it("throws when deleting the default bus", () => {
    // Arrange
    const expectedError = "ValidationException";

    // Act
    const actualFn = () => provider.deleteEventBus("default");

    // Assert
    expect(actualFn).toThrow(expectedError);
  });
});

describe("EventBridgeProvider rules", () => {
  let provider: EventBridgeProvider;

  beforeEach(async () => {
    provider = new EventBridgeProvider([]);
    await provider.start();
  });

  it("creates a rule on the default bus", () => {
    // Arrange
    const expectedRuleName = "my-rule";

    // Act
    const actual = provider.putRule(expectedRuleName, "default", '{"source":["test"]}');

    // Assert
    expect(actual.RuleArn).toContain(expectedRuleName);
  });

  it("lists rules on a bus", () => {
    // Arrange
    const expectedRuleName = "listed-rule";
    provider.putRule(expectedRuleName);

    // Act
    const actual = provider.listRules("default");

    // Assert
    expect((actual.Rules as { Name: string }[]).some((r) => r.Name === expectedRuleName)).toBe(true);
  });

  it("puts targets on a rule", () => {
    // Arrange
    const expectedTargetId = "target-1";
    provider.putRule("rule-with-target");

    // Act
    const actual = provider.putTargets("rule-with-target", "default", [
      { Id: expectedTargetId, Arn: "arn:aws:sqs:us-east-1:123:queue" },
    ]);

    // Assert
    expect(actual.FailedEntryCount).toBe(0);
  });

  it("lists targets by rule", () => {
    // Arrange
    const expectedTargetId = "listed-target";
    provider.putRule("target-rule");
    provider.putTargets("target-rule", "default", [
      { Id: expectedTargetId, Arn: "arn:aws:sqs:us-east-1:123:queue" },
    ]);

    // Act
    const actual = provider.listTargetsByRule("target-rule");

    // Assert
    expect(actual.Targets.some((t) => t.Id === expectedTargetId)).toBe(true);
  });
});

describe("EventBridgeProvider events", () => {
  let provider: EventBridgeProvider;

  beforeEach(async () => {
    provider = new EventBridgeProvider([]);
    await provider.start();
  });

  it("stores events from putEvents", () => {
    // Arrange
    const expectedSource = "test.source";

    // Act
    provider.putEvents([
      { Source: expectedSource, DetailType: "TestEvent", Detail: "{}" },
    ]);

    // Assert
    const actualEvents = provider.listEvents("default");
    expect(actualEvents.some((e) => e.source === expectedSource)).toBe(true);
  });

  it("returns event IDs from putEvents", () => {
    // Arrange (default bus exists)

    // Act
    const actual = provider.putEvents([
      { Source: "test", DetailType: "T", Detail: "{}" },
    ]);

    // Assert
    expect(actual.FailedEntryCount).toBe(0);
    expect(actual.Entries[0]?.EventId).toBeDefined();
  });

  it("clears dynamic buses and events on reset", async () => {
    // Arrange
    const expectedAbsentBus = "temp-bus";
    provider.createEventBus(expectedAbsentBus);
    provider.putEvents([{ EventBusName: expectedAbsentBus, Source: "s", DetailType: "T", Detail: "{}" }]);

    // Act
    await provider.reset();

    // Assert
    const actualBuses = provider.listEventBuses();
    expect(actualBuses.EventBuses.some((b) => b.Name === expectedAbsentBus)).toBe(false);
  });
});
