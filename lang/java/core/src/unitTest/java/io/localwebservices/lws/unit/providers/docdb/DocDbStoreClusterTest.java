package io.localwebservices.lws.unit.providers.docdb;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.localwebservices.lws.providers.docdb.DocDbStore;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import org.junit.jupiter.api.Test;

public class DocDbStoreClusterTest {

  @Test
  public void createCluster_withParams_storesCluster() {
    // Arrange
    DocDbStore store = new DocDbStore();
    Map<String, String> params = new LinkedHashMap<>();
    params.put("DBClusterIdentifier", "my-cluster");
    String expectedId = "my-cluster";

    // Act
    Map<String, Object> actualCluster = store.createCluster(params);

    // Assert
    assertNotNull(actualCluster, "Expected actualCluster to not be null");
    assertEquals(expectedId, actualCluster.get("DBClusterIdentifier"), "Expected id to match");
  }

  @Test
  public void createCluster_defaultsEngine() {
    // Arrange
    DocDbStore store = new DocDbStore();
    Map<String, String> params = new LinkedHashMap<>();
    params.put("DBClusterIdentifier", "my-cluster");
    String expectedEngine = "docdb";

    // Act
    Map<String, Object> actualCluster = store.createCluster(params);

    // Assert
    assertEquals(expectedEngine, actualCluster.get("Engine"), "Expected engine to match");
  }

  @Test
  public void describeClusters_withId_returnsSingleCluster() {
    // Arrange
    DocDbStore store = new DocDbStore();
    Map<String, String> paramsA = new LinkedHashMap<>();
    paramsA.put("DBClusterIdentifier", "cluster-a");
    Map<String, String> paramsB = new LinkedHashMap<>();
    paramsB.put("DBClusterIdentifier", "cluster-b");
    store.createCluster(paramsA);
    store.createCluster(paramsB);
    int expectedSize = 1;
    String expectedId = "cluster-a";

    // Act
    List<Map<String, Object>> actualClusters = store.describeClusters("cluster-a");

    // Assert
    assertEquals(expectedSize, actualClusters.size(), "Expected actualClusters.size() to match expectedSize");
    assertEquals(expectedId, actualClusters.get(0).get("DBClusterIdentifier"), "Expected id to match");
  }

  @Test
  public void describeClusters_withNullId_returnsAll() {
    // Arrange
    DocDbStore store = new DocDbStore();
    Map<String, String> paramsA = new LinkedHashMap<>();
    paramsA.put("DBClusterIdentifier", "cluster-a");
    Map<String, String> paramsB = new LinkedHashMap<>();
    paramsB.put("DBClusterIdentifier", "cluster-b");
    store.createCluster(paramsA);
    store.createCluster(paramsB);
    int expectedSize = 2;

    // Act
    List<Map<String, Object>> actualClusters = store.describeClusters(null);

    // Assert
    assertEquals(expectedSize, actualClusters.size(), "Expected actualClusters.size() to match expectedSize");
  }

  @Test
  public void deleteCluster_existingId_returnsAndRemoves() {
    // Arrange
    DocDbStore store = new DocDbStore();
    Map<String, String> params = new LinkedHashMap<>();
    params.put("DBClusterIdentifier", "my-cluster");
    store.createCluster(params);
    String expectedId = "my-cluster";
    int expectedRemainingSize = 0;

    // Act
    Map<String, Object> actualDeleted = store.deleteCluster("my-cluster");

    // Assert
    assertNotNull(actualDeleted, "Expected actualDeleted to not be null");
    assertEquals(expectedId, actualDeleted.get("DBClusterIdentifier"), "Expected id to match");
    assertTrue(store.describeClusters(null).isEmpty(), "Expected store.describeClusters(null) to be empty");
    assertEquals(expectedRemainingSize, store.describeClusters(null).size(), "Expected store.describeClusters(null).size() to match expectedRemainingSize");
  }

  @Test
  public void deleteCluster_unknownId_returnsNull() {
    // Arrange
    DocDbStore store = new DocDbStore();

    // Act
    Map<String, Object> actualDeleted = store.deleteCluster("does-not-exist");

    // Assert
    assertNull(actualDeleted, "Expected actualDeleted to be null");
  }

  @Test
  public void reset_clearsAllClusters() {
    // Arrange
    DocDbStore store = new DocDbStore();
    Map<String, String> params = new LinkedHashMap<>();
    params.put("DBClusterIdentifier", "my-cluster");
    store.createCluster(params);
    int expectedSize = 0;

    // Act
    store.reset();

    // Assert
    assertEquals(expectedSize, store.describeClusters(null).size(), "Expected store.describeClusters(null).size() to match expectedSize");
  }
}
