package io.localwebservices.lws.unit.providers.apigateway;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.localwebservices.lws.providers.apigateway.ApiGatewayStore;
import java.util.Map;
import org.junit.jupiter.api.Test;

public class ApiGatewayStoreTest {

  @Test
  public void shortId_returnsNonNullString() {
    // Arrange (none required — static utility)

    // Act
    String actualId = ApiGatewayStore.shortId();

    // Assert
    assertNotNull(actualId, "Expected actualId to not be null");
    assertFalse(actualId.isEmpty(), "Expected actualId to not be empty");
  }

  @Test
  public void reset_clearsAllMaps() {
    // Arrange
    ApiGatewayStore store = new ApiGatewayStore();
    String expectedApiId = "api-123";
    store.apis.put(expectedApiId, Map.of("id", expectedApiId));
    store.resources.put(expectedApiId, Map.of("res-1", Map.of("id", "res-1")));
    store.deployments.put(expectedApiId, Map.of("dep-1", Map.of("id", "dep-1")));
    store.stages.put(expectedApiId, Map.of("prod", Map.of("stageName", "prod")));

    // Act
    store.reset();

    // Assert
    assertFalse(store.apis.containsKey(expectedApiId), "Expected map to not contain the key");
    assertFalse(store.resources.containsKey(expectedApiId), "Expected map to not contain the key");
    assertFalse(store.deployments.containsKey(expectedApiId), "Expected map to not contain the key");
    assertFalse(store.stages.containsKey(expectedApiId), "Expected map to not contain the key");
  }

  @Test
  public void apis_storeAndRetrieveByKey() {
    // Arrange
    ApiGatewayStore store = new ApiGatewayStore();
    String expectedApiId = "test-api";

    // Act
    store.apis.put(expectedApiId, Map.of("id", expectedApiId));

    // Assert
    assertTrue(store.apis.containsKey(expectedApiId), "Expected map to contain the expected key");
  }
}
