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
    assertNotNull(actualQueue, "Expected actualQueue to not be null");
  }

  @Test
  void createQueue_returnsQueueWithCorrectName() {
    // Arrange
    String expectedName = "my-queue";

    // Act
    store.createQueue(expectedName, Map.of());

    // Assert
    var actualQueue = store.getQueue(expectedName);
    assertNotNull(actualQueue, "Expected actualQueue to not be null");
    assertEquals(expectedName, actualQueue.name, "Expected actualQueue.name to equal expectedName");
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
    assertEquals(1, actualSize, "Expected actualSize to match 1");
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
    assertNotNull(actualQueue, "Expected actualQueue to not be null");
  }

  @Test
  void listQueues_withPrefix_filtersQueues() {
    // Arrange
    store.createQueue("abc-queue", Map.of());
    store.createQueue("xyz-queue", Map.of());

    // Act
    List<?> actualQueues = store.listQueues("abc");

    // Assert
    assertEquals(1, actualQueues.size(), "Expected actualQueues.size() to match 1");
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
    assertNull(actualQueue, "Expected actualQueue to be null");
  }

  @Test
  void reset_clearsAllQueues() {
    // Arrange
    store.createQueue("my-queue", Map.of());

    // Act
    store.reset();

    // Assert
    List<?> actualQueues = store.listQueues(null);
    assertTrue(actualQueues.isEmpty(), "Expected actualQueues to be empty");
  }
}
