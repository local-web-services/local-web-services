package io.localwebservices.lws.unit.providers.sns;

import static org.junit.jupiter.api.Assertions.*;

import io.localwebservices.lws.providers.sns.SnsStore;
import java.util.List;
import java.util.Map;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class SnsStoreSubscriptionTest {

  private SnsStore store;

  @BeforeEach
  void setUp() {
    store = new SnsStore();
    store.reset();
  }

  @Test
  void subscriptions_put_storesData() {
    // Arrange
    String subArn = "arn:aws:sns:us-east-1:000000000000:my-topic:sub-1";

    // Act
    store.subscriptions.put(subArn, Map.<String, Object>of("SubscriptionArn", subArn));

    // Assert
    var actualSubscription = store.subscriptions.get(subArn);
    assertNotNull(actualSubscription);
  }

  @Test
  void subscriptionAttrs_put_storesAttrs() {
    // Arrange
    String subArn = "arn:aws:sns:us-east-1:000000000000:my-topic:sub-1";

    // Act
    store.subscriptionAttrs.put(subArn, Map.of("RawMessageDelivery", "true"));

    // Assert
    var actualAttrs = store.subscriptionAttrs.get(subArn);
    assertNotNull(actualAttrs);
  }

  @Test
  void resourceTags_put_storesTagList() {
    // Arrange
    String arn = "arn:aws:sns:us-east-1:000000000000:my-topic";

    // Act
    store.resourceTags.put(arn, List.of(Map.of("Key", "env", "Value", "prod")));

    // Assert
    var actualTags = store.resourceTags.get(arn);
    assertNotNull(actualTags);
  }

  @Test
  void reset_clearsSubscriptionAttrs() {
    // Arrange
    String subArn = "arn:aws:sns:us-east-1:000000000000:my-topic:sub-1";
    store.subscriptionAttrs.put(subArn, Map.of("RawMessageDelivery", "true"));

    // Act
    store.reset();

    // Assert
    assertTrue(store.subscriptionAttrs.isEmpty());
  }
}
