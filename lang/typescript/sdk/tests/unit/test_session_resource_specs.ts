import { describe, it, expect } from "vitest";
import {
  DynamoTable,
  SqsQueue,
  S3Bucket,
  SnsTopic,
  SsmParameter,
  Secret,
  StateMachine,
} from "../../src/specs.js";

describe("DynamoTable spec", () => {
  it("stores name and hashKey with defaults", () => {
    // Arrange
    const expectedName = "Orders";
    const expectedHashKey = "orderId";

    // Act
    const actual = new DynamoTable(expectedName, expectedHashKey);

    // Assert
    expect(actual.name).toBe(expectedName);
    expect(actual.hashKey).toBe(expectedHashKey);
    expect(actual.hashKeyType).toBe("S");
    expect(actual.sortKey).toBeUndefined();
    expect(actual.sortKeyType).toBe("S");
  });

  it("accepts sort key", () => {
    // Arrange
    const expectedSortKey = "createdAt";

    // Act
    const actual = new DynamoTable("Orders", "id", "S", expectedSortKey, "N");

    // Assert
    expect(actual.sortKey).toBe(expectedSortKey);
    expect(actual.sortKeyType).toBe("N");
  });
});

describe("SqsQueue spec", () => {
  it("stores name with defaults", () => {
    // Arrange
    const expectedName = "OrderQueue";

    // Act
    const actual = new SqsQueue(expectedName);

    // Assert
    expect(actual.name).toBe(expectedName);
    expect(actual.visibilityTimeout).toBe(30);
    expect(actual.isFifo).toBe(false);
  });

  it("accepts fifo flag and custom visibility timeout", () => {
    // Arrange
    const expectedTimeout = 60;

    // Act
    const actual = new SqsQueue("OrderQueue.fifo", expectedTimeout, true);

    // Assert
    expect(actual.visibilityTimeout).toBe(expectedTimeout);
    expect(actual.isFifo).toBe(true);
  });
});

describe("S3Bucket spec", () => {
  it("stores bucket name", () => {
    // Arrange
    const expectedName = "my-bucket";

    // Act
    const actual = new S3Bucket(expectedName);

    // Assert
    expect(actual.name).toBe(expectedName);
  });
});

describe("SnsTopic spec", () => {
  it("stores topic name", () => {
    // Arrange
    const expectedName = "OrderCreated";

    // Act
    const actual = new SnsTopic(expectedName);

    // Assert
    expect(actual.name).toBe(expectedName);
  });
});

describe("SsmParameter spec", () => {
  it("stores parameter name", () => {
    // Arrange
    const expectedName = "/app/config/db-host";

    // Act
    const actual = new SsmParameter(expectedName);

    // Assert
    expect(actual.name).toBe(expectedName);
  });
});

describe("Secret spec", () => {
  it("stores secret name", () => {
    // Arrange
    const expectedName = "prod/db/password";

    // Act
    const actual = new Secret(expectedName);

    // Assert
    expect(actual.name).toBe(expectedName);
  });
});

describe("StateMachine spec", () => {
  it("stores name and definition with default role", () => {
    // Arrange
    const expectedName = "OrderProcessor";
    const expectedDef = '{"Comment":"test","StartAt":"Start","States":{"Start":{"Type":"Succeed"}}}';

    // Act
    const actual = new StateMachine(expectedName, expectedDef);

    // Assert
    expect(actual.name).toBe(expectedName);
    expect(actual.definition).toBe(expectedDef);
    expect(actual.roleArn).toContain("iam");
  });
});
