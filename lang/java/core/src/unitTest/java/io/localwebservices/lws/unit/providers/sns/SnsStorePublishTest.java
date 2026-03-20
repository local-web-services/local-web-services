package io.localwebservices.lws.unit.providers.sns;

import static org.junit.jupiter.api.Assertions.*;

import io.localwebservices.lws.providers.sns.SnsStore;
import java.util.Map;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class SnsStorePublishTest {

  private SnsStore store;

  @BeforeEach
  void setUp() {
    store = new SnsStore();
    store.reset();
  }

  @Test
  void topics_afterPut_containsKey() {
    // Arrange
    String arn = store.topicArn("my-topic");
    Map<String, Object> topicMap = Map.of("TopicArn", arn);

    // Act
    store.topics.put(arn, topicMap);

    // Assert
    assertTrue(store.topics.containsKey(arn), "Expected map to contain the expected key");
  }

  @Test
  void topicArn_differentNames_returnsDifferentArns() {
    // Arrange
    String firstName = "topic-alpha";
    String secondName = "topic-beta";

    // Act
    String actualFirstArn = store.topicArn(firstName);
    String actualSecondArn = store.topicArn(secondName);

    // Assert
    assertNotEquals(actualFirstArn, actualSecondArn, "Expected actualFirstArn and actualSecondArn to differ");
  }

  @Test
  void topics_afterRemove_doesNotContainKey() {
    // Arrange
    String arn = store.topicArn("my-topic");
    store.topics.put(arn, Map.<String, Object>of("TopicArn", arn));

    // Act
    store.topics.remove(arn);

    // Assert
    assertFalse(store.topics.containsKey(arn), "Expected map to not contain the key");
  }
}
