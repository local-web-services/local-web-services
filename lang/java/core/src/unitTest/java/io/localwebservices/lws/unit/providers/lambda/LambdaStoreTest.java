package io.localwebservices.lws.unit.providers.lambda;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.localwebservices.lws.providers.lambda.LambdaStore;
import java.util.Map;
import org.junit.jupiter.api.Test;

public class LambdaStoreTest {

  @Test
  public void reset_clearsAllMaps() {
    // Arrange
    LambdaStore store = new LambdaStore();
    String functionName = "my-function";
    store.functions.put(functionName, Map.of("FunctionName", functionName));
    store.permissions.put(functionName, java.util.List.of());
    store.eventSourceMappings.put("uuid-1", Map.of("UUID", "uuid-1"));

    // Act
    store.reset();

    // Assert
    assertFalse(store.functions.containsKey(functionName), "Expected map to not contain the key");
    assertFalse(store.permissions.containsKey(functionName), "Expected map to not contain the key");
    assertFalse(store.eventSourceMappings.containsKey("uuid-1"), "Expected map to not contain the key");
  }

  @Test
  public void functions_storeAndRetrieveByKey() {
    // Arrange
    LambdaStore store = new LambdaStore();
    String expectedName = "hello-function";

    // Act
    store.functions.put(expectedName, Map.of("FunctionName", expectedName));

    // Assert
    assertTrue(store.functions.containsKey(expectedName), "Expected map to contain the expected key");
  }

  @Test
  public void eventSourceMappings_storeAndRetrieveByKey() {
    // Arrange
    LambdaStore store = new LambdaStore();
    String expectedUuid = "esmapping-uuid";

    // Act
    store.eventSourceMappings.put(expectedUuid, Map.of("UUID", expectedUuid));

    // Assert
    assertTrue(store.eventSourceMappings.containsKey(expectedUuid), "Expected map to contain the expected key");
  }
}
