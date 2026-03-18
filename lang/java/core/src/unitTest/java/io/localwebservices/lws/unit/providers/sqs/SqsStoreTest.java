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
    assertTrue(actualUrl.contains("4566"));
    assertTrue(actualUrl.contains(expectedAccount));
    assertTrue(actualUrl.contains(expectedName));
  }

  @Test
  public void createQueue_returnsQueueWithUrl() {
    // Arrange
    SqsStore store = new SqsStore(4566);
    String expectedName = "created-queue";

    // Act
    LocalQueue actualQueue = store.createQueue(expectedName, Map.of());

    // Assert
    assertNotNull(actualQueue);
    assertEquals(expectedName, actualQueue.name);
    assertNotNull(actualQueue.url);
  }

  @Test
  public void createQueue_fifoQueueByName_setsFifoTrue() {
    // Arrange
    SqsStore store = new SqsStore(4566);

    // Act
    LocalQueue actualQueue = store.createQueue("orders.fifo", Map.of());

    // Assert
    assertTrue(actualQueue.isFifo);
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
    assertNotNull(actualQueue);
    assertEquals(expectedName, actualQueue.name);
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
    assertNotNull(actualQueue);
    assertEquals(queueName, actualQueue.name);
  }

  @Test
  public void getQueue_nullInput_returnsNull() {
    // Arrange
    SqsStore store = new SqsStore(4566);

    // Act
    LocalQueue actualQueue = store.getQueue(null);

    // Assert
    assertNull(actualQueue);
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
    assertEquals(expectedCount, actualQueues.size());
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
    assertEquals(expectedCount, actualQueues.size());
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
    assertNull(store.getQueue(queueName));
  }

  @Test
  public void reset_clearsAllQueues() {
    // Arrange
    SqsStore store = new SqsStore(4566);
    store.createQueue("reset-queue", Map.of());

    // Act
    store.reset();

    // Assert
    assertEquals(0, store.listQueues(null).size());
  }

  @Test
  public void sendMessage_returnsMessageId() {
    // Arrange
    SqsStore store = new SqsStore(4566);
    LocalQueue queue = store.createQueue("send-queue", Map.of());

    // Act
    String actualMessageId = queue.sendMessage("hello", 0);

    // Assert
    assertNotNull(actualMessageId);
    assertFalse(actualMessageId.isEmpty());
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
    assertEquals(1, actualMessages.size());
    assertEquals("body-content", actualMessages.get(0).body);
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
    assertFalse(queue.hasMessage(expectedReceiptHandle));
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
    assertTrue(actualResult);
  }

  @Test
  public void hasMessage_nullReceiptHandle_returnsFalse() {
    // Arrange
    SqsStore store = new SqsStore(4566);
    LocalQueue queue = store.createQueue("no-msg-queue", Map.of());

    // Act
    boolean actualResult = queue.hasMessage(null);

    // Assert
    assertFalse(actualResult);
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
    assertEquals(expectedCount, queue.approximateMessageCount());
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
    assertEquals(0, queue.approximateMessageCount());
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
    assertEquals(expectedValue, actualTags.get(expectedKey));
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
    assertFalse(actualTags.containsKey("env"));
    assertTrue(actualTags.containsKey("team"));
  }

  @Test
  public void getQueueTags_missingQueue_returnsEmptyMap() {
    // Arrange
    SqsStore store = new SqsStore(4566);
    int expectedSize = 0;

    // Act
    Map<String, String> actualTags = store.getQueueTags("nonexistent");

    // Assert
    assertEquals(expectedSize, actualTags.size());
  }

  @Test
  public void md5_returnsExpectedHex() {
    // Arrange
    String expectedMd5 = "5d41402abc4b2a76b9719d911017c592";

    // Act
    String actualMd5 = SqsStore.md5("hello");

    // Assert
    assertEquals(expectedMd5, actualMd5);
  }

  @Test
  public void createQueue_withVisibilityTimeout_setsTimeout() {
    // Arrange
    SqsStore store = new SqsStore(4566);
    int expectedTimeout = 60;

    // Act
    LocalQueue actualQueue =
        store.createQueue("timeout-queue", Map.of("VisibilityTimeout", String.valueOf(expectedTimeout)));

    // Assert
    assertEquals(expectedTimeout, actualQueue.visibilityTimeout);
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
    assertEquals(expectedCount, actualCount);
  }
}
