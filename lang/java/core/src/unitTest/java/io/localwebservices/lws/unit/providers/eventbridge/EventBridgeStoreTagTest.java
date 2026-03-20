package io.localwebservices.lws.unit.providers.eventbridge;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.localwebservices.lws.providers.eventbridge.EventBridgeStore;
import java.util.List;
import java.util.Map;
import org.junit.jupiter.api.Test;

public class EventBridgeStoreTagTest {

  @Test
  public void resourceTags_putAndGet_storesTagList() {
    // Arrange
    EventBridgeStore store = new EventBridgeStore();
    String expectedArn = "arn:x";
    int expectedTagCount = 1;

    // Act
    store.resourceTags.put(expectedArn, List.of(Map.of("Key", "env", "Value", "prod")));

    // Assert
    int actualTagCount = store.resourceTags.get(expectedArn).size();
    assertEquals(
        expectedTagCount, actualTagCount, "Expected actualTagCount to match expectedTagCount");
  }

  @Test
  public void reset_clearsResourceTags() {
    // Arrange
    EventBridgeStore store = new EventBridgeStore();
    store.resourceTags.put("arn:x", List.of(Map.of("Key", "env", "Value", "prod")));

    // Act
    store.reset();

    // Assert
    assertTrue(store.resourceTags.isEmpty(), "Expected store.resourceTags to be empty");
  }
}
