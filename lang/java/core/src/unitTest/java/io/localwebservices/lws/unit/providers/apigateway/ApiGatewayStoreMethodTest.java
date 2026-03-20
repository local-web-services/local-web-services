package io.localwebservices.lws.unit.providers.apigateway;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.localwebservices.lws.providers.apigateway.ApiGatewayStore;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import org.junit.jupiter.api.Test;

public class ApiGatewayStoreMethodTest {

  @Test
  public void resources_nestedMap_canHoldMethodData() {
    // Arrange
    ApiGatewayStore store = new ApiGatewayStore();
    String apiId = "api1";
    String resourceId = "res1";
    String expectedHttpMethod = "GET";
    Map<String, Object> methodData = new HashMap<>();
    methodData.put("httpMethod", expectedHttpMethod);
    methodData.put("authorizationType", "NONE");

    // Act
    Map<String, Object> resourceData = new HashMap<>();
    resourceData.put("id", resourceId);
    resourceData.put("methods", Map.of(expectedHttpMethod, methodData));
    store
        .resources
        .computeIfAbsent(apiId, k -> new ConcurrentHashMap<>())
        .put(resourceId, resourceData);

    // Assert
    @SuppressWarnings("unchecked")
    Map<String, Object> actualMethods =
        (Map<String, Object>) store.resources.get(apiId).get(resourceId).get("methods");
    String actualHttpMethod =
        (String) ((Map<String, Object>) actualMethods.get(expectedHttpMethod)).get("httpMethod");
    assertEquals(expectedHttpMethod, actualHttpMethod, "Expected actualHttpMethod to equal expectedHttpMethod");
  }

  @Test
  public void reset_clearsAllResourcesIncludingMethods() {
    // Arrange
    ApiGatewayStore store = new ApiGatewayStore();
    String apiId = "api1";
    Map<String, Object> resourceData = new HashMap<>();
    resourceData.put("id", "res1");
    resourceData.put("methods", Map.of("GET", Map.of("httpMethod", "GET")));
    store
        .resources
        .computeIfAbsent(apiId, k -> new ConcurrentHashMap<>())
        .put("res1", resourceData);

    // Act
    store.reset();

    // Assert
    assertTrue(store.resources.isEmpty(), "Expected store.resources to be empty");
  }
}
