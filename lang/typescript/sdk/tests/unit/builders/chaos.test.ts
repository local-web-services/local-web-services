import { ChaosBuilder } from "../../../src/builders/chaos";

const EXPECTED_MGMT_PORT = 8080;
const EXPECTED_CHAOS_URL = `http://127.0.0.1:${EXPECTED_MGMT_PORT}/_ldk/chaos`;

describe("ChaosBuilder", () => {
  let fakeFetch: jest.Mock;

  beforeEach(() => {
    fakeFetch = jest.fn().mockResolvedValue({ ok: true });
    global.fetch = fakeFetch;
  });

  describe("errorRate", () => {
    it("sets error_rate in the config and returns itself for chaining", async () => {
      // Arrange
      const builder = new ChaosBuilder("dynamodb", EXPECTED_MGMT_PORT);
      const expectedRate = 0.5;

      // Act
      await builder.errorRate(expectedRate).apply();

      // Assert
      const actualBody = JSON.parse(fakeFetch.mock.calls[0][1].body);
      expect(actualBody.dynamodb.error_rate, "Expected dynamodb error_rate to match the configured rate").toBe(expectedRate);
    });
  });

  describe("latency", () => {
    it("sets latency_min_ms and latency_max_ms in the config", async () => {
      // Arrange
      const builder = new ChaosBuilder("sqs", EXPECTED_MGMT_PORT);
      const expectedMin = 100;
      const expectedMax = 500;

      // Act
      await builder.latency(expectedMin, expectedMax).apply();

      // Assert
      const actualBody = JSON.parse(fakeFetch.mock.calls[0][1].body);
      expect(actualBody.sqs.latency_min_ms, "Expected sqs latency_min_ms to match the configured minimum").toBe(expectedMin);
      expect(actualBody.sqs.latency_max_ms, "Expected sqs latency_max_ms to match the configured maximum").toBe(expectedMax);
    });
  });

  describe("connectionResetRate", () => {
    it("sets connection_reset_rate in the config", async () => {
      // Arrange
      const builder = new ChaosBuilder("s3", EXPECTED_MGMT_PORT);
      const expectedRate = 0.1;

      // Act
      await builder.connectionResetRate(expectedRate).apply();

      // Assert
      const actualBody = JSON.parse(fakeFetch.mock.calls[0][1].body);
      expect(actualBody.s3.connection_reset_rate, "Expected s3 connection_reset_rate to match the configured rate").toBe(expectedRate);
    });
  });

  describe("timeoutRate", () => {
    it("sets timeout_rate in the config", async () => {
      // Arrange
      const builder = new ChaosBuilder("dynamodb", EXPECTED_MGMT_PORT);
      const expectedRate = 0.25;

      // Act
      await builder.timeoutRate(expectedRate).apply();

      // Assert
      const actualBody = JSON.parse(fakeFetch.mock.calls[0][1].body);
      expect(actualBody.dynamodb.timeout_rate, "Expected dynamodb timeout_rate to match the configured rate").toBe(expectedRate);
    });
  });

  describe("apply", () => {
    it("POSTs to the chaos management endpoint with enabled:true", async () => {
      // Arrange
      const builder = new ChaosBuilder("dynamodb", EXPECTED_MGMT_PORT);

      // Act
      await builder.errorRate(0.2).apply();

      // Assert
      expect(fakeFetch, "Expected fetch to have been called with the chaos management URL and correct headers").toHaveBeenCalledWith(
        EXPECTED_CHAOS_URL,
        expect.objectContaining({
          method: "POST",
          headers: { "Content-Type": "application/json" },
        }),
      );
      const actualBody = JSON.parse(fakeFetch.mock.calls[0][1].body);
      expect(actualBody.dynamodb.enabled, "Expected dynamodb enabled flag to be true after apply").toBe(true);
    });

    it("supports method chaining for multiple chaos settings", async () => {
      // Arrange
      const builder = new ChaosBuilder("dynamodb", EXPECTED_MGMT_PORT);

      // Act
      await builder.errorRate(0.1).latency(50, 200).timeoutRate(0.05).apply();

      // Assert
      const actualBody = JSON.parse(fakeFetch.mock.calls[0][1].body);
      expect(actualBody.dynamodb.error_rate, "Expected dynamodb error_rate to be set via method chaining").toBe(0.1);
      expect(actualBody.dynamodb.latency_min_ms, "Expected dynamodb latency_min_ms to be set via method chaining").toBe(50);
      expect(actualBody.dynamodb.latency_max_ms, "Expected dynamodb latency_max_ms to be set via method chaining").toBe(200);
      expect(actualBody.dynamodb.timeout_rate, "Expected dynamodb timeout_rate to be set via method chaining").toBe(0.05);
    });
  });

  describe("clear", () => {
    it("POSTs disabled state with error_rate 0 to the chaos endpoint", async () => {
      // Arrange
      const builder = new ChaosBuilder("dynamodb", EXPECTED_MGMT_PORT);

      // Act
      await builder.clear();

      // Assert
      expect(fakeFetch, "Expected fetch to have been called with the chaos management URL and POST method").toHaveBeenCalledWith(
        EXPECTED_CHAOS_URL,
        expect.objectContaining({ method: "POST" }),
      );
      const actualBody = JSON.parse(fakeFetch.mock.calls[0][1].body);
      expect(actualBody.dynamodb.enabled, "Expected dynamodb enabled flag to be false after clear").toBe(false);
      expect(actualBody.dynamodb.error_rate, "Expected dynamodb error_rate to be 0 after clear").toBe(0.0);
    });
  });
});
