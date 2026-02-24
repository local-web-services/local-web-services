import { ChaosBuilder } from "../../../src/builders/chaos";

const EXPECTED_MGMT_PORT = 8080;
const EXPECTED_CHAOS_URL = `http://127.0.0.1:${EXPECTED_MGMT_PORT}/_ldk/chaos`;

describe("ChaosBuilder", () => {
  let fakeFetch: jest.Mock;

  beforeEach(() => {
    fakeFetch = jest.fn().fakeResolvedValue({ ok: true });
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
      const actualBody = JSON.parse(fakeFetch.fake.calls[0][1].body);
      expect(actualBody.dynamodb.error_rate).toBe(expectedRate);
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
      const actualBody = JSON.parse(fakeFetch.fake.calls[0][1].body);
      expect(actualBody.sqs.latency_min_ms).toBe(expectedMin);
      expect(actualBody.sqs.latency_max_ms).toBe(expectedMax);
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
      const actualBody = JSON.parse(fakeFetch.fake.calls[0][1].body);
      expect(actualBody.s3.connection_reset_rate).toBe(expectedRate);
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
      const actualBody = JSON.parse(fakeFetch.fake.calls[0][1].body);
      expect(actualBody.dynamodb.timeout_rate).toBe(expectedRate);
    });
  });

  describe("apply", () => {
    it("POSTs to the chaos management endpoint with enabled:true", async () => {
      // Arrange
      const builder = new ChaosBuilder("dynamodb", EXPECTED_MGMT_PORT);

      // Act
      await builder.errorRate(0.2).apply();

      // Assert
      expect(fakeFetch).toHaveBeenCalledWith(
        EXPECTED_CHAOS_URL,
        expect.objectContaining({
          method: "POST",
          headers: { "Content-Type": "application/json" },
        })
      );
      const actualBody = JSON.parse(fakeFetch.fake.calls[0][1].body);
      expect(actualBody.dynamodb.enabled).toBe(true);
    });

    it("supports method chaining for multiple chaos settings", async () => {
      // Arrange
      const builder = new ChaosBuilder("dynamodb", EXPECTED_MGMT_PORT);

      // Act
      await builder.errorRate(0.1).latency(50, 200).timeoutRate(0.05).apply();

      // Assert
      const actualBody = JSON.parse(fakeFetch.fake.calls[0][1].body);
      expect(actualBody.dynamodb.error_rate).toBe(0.1);
      expect(actualBody.dynamodb.latency_min_ms).toBe(50);
      expect(actualBody.dynamodb.latency_max_ms).toBe(200);
      expect(actualBody.dynamodb.timeout_rate).toBe(0.05);
    });
  });

  describe("clear", () => {
    it("POSTs disabled state with error_rate 0 to the chaos endpoint", async () => {
      // Arrange
      const builder = new ChaosBuilder("dynamodb", EXPECTED_MGMT_PORT);

      // Act
      await builder.clear();

      // Assert
      expect(fakeFetch).toHaveBeenCalledWith(
        EXPECTED_CHAOS_URL,
        expect.objectContaining({ method: "POST" })
      );
      const actualBody = JSON.parse(fakeFetch.fake.calls[0][1].body);
      expect(actualBody.dynamodb.enabled).toBe(false);
      expect(actualBody.dynamodb.error_rate).toBe(0.0);
    });
  });
});
