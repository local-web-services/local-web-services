package io.localwebservices.lws.unit.providers.apigateway;

import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;

import io.localwebservices.lws.providers.apigateway.ApiGatewayStore;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import org.junit.jupiter.api.Test;

public class ApiGatewayStoreIntegrationTest {

  @Test
  public void resources_putIntegration_storesInNestedMap() {
    // Arrange
    ApiGatewayStore store = new ApiGatewayStore();
    String apiId = "api1";
    String resourceId = "res1";
    Map<String, Object> integrationData = new HashMap<>();
    integrationData.put("type", "AWS_PROXY");
    integrationData.put("uri", "arn:aws:lambda:us-east-1:123:function:my-fn");
    Map<String, Object> resourceData = new HashMap<>();
    resourceData.put("id", resourceId);
    resourceData.put("integration", integrationData);

    // Act
    store
        .resources
        .computeIfAbsent(apiId, k -> new ConcurrentHashMap<>())
        .put(resourceId, resourceData);

    // Assert
    assertNotNull(store.resources.get(apiId).get(resourceId).get("integration"));
  }

  @Test
  public void resources_removeIntegration_removesFromNestedMap() {
    // Arrange
    ApiGatewayStore store = new ApiGatewayStore();
    String apiId = "api1";
    String resourceId = "res1";
    Map<String, Object> resourceData = new HashMap<>();
    resourceData.put("id", resourceId);
    resourceData.put("integration", Map.of("type", "AWS_PROXY"));
    store
        .resources
        .computeIfAbsent(apiId, k -> new ConcurrentHashMap<>())
        .put(resourceId, resourceData);

    // Act
    store.resources.get(apiId).get(resourceId).remove("integration");

    // Assert
    assertNull(store.resources.get(apiId).get(resourceId).get("integration"));
  }
}
