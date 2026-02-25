import { SQSClient } from "@aws-sdk/client-sqs";
import { SQSHelper } from "../../../src/resources/sqs";

function makeFakeClient(): { send: jest.Mock; client: SQSClient } {
  const send = jest.fn();
  return { send, client: { send } as unknown as SQSClient };
}

const EXPECTED_PORT = 4566;
const EXPECTED_QUEUE_NAME = "OrderQueue";
const EXPECTED_QUEUE_URL = `http://127.0.0.1:${EXPECTED_PORT}/000000000000/${EXPECTED_QUEUE_NAME}`;

describe("SQSHelper", () => {
  describe("url", () => {
    it("returns the correctly formatted queue URL", () => {
      // Arrange
      const { client } = makeFakeClient();
      const helper = new SQSHelper(EXPECTED_QUEUE_NAME, client, EXPECTED_PORT);

      // Act
      const actual = helper.url;

      // Assert
      expect(actual).toBe(EXPECTED_QUEUE_URL);
    });
  });

  describe("send", () => {
    it("sends a string body unchanged", async () => {
      // Arrange
      const { send, client } = makeFakeClient();
      const helper = new SQSHelper(EXPECTED_QUEUE_NAME, client, EXPECTED_PORT);
      const expectedBody = "plain text message";
      send.mockResolvedValue({ MessageId: "msg-1" });

      // Act
      const actual = await helper.send(expectedBody);

      // Assert
      expect(actual).toBe("msg-1");
      const actualCommand = send.mock.calls[0][0];
      expect(actualCommand.input.QueueUrl).toBe(EXPECTED_QUEUE_URL);
      expect(actualCommand.input.MessageBody).toBe(expectedBody);
    });

    it("JSON-encodes an object body", async () => {
      // Arrange
      const { send, client } = makeFakeClient();
      const helper = new SQSHelper(EXPECTED_QUEUE_NAME, client, EXPECTED_PORT);
      const expectedPayload = { orderId: "42", status: "pending" };
      send.mockResolvedValue({ MessageId: "msg-2" });

      // Act
      await helper.send(expectedPayload);

      // Assert
      const actualCommand = send.mock.calls[0][0];
      expect(actualCommand.input.MessageBody).toBe(JSON.stringify(expectedPayload));
    });

    it("includes MessageGroupId when provided", async () => {
      // Arrange
      const { send, client } = makeFakeClient();
      const helper = new SQSHelper(EXPECTED_QUEUE_NAME, client, EXPECTED_PORT);
      send.mockResolvedValue({ MessageId: "msg-3" });
      const expectedGroupId = "order-group";

      // Act
      await helper.send("body", { messageGroupId: expectedGroupId });

      // Assert
      const actualCommand = send.mock.calls[0][0];
      expect(actualCommand.input.MessageGroupId).toBe(expectedGroupId);
    });
  });

  describe("receive", () => {
    it("returns the messages from the response", async () => {
      // Arrange
      const { send, client } = makeFakeClient();
      const helper = new SQSHelper(EXPECTED_QUEUE_NAME, client, EXPECTED_PORT);
      const expectedMessages = [{ MessageId: "m1", Body: "hello" }];
      send.mockResolvedValue({ Messages: expectedMessages });

      // Act
      const actual = await helper.receive();

      // Assert
      expect(actual).toEqual(expectedMessages);
    });

    it("returns empty array when no messages are available", async () => {
      // Arrange
      const { send, client } = makeFakeClient();
      const helper = new SQSHelper(EXPECTED_QUEUE_NAME, client, EXPECTED_PORT);
      send.mockResolvedValue({});

      // Act
      const actual = await helper.receive();

      // Assert
      expect(actual).toEqual([]);
    });

    it("caps MaxNumberOfMessages at 10", async () => {
      // Arrange
      const { send, client } = makeFakeClient();
      const helper = new SQSHelper(EXPECTED_QUEUE_NAME, client, EXPECTED_PORT);
      send.mockResolvedValue({ Messages: [] });

      // Act
      await helper.receive(100);

      // Assert
      const actualCommand = send.mock.calls[0][0];
      expect(actualCommand.input.MaxNumberOfMessages).toBe(10);
    });
  });

  describe("purge", () => {
    it("calls PurgeQueueCommand with the correct queue URL", async () => {
      // Arrange
      const { send, client } = makeFakeClient();
      const helper = new SQSHelper(EXPECTED_QUEUE_NAME, client, EXPECTED_PORT);
      send.mockResolvedValue({});

      // Act
      await helper.purge();

      // Assert
      const actualCommand = send.mock.calls[0][0];
      expect(actualCommand.input.QueueUrl).toBe(EXPECTED_QUEUE_URL);
    });
  });

  describe("assertMessageCount", () => {
    it("does not throw when the count matches", async () => {
      // Arrange
      const { send, client } = makeFakeClient();
      const helper = new SQSHelper(EXPECTED_QUEUE_NAME, client, EXPECTED_PORT);
      send.mockResolvedValue({
        Attributes: { ApproximateNumberOfMessages: "3" },
      });
      const expectedCount = 3;

      // Act & Assert
      await expect(helper.assertMessageCount(expectedCount)).resolves.toBeUndefined();
    });

    it("throws when the count does not match", async () => {
      // Arrange
      const { send, client } = makeFakeClient();
      const helper = new SQSHelper(EXPECTED_QUEUE_NAME, client, EXPECTED_PORT);
      send.mockResolvedValue({
        Attributes: { ApproximateNumberOfMessages: "5" },
      });
      const expectedCount = 2;

      // Act & Assert
      await expect(helper.assertMessageCount(expectedCount)).rejects.toThrow(
        `Expected 2 message(s) in queue "${EXPECTED_QUEUE_NAME}"`
      );
    });
  });
});
