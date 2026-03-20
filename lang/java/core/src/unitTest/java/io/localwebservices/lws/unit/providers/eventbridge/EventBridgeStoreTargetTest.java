package io.localwebservices.lws.unit.providers.eventbridge;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.localwebservices.lws.providers.eventbridge.EventBridgeStore;
import java.util.List;
import java.util.Map;
import org.junit.jupiter.api.Test;

public class EventBridgeStoreTargetTest {

  @Test
  public void ruleTargets_putAndGet_storesTargetList() {
    // Arrange
    EventBridgeStore store = new EventBridgeStore();
    String expectedRuleName = "my-rule";
    int expectedTargetCount = 1;

    // Act
    store.ruleTargets.put(expectedRuleName, List.of(Map.of("Id", "t1", "Arn", "arn:x")));

    // Assert
    int actualTargetCount = store.ruleTargets.get(expectedRuleName).size();
    assertEquals(
        expectedTargetCount,
        actualTargetCount,
        "Expected actualTargetCount to match expectedTargetCount");
  }

  @Test
  public void ruleTargets_remove_deletesTargets() {
    // Arrange
    EventBridgeStore store = new EventBridgeStore();
    String expectedRuleName = "my-rule";
    store.ruleTargets.put(expectedRuleName, List.of(Map.of("Id", "t1", "Arn", "arn:x")));

    // Act
    store.ruleTargets.remove(expectedRuleName);

    // Assert
    assertNull(
        store.ruleTargets.get(expectedRuleName),
        "Expected store.ruleTargets.get(expectedRuleName) to be null");
  }

  @Test
  public void reset_clearsRuleTargets() {
    // Arrange
    EventBridgeStore store = new EventBridgeStore();
    store.ruleTargets.put("my-rule", List.of(Map.of("Id", "t1", "Arn", "arn:x")));

    // Act
    store.reset();

    // Assert
    assertTrue(store.ruleTargets.isEmpty(), "Expected store.ruleTargets to be empty");
  }
}
