package io.localwebservices.lws.unit.providers.sqs;

import static org.junit.jupiter.api.Assertions.*;

import io.localwebservices.lws.providers.sqs.SqsStore;
import java.util.List;
import java.util.Map;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class SqsStoreCreateQueueTest {

  private SqsStore store;

  @BeforeEach
  void setUp() {
    store = new SqsStore(9324);
    store.reset();
  }

  @Test
  void createQueue_newName_storesQueue() {
    // Arrange
    String queueName = "my-queue";

    // Act
    store.createQueue(queueName, Map.of());

    // Assert
    var actualQueue = store.getQueue(queueName);
    assertNotNull(actualQueue);
  }

  @Test
  void createQueue_returnsQueueWithCorrectName() {
    // Arrange
    String expectedName = "my-queue";

    // Act
    store.createQueue(expectedName, Map.of());

    // Assert
    var actualQueue = store.getQueue(expectedName);
    assertNotNull(actualQueue);
    assertEquals(expectedName, actualQueue.name);
  }

  @Test
  void createQueue_generatesSqsUrl() {
    // Arrange
    String queueName = "my-queue";

    // Act
    store.createQueue(queueName, Map.of());

    // Assert
    String actualUrl = store.queueUrl(queueName);
    assertTrue(actualUrl.contains("127.0.0.1:9324"), "URL should contain host and port");
    assertTrue(actualUrl.contains("my-queue"), "URL should contain queue name");
  }

  @Test
  void createQueue_idempotent_returnsExistingOnRecreate() {
    // Arrange
    String queueName = "my-queue";
    store.createQueue(queueName, Map.of());

    // Act
    store.createQueue(queueName, Map.of());

    // Assert
    int actualSize = store.listQueues(null).size();
    assertEquals(1, actualSize);
  }

  @Test
  void getQueue_byUrl_returnsQueue() {
    // Arrange
    String queueName = "my-queue";
    store.createQueue(queueName, Map.of());
    String url = store.queueUrl(queueName);

    // Act
    var actualQueue = store.getQueue(url);

    // Assert
    assertNotNull(actualQueue);
  }

  @Test
  void listQueues_withPrefix_filtersQueues() {
    // Arrange
    store.createQueue("abc-queue", Map.of());
    store.createQueue("xyz-queue", Map.of());

    // Act
    List<?> actualQueues = store.listQueues("abc");

    // Assert
    assertEquals(1, actualQueues.size());
  }

  @Test
  void deleteQueue_removesQueue() {
    // Arrange
    String queueName = "my-queue";
    store.createQueue(queueName, Map.of());

    // Act
    store.deleteQueue(queueName);

    // Assert
    var actualQueue = store.getQueue(queueName);
    assertNull(actualQueue);
  }

  @Test
  void reset_clearsAllQueues() {
    // Arrange
    store.createQueue("my-queue", Map.of());

    // Act
    store.reset();

    // Assert
    List<?> actualQueues = store.listQueues(null);
    assertTrue(actualQueues.isEmpty());
  }
}
