import { DynamoDBClient, AttributeValue } from "@aws-sdk/client-dynamodb";
import { DynamoDBHelper } from "../../../src/resources/dynamodb";

function makeFakeClient(): { send: jest.Mock; client: DynamoDBClient } {
  const send = jest.fn();
  return { send, client: { send } as unknown as DynamoDBClient };
}

describe("DynamoDBHelper", () => {
  describe("put", () => {
    it("calls PutItemCommand with the correct table name and item", async () => {
      // Arrange
      const { send, client } = makeFakeClient();
      const helper = new DynamoDBHelper("Orders", client);
      const expectedItem: Record<string, AttributeValue> = {
        id: { S: "1" },
        status: { S: "pending" },
      };
      send.mockResolvedValue({});

      // Act
      await helper.put(expectedItem);

      // Assert
      expect(
        send,
        "Expected send to have been called once for PutItemCommand",
      ).toHaveBeenCalledTimes(1);
      const actualCommand = send.mock.calls[0][0];
      expect(
        actualCommand.input.TableName,
        "Expected PutItemCommand to use the Orders table name",
      ).toBe("Orders");
      expect(
        actualCommand.input.Item,
        "Expected PutItemCommand to use the configured item",
      ).toEqual(expectedItem);
    });
  });

  describe("get", () => {
    it("returns the item from the response", async () => {
      // Arrange
      const { send, client } = makeFakeClient();
      const helper = new DynamoDBHelper("Orders", client);
      const expectedItem: Record<string, AttributeValue> = {
        id: { S: "1" },
        status: { S: "complete" },
      };
      send.mockResolvedValue({ Item: expectedItem });

      // Act
      const actual = await helper.get({ id: { S: "1" } });

      // Assert
      expect(actual, "Expected get to return the item from the response").toEqual(expectedItem);
    });

    it("returns undefined when the item is not found", async () => {
      // Arrange
      const { send, client } = makeFakeClient();
      const helper = new DynamoDBHelper("Orders", client);
      send.mockResolvedValue({});

      // Act
      const actual = await helper.get({ id: { S: "missing" } });

      // Assert
      expect(actual, "Expected get to return undefined when the item is not found").toBeUndefined();
    });
  });

  describe("delete", () => {
    it("calls DeleteItemCommand with the correct table name and key", async () => {
      // Arrange
      const { send, client } = makeFakeClient();
      const helper = new DynamoDBHelper("Orders", client);
      const expectedKey: Record<string, AttributeValue> = { id: { S: "1" } };
      send.mockResolvedValue({});

      // Act
      await helper.delete(expectedKey);

      // Assert
      expect(
        send,
        "Expected send to have been called once for DeleteItemCommand",
      ).toHaveBeenCalledTimes(1);
      const actualCommand = send.mock.calls[0][0];
      expect(
        actualCommand.input.TableName,
        "Expected DeleteItemCommand to use the Orders table name",
      ).toBe("Orders");
      expect(
        actualCommand.input.Key,
        "Expected DeleteItemCommand to use the configured key",
      ).toEqual(expectedKey);
    });
  });

  describe("scan", () => {
    it("returns all items from a single page", async () => {
      // Arrange
      const { send, client } = makeFakeClient();
      const helper = new DynamoDBHelper("Orders", client);
      const expectedItems: Array<Record<string, AttributeValue>> = [
        { id: { S: "1" } },
        { id: { S: "2" } },
      ];
      send.mockResolvedValue({ Items: expectedItems, LastEvaluatedKey: undefined });

      // Act
      const actual = await helper.scan();

      // Assert
      expect(actual, "Expected scan to return all items from a single page").toEqual(expectedItems);
      expect(
        send,
        "Expected send to have been called once for a single-page scan",
      ).toHaveBeenCalledTimes(1);
    });

    it("paginates until there is no LastEvaluatedKey", async () => {
      // Arrange
      const { send, client } = makeFakeClient();
      const helper = new DynamoDBHelper("Orders", client);
      send
        .mockResolvedValueOnce({
          Items: [{ id: { S: "1" } }],
          LastEvaluatedKey: { id: { S: "1" } },
        })
        .mockResolvedValueOnce({
          Items: [{ id: { S: "2" } }],
          LastEvaluatedKey: undefined,
        });

      // Act
      const actual = await helper.scan();

      // Assert
      expect(actual, "Expected scan to return all items across both pages").toHaveLength(2);
      expect(
        send,
        "Expected send to have been called twice for a two-page scan",
      ).toHaveBeenCalledTimes(2);
    });
  });

  describe("assertItemExists", () => {
    it("returns the item when it exists", async () => {
      // Arrange
      const { send, client } = makeFakeClient();
      const helper = new DynamoDBHelper("Orders", client);
      const expectedItem: Record<string, AttributeValue> = { id: { S: "1" } };
      send.mockResolvedValue({ Item: expectedItem });

      // Act
      const actual = await helper.assertItemExists({ id: { S: "1" } });

      // Assert
      expect(actual, "Expected assertItemExists to return the item when it exists").toEqual(
        expectedItem,
      );
    });

    it("throws when the item does not exist", async () => {
      // Arrange
      const { send, client } = makeFakeClient();
      const helper = new DynamoDBHelper("Orders", client);
      send.mockResolvedValue({});
      const expectedKey = { id: { S: "missing" } };

      // Act & Assert
      await expect(
        helper.assertItemExists(expectedKey),
        "Expected assertItemExists to reject when the item does not exist",
      ).rejects.toThrow("Expected item with key");
    });
  });

  describe("assertItemCount", () => {
    it("does not throw when the item count matches", async () => {
      // Arrange
      const { send, client } = makeFakeClient();
      const helper = new DynamoDBHelper("Orders", client);
      send.mockResolvedValue({ Items: [{ id: { S: "1" } }] });
      const expectedCount = 1;

      // Act & Assert
      await expect(
        helper.assertItemCount(expectedCount),
        "Expected assertItemCount to resolve when the item count matches",
      ).resolves.toBeUndefined();
    });

    it("throws when the item count does not match", async () => {
      // Arrange
      const { send, client } = makeFakeClient();
      const helper = new DynamoDBHelper("Orders", client);
      send.mockResolvedValue({
        Items: [{ id: { S: "1" } }, { id: { S: "2" } }],
      });
      const expectedCount = 1;

      // Act & Assert
      await expect(
        helper.assertItemCount(expectedCount),
        "Expected assertItemCount to reject when the item count does not match",
      ).rejects.toThrow("Expected 1 item(s)");
    });
  });
});
