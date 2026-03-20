package io.localwebservices.lws.unit.providers.eventbridge;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.localwebservices.lws.providers.eventbridge.EventBridgeStore;
import java.util.Map;
import org.junit.jupiter.api.Test;

public class EventBridgeStoreRuleTest {

  @Test
  public void rules_putAndGet_storesRuleData() {
    // Arrange
    EventBridgeStore store = new EventBridgeStore();
    String expectedRuleName = "my-rule";
    String expectedRuleState = "ENABLED";

    // Act
    store.rules.put(expectedRuleName, Map.of("Name", expectedRuleName, "State", expectedRuleState));

    // Assert
    assertNotNull(
        store.rules.get(expectedRuleName),
        "Expected store.rules.get(expectedRuleName) to not be null");
  }

  @Test
  public void rules_remove_deletesRule() {
    // Arrange
    EventBridgeStore store = new EventBridgeStore();
    String expectedRuleName = "my-rule";
    store.rules.put(expectedRuleName, Map.of("Name", expectedRuleName, "State", "ENABLED"));

    // Act
    store.rules.remove(expectedRuleName);

    // Assert
    assertNull(
        store.rules.get(expectedRuleName), "Expected store.rules.get(expectedRuleName) to be null");
  }

  @Test
  public void reset_clearsRules() {
    // Arrange
    EventBridgeStore store = new EventBridgeStore();
    store.rules.put("my-rule", Map.of("Name", "my-rule", "State", "ENABLED"));

    // Act
    store.reset();

    // Assert
    assertTrue(store.rules.isEmpty(), "Expected store.rules to be empty");
  }

  @Test
  public void rules_multipleRules_allAccessible() {
    // Arrange
    EventBridgeStore store = new EventBridgeStore();
    String expectedRuleOne = "r1";
    String expectedRuleTwo = "r2";
    int expectedRuleCount = 2;

    // Act
    store.rules.put(expectedRuleOne, Map.of("Name", expectedRuleOne));
    store.rules.put(expectedRuleTwo, Map.of("Name", expectedRuleTwo));

    // Assert
    int actualRuleCount = store.rules.size();
    assertEquals(
        expectedRuleCount, actualRuleCount, "Expected actualRuleCount to match expectedRuleCount");
  }
}
