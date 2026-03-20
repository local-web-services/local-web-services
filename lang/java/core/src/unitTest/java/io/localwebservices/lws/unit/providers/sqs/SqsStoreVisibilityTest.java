package io.localwebservices.lws.unit.providers.sqs;

import static org.junit.jupiter.api.Assertions.*;

import io.localwebservices.lws.providers.sqs.SqsStore;
import java.util.Map;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class SqsStoreVisibilityTest {

  private SqsStore store;

  @BeforeEach
  void setUp() {
    store = new SqsStore(9324);
    store.reset();
  }

  @Test
  void receiveMessages_setsMessageInvisible() {
    // Arrange
    store.createQueue("my-queue", Map.of("VisibilityTimeout", "30"));
    var queue = store.getQueue("my-queue");
    queue.sendMessage("hello", 0);
    queue.receiveMessages(1);

    // Act
    var actualMessages = queue.receiveMessages(1);

    // Assert
    assertEquals(0, actualMessages.size(), "Expected actualMessages.size() to match 0");
  }

  @Test
  void changeVisibility_toZero_makesMessageVisibleImmediately() {
    // Arrange
    store.createQueue("my-queue", Map.of("VisibilityTimeout", "30"));
    var queue = store.getQueue("my-queue");
    queue.sendMessage("hello", 0);
    var firstReceive = queue.receiveMessages(1);
    String receiptHandle = firstReceive.get(0).receiptHandle;

    // Act
    queue.changeVisibility(receiptHandle, 0);

    // Assert
    var actualMessages = queue.receiveMessages(1);
    assertEquals(1, actualMessages.size(), "Expected actualMessages.size() to match 1");
  }

  @Test
  void hasMessage_validReceiptHandle_returnsTrue() {
    // Arrange
    store.createQueue("my-queue", Map.of());
    var queue = store.getQueue("my-queue");
    queue.sendMessage("hello", 0);
    var messages = queue.receiveMessages(1);
    String receiptHandle = messages.get(0).receiptHandle;

    // Act
    boolean actualHasMessage = queue.hasMessage(receiptHandle);

    // Assert
    assertTrue(actualHasMessage, "Expected condition to be true: actualHasMessage");
  }

  @Test
  void hasMessage_unknownReceiptHandle_returnsFalse() {
    // Arrange
    store.createQueue("my-queue", Map.of());
    var queue = store.getQueue("my-queue");

    // Act
    boolean actualHasMessage = queue.hasMessage("fake-receipt-handle");

    // Assert
    assertFalse(actualHasMessage, "Expected condition to be false: actualHasMessage");
  }
}
