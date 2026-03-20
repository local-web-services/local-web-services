import { FakeBuilder, FakeRuleBuilder } from "../../../src/builders/fake";

const EXPECTED_MGMT_PORT = 8080;
const EXPECTED_MGMT_URL = `http://127.0.0.1:${EXPECTED_MGMT_PORT}/_ldk/aws-fake`;

describe("FakeBuilder", () => {
  let fakeFetch: jest.Mock;

  beforeEach(() => {
    fakeFetch = jest.fn().mockResolvedValue({ ok: true });
    global.fetch = fakeFetch;
  });

  describe("clear", () => {
    it("POSTs disabled:false with empty rules to the management endpoint", async () => {
      // Arrange
      const builder = new FakeBuilder("dynamodb", EXPECTED_MGMT_PORT);

      // Act
      await builder.clear();

      // Assert
      expect(
        fakeFetch,
        "Expected fetch to have been called with the fake management URL and correct headers",
      ).toHaveBeenCalledWith(
        EXPECTED_MGMT_URL,
        expect.objectContaining({
          method: "POST",
          headers: { "Content-Type": "application/json" },
        }),
      );
      const actualBody = JSON.parse(fakeFetch.mock.calls[0][1].body);
      expect(actualBody.dynamodb.enabled, "Expected dynamodb enabled to be false after clear").toBe(
        false,
      );
      expect(
        actualBody.dynamodb.rules,
        "Expected dynamodb rules to be an empty array after clear",
      ).toEqual([]);
    });
  });

  describe("operation", () => {
    it("returns a FakeRuleBuilder for the given operation", () => {
      // Arrange
      const builder = new FakeBuilder("dynamodb", EXPECTED_MGMT_PORT);

      // Act
      const actual = builder.operation("PutItem");

      // Assert
      expect(actual, "Expected operation() to return a FakeRuleBuilder instance").toBeInstanceOf(
        FakeRuleBuilder,
      );
    });
  });
});

describe("FakeRuleBuilder", () => {
  let fakeFetch: jest.Mock;

  beforeEach(() => {
    fakeFetch = jest.fn().mockResolvedValue({ ok: true });
    global.fetch = fakeFetch;
  });

  describe("respond", () => {
    it("POSTs a rule with the correct operation and response", async () => {
      // Arrange
      const builder = new FakeBuilder("dynamodb", EXPECTED_MGMT_PORT);
      const expectedOperation = "PutItem";
      const expectedStatus = 200;
      const expectedBody = '{"result":"ok"}';

      // Act
      await builder
        .operation(expectedOperation)
        .respond({ status: expectedStatus, body: expectedBody });

      // Assert
      const actualBody = JSON.parse(fakeFetch.mock.calls[0][1].body);
      const actualRule = actualBody.dynamodb.rules[0];
      expect(
        actualRule.operation,
        "Expected the rule operation to match the configured operation",
      ).toBe(expectedOperation);
      expect(
        actualRule.response.status,
        "Expected the rule response status to match the configured status",
      ).toBe(expectedStatus);
      expect(
        actualRule.response.body,
        "Expected the rule response body to match the configured body",
      ).toBe(expectedBody);
    });

    it("JSON-encodes an object body", async () => {
      // Arrange
      const builder = new FakeBuilder("dynamodb", EXPECTED_MGMT_PORT);
      const expectedPayload = { Items: [] };

      // Act
      await builder.operation("Scan").respond({ body: expectedPayload });

      // Assert
      const actualBody = JSON.parse(fakeFetch.mock.calls[0][1].body);
      expect(
        actualBody.dynamodb.rules[0].response.body,
        "Expected the object body to be JSON-encoded in the rule response",
      ).toBe(JSON.stringify(expectedPayload));
    });

    it("uses default status 200 when not specified", async () => {
      // Arrange
      const builder = new FakeBuilder("dynamodb", EXPECTED_MGMT_PORT);

      // Act
      await builder.operation("GetItem").respond({});

      // Assert
      const actualBody = JSON.parse(fakeFetch.mock.calls[0][1].body);
      expect(
        actualBody.dynamodb.rules[0].response.status,
        "Expected the default response status to be 200 when not specified",
      ).toBe(200);
    });

    it("returns the parent FakeBuilder", async () => {
      // Arrange
      const builder = new FakeBuilder("dynamodb", EXPECTED_MGMT_PORT);

      // Act
      const actual = await builder.operation("GetItem").respond({});

      // Assert
      expect(actual, "Expected respond() to return the parent FakeBuilder for chaining").toBe(
        builder,
      );
    });
  });

  describe("error", () => {
    it("POSTs an error rule with the correct type and message", async () => {
      // Arrange
      const builder = new FakeBuilder("dynamodb", EXPECTED_MGMT_PORT);
      const expectedErrorType = "ResourceNotFoundException";
      const expectedMessage = "Table not found";
      const expectedStatus = 400;

      // Act
      await builder.operation("GetItem").error(expectedErrorType, expectedMessage, expectedStatus);

      // Assert
      const actualBody = JSON.parse(fakeFetch.mock.calls[0][1].body);
      const actualRule = actualBody.dynamodb.rules[0];
      expect(
        actualRule.response.status,
        "Expected the error rule response status to match the configured status",
      ).toBe(expectedStatus);
      const parsedRuleBody = JSON.parse(actualRule.response.body);
      expect(
        parsedRuleBody.__type,
        "Expected the error rule body __type to match the configured error type",
      ).toBe(expectedErrorType);
      expect(
        parsedRuleBody.message,
        "Expected the error rule body message to match the configured message",
      ).toBe(expectedMessage);
    });
  });

  describe("withHeader", () => {
    it("includes match_headers in the posted rule", async () => {
      // Arrange
      const builder = new FakeBuilder("dynamodb", EXPECTED_MGMT_PORT);
      const expectedHeaderName = "X-Amz-Target";
      const expectedHeaderValue = "DynamoDB_20120810.PutItem";

      // Act
      await builder
        .operation("PutItem")
        .withHeader(expectedHeaderName, expectedHeaderValue)
        .respond({});

      // Assert
      const actualBody = JSON.parse(fakeFetch.mock.calls[0][1].body);
      const actualMatchHeaders = actualBody.dynamodb.rules[0].match_headers;
      expect(
        actualMatchHeaders[expectedHeaderName],
        "Expected match_headers to contain the configured header value",
      ).toBe(expectedHeaderValue);
    });
  });
});
