package io.localwebservices.lws.unit.providers.sqs;

import static org.junit.jupiter.api.Assertions.*;

import io.localwebservices.lws.providers.sqs.SqsStore;
import java.util.Map;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class SqsStoreSendReceiveTest {

  private SqsStore store;

  @BeforeEach
  void setUp() {
    store = new SqsStore(9324);
    store.reset();
    store.createQueue("my-queue", Map.of());
  }

  @Test
  void sendMessage_returnsMessageId() {
    // Arrange
    var queue = store.getQueue("my-queue");

    // Act
    String actualMessageId = queue.sendMessage("hello", 0);

    // Assert
    assertNotNull(actualMessageId);
  }

  @Test
  void receiveMessages_afterSend_returnsMessage() {
    // Arrange
    var queue = store.getQueue("my-queue");
    queue.sendMessage("hello", 0);

    // Act
    var actualMessages = queue.receiveMessages(1);

    // Assert
    assertEquals(1, actualMessages.size());
    assertEquals("hello", actualMessages.get(0).body);
  }

  @Test
  void receiveMessages_emptyQueue_returnsEmptyList() {
    // Arrange
    var queue = store.getQueue("my-queue");

    // Act
    var actualMessages = queue.receiveMessages(1);

    // Assert
    assertEquals(0, actualMessages.size());
  }

  @Test
  void deleteMessage_removesMessage() {
    // Arrange
    var queue = store.getQueue("my-queue");
    queue.sendMessage("hello", 0);
    var messages = queue.receiveMessages(1);
    String receiptHandle = messages.get(0).receiptHandle;

    // Act
    queue.deleteMessage(receiptHandle);

    // Assert
    boolean actualHasMessage = queue.hasMessage(receiptHandle);
    assertFalse(actualHasMessage);
  }

  @Test
  void approximateMessageCount_afterSend_returnsOne() {
    // Arrange
    var queue = store.getQueue("my-queue");
    queue.sendMessage("hello", 0);

    // Act
    int actualCount = queue.approximateMessageCount();

    // Assert
    assertEquals(1, actualCount);
  }
}
