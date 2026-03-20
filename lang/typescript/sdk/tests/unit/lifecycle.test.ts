import { LifecycleBuilder } from "../../src/builders/lifecycle";

describe("LifecycleBuilder", () => {
  beforeEach(() => {
    global.fetch = jest.fn().mockResolvedValue({ ok: true });
  });

  afterEach(() => {
    jest.clearAllMocks();
  });

  describe("createDwellMs", () => {
    it("stores the create dwell duration and returns this for chaining", () => {
      // Arrange
      const expectedDwellMs = 500;
      const builder = new LifecycleBuilder("dynamodb", 9000);

      // Act
      const actualResult = builder.createDwellMs(expectedDwellMs);

      // Assert
      expect(
        actualResult,
        "Expected createDwellMs() to return the LifecycleBuilder instance for chaining",
      ).toBe(builder);
    });
  });

  describe("deleteDwellMs", () => {
    it("stores the delete dwell duration and returns this for chaining", () => {
      // Arrange
      const expectedDwellMs = 200;
      const builder = new LifecycleBuilder("dynamodb", 9000);

      // Act
      const actualResult = builder.deleteDwellMs(expectedDwellMs);

      // Assert
      expect(
        actualResult,
        "Expected deleteDwellMs() to return the LifecycleBuilder instance for chaining",
      ).toBe(builder);
    });
  });

  describe("apply", () => {
    it("POSTs to /_ldk/lifecycle with enabled true and the configured dwell values", async () => {
      // Arrange
      const expectedService = "dynamodb";
      const expectedCreateDwellMs = 500;
      const expectedDeleteDwellMs = 200;
      const builder = new LifecycleBuilder(expectedService, 9000);
      builder.createDwellMs(expectedCreateDwellMs).deleteDwellMs(expectedDeleteDwellMs);

      // Act
      await builder.apply();

      // Assert
      const fetchMock = global.fetch as jest.Mock;
      expect(
        fetchMock,
        "Expected fetch to have been called with the lifecycle endpoint and POST method",
      ).toHaveBeenCalledWith(
        "http://127.0.0.1:9000/_ldk/lifecycle",
        expect.objectContaining({ method: "POST" }),
      );
      const actualBody = JSON.parse((fetchMock.mock.calls[0][1] as Record<string, string>).body);
      expect(
        actualBody[expectedService].enabled,
        "Expected the dynamodb lifecycle enabled flag to be true after apply",
      ).toBe(true);
      expect(
        actualBody[expectedService].create_dwell_ms,
        "Expected create_dwell_ms to match the configured value",
      ).toBe(expectedCreateDwellMs);
      expect(
        actualBody[expectedService].delete_dwell_ms,
        "Expected delete_dwell_ms to match the configured value",
      ).toBe(expectedDeleteDwellMs);
    });
  });

  describe("clear", () => {
    it("POSTs to /_ldk/lifecycle with enabled false and zero dwell values", async () => {
      // Arrange
      const expectedService = "dynamodb";
      const builder = new LifecycleBuilder(expectedService, 9000);

      // Act
      await builder.clear();

      // Assert
      const fetchMock = global.fetch as jest.Mock;
      expect(
        fetchMock,
        "Expected fetch to have been called with the lifecycle endpoint and POST method",
      ).toHaveBeenCalledWith(
        "http://127.0.0.1:9000/_ldk/lifecycle",
        expect.objectContaining({ method: "POST" }),
      );
      const actualBody = JSON.parse((fetchMock.mock.calls[0][1] as Record<string, string>).body);
      expect(
        actualBody[expectedService].enabled,
        "Expected the dynamodb lifecycle enabled flag to be false after clear",
      ).toBe(false);
      expect(
        actualBody[expectedService].create_dwell_ms,
        "Expected create_dwell_ms to be 0 after clear",
      ).toBe(0);
      expect(
        actualBody[expectedService].delete_dwell_ms,
        "Expected delete_dwell_ms to be 0 after clear",
      ).toBe(0);
    });
  });
});
