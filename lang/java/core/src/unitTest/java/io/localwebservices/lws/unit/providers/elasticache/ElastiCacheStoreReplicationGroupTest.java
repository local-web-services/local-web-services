package io.localwebservices.lws.unit.providers.elasticache;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;

import io.localwebservices.lws.providers.elasticache.ElastiCacheStore;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import org.junit.jupiter.api.Test;

public class ElastiCacheStoreReplicationGroupTest {

  @Test
  public void createReplicationGroup_storesGroup() {
    // Arrange
    ElastiCacheStore store = new ElastiCacheStore();
    Map<String, String> params = new LinkedHashMap<>();
    params.put("ReplicationGroupId", "my-rg");
    params.put("ReplicationGroupDescription", "test group");
    String expectedGroupId = "my-rg";

    // Act
    Map<String, Object> actualGroup = store.createReplicationGroup(params);

    // Assert
    assertNotNull(actualGroup, "Expected actualGroup to not be null");
    assertEquals(expectedGroupId, actualGroup.get("ReplicationGroupId"), "Expected groupId to match");
  }

  @Test
  public void createReplicationGroup_hasAvailableStatus() {
    // Arrange
    ElastiCacheStore store = new ElastiCacheStore();
    Map<String, String> params = new LinkedHashMap<>();
    params.put("ReplicationGroupId", "status-rg");
    params.put("ReplicationGroupDescription", "status group");
    String expectedStatus = "available";

    // Act
    Map<String, Object> actualGroup = store.createReplicationGroup(params);

    // Assert
    assertEquals(expectedStatus, actualGroup.get("Status"), "Expected status to match");
  }

  @Test
  public void describeReplicationGroups_withId_returnsSingle() {
    // Arrange
    ElastiCacheStore store = new ElastiCacheStore();
    Map<String, String> params1 = new LinkedHashMap<>();
    params1.put("ReplicationGroupId", "rg-one");
    params1.put("ReplicationGroupDescription", "group one");
    Map<String, String> params2 = new LinkedHashMap<>();
    params2.put("ReplicationGroupId", "rg-two");
    params2.put("ReplicationGroupDescription", "group two");
    store.createReplicationGroup(params1);
    store.createReplicationGroup(params2);
    int expectedCount = 1;

    // Act
    List<Map<String, Object>> actualGroups = store.describeReplicationGroups("rg-one");

    // Assert
    assertEquals(expectedCount, actualGroups.size(), "Expected actualGroups.size() to match expectedCount");
    assertEquals("rg-one", actualGroups.get(0).get("ReplicationGroupId"), "Expected values to match");
  }

  @Test
  public void describeReplicationGroups_withNull_returnsAll() {
    // Arrange
    ElastiCacheStore store = new ElastiCacheStore();
    Map<String, String> params1 = new LinkedHashMap<>();
    params1.put("ReplicationGroupId", "rg-alpha");
    params1.put("ReplicationGroupDescription", "alpha");
    Map<String, String> params2 = new LinkedHashMap<>();
    params2.put("ReplicationGroupId", "rg-beta");
    params2.put("ReplicationGroupDescription", "beta");
    store.createReplicationGroup(params1);
    store.createReplicationGroup(params2);
    int expectedCount = 2;

    // Act
    List<Map<String, Object>> actualGroups = store.describeReplicationGroups(null);

    // Assert
    assertEquals(expectedCount, actualGroups.size(), "Expected actualGroups.size() to match expectedCount");
  }

  @Test
  public void deleteReplicationGroup_existingId_returnsAndRemoves() {
    // Arrange
    ElastiCacheStore store = new ElastiCacheStore();
    Map<String, String> params = new LinkedHashMap<>();
    params.put("ReplicationGroupId", "delete-rg");
    params.put("ReplicationGroupDescription", "to delete");
    store.createReplicationGroup(params);
    int expectedCount = 0;

    // Act
    Map<String, Object> actualDeleted = store.deleteReplicationGroup("delete-rg");

    // Assert
    assertNotNull(actualDeleted, "Expected actualDeleted to not be null");
    assertEquals("delete-rg", actualDeleted.get("ReplicationGroupId"), "Expected values to match");
    List<Map<String, Object>> actualRemaining = store.describeReplicationGroups(null);
    assertEquals(expectedCount, actualRemaining.size(), "Expected actualRemaining.size() to match expectedCount");
  }

  @Test
  public void deleteReplicationGroup_unknownId_returnsNull() {
    // Arrange
    ElastiCacheStore store = new ElastiCacheStore();
    String unknownId = "non-existent-rg";

    // Act
    Map<String, Object> actualDeleted = store.deleteReplicationGroup(unknownId);

    // Assert
    assertNull(actualDeleted, "Expected actualDeleted to be null");
  }
}
