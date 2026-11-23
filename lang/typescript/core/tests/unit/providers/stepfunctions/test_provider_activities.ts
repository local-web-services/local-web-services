import { describe, it, expect, beforeEach } from "vitest";
import { StepFunctionsProvider } from "../../../../src/providers/stepfunctions/provider.js";

describe("StepFunctionsProvider activities", () => {
  let provider: StepFunctionsProvider;

  beforeEach(async () => {
    provider = new StepFunctionsProvider();
    await provider.start();
  });

  it("CreateActivity stores activity retrievable via DescribeActivity", () => {
    // Arrange
    const expectedName = "my-activity";

    // Act
    const created = provider.createActivity(expectedName);
    const actual = provider.describeActivity(created.activityArn);

    // Assert
    expect(actual.name).toBe(expectedName);
    expect(actual.activityArn).toBe(created.activityArn);
  });

  it("CreateActivity throws on duplicate name", () => {
    // Arrange
    const expectedName = "duplicate-activity";
    provider.createActivity(expectedName);
    const expectedError = /ActivityAlreadyExists/;

    // Act
    const actualThrow = () => provider.createActivity(expectedName);

    // Assert
    expect(actualThrow).toThrow(expectedError);
  });

  it("DeleteActivity removes the activity", () => {
    // Arrange
    const { activityArn } = provider.createActivity("delete-me");
    const expectedCount = 0;

    // Act
    provider.deleteActivity(activityArn);
    const actual = provider.listActivities();

    // Assert
    expect(actual.activities).toHaveLength(expectedCount);
  });

  it("DeleteActivity throws for unknown ARN", () => {
    // Arrange
    const unknownArn = "arn:aws:states:us-east-1:000000000000:activity:does-not-exist";
    const expectedError = /ActivityDoesNotExist/;

    // Act
    const actualThrow = () => provider.deleteActivity(unknownArn);

    // Assert
    expect(actualThrow).toThrow(expectedError);
  });

  it("ListActivities returns all created activities", () => {
    // Arrange
    provider.createActivity("activity-a");
    provider.createActivity("activity-b");
    const expectedCount = 2;

    // Act
    const actual = provider.listActivities();

    // Assert
    expect(actual.activities).toHaveLength(expectedCount);
    const expectedNames = ["activity-a", "activity-b"];
    const actualNames = actual.activities.map((a) => a.name).sort();
    expect(actualNames).toEqual(expectedNames.sort());
  });
});
