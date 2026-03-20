package io.localwebservices.lws.unit.providers.elasticache;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import io.localwebservices.lws.providers.elasticache.ElastiCacheStore;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import org.junit.jupiter.api.Test;

public class ElastiCacheStoreSubnetGroupTest {

  @Test
  public void createCacheSubnetGroup_storesGroup() {
    // Arrange
    ElastiCacheStore store = new ElastiCacheStore();
    Map<String, String> params = new LinkedHashMap<>();
    params.put("CacheSubnetGroupName", "my-subnet-group");
    params.put("CacheSubnetGroupDescription", "test subnet group");
    String expectedGroupName = "my-subnet-group";

    // Act
    Map<String, Object> actualGroup = store.createCacheSubnetGroup(params);

    // Assert
    assertNotNull(actualGroup, "Expected actualGroup to not be null");
    assertEquals(expectedGroupName, actualGroup.get("CacheSubnetGroupName"), "Expected actualGroup.get("CacheSubnetGroupName") to equal expectedGroupName");
  }

  @Test
  public void createCacheSubnetGroup_setsVpcId() {
    // Arrange
    ElastiCacheStore store = new ElastiCacheStore();
    Map<String, String> params = new LinkedHashMap<>();
    params.put("CacheSubnetGroupName", "vpc-subnet-group");
    params.put("CacheSubnetGroupDescription", "vpc test");
    String expectedVpcId = "vpc-00000000";

    // Act
    Map<String, Object> actualGroup = store.createCacheSubnetGroup(params);

    // Assert
    assertEquals(expectedVpcId, actualGroup.get("VpcId"), "Expected actualGroup.get("VpcId") to equal expectedVpcId");
  }

  @Test
  public void describeCacheSubnetGroups_withName_returnsSingle() {
    // Arrange
    ElastiCacheStore store = new ElastiCacheStore();
    Map<String, String> params1 = new LinkedHashMap<>();
    params1.put("CacheSubnetGroupName", "sg-one");
    params1.put("CacheSubnetGroupDescription", "one");
    Map<String, String> params2 = new LinkedHashMap<>();
    params2.put("CacheSubnetGroupName", "sg-two");
    params2.put("CacheSubnetGroupDescription", "two");
    store.createCacheSubnetGroup(params1);
    store.createCacheSubnetGroup(params2);
    int expectedCount = 1;

    // Act
    List<Map<String, Object>> actualGroups = store.describeCacheSubnetGroups("sg-one");

    // Assert
    assertEquals(expectedCount, actualGroups.size(), "Expected actualGroups.size() to match expectedCount");
    assertEquals("sg-one", actualGroups.get(0).get("CacheSubnetGroupName"), "Expected actualGroups.get(0).get("CacheSubnetGroupName") to equal "sg-one"");
  }

  @Test
  public void describeCacheSubnetGroups_withNull_returnsAll() {
    // Arrange
    ElastiCacheStore store = new ElastiCacheStore();
    Map<String, String> params1 = new LinkedHashMap<>();
    params1.put("CacheSubnetGroupName", "sg-alpha");
    params1.put("CacheSubnetGroupDescription", "alpha");
    Map<String, String> params2 = new LinkedHashMap<>();
    params2.put("CacheSubnetGroupName", "sg-beta");
    params2.put("CacheSubnetGroupDescription", "beta");
    store.createCacheSubnetGroup(params1);
    store.createCacheSubnetGroup(params2);
    int expectedCount = 2;

    // Act
    List<Map<String, Object>> actualGroups = store.describeCacheSubnetGroups(null);

    // Assert
    assertEquals(expectedCount, actualGroups.size(), "Expected actualGroups.size() to match expectedCount");
  }

  @Test
  public void deleteCacheSubnetGroup_removes() {
    // Arrange
    ElastiCacheStore store = new ElastiCacheStore();
    Map<String, String> params = new LinkedHashMap<>();
    params.put("CacheSubnetGroupName", "delete-sg");
    params.put("CacheSubnetGroupDescription", "to delete");
    store.createCacheSubnetGroup(params);
    int expectedCount = 0;

    // Act
    store.deleteCacheSubnetGroup("delete-sg");

    // Assert
    List<Map<String, Object>> actualGroups = store.describeCacheSubnetGroups(null);
    assertEquals(expectedCount, actualGroups.size(), "Expected actualGroups.size() to match expectedCount");
  }
}
