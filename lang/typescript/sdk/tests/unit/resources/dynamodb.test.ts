import {
  DynamoDBClient,
  AttributeValue,
} from "@aws-sdk/client-dynamodb";
import { DynamoDBHelper } from "../../../src/resources/dynamodb";

function makeFakeClient(): { send: jest.Fake; client: DynamoDBClient } {
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
      send.fakeResolvedValue({});

      // Act
      await helper.put(expectedItem);

      // Assert
      expect(send).toHaveBeenCalledTimes(1);
      const actualCommand = send.fake.calls[0][0];
      expect(actualCommand.input.TableName).toBe("Orders");
      expect(actualCommand.input.Item).toEqual(expectedItem);
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
      send.fakeResolvedValue({ Item: expectedItem });

      // Act
      const actual = await helper.get({ id: { S: "1" } });

      // Assert
      expect(actual).toEqual(expectedItem);
    });

    it("returns undefined when the item is not found", async () => {
      // Arrange
      const { send, client } = makeFakeClient();
      const helper = new DynamoDBHelper("Orders", client);
      send.fakeResolvedValue({});

      // Act
      const actual = await helper.get({ id: { S: "missing" } });

      // Assert
      expect(actual).toBeUndefined();
    });
  });

  describe("delete", () => {
    it("calls DeleteItemCommand with the correct table name and key", async () => {
      // Arrange
      const { send, client } = makeFakeClient();
      const helper = new DynamoDBHelper("Orders", client);
      const expectedKey: Record<string, AttributeValue> = { id: { S: "1" } };
      send.fakeResolvedValue({});

      // Act
      await helper.delete(expectedKey);

      // Assert
      expect(send).toHaveBeenCalledTimes(1);
      const actualCommand = send.fake.calls[0][0];
      expect(actualCommand.input.TableName).toBe("Orders");
      expect(actualCommand.input.Key).toEqual(expectedKey);
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
      send.fakeResolvedValue({ Items: expectedItems, LastEvaluatedKey: undefined });

      // Act
      const actual = await helper.scan();

      // Assert
      expect(actual).toEqual(expectedItems);
      expect(send).toHaveBeenCalledTimes(1);
    });

    it("paginates until there is no LastEvaluatedKey", async () => {
      // Arrange
      const { send, client } = makeFakeClient();
      const helper = new DynamoDBHelper("Orders", client);
      send
        .fakeResolvedValueOnce({
          Items: [{ id: { S: "1" } }],
          LastEvaluatedKey: { id: { S: "1" } },
        })
        .fakeResolvedValueOnce({
          Items: [{ id: { S: "2" } }],
          LastEvaluatedKey: undefined,
        });

      // Act
      const actual = await helper.scan();

      // Assert
      expect(actual).toHaveLength(2);
      expect(send).toHaveBeenCalledTimes(2);
    });
  });

  describe("assertItemExists", () => {
    it("returns the item when it exists", async () => {
      // Arrange
      const { send, client } = makeFakeClient();
      const helper = new DynamoDBHelper("Orders", client);
      const expectedItem: Record<string, AttributeValue> = { id: { S: "1" } };
      send.fakeResolvedValue({ Item: expectedItem });

      // Act
      const actual = await helper.assertItemExists({ id: { S: "1" } });

      // Assert
      expect(actual).toEqual(expectedItem);
    });

    it("throws when the item does not exist", async () => {
      // Arrange
      const { send, client } = makeFakeClient();
      const helper = new DynamoDBHelper("Orders", client);
      send.fakeResolvedValue({});
      const expectedKey = { id: { S: "missing" } };

      // Act & Assert
      await expect(helper.assertItemExists(expectedKey)).rejects.toThrow(
        'Expected item with key'
      );
    });
  });

  describe("assertItemCount", () => {
    it("does not throw when the item count matches", async () => {
      // Arrange
      const { send, client } = makeFakeClient();
      const helper = new DynamoDBHelper("Orders", client);
      send.fakeResolvedValue({ Items: [{ id: { S: "1" } }] });
      const expectedCount = 1;

      // Act & Assert
      await expect(helper.assertItemCount(expectedCount)).resolves.toBeUndefined();
    });

    it("throws when the item count does not match", async () => {
      // Arrange
      const { send, client } = makeFakeClient();
      const helper = new DynamoDBHelper("Orders", client);
      send.fakeResolvedValue({
        Items: [{ id: { S: "1" } }, { id: { S: "2" } }],
      });
      const expectedCount = 1;

      // Act & Assert
      await expect(helper.assertItemCount(expectedCount)).rejects.toThrow(
        "Expected 1 item(s)"
      );
    });
  });
});
