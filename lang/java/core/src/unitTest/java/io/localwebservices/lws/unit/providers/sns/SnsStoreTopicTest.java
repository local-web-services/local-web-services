package io.localwebservices.lws.unit.providers.sns;

import static org.junit.jupiter.api.Assertions.*;

import io.localwebservices.lws.providers.sns.SnsStore;
import java.util.Map;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class SnsStoreTopicTest {

  private SnsStore store;

  @BeforeEach
  void setUp() {
    store = new SnsStore();
    store.reset();
  }

  @Test
  void topicArn_returnsCorrectFormat() {
    // Arrange
    String topicName = "my-topic";
    String expectedArn = "arn:aws:sns:us-east-1:000000000000:my-topic";

    // Act
    String actualArn = store.topicArn(topicName);

    // Assert
    assertEquals(expectedArn, actualArn);
  }

  @Test
  void topics_putAndGet_storesTopicData() {
    // Arrange
    String arn = "arn:aws:sns:us-east-1:000000000000:my-topic";

    // Act
    store.topics.put(arn, Map.<String, Object>of("TopicArn", arn));

    // Assert
    var actualTopic = store.topics.get(arn);
    assertNotNull(actualTopic);
  }

  @Test
  void reset_clearsAllTopics() {
    // Arrange
    String arn = "arn:aws:sns:us-east-1:000000000000:my-topic";
    store.topics.put(arn, Map.<String, Object>of("TopicArn", arn));

    // Act
    store.reset();

    // Assert
    assertTrue(store.topics.isEmpty());
  }

  @Test
  void reset_clearsAllSubscriptions() {
    // Arrange
    String subArn = "arn:aws:sns:us-east-1:000000000000:my-topic:sub-1";
    store.subscriptions.put(subArn, Map.<String, Object>of("SubscriptionArn", subArn));

    // Act
    store.reset();

    // Assert
    assertTrue(store.subscriptions.isEmpty());
  }
}
