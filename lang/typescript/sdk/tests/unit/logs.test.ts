import { LogCapture, LogEntry } from "../../src/logs";

describe("LogCapture", () => {
  let capture: LogCapture;

  beforeEach(() => {
    capture = new LogCapture(8080);
  });

  function injectEntries(entries: LogEntry[]): void {
    (capture as unknown as { entries: LogEntry[] }).entries = entries;
  }

  describe("all", () => {
    it("returns a copy of the captured entries", () => {
      // Arrange
      const expectedEntries: LogEntry[] = [
        { service: "dynamodb", operation: "PutItem", level: "INFO" },
      ];
      injectEntries(expectedEntries);

      // Act
      const actual = capture.all;

      // Assert
      expect(actual).toEqual(expectedEntries);
      expect(actual).not.toBe(expectedEntries);
    });
  });

  describe("forService", () => {
    it("returns only entries matching the given service (case-insensitive)", () => {
      // Arrange
      injectEntries([
        { service: "dynamodb", operation: "PutItem" },
        { service: "S3", operation: "GetObject" },
        { service: "DynamoDB", operation: "GetItem" },
      ]);

      // Act
      const actual = capture.forService("dynamodb");

      // Assert
      expect(actual).toHaveLength(2);
      expect(actual.map((e) => e.operation)).toEqual(["PutItem", "GetItem"]);
    });

    it("returns empty array when no entries match", () => {
      // Arrange
      injectEntries([{ service: "s3", operation: "GetObject" }]);

      // Act
      const actual = capture.forService("dynamodb");

      // Assert
      expect(actual).toHaveLength(0);
    });
  });

  describe("forOperation", () => {
    it("returns only entries matching the given operation", () => {
      // Arrange
      injectEntries([
        { service: "dynamodb", operation: "PutItem" },
        { service: "dynamodb", operation: "GetItem" },
        { service: "s3", operation: "PutItem" },
      ]);

      // Act
      const actual = capture.forOperation("PutItem");

      // Assert
      expect(actual).toHaveLength(2);
      expect(actual.map((e) => e.service)).toEqual(["dynamodb", "s3"]);
    });
  });

  describe("assertCalled", () => {
    it("does not throw when a matching entry exists", () => {
      // Arrange
      injectEntries([{ service: "dynamodb", operation: "PutItem" }]);

      // Act & Assert
      expect(() => capture.assertCalled("dynamodb", "PutItem")).not.toThrow();
    });

    it("does not throw when matching service differs only in case", () => {
      // Arrange
      injectEntries([{ service: "DynamoDB", operation: "PutItem" }]);

      // Act & Assert
      expect(() => capture.assertCalled("dynamodb", "PutItem")).not.toThrow();
    });

    it("throws when no matching entry is found", () => {
      // Arrange
      injectEntries([{ service: "s3", operation: "GetObject" }]);

      // Act & Assert
      expect(() => capture.assertCalled("dynamodb", "PutItem")).toThrow(
        "Expected dynamodb.PutItem to have been called",
      );
    });

    it("throws when no entries have been captured at all", () => {
      // Arrange — empty entries

      // Act & Assert
      expect(() => capture.assertCalled("dynamodb", "PutItem")).toThrow(
        "Expected dynamodb.PutItem to have been called",
      );
    });
  });

  describe("assertNotCalled", () => {
    it("does not throw when no matching entry exists", () => {
      // Arrange
      injectEntries([{ service: "s3", operation: "GetObject" }]);

      // Act & Assert
      expect(() => capture.assertNotCalled("dynamodb", "PutItem")).not.toThrow();
    });

    it("throws when a matching entry is found", () => {
      // Arrange
      injectEntries([{ service: "dynamodb", operation: "PutItem" }]);

      // Act & Assert
      expect(() => capture.assertNotCalled("dynamodb", "PutItem")).toThrow(
        "Expected dynamodb.PutItem NOT to have been called",
      );
    });
  });

  describe("assertCallCount", () => {
    it("does not throw when the call count matches exactly", () => {
      // Arrange
      injectEntries([
        { service: "dynamodb", operation: "PutItem" },
        { service: "dynamodb", operation: "PutItem" },
      ]);
      const expectedCount = 2;

      // Act & Assert
      expect(() => capture.assertCallCount("dynamodb", "PutItem", expectedCount)).not.toThrow();
    });

    it("throws when the call count is lower than expected", () => {
      // Arrange
      injectEntries([{ service: "dynamodb", operation: "PutItem" }]);
      const expectedCount = 2;

      // Act & Assert
      expect(() => capture.assertCallCount("dynamodb", "PutItem", expectedCount)).toThrow(
        "Expected dynamodb.PutItem to be called 2 time(s), but was called 1 time(s).",
      );
    });

    it("throws when the call count is higher than expected", () => {
      // Arrange
      injectEntries([
        { service: "dynamodb", operation: "PutItem" },
        { service: "dynamodb", operation: "PutItem" },
        { service: "dynamodb", operation: "PutItem" },
      ]);
      const expectedCount = 1;

      // Act & Assert
      expect(() => capture.assertCallCount("dynamodb", "PutItem", expectedCount)).toThrow(
        "Expected dynamodb.PutItem to be called 1 time(s), but was called 3 time(s).",
      );
    });

    it("does not throw when expected count is zero and no matching entries exist", () => {
      // Arrange
      injectEntries([{ service: "s3", operation: "GetObject" }]);
      const expectedCount = 0;

      // Act & Assert
      expect(() => capture.assertCallCount("dynamodb", "PutItem", expectedCount)).not.toThrow();
    });
  });

  describe("assertNoErrors", () => {
    it("does not throw when there are no ERROR-level entries", () => {
      // Arrange
      injectEntries([{ service: "dynamodb", operation: "PutItem", level: "INFO" }]);

      // Act & Assert
      expect(() => capture.assertNoErrors()).not.toThrow();
    });

    it("throws when an ERROR-level entry is present", () => {
      // Arrange
      injectEntries([
        { service: "dynamodb", operation: "PutItem", level: "INFO" },
        { service: "s3", operation: "GetObject", level: "ERROR" },
      ]);

      // Act & Assert
      expect(() => capture.assertNoErrors()).toThrow("Expected no ERROR log entries, but found 1");
    });

    it("does not throw when the entries list is empty", () => {
      // Arrange — empty entries

      // Act & Assert
      expect(() => capture.assertNoErrors()).not.toThrow();
    });
  });
});
