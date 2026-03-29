package io.localwebservices.lws.unit.providers.elasticache;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertThrows;

import io.localwebservices.lws.providers.elasticache.ElastiCacheStore;
import java.util.Map;
import org.junit.jupiter.api.Test;

public class ElastiCacheStoreExtendedOpsTest {

  @Test
  public void modifyCacheCluster_existingId_returnsCluster() {
    // Arrange
    ElastiCacheStore store = new ElastiCacheStore();
    store.createCacheCluster(Map.of("CacheClusterId", "mod-cluster"));
    String expectedId = "mod-cluster";

    // Act
    Map<String, Object> actualCluster = store.modifyCacheCluster("mod-cluster");

    // Assert
    assertNotNull(actualCluster, "Expected actualCluster to not be null");
    assertEquals(expectedId, actualCluster.get("CacheClusterId"), "Expected clusterId to match");
  }

  @Test
  public void modifyCacheCluster_unknownId_throwsException() {
    // Arrange
    ElastiCacheStore store = new ElastiCacheStore();

    // Act & Assert
    assertThrows(
        IllegalArgumentException.class,
        () -> store.modifyCacheCluster("nonexistent"),
        "Expected IllegalArgumentException for unknown cluster");
  }

  @Test
  public void modifyReplicationGroup_existingId_returnsGroup() {
    // Arrange
    ElastiCacheStore store = new ElastiCacheStore();
    store.createReplicationGroup(
        Map.of("ReplicationGroupId", "mod-rg", "ReplicationGroupDescription", "test"));
    String expectedId = "mod-rg";

    // Act
    Map<String, Object> actualGroup = store.modifyReplicationGroup("mod-rg");

    // Assert
    assertNotNull(actualGroup, "Expected actualGroup to not be null");
    assertEquals(expectedId, actualGroup.get("ReplicationGroupId"), "Expected groupId to match");
  }

  @Test
  public void modifyReplicationGroup_unknownId_throwsException() {
    // Arrange
    ElastiCacheStore store = new ElastiCacheStore();

    // Act & Assert
    assertThrows(
        IllegalArgumentException.class,
        () -> store.modifyReplicationGroup("nonexistent"),
        "Expected IllegalArgumentException for unknown replication group");
  }

  @Test
  public void createCacheParameterGroup_storesGroup() {
    // Arrange
    ElastiCacheStore store = new ElastiCacheStore();
    Map<String, String> params =
        Map.of(
            "CacheParameterGroupName", "my-pg",
            "CacheParameterGroupFamily", "redis7",
            "Description", "test pg");
    String expectedName = "my-pg";

    // Act
    Map<String, Object> actualPg = store.createCacheParameterGroup(params);

    // Assert
    assertNotNull(actualPg, "Expected actualPg to not be null");
    assertEquals(expectedName, actualPg.get("CacheParameterGroupName"), "Expected name to match");
  }

  @Test
  public void deleteCacheParameterGroup_removesGroup() {
    // Arrange
    ElastiCacheStore store = new ElastiCacheStore();
    store.createCacheParameterGroup(
        Map.of("CacheParameterGroupName", "del-pg", "CacheParameterGroupFamily", "redis7"));

    // Act
    store.deleteCacheParameterGroup("del-pg");

    // Assert (re-creating with same name should succeed, proving it was removed)
    Map<String, Object> actualPg =
        store.createCacheParameterGroup(
            Map.of("CacheParameterGroupName", "del-pg", "CacheParameterGroupFamily", "redis7"));
    assertNotNull(actualPg, "Expected actualPg to not be null after re-create");
  }

  @Test
  public void createSnapshot_storesSnapshot() {
    // Arrange
    ElastiCacheStore store = new ElastiCacheStore();
    Map<String, String> params =
        Map.of("SnapshotName", "my-snap", "CacheClusterId", "source-cluster");
    String expectedName = "my-snap";

    // Act
    Map<String, Object> actualSnap = store.createSnapshot(params);

    // Assert
    assertNotNull(actualSnap, "Expected actualSnap to not be null");
    assertEquals(expectedName, actualSnap.get("SnapshotName"), "Expected name to match");
    assertEquals("available", actualSnap.get("SnapshotStatus"), "Expected status to match");
  }

  @Test
  public void deleteSnapshot_existingName_returnsAndRemoves() {
    // Arrange
    ElastiCacheStore store = new ElastiCacheStore();
    store.createSnapshot(Map.of("SnapshotName", "del-snap"));
    String expectedName = "del-snap";

    // Act
    Map<String, Object> actualDeleted = store.deleteSnapshot("del-snap");

    // Assert
    assertNotNull(actualDeleted, "Expected actualDeleted to not be null");
    assertEquals(expectedName, actualDeleted.get("SnapshotName"), "Expected name to match");
  }

  @Test
  public void deleteSnapshot_unknownName_returnsNull() {
    // Arrange
    ElastiCacheStore store = new ElastiCacheStore();

    // Act
    Map<String, Object> actualDeleted = store.deleteSnapshot("nonexistent");

    // Assert
    assertNull(actualDeleted, "Expected actualDeleted to be null");
  }

  @Test
  public void reset_clearsParameterGroupsAndSnapshots() {
    // Arrange
    ElastiCacheStore store = new ElastiCacheStore();
    store.createCacheParameterGroup(
        Map.of("CacheParameterGroupName", "pg-1", "CacheParameterGroupFamily", "redis7"));
    store.createSnapshot(Map.of("SnapshotName", "snap-1"));

    // Act
    store.reset();

    // Assert: after reset, deleteSnapshot returns null (was cleared)
    Map<String, Object> actualSnap = store.deleteSnapshot("snap-1");
    assertNull(actualSnap, "Expected snapshot to be null after reset");
  }
}
