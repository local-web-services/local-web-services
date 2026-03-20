package io.localwebservices.lws.unit.providers.lambda;

import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.localwebservices.lws.providers.lambda.LambdaStore;
import java.util.Map;
import org.junit.jupiter.api.Test;

public class LambdaStoreEventSourceTest {

  @Test
  public void eventSourceMappings_put_storesMappingData() {
    // Arrange
    LambdaStore store = new LambdaStore();
    String expectedUuid = "uuid-1";
    String expectedArn = "arn:x";

    // Act
    store.eventSourceMappings.put(
        expectedUuid, Map.of("UUID", expectedUuid, "FunctionArn", expectedArn));

    // Assert
    assertNotNull(
        store.eventSourceMappings.get(expectedUuid),
        "Expected store.eventSourceMappings.get(expectedUuid) to not be null");
  }

  @Test
  public void eventSourceMappings_remove_deletesMapping() {
    // Arrange
    LambdaStore store = new LambdaStore();
    String uuid = "uuid-1";
    store.eventSourceMappings.put(uuid, Map.of("UUID", uuid, "FunctionArn", "arn:x"));

    // Act
    store.eventSourceMappings.remove(uuid);

    // Assert
    assertNull(
        store.eventSourceMappings.get(uuid),
        "Expected store.eventSourceMappings.get(uuid) to be null");
  }

  @Test
  public void reset_clearsEventSourceMappings() {
    // Arrange
    LambdaStore store = new LambdaStore();
    store.eventSourceMappings.put("uuid-1", Map.of("UUID", "uuid-1", "FunctionArn", "arn:x"));

    // Act
    store.reset();

    // Assert
    assertTrue(
        store.eventSourceMappings.isEmpty(), "Expected store.eventSourceMappings to be empty");
  }
}
