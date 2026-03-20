package io.localwebservices.lws.unit.providers.sqs;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.localwebservices.lws.providers.sqs.SqsStore;
import io.localwebservices.lws.providers.sqs.SqsStore.LocalQueue;
import java.util.List;
import java.util.Map;
import org.junit.jupiter.api.Test;

public class SqsStoreTest {

  @Test
  public void queueUrl_containsPortAccountAndName() {
    // Arrange
    SqsStore store = new SqsStore(4566);
    String expectedName = "my-queue";
    String expectedAccount = "000000000000";

    // Act
    String actualUrl = store.queueUrl(expectedName);

    // Assert
    assertTrue(actualUrl.contains("4566"), "Expected value to contain expected substring");
    assertTrue(actualUrl.contains(expectedAccount), "Expected value to contain expected substring");
    assertTrue(actualUrl.contains(expectedName), "Expected value to contain expected substring");
  }

  @Test
  public void createQueue_returnsQueueWithUrl() {
    // Arrange
    SqsStore store = new SqsStore(4566);
    String expectedName = "created-queue";

    // Act
    LocalQueue actualQueue = store.createQueue(expectedName, Map.of());

    // Assert
    assertNotNull(actualQueue, "Expected actualQueue to not be null");
    assertEquals(expectedName, actualQueue.name, "Expected actualQueue.name to equal expectedName");
    assertNotNull(actualQueue.url, "Expected actualQueue.url to not be null");
  }

  @Test
  public void createQueue_fifoQueueByName_setsFifoTrue() {
    // Arrange
    SqsStore store = new SqsStore(4566);

    // Act
    LocalQueue actualQueue = store.createQueue("orders.fifo", Map.of());

    // Assert
    assertTrue(actualQueue.isFifo, "Expected condition to be true: actualQueue.isFifo");
  }

  @Test
  public void getQueue_byName_returnsQueue() {
    // Arrange
    SqsStore store = new SqsStore(4566);
    String expectedName = "get-by-name";
    store.createQueue(expectedName, Map.of());

    // Act
    LocalQueue actualQueue = store.getQueue(expectedName);

    // Assert
    assertNotNull(actualQueue, "Expected actualQueue to not be null");
    assertEquals(expectedName, actualQueue.name, "Expected actualQueue.name to equal expectedName");
  }

  @Test
  public void getQueue_byUrl_returnsQueue() {
    // Arrange
    SqsStore store = new SqsStore(4566);
    String queueName = "get-by-url";
    LocalQueue created = store.createQueue(queueName, Map.of());

    // Act
    LocalQueue actualQueue = store.getQueue(created.url);

    // Assert
    assertNotNull(actualQueue, "Expected actualQueue to not be null");
    assertEquals(queueName, actualQueue.name, "Expected actualQueue.name to equal queueName");
  }

  @Test
  public void getQueue_nullInput_returnsNull() {
    // Arrange
    SqsStore store = new SqsStore(4566);

    // Act
    LocalQueue actualQueue = store.getQueue(null);

    // Assert
    assertNull(actualQueue, "Expected actualQueue to be null");
  }

  @Test
  public void listQueues_noPrefix_returnsAll() {
    // Arrange
    SqsStore store = new SqsStore(4566);
    store.createQueue("alpha", Map.of());
    store.createQueue("beta", Map.of());
    int expectedCount = 2;

    // Act
    List<LocalQueue> actualQueues = store.listQueues(null);

    // Assert
    assertEquals(
        expectedCount, actualQueues.size(), "Expected actualQueues.size() to match expectedCount");
  }

  @Test
  public void listQueues_withPrefix_filtersQueues() {
    // Arrange
    SqsStore store = new SqsStore(4566);
    store.createQueue("prefix-a", Map.of());
    store.createQueue("prefix-b", Map.of());
    store.createQueue("other-c", Map.of());
    int expectedCount = 2;

    // Act
    List<LocalQueue> actualQueues = store.listQueues("prefix");

    // Assert
    assertEquals(
        expectedCount, actualQueues.size(), "Expected actualQueues.size() to match expectedCount");
  }

  @Test
  public void deleteQueue_removesQueue() {
    // Arrange
    SqsStore store = new SqsStore(4566);
    String queueName = "delete-me";
    store.createQueue(queueName, Map.of());

    // Act
    store.deleteQueue(queueName);

    // Assert
    assertNull(store.getQueue(queueName), "Expected store.getQueue(queueName) to be null");
  }

  @Test
  public void reset_clearsAllQueues() {
    // Arrange
    SqsStore store = new SqsStore(4566);
    store.createQueue("reset-queue", Map.of());

    // Act
    store.reset();

    // Assert
    assertEquals(
        0, store.listQueues(null).size(), "Expected store.listQueues(null).size() to match 0");
  }

