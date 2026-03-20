package io.localwebservices.lws.unit.providers.eventbridge;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.localwebservices.lws.providers.eventbridge.EventBridgeStore;
import java.util.Map;
import org.junit.jupiter.api.Test;

public class EventBridgeStoreEventBusTest {

  @Test
  public void constructor_createsDefaultEventBus() {
    // Arrange (none)

    // Act
    EventBridgeStore store = new EventBridgeStore();

    // Assert
    assertTrue(store.eventBuses.containsKey("default"), "Expected map to contain the expected key");
  }

  @Test
  public void eventBuses_put_storesCustomBus() {
    // Arrange
    EventBridgeStore store = new EventBridgeStore();
    String expectedBusName = "my-bus";

    // Act
    store.eventBuses.put(expectedBusName, Map.of("Name", expectedBusName));

    // Assert
    assertTrue(
        store.eventBuses.containsKey(expectedBusName), "Expected map to contain the expected key");
  }

  @Test
  public void reset_clearsCustomBus() {
    // Arrange
    EventBridgeStore store = new EventBridgeStore();
    String expectedBusName = "my-bus";
    store.eventBuses.put(expectedBusName, Map.of("Name", expectedBusName));

    // Act
    store.reset();

    // Assert
    assertFalse(
        store.eventBuses.containsKey(expectedBusName), "Expected map to not contain the key");
  }

  @Test
  public void reset_recreatesDefaultBus() {
    // Arrange
    EventBridgeStore store = new EventBridgeStore();
    store.eventBuses.put("my-bus", Map.of("Name", "my-bus"));

    // Act
    store.reset();

    // Assert
    assertTrue(store.eventBuses.containsKey("default"), "Expected map to contain the expected key");
  }
}
