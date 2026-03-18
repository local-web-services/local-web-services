package io.localwebservices.lws.unit.providers.sqs;

import static org.junit.jupiter.api.Assertions.*;

import io.localwebservices.lws.providers.sqs.SqsStore;
import java.util.Map;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class SqsStorePurgeTest {

  private SqsStore store;

  @BeforeEach
  void setUp() {
    store = new SqsStore(9324);
    store.reset();
    store.createQueue("my-queue", Map.of());
  }

  @Test
  void purge_clearsAllMessages() {
    // Arrange
    var queue = store.getQueue("my-queue");
    queue.sendMessage("msg-1", 0);
    queue.sendMessage("msg-2", 0);
    queue.sendMessage("msg-3", 0);

    // Act
    queue.purge();

    // Assert
    int actualCount = queue.approximateMessageCount();
    assertEquals(0, actualCount);
  }

  @Test
  void approximateMessageCount_afterPurge_returnsZero() {
    // Arrange
    var queue = store.getQueue("my-queue");
    queue.sendMessage("msg-1", 0);
    queue.sendMessage("msg-2", 0);
    queue.sendMessage("msg-3", 0);
    queue.purge();

    // Act
    int actualCount = queue.approximateMessageCount();

    // Assert
    assertEquals(0, actualCount);
  }

  @Test
  void md5_returnsCorrectHash() {
    // Arrange
    String expectedHash = "5d41402abc4b2a76b9719d911017c592";

    // Act
    String actualHash = SqsStore.md5("hello");

    // Assert
    assertEquals(expectedHash, actualHash);
  }
}