  @Test
  public void sendMessage_returnsMessageId() {
    // Arrange
    SqsStore store = new SqsStore(4566);
    LocalQueue queue = store.createQueue("send-queue", Map.of());

    // Act
    String actualMessageId = queue.sendMessage("hello", 0);

    // Assert
    assertNotNull(actualMessageId, "Expected actualMessageId to not be null");
    assertFalse(actualMessageId.isEmpty(), "Expected actualMessageId to not be empty");
  }

  @Test
  public void receiveMessages_returnsSentMessage() {
    // Arrange
    SqsStore store = new SqsStore(4566);
    LocalQueue queue = store.createQueue("recv-queue", Map.of());
    queue.sendMessage("body-content", 0);

    // Act
    List<SqsStore.SqsMessage> actualMessages = queue.receiveMessages(10);

    // Assert
    assertEquals(1, actualMessages.size(), "Expected actualMessages.size() to match 1");
    assertEquals("body-content", actualMessages.get(0).body, "Expected values to match");
  }

  @Test
  public void deleteMessage_removesMessageByReceiptHandle() {
    // Arrange
    SqsStore store = new SqsStore(4566);
    LocalQueue queue = store.createQueue("del-msg-queue", Map.of());
    queue.sendMessage("to-delete", 0);
    List<SqsStore.SqsMessage> messages = queue.receiveMessages(1);
    String expectedReceiptHandle = messages.get(0).receiptHandle;

    // Act
    queue.deleteMessage(expectedReceiptHandle);

    // Assert
    assertFalse(
        queue.hasMessage(expectedReceiptHandle),
        "Expected condition to be false: queue.hasMessage(expectedReceiptHandle)");
  }

  @Test
  public void hasMessage_afterSend_returnsTrue() {
    // Arrange
    SqsStore store = new SqsStore(4566);
    LocalQueue queue = store.createQueue("has-msg-queue", Map.of());
    queue.sendMessage("body", 0);
    List<SqsStore.SqsMessage> messages = queue.receiveMessages(1);
    String expectedReceiptHandle = messages.get(0).receiptHandle;

    // Act
    boolean actualResult = queue.hasMessage(expectedReceiptHandle);

    // Assert
    assertTrue(actualResult, "Expected condition to be true: actualResult");
  }

  @Test
  public void hasMessage_nullReceiptHandle_returnsFalse() {
    // Arrange
    SqsStore store = new SqsStore(4566);
    LocalQueue queue = store.createQueue("no-msg-queue", Map.of());

    // Act
    boolean actualResult = queue.hasMessage(null);

    // Assert
    assertFalse(actualResult, "Expected condition to be false: actualResult");
  }

  @Test
  public void purge_removesAllMessages() {
    // Arrange
    SqsStore store = new SqsStore(4566);
    LocalQueue queue = store.createQueue("purge-queue", Map.of());
    queue.sendMessage("msg1", 0);
    queue.sendMessage("msg2", 0);
    int expectedCount = 0;

    // Act
    queue.purge();

    // Assert
    assertEquals(
        expectedCount,
        queue.approximateMessageCount(),
        "Expected queue.approximateMessageCount() to match expectedCount");
  }

  @Test
  public void changeVisibility_hidesMessageTemporarily() {
    // Arrange
    SqsStore store = new SqsStore(4566);
    LocalQueue queue = store.createQueue("vis-queue", Map.of());
    queue.sendMessage("body", 0);
    List<SqsStore.SqsMessage> messages = queue.receiveMessages(1);
    String receiptHandle = messages.get(0).receiptHandle;

    // Act
    queue.changeVisibility(receiptHandle, 30);

    // Assert — message should now be invisible (0 visible messages)
    assertEquals(
        0, queue.approximateMessageCount(), "Expected queue.approximateMessageCount() to match 0");
  }

  @Test
  public void setQueueTags_andGetQueueTags_roundTrip() {
    // Arrange
    SqsStore store = new SqsStore(4566);
    String queueName = "tagged-queue";
    store.createQueue(queueName, Map.of());
    String expectedKey = "env";
    String expectedValue = "prod";

    // Act
    store.setQueueTags(queueName, Map.of(expectedKey, expectedValue));
    Map<String, String> actualTags = store.getQueueTags(queueName);

    // Assert
    assertEquals(
        expectedValue,
        actualTags.get(expectedKey),
        "Expected actualTags.get(expectedKey) to equal expectedValue");
  }

