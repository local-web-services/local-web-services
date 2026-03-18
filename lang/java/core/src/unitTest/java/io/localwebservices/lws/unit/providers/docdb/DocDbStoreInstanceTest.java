package io.localwebservices.lws.unit.providers.docdb;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;

import io.localwebservices.lws.providers.docdb.DocDbStore;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import org.junit.jupiter.api.Test;

public class DocDbStoreInstanceTest {

  @Test
  public void createInstance_withParams_storesInstance() {
    // Arrange
    DocDbStore store = new DocDbStore();
    Map<String, String> params = new LinkedHashMap<>();
    params.put("DBInstanceIdentifier", "my-instance");
    params.put("DBClusterIdentifier", "my-cluster");
    String expectedId = "my-instance";

    // Act
    Map<String, Object> actualInstance = store.createInstance(params);

    // Assert
    assertNotNull(actualInstance);
    assertEquals(expectedId, actualInstance.get("DBInstanceIdentifier"));
  }

  @Test
  public void describeInstances_withId_returnsSingleInstance() {
    // Arrange
    DocDbStore store = new DocDbStore();
    Map<String, String> paramsA = new LinkedHashMap<>();
    paramsA.put("DBInstanceIdentifier", "instance-a");
    Map<String, String> paramsB = new LinkedHashMap<>();
    paramsB.put("DBInstanceIdentifier", "instance-b");
    store.createInstance(paramsA);
    store.createInstance(paramsB);
    int expectedSize = 1;
    String expectedId = "instance-a";

    // Act
    List<Map<String, Object>> actualInstances = store.describeInstances("instance-a");

    // Assert
    assertEquals(expectedSize, actualInstances.size());
    assertEquals(expectedId, actualInstances.get(0).get("DBInstanceIdentifier"));
  }

  @Test
  public void describeInstances_withNullId_returnsAll() {
    // Arrange
    DocDbStore store = new DocDbStore();
    Map<String, String> paramsA = new LinkedHashMap<>();
    paramsA.put("DBInstanceIdentifier", "instance-a");
    Map<String, String> paramsB = new LinkedHashMap<>();
    paramsB.put("DBInstanceIdentifier", "instance-b");
    store.createInstance(paramsA);
    store.createInstance(paramsB);
    int expectedSize = 2;

    // Act
    List<Map<String, Object>> actualInstances = store.describeInstances(null);

    // Assert
    assertEquals(expectedSize, actualInstances.size());
  }

  @Test
  public void deleteInstance_existingId_returnsAndRemoves() {
    // Arrange
    DocDbStore store = new DocDbStore();
    Map<String, String> params = new LinkedHashMap<>();
    params.put("DBInstanceIdentifier", "my-instance");
    store.createInstance(params);
    String expectedId = "my-instance";
    int expectedRemainingSize = 0;

    // Act
    Map<String, Object> actualDeleted = store.deleteInstance("my-instance");

    // Assert
    assertNotNull(actualDeleted);
    assertEquals(expectedId, actualDeleted.get("DBInstanceIdentifier"));
    assertEquals(expectedRemainingSize, store.describeInstances(null).size());
  }

  @Test
  public void deleteInstance_unknownId_returnsNull() {
    // Arrange
    DocDbStore store = new DocDbStore();

    // Act
    Map<String, Object> actualDeleted = store.deleteInstance("does-not-exist");

    // Assert
    assertNull(actualDeleted);
  }
}
