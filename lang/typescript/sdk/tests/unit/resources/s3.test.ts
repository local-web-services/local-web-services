import { S3Client } from "@aws-sdk/client-s3";
import { S3Helper } from "../../../src/resources/s3";

function makeFakeClient(): { send: jest.Mock; client: S3Client } {
  const send = jest.fn();
  return { send, client: { send } as unknown as S3Client };
}

function makeAsyncBody(content: string): AsyncIterable<Uint8Array> {
  return {
    [Symbol.asyncIterator]: async function* () {
      yield Buffer.from(content);
    },
  };
}

const EXPECTED_BUCKET = "my-bucket";

describe("S3Helper", () => {
  describe("put", () => {
    it("calls PutObjectCommand with correct bucket, key, and body", async () => {
      // Arrange
      const { send, client } = makeFakeClient();
      const helper = new S3Helper(EXPECTED_BUCKET, client);
      send.mockResolvedValue({});
      const expectedKey = "uploads/file.txt";
      const expectedContent = "hello world";

      // Act
      await helper.put(expectedKey, expectedContent, "text/plain");

      // Assert
      expect(
        send,
        "Expected send to have been called once for PutObjectCommand",
      ).toHaveBeenCalledTimes(1);
      const actualCommand = send.mock.calls[0][0];
      expect(
        actualCommand.input.Bucket,
        "Expected PutObjectCommand to use the correct bucket name",
      ).toBe(EXPECTED_BUCKET);
      expect(
        actualCommand.input.Key,
        "Expected PutObjectCommand to use the correct object key",
      ).toBe(expectedKey);
      expect(
        actualCommand.input.ContentType,
        "Expected PutObjectCommand to use the correct content type",
      ).toBe("text/plain");
    });
  });

  describe("get", () => {
    it("returns the object body as a Buffer", async () => {
      // Arrange
      const { send, client } = makeFakeClient();
      const helper = new S3Helper(EXPECTED_BUCKET, client);
      const expectedContent = "file content";
      send.mockResolvedValue({ Body: makeAsyncBody(expectedContent) });

      // Act
      const actual = await helper.get("some-key");

      // Assert
      expect(
        actual.toString("utf-8"),
        "Expected get to return the object body decoded as UTF-8",
      ).toBe(expectedContent);
    });
  });

  describe("getText", () => {
    it("returns the object body decoded as UTF-8 text", async () => {
      // Arrange
      const { send, client } = makeFakeClient();
      const helper = new S3Helper(EXPECTED_BUCKET, client);
      const expectedText = "hello from s3";
      send.mockResolvedValue({ Body: makeAsyncBody(expectedText) });

      // Act
      const actual = await helper.getText("some-key");

      // Assert
      expect(actual, "Expected getText to return the object body as a UTF-8 string").toBe(
        expectedText,
      );
    });
  });

  describe("delete", () => {
    it("calls DeleteObjectCommand with correct bucket and key", async () => {
      // Arrange
      const { send, client } = makeFakeClient();
      const helper = new S3Helper(EXPECTED_BUCKET, client);
      send.mockResolvedValue({});
      const expectedKey = "to-delete.txt";

      // Act
      await helper.delete(expectedKey);

      // Assert
      const actualCommand = send.mock.calls[0][0];
      expect(
        actualCommand.input.Bucket,
        "Expected DeleteObjectCommand to use the correct bucket name",
      ).toBe(EXPECTED_BUCKET);
      expect(
        actualCommand.input.Key,
        "Expected DeleteObjectCommand to use the correct object key",
      ).toBe(expectedKey);
    });
  });

  describe("listKeys", () => {
    it("returns all object keys from a single page", async () => {
      // Arrange
      const { send, client } = makeFakeClient();
      const helper = new S3Helper(EXPECTED_BUCKET, client);
      send.mockResolvedValue({
        Contents: [{ Key: "a.txt" }, { Key: "b.txt" }],
        NextContinuationToken: undefined,
      });

      // Act
      const actual = await helper.listKeys();

      // Assert
      expect(actual, "Expected listKeys to return all object keys from a single page").toEqual([
        "a.txt",
        "b.txt",
      ]);
      expect(
        send,
        "Expected send to have been called once for a single-page list",
      ).toHaveBeenCalledTimes(1);
    });

    it("paginates until there is no NextContinuationToken", async () => {
      // Arrange
      const { send, client } = makeFakeClient();
      const helper = new S3Helper(EXPECTED_BUCKET, client);
      send
        .mockResolvedValueOnce({
          Contents: [{ Key: "a.txt" }],
          NextContinuationToken: "token-1",
        })
        .mockResolvedValueOnce({
          Contents: [{ Key: "b.txt" }],
          NextContinuationToken: undefined,
        });

      // Act
      const actual = await helper.listKeys();

      // Assert
      expect(actual, "Expected listKeys to return all object keys across both pages").toEqual([
        "a.txt",
        "b.txt",
      ]);
      expect(
        send,
        "Expected send to have been called twice for a two-page list",
      ).toHaveBeenCalledTimes(2);
    });

    it("passes a prefix filter when provided", async () => {
      // Arrange
      const { send, client } = makeFakeClient();
      const helper = new S3Helper(EXPECTED_BUCKET, client);
      send.mockResolvedValue({ Contents: [], NextContinuationToken: undefined });
      const expectedPrefix = "uploads/";

      // Act
      await helper.listKeys(expectedPrefix);

      // Assert
      const actualCommand = send.mock.calls[0][0];
      expect(
        actualCommand.input.Prefix,
        "Expected the list command to use the configured prefix filter",
      ).toBe(expectedPrefix);
    });
  });

  describe("assertObjectExists", () => {
    it("does not throw when the key exists", async () => {
      // Arrange
      const { send, client } = makeFakeClient();
      const helper = new S3Helper(EXPECTED_BUCKET, client);
      send.mockResolvedValue({
        Contents: [{ Key: "target.txt" }],
        NextContinuationToken: undefined,
      });

      // Act & Assert
      await expect(
        helper.assertObjectExists("target.txt"),
        "Expected assertObjectExists to resolve when the key exists",
      ).resolves.toBeUndefined();
    });

    it("throws when the key does not exist", async () => {
      // Arrange
      const { send, client } = makeFakeClient();
      const helper = new S3Helper(EXPECTED_BUCKET, client);
      send.mockResolvedValue({ Contents: [], NextContinuationToken: undefined });

      // Act & Assert
      await expect(
        helper.assertObjectExists("missing.txt"),
        "Expected assertObjectExists to reject when the key does not exist",
      ).rejects.toThrow('Expected object "missing.txt" to exist in bucket');
    });
  });

  describe("assertObjectCount", () => {
    it("does not throw when the object count matches", async () => {
      // Arrange
      const { send, client } = makeFakeClient();
      const helper = new S3Helper(EXPECTED_BUCKET, client);
      send.mockResolvedValue({
        Contents: [{ Key: "a.txt" }, { Key: "b.txt" }],
        NextContinuationToken: undefined,
      });
      const expectedCount = 2;

      // Act & Assert
      await expect(
        helper.assertObjectCount(expectedCount),
        "Expected assertObjectCount to resolve when the object count matches",
      ).resolves.toBeUndefined();
    });

    it("throws when the object count does not match", async () => {
      // Arrange
      const { send, client } = makeFakeClient();
      const helper = new S3Helper(EXPECTED_BUCKET, client);
      send.mockResolvedValue({
        Contents: [{ Key: "a.txt" }],
        NextContinuationToken: undefined,
      });
      const expectedCount = 3;

      // Act & Assert
      await expect(
        helper.assertObjectCount(expectedCount),
        "Expected assertObjectCount to reject when the object count does not match",
      ).rejects.toThrow("Expected 3 object(s)");
    });
  });
});
