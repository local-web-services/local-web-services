package io.localwebservices.lws.unit.providers.docdb;

import static org.junit.jupiter.api.Assertions.assertEquals;

import io.localwebservices.lws.providers.docdb.DocDbStore;
import java.util.List;
import java.util.Map;
import org.junit.jupiter.api.Test;

public class DocDbStoreBranchTest {

  @Test
  public void describeClusters_byIdNotFound_returnsEmptyList() {
    // Arrange
    DocDbStore store = new DocDbStore();
    store.createCluster(Map.of("DBClusterIdentifier", "existing-cluster"));
    int expectedCount = 0;

    // Act
    List<Map<String, Object>> actualClusters = store.describeClusters("nonexistent-id");

    // Assert
    assertEquals(
        expectedCount,
        actualClusters.size(),
        "Expected actualClusters.size() to match expectedCount");
  }

  @Test
  public void describeInstances_byIdNotFound_returnsEmptyList() {
    // Arrange
    DocDbStore store = new DocDbStore();
    store.createInstance(
        Map.of(
            "DBInstanceIdentifier", "existing-instance",
            "DBClusterIdentifier", "cluster-1",
            "DBInstanceClass", "db.r5.large"));
    int expectedCount = 0;

    // Act
    List<Map<String, Object>> actualInstances = store.describeInstances("nonexistent-id");

    // Assert
    assertEquals(
        expectedCount,
        actualInstances.size(),
        "Expected actualInstances.size() to match expectedCount");
  }

  @Test
  public void describeSnapshots_byIdNotFound_returnsEmptyList() {
    // Arrange
    DocDbStore store = new DocDbStore();
    store.createSnapshot(
        Map.of(
            "DBClusterSnapshotIdentifier", "existing-snap",
            "DBClusterIdentifier", "cluster-1"));
    int expectedCount = 0;

    // Act
    List<Map<String, Object>> actualSnapshots = store.describeSnapshots("nonexistent-id");

    // Assert
    assertEquals(
        expectedCount,
        actualSnapshots.size(),
        "Expected actualSnapshots.size() to match expectedCount");
  }
}
