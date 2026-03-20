package io.localwebservices.lws.unit.providers.sns;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.localwebservices.lws.providers.sns.SnsStore;
import java.util.Map;
import org.junit.jupiter.api.Test;

public class SnsStoreTest {

  @Test
  public void topicArn_containsRegionAccountAndName() {
    // Arrange
    SnsStore store = new SnsStore();
    String topicName = "my-topic";
    String expectedAccount = "000000000000";
    String expectedRegion = "us-east-1";

    // Act
    String actualArn = store.topicArn(topicName);

    // Assert
    assertTrue(actualArn.contains(expectedAccount), "Expected value to contain expected substring");
    assertTrue(actualArn.contains(expectedRegion), "Expected value to contain expected substring");
    assertTrue(actualArn.contains(topicName), "Expected value to contain expected substring");
  }

  @Test
  public void reset_clearsAllMaps() {
    // Arrange
    SnsStore store = new SnsStore();
    String topicArn = store.topicArn("reset-topic");
    store.topics.put(topicArn, Map.of("TopicArn", topicArn));
    store.subscriptions.put("sub-1", Map.of("SubscriptionArn", "sub-1"));

    // Act
    store.reset();

    // Assert
    assertFalse(store.topics.containsKey(topicArn), "Expected map to not contain the key");
    assertFalse(store.subscriptions.containsKey("sub-1"), "Expected map to not contain the key");
  }

  @Test
  public void topics_storeAndRetrieveByArn() {
    // Arrange
    SnsStore store = new SnsStore();
    String topicArn = store.topicArn("test-topic");

    // Act
    store.topics.put(topicArn, Map.of("TopicArn", topicArn));

    // Assert
    assertTrue(store.topics.containsKey(topicArn), "Expected map to contain the expected key");
  }
}
