package io.localwebservices.lws.unit.providers.apigateway;

import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.localwebservices.lws.providers.apigateway.ApiGatewayStore;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import org.junit.jupiter.api.Test;

public class ApiGatewayStoreResourceTest {

  @Test
  public void resources_computeIfAbsent_createsNestedMap() {
    // Arrange
    ApiGatewayStore store = new ApiGatewayStore();
    String apiId = "api1";
    String expectedResourceId = "res1";

    // Act
    store
        .resources
        .computeIfAbsent(apiId, k -> new ConcurrentHashMap<>())
        .put(expectedResourceId, Map.of("id", expectedResourceId));

    // Assert
    assertNotNull(store.resources.get(apiId).get(expectedResourceId), "Expected store.resources.get(apiId).get(expectedResourceId) to not be null");
  }

  @Test
  public void resources_remove_deletesResource() {
    // Arrange
    ApiGatewayStore store = new ApiGatewayStore();
    String apiId = "api1";
    String resourceId = "res1";
    store
        .resources
        .computeIfAbsent(apiId, k -> new ConcurrentHashMap<>())
        .put(resourceId, Map.of("id", resourceId));

    // Act
    store.resources.get(apiId).remove(resourceId);

    // Assert
    assertNull(store.resources.get(apiId).get(resourceId), "Expected store.resources.get(apiId).get(resourceId) to be null");
  }

  @Test
  public void reset_clearsResources() {
    // Arrange
    ApiGatewayStore store = new ApiGatewayStore();
    store
        .resources
        .computeIfAbsent("api1", k -> new ConcurrentHashMap<>())
        .put("res1", Map.of("id", "res1"));

    // Act
    store.reset();

    // Assert
    assertTrue(store.resources.isEmpty(), "Expected store.resources to be empty");
  }
}
