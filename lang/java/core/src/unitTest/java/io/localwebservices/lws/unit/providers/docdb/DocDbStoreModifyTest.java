package io.localwebservices.lws.unit.providers.docdb;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;

import io.localwebservices.lws.providers.docdb.DocDbStore;
import java.util.LinkedHashMap;
import java.util.Map;
import org.junit.jupiter.api.Test;

public class DocDbStoreModifyTest {

  @Test
  public void modifyInstance_nonExistentId_returnsNull() {
    // Arrange
    DocDbStore store = new DocDbStore();

    // Act
    Map<String, Object> actualResult = store.modifyInstance("nonexistent", Map.of());

    // Assert
    assertNull(actualResult, "Expected actualResult to be null for non-existent instance");
  }

  @Test
  public void modifyInstance_existingId_withClassChange_updatesClass() {
    // Arrange
    DocDbStore store = new DocDbStore();
    Map<String, String> createParams = new LinkedHashMap<>();
    createParams.put("DBInstanceIdentifier", "my-instance");
    createParams.put("DBInstanceClass", "db.r5.large");
    store.createInstance(createParams);
    String expectedClass = "db.r5.xlarge";

    // Act
    Map<String, String> modifyParams = Map.of("DBInstanceClass", "db.r5.xlarge");
    Map<String, Object> actualResult = store.modifyInstance("my-instance", modifyParams);

    // Assert
    assertNotNull(actualResult, "Expected actualResult to not be null");
    assertEquals(expectedClass, actualResult.get("DBInstanceClass"), "Expected class to match");
  }

  @Test
  public void modifyInstance_existingId_withoutClassChange_returnsUnmodified() {
    // Arrange
    DocDbStore store = new DocDbStore();
    Map<String, String> createParams = new LinkedHashMap<>();
    createParams.put("DBInstanceIdentifier", "my-instance");
    createParams.put("DBInstanceClass", "db.r5.large");
    store.createInstance(createParams);
    String expectedClass = "db.r5.large";

    // Act
    Map<String, Object> actualResult = store.modifyInstance("my-instance", Map.of());

    // Assert
    assertNotNull(actualResult, "Expected actualResult to not be null");
    assertEquals(
        expectedClass, actualResult.get("DBInstanceClass"), "Expected class to remain unchanged");
  }

  @Test
  public void modifyCluster_nonExistentId_returnsNull() {
    // Arrange
    DocDbStore store = new DocDbStore();

    // Act
    Map<String, Object> actualResult = store.modifyCluster("nonexistent", Map.of());

    // Assert
    assertNull(actualResult, "Expected actualResult to be null for non-existent cluster");
  }

  @Test
  public void modifyCluster_existingId_withRetentionChange_updatesRetention() {
    // Arrange
    DocDbStore store = new DocDbStore();
    Map<String, String> createParams = new LinkedHashMap<>();
    createParams.put("DBClusterIdentifier", "my-cluster");
    store.createCluster(createParams);
    String expectedRetention = "7";

    // Act
    Map<String, String> modifyParams = Map.of("BackupRetentionPeriod", "7");
    Map<String, Object> actualResult = store.modifyCluster("my-cluster", modifyParams);

    // Assert
    assertNotNull(actualResult, "Expected actualResult to not be null");
    assertEquals(
        expectedRetention,
        actualResult.get("BackupRetentionPeriod"),
        "Expected retention period to match");
  }

  @Test
  public void modifyCluster_existingId_withoutRetentionChange_returnsUnmodified() {
    // Arrange
    DocDbStore store = new DocDbStore();
    Map<String, String> createParams = new LinkedHashMap<>();
    createParams.put("DBClusterIdentifier", "my-cluster");
    store.createCluster(createParams);
    String expectedId = "my-cluster";

    // Act
    Map<String, Object> actualResult = store.modifyCluster("my-cluster", Map.of());

    // Assert
    assertNotNull(actualResult, "Expected actualResult to not be null");
    assertEquals(
        expectedId, actualResult.get("DBClusterIdentifier"), "Expected id to remain unchanged");
  }
}
