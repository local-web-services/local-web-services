package io.localwebservices.lws.unit.providers.apigateway;

import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.localwebservices.lws.providers.apigateway.ApiGatewayStore;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import org.junit.jupiter.api.Test;

public class ApiGatewayStoreDeploymentStageTest {

  @Test
  public void deployments_put_storesDeployment() {
    // Arrange
    ApiGatewayStore store = new ApiGatewayStore();
    String apiId = "api1";
    String expectedDeploymentId = "dep1";

    // Act
    store
        .deployments
        .computeIfAbsent(apiId, k -> new ConcurrentHashMap<>())
        .put(expectedDeploymentId, Map.of("id", expectedDeploymentId));

    // Assert
    assertNotNull(store.deployments.get(apiId).get(expectedDeploymentId));
  }

  @Test
  public void stages_put_storesStage() {
    // Arrange
    ApiGatewayStore store = new ApiGatewayStore();
    String apiId = "api1";
    String expectedStageName = "prod";

    // Act
    store
        .stages
        .computeIfAbsent(apiId, k -> new ConcurrentHashMap<>())
        .put(expectedStageName, Map.of("stageName", expectedStageName));

    // Assert
    assertNotNull(store.stages.get(apiId).get(expectedStageName));
  }

  @Test
  public void reset_clearsDeployments() {
    // Arrange
    ApiGatewayStore store = new ApiGatewayStore();
    store
        .deployments
        .computeIfAbsent("api1", k -> new ConcurrentHashMap<>())
        .put("dep1", Map.of("id", "dep1"));

    // Act
    store.reset();

    // Assert
    assertTrue(store.deployments.isEmpty());
  }

  @Test
  public void reset_clearsStages() {
    // Arrange
    ApiGatewayStore store = new ApiGatewayStore();
    store
        .stages
        .computeIfAbsent("api1", k -> new ConcurrentHashMap<>())
        .put("prod", Map.of("stageName", "prod"));

    // Act
    store.reset();

    // Assert
    assertTrue(store.stages.isEmpty());
  }
}
