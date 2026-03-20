package io.localwebservices.lws.unit.providers.eventbridge;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.localwebservices.lws.providers.eventbridge.EventBridgeStore;
import java.util.List;
import java.util.Map;
import org.junit.jupiter.api.Test;

public class EventBridgeStoreTest {

  @Test
  public void constructor_initializesDefaultBus() {
    // Arrange (none)

    // Act
    EventBridgeStore store = new EventBridgeStore();

    // Assert
    assertTrue(store.eventBuses.containsKey("default"), "Expected map to contain the expected key");
  }

  @Test
  public void reset_clearsCustomBusesAndRulesAndRestoresDefaultBus() {
    // Arrange
    EventBridgeStore store = new EventBridgeStore();
    store.eventBuses.put("custom-bus", Map.of("Name", "custom-bus"));
    store.rules.put("rule-1", Map.of("Name", "rule-1"));
    store.ruleTargets.put("rule-1", List.of(Map.of("Id", "t1")));

    // Act
    store.reset();

    // Assert
    assertFalse(store.eventBuses.containsKey("custom-bus"), "Expected map to not contain the key");
    assertFalse(store.rules.containsKey("rule-1"), "Expected map to not contain the key");
    assertFalse(store.ruleTargets.containsKey("rule-1"), "Expected map to not contain the key");
    assertTrue(store.eventBuses.containsKey("default"), "Expected map to contain the expected key");
  }

  @Test
  public void rules_storeAndRetrieveByKey() {
    // Arrange
    EventBridgeStore store = new EventBridgeStore();
    String expectedRuleName = "my-rule";

    // Act
    store.rules.put(expectedRuleName, Map.of("Name", expectedRuleName));

    // Assert
    assertTrue(store.rules.containsKey(expectedRuleName), "Expected map to contain the expected key");
  }
}
