import { CapacityBuilder } from "../../../src/builders/capacity";

const EXPECTED_MGMT_PORT = 8080;
const EXPECTED_CAPACITY_URL = `http://127.0.0.1:${EXPECTED_MGMT_PORT}/_ldk/capacity`;

describe("CapacityBuilder", () => {
  let fakeFetch: jest.Mock;

  beforeEach(() => {
    fakeFetch = jest.fn().mockResolvedValue({ ok: true });
    global.fetch = fakeFetch;
  });

  describe("exhaust", () => {
    it("sets slots to 0 and returns this for chaining", async () => {
      // Arrange
      const builder = new CapacityBuilder("dynamodb", EXPECTED_MGMT_PORT);

      // Act
      await builder.exhaust().apply();

      // Assert
      const actualBody = JSON.parse(fakeFetch.mock.calls[0][1].body);
      expect(actualBody.dynamodb.slots).toBe(0);
    });
  });

  describe("slots", () => {
    it("sets slots to the given number and returns this for chaining", async () => {
      // Arrange
      const builder = new CapacityBuilder("sqs", EXPECTED_MGMT_PORT);
      const expectedSlots = 5;

      // Act
      await builder.slots(expectedSlots).apply();

      // Assert
      const actualBody = JSON.parse(fakeFetch.mock.calls[0][1].body);
      expect(actualBody.sqs.slots).toBe(expectedSlots);
    });
  });

  describe("unlimited", () => {
    it("sets slots to null and returns this for chaining", async () => {
      // Arrange
      const builder = new CapacityBuilder("stepfunctions", EXPECTED_MGMT_PORT);

      // Act
      await builder.unlimited().apply();

      // Assert
      const actualBody = JSON.parse(fakeFetch.mock.calls[0][1].body);
      expect(actualBody.stepfunctions.slots).toBeNull();
    });
  });

  describe("apply", () => {
    it("POSTs to the capacity management endpoint", async () => {
      // Arrange
      const builder = new CapacityBuilder("dynamodb", EXPECTED_MGMT_PORT);

      // Act
      await builder.exhaust().apply();

      // Assert
      expect(fakeFetch).toHaveBeenCalledWith(
        EXPECTED_CAPACITY_URL,
        expect.objectContaining({
          method: "POST",
          headers: { "Content-Type": "application/json" },
        }),
      );
    });

    it("sends the service name as the top-level key in the POST body", async () => {
      // Arrange
      const expectedService = "lambda";
      const builder = new CapacityBuilder(expectedService, EXPECTED_MGMT_PORT);

      // Act
      await builder.exhaust().apply();

      // Assert
      const actualBody = JSON.parse(fakeFetch.mock.calls[0][1].body);
      expect(actualBody).toHaveProperty(expectedService);
    });
  });

  describe("clear", () => {
    it("POSTs slots null to reset capacity to unlimited", async () => {
      // Arrange
      const builder = new CapacityBuilder("dynamodb", EXPECTED_MGMT_PORT);

      // Act
      await builder.clear();

      // Assert
      expect(fakeFetch).toHaveBeenCalledWith(
        EXPECTED_CAPACITY_URL,
        expect.objectContaining({ method: "POST" }),
      );
      const actualBody = JSON.parse(fakeFetch.mock.calls[0][1].body);
      expect(actualBody.dynamodb.slots).toBeNull();
    });
  });
});
