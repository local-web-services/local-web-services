package io.localwebservices.lws.unit.providers.elasticache;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;

import io.localwebservices.lws.providers.elasticache.ElastiCacheStore;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import org.junit.jupiter.api.Test;

public class ElastiCacheStoreClusterTest {

  @Test
  public void createCacheCluster_withParams_storesCluster() {
    // Arrange
    ElastiCacheStore store = new ElastiCacheStore();
    Map<String, String> params = new LinkedHashMap<>();
    params.put("CacheClusterId", "my-cluster");
    String expectedClusterId = "my-cluster";

    // Act
    Map<String, Object> actualCluster = store.createCacheCluster(params);

    // Assert
    assertNotNull(actualCluster, "Expected actualCluster to not be null");
    assertEquals(
        expectedClusterId, actualCluster.get("CacheClusterId"), "Expected clusterId to match");
  }

  @Test
  public void createCacheCluster_defaultsEngine() {
    // Arrange
    ElastiCacheStore store = new ElastiCacheStore();
    Map<String, String> params = new LinkedHashMap<>();
    params.put("CacheClusterId", "engine-cluster");
    String expectedEngine = "redis";

    // Act
    Map<String, Object> actualCluster = store.createCacheCluster(params);

    // Assert
    assertEquals(expectedEngine, actualCluster.get("Engine"), "Expected engine to match");
  }

  @Test
  public void createCacheCluster_hasAvailableStatus() {
    // Arrange
    ElastiCacheStore store = new ElastiCacheStore();
    Map<String, String> params = new LinkedHashMap<>();
    params.put("CacheClusterId", "status-cluster");
    String expectedStatus = "available";

    // Act
    Map<String, Object> actualCluster = store.createCacheCluster(params);

    // Assert
    assertEquals(
        expectedStatus, actualCluster.get("CacheClusterStatus"), "Expected status to match");
  }

  @Test
  public void describeCacheClusters_withId_returnsSingle() {
    // Arrange
    ElastiCacheStore store = new ElastiCacheStore();
    Map<String, String> params1 = new LinkedHashMap<>();
    params1.put("CacheClusterId", "cluster-a");
    Map<String, String> params2 = new LinkedHashMap<>();
    params2.put("CacheClusterId", "cluster-b");
    store.createCacheCluster(params1);
    store.createCacheCluster(params2);
    int expectedCount = 1;

    // Act
    List<Map<String, Object>> actualClusters = store.describeCacheClusters("cluster-a");

    // Assert
    assertEquals(
        expectedCount,
        actualClusters.size(),
        "Expected actualClusters.size() to match expectedCount");
    assertEquals(
        "cluster-a", actualClusters.get(0).get("CacheClusterId"), "Expected values to match");
  }

  @Test
  public void describeCacheClusters_withNull_returnsAll() {
    // Arrange
    ElastiCacheStore store = new ElastiCacheStore();
    Map<String, String> params1 = new LinkedHashMap<>();
    params1.put("CacheClusterId", "cluster-x");
    Map<String, String> params2 = new LinkedHashMap<>();
    params2.put("CacheClusterId", "cluster-y");
    store.createCacheCluster(params1);
    store.createCacheCluster(params2);
    int expectedCount = 2;

    // Act
    List<Map<String, Object>> actualClusters = store.describeCacheClusters(null);

    // Assert
    assertEquals(
        expectedCount,
        actualClusters.size(),
        "Expected actualClusters.size() to match expectedCount");
  }

  @Test
  public void deleteCacheCluster_existingId_returnsAndRemoves() {
    // Arrange
    ElastiCacheStore store = new ElastiCacheStore();
    Map<String, String> params = new LinkedHashMap<>();
    params.put("CacheClusterId", "delete-cluster");
    store.createCacheCluster(params);
    int expectedCount = 0;

    // Act
    Map<String, Object> actualDeleted = store.deleteCacheCluster("delete-cluster");

    // Assert
    assertNotNull(actualDeleted, "Expected actualDeleted to not be null");
    assertEquals("delete-cluster", actualDeleted.get("CacheClusterId"), "Expected values to match");
    List<Map<String, Object>> actualRemaining = store.describeCacheClusters(null);
    assertEquals(
        expectedCount,
        actualRemaining.size(),
        "Expected actualRemaining.size() to match expectedCount");
  }

  @Test
  public void deleteCacheCluster_unknownId_returnsNull() {
    // Arrange
    ElastiCacheStore store = new ElastiCacheStore();
    String unknownId = "non-existent-cluster";

    // Act
    Map<String, Object> actualDeleted = store.deleteCacheCluster(unknownId);

    // Assert
    assertNull(actualDeleted, "Expected actualDeleted to be null");
  }

  @Test
  public void reset_clearsAllClusters() {
    // Arrange
    ElastiCacheStore store = new ElastiCacheStore();
    Map<String, String> params = new LinkedHashMap<>();
    params.put("CacheClusterId", "reset-cluster");
    store.createCacheCluster(params);
    int expectedCount = 0;

    // Act
    store.reset();

    // Assert
    List<Map<String, Object>> actualClusters = store.describeCacheClusters(null);
    assertEquals(
        expectedCount,
        actualClusters.size(),
        "Expected actualClusters.size() to match expectedCount");
  }
}
