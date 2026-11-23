import { describe, it, expect } from "vitest";
import { SqsProvider } from "../../../../src/providers/sqs/provider.js";

describe("SqsProvider send/receive", () => {
  it("SendMessage round-trips through ReceiveMessage", async () => {
    // Arrange
    const provider = new SqsProvider();
    await provider.start();
    await provider.createQueue("test-queue");
    const expectedBody = "hello-world";

    // Act
    const queue = provider.getQueue("test-queue")!;
    await queue.sendMessage(expectedBody);
    const messages = await queue.receiveMessages(1, 0);

    // Assert
    expect(messages).toHaveLength(1);
    const actualBody = messages[0]!.body;
    expect(actualBody).toBe(expectedBody);
  });

  it("ReceiveMessage returns empty when queue is empty", async () => {
    // Arrange
    const provider = new SqsProvider();
    await provider.start();
    await provider.createQueue("empty-queue");

    // Act
    const queue = provider.getQueue("empty-queue")!;
    const messages = await queue.receiveMessages(1, 0);

    // Assert
    const actualCount = messages.length;
    expect(actualCount).toBe(0);
  });

  it("DeleteMessage removes message from queue", async () => {
    // Arrange
    const provider = new SqsProvider();
    await provider.start();
    await provider.createQueue("del-queue");
    const queue = provider.getQueue("del-queue")!;
    await queue.sendMessage("to-delete");
    const [msg] = await queue.receiveMessages(1, 0);
    const expectedCount = 0;

    // Act
    await queue.deleteMessage(msg!.receiptHandle);
    // Make message visible again by expiring visibility (force visibleAfter to past)
    // After delete there should be no messages
    const remaining = queue.messages.filter(
      (m) => m.messageId === msg!.messageId,
    );

    // Assert
    const actualCount = remaining.length;
    expect(actualCount).toBe(expectedCount);
  });

  it("SendMessage returns a unique message ID", async () => {
    // Arrange
    const provider = new SqsProvider();
    await provider.start();
    await provider.createQueue("id-queue");
    const queue = provider.getQueue("id-queue")!;

    // Act
    const id1 = await queue.sendMessage("msg-a");
    const id2 = await queue.sendMessage("msg-b");

    // Assert
    expect(id1).not.toBe(id2);
  });
});
