package io.localwebservices.lws.unit.providers.docdb;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;

import io.localwebservices.lws.providers.docdb.DocDbStore;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import org.junit.jupiter.api.Test;

public class DocDbStoreSnapshotTest {

  @Test
  public void createSnapshot_withParams_storesSnapshot() {
    // Arrange
    DocDbStore store = new DocDbStore();
    Map<String, String> params = new LinkedHashMap<>();
    params.put("DBClusterIdentifier", "my-cluster");
    params.put("DBClusterSnapshotIdentifier", "my-snap");
    String expectedSnapshotId = "my-snap";

    // Act
    Map<String, Object> actualSnapshot = store.createSnapshot(params);

    // Assert
    assertNotNull(actualSnapshot, "Expected actualSnapshot to not be null");
    assertEquals(expectedSnapshotId, actualSnapshot.get("DBClusterSnapshotIdentifier"), "Expected actualSnapshot.get("DBClusterSnapshotIdentifier") to equal expectedSnapshotId");
  }

  @Test
  public void describeSnapshots_withId_returnsSingleSnapshot() {
    // Arrange
    DocDbStore store = new DocDbStore();
    Map<String, String> paramsA = new LinkedHashMap<>();
    paramsA.put("DBClusterIdentifier", "my-cluster");
    paramsA.put("DBClusterSnapshotIdentifier", "snap-a");
    Map<String, String> paramsB = new LinkedHashMap<>();
    paramsB.put("DBClusterIdentifier", "my-cluster");
    paramsB.put("DBClusterSnapshotIdentifier", "snap-b");
    store.createSnapshot(paramsA);
    store.createSnapshot(paramsB);
    int expectedSize = 1;
    String expectedId = "snap-a";

    // Act
    List<Map<String, Object>> actualSnapshots = store.describeSnapshots("snap-a");

    // Assert
    assertEquals(expectedSize, actualSnapshots.size(), "Expected actualSnapshots.size() to match expectedSize");
    assertEquals(expectedId, actualSnapshots.get(0).get("DBClusterSnapshotIdentifier"), "Expected actualSnapshots.get(0).get("DBClusterSnapshotIdentifier") to equal expectedId");
  }

  @Test
  public void describeSnapshots_withNullId_returnsAll() {
    // Arrange
    DocDbStore store = new DocDbStore();
    Map<String, String> paramsA = new LinkedHashMap<>();
    paramsA.put("DBClusterIdentifier", "my-cluster");
    paramsA.put("DBClusterSnapshotIdentifier", "snap-a");
    Map<String, String> paramsB = new LinkedHashMap<>();
    paramsB.put("DBClusterIdentifier", "my-cluster");
    paramsB.put("DBClusterSnapshotIdentifier", "snap-b");
    store.createSnapshot(paramsA);
    store.createSnapshot(paramsB);
    int expectedSize = 2;

    // Act
    List<Map<String, Object>> actualSnapshots = store.describeSnapshots(null);

    // Assert
    assertEquals(expectedSize, actualSnapshots.size(), "Expected actualSnapshots.size() to match expectedSize");
  }

  @Test
  public void deleteSnapshot_existingId_returnsAndRemoves() {
    // Arrange
    DocDbStore store = new DocDbStore();
    Map<String, String> params = new LinkedHashMap<>();
    params.put("DBClusterIdentifier", "my-cluster");
    params.put("DBClusterSnapshotIdentifier", "my-snap");
    store.createSnapshot(params);
    String expectedId = "my-snap";
    int expectedRemainingSize = 0;

    // Act
    Map<String, Object> actualDeleted = store.deleteSnapshot("my-snap");

    // Assert
    assertNotNull(actualDeleted, "Expected actualDeleted to not be null");
    assertEquals(expectedId, actualDeleted.get("DBClusterSnapshotIdentifier"), "Expected actualDeleted.get("DBClusterSnapshotIdentifier") to equal expectedId");
    assertEquals(expectedRemainingSize, store.describeSnapshots(null).size(), "Expected store.describeSnapshots(null).size() to match expectedRemainingSize");
  }

  @Test
  public void deleteSnapshot_unknownId_returnsNull() {
    // Arrange
    DocDbStore store = new DocDbStore();

    // Act
    Map<String, Object> actualDeleted = store.deleteSnapshot("does-not-exist");

    // Assert
    assertNull(actualDeleted, "Expected actualDeleted to be null");
  }
}