  @Test
  public void removeQueueTags_removesSpecifiedKey() {
    // Arrange
    SqsStore store = new SqsStore(4566);
    String queueName = "untag-queue";
    store.createQueue(queueName, Map.of());
    store.setQueueTags(queueName, Map.of("env", "prod", "team", "platform"));

    // Act
    store.removeQueueTags(queueName, List.of("env"));

    // Assert
    Map<String, String> actualTags = store.getQueueTags(queueName);
    assertFalse(actualTags.containsKey("env"), "Expected map to not contain the key");
    assertTrue(actualTags.containsKey("team"), "Expected map to contain the expected key");
  }

  @Test
  public void getQueueTags_missingQueue_returnsEmptyMap() {
    // Arrange
    SqsStore store = new SqsStore(4566);
    int expectedSize = 0;

    // Act
    Map<String, String> actualTags = store.getQueueTags("nonexistent");

    // Assert
    assertEquals(
        expectedSize, actualTags.size(), "Expected actualTags.size() to match expectedSize");
  }

  @Test
  public void md5_returnsExpectedHex() {
    // Arrange
    String expectedMd5 = "5d41402abc4b2a76b9719d911017c592";

    // Act
    String actualMd5 = SqsStore.md5("hello");

    // Assert
    assertEquals(expectedMd5, actualMd5, "Expected actualMd5 to equal expectedMd5");
  }

  @Test
  public void createQueue_withVisibilityTimeout_setsTimeout() {
    // Arrange
    SqsStore store = new SqsStore(4566);
    int expectedTimeout = 60;

    // Act
    LocalQueue actualQueue =
        store.createQueue(
            "timeout-queue", Map.of("VisibilityTimeout", String.valueOf(expectedTimeout)));

    // Assert
    assertEquals(
        expectedTimeout,
        actualQueue.visibilityTimeout,
        "Expected actualQueue.visibilityTimeout to equal expectedTimeout");
  }

  @Test
  public void approximateMessageCount_countsOnlyVisibleMessages() {
    // Arrange
    SqsStore store = new SqsStore(4566);
    LocalQueue queue = store.createQueue("count-queue", Map.of());
    queue.sendMessage("visible", 0);
    int expectedCount = 1;

    // Act
    int actualCount = queue.approximateMessageCount();

    // Assert
    assertEquals(expectedCount, actualCount, "Expected actualCount to match expectedCount");
  }

  @Test
  public void createQueue_withFifoQueueAttribute_setsFifoTrue() {
    // Arrange
    SqsStore store = new SqsStore(4566);

    // Act — FifoQueue attribute set to "true" (not by name ending in .fifo)
    LocalQueue actualQueue = store.createQueue("my-queue", Map.of("FifoQueue", "true"));

    // Assert
    assertTrue(actualQueue.isFifo, "Expected condition to be true: actualQueue.isFifo");
  }

  @Test
  public void listQueues_withEmptyPrefix_returnsAll() {
    // Arrange
    SqsStore store = new SqsStore(4566);
    store.createQueue("queue-a", Map.of());
    store.createQueue("queue-b", Map.of());
    int expectedCount = 2;

    // Act — empty string prefix should return all queues
    List<SqsStore.LocalQueue> actualQueues = store.listQueues("");

    // Assert
    assertEquals(
        expectedCount, actualQueues.size(), "Expected actualQueues.size() to match expectedCount");
  }

  @Test
  public void deleteQueue_nonExistentQueue_doesNotThrow() {
    // Arrange
    SqsStore store = new SqsStore(4566);

    // Act — deleteQueue on non-existent should be no-op (queue == null branch)
    store.deleteQueue("ghost-queue");

    // Assert
    assertEquals(
        0, store.listQueues(null).size(), "Expected store.listQueues(null).size() to match 0");
  }

  @Test
  public void setQueueTags_nonExistentQueue_doesNotThrow() {
    // Arrange
    SqsStore store = new SqsStore(4566);

    // Act — queue == null branch in setQueueTags
    store.setQueueTags("nonexistent", Map.of("key", "value"));

    // Assert — no exception, store unchanged
    assertEquals(
        0, store.listQueues(null).size(), "Expected store.listQueues(null).size() to match 0");
  }

  @Test
  public void removeQueueTags_queueWithNoExistingTags_doesNotThrow() {
    // Arrange
    SqsStore store = new SqsStore(4566);
    store.createQueue("no-tags-queue", Map.of());

    // Act — existing == null branch in removeQueueTags
    store.removeQueueTags("no-tags-queue", List.of("env"));

    // Assert
    assertTrue(store.getQueueTags("no-tags-queue").isEmpty(), "Expected values to match");
  }
}
