package io.localwebservices.lws.unit.providers.dynamodb;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.localwebservices.lws.providers.dynamodb.DynamoDbStore;
import java.util.List;
import java.util.Map;
import org.junit.jupiter.api.Test;

public class DynamoDbStoreScanTest {

  private DynamoDbStore storeWithTable() {
    DynamoDbStore store = new DynamoDbStore();
    store.createTable("T", "id", "S", null, null, List.of());
    return store;
  }

  @Test
  public void scan_emptyTable_returnsZeroItems() {
    // Arrange
    DynamoDbStore store = storeWithTable();
    int expectedCount = 0;

    // Act
    List<Map<String, Object>> actualItems = store.scan("T", null, null, null, null, null);

    // Assert
    assertEquals(expectedCount, actualItems.size());
    assertTrue(actualItems.isEmpty());
  }

  @Test
  public void scan_twoItems_returnsTwo() {
    // Arrange
    DynamoDbStore store = storeWithTable();
    store.putItem("T", Map.of("id", Map.of("S", "a"), "val", Map.of("S", "1")));
    store.putItem("T", Map.of("id", Map.of("S", "b"), "val", Map.of("S", "2")));
    int expectedCount = 2;

    // Act
    List<Map<String, Object>> actualItems = store.scan("T", null, null, null, null, null);

    // Assert
    assertEquals(expectedCount, actualItems.size());
  }

  @Test
  public void scan_withLimit_returnsLimitedItems() {
    // Arrange
    DynamoDbStore store = storeWithTable();
    store.putItem("T", Map.of("id", Map.of("S", "a")));
    store.putItem("T", Map.of("id", Map.of("S", "b")));
    store.putItem("T", Map.of("id", Map.of("S", "c")));
    int expectedSize = 2;

    // Act
    List<Map<String, Object>> actualItems = store.scan("T", null, null, null, 2, null);

    // Assert
    assertEquals(expectedSize, actualItems.size());
  }

  @Test
  public void scan_withNullFilter_returnsAll() {
    // Arrange
    DynamoDbStore store = storeWithTable();
    store.putItem("T", Map.of("id", Map.of("S", "x"), "color", Map.of("S", "red")));
    store.putItem("T", Map.of("id", Map.of("S", "y"), "color", Map.of("S", "blue")));
    int expectedCount = 2;

    // Act
    List<Map<String, Object>> actualItems = store.scan("T", null, null, null, null, null);

    // Assert
    assertEquals(expectedCount, actualItems.size());
  }
}
