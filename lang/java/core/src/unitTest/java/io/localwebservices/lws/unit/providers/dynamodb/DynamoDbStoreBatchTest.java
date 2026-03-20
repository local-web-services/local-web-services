package io.localwebservices.lws.unit.providers.dynamodb;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.localwebservices.lws.providers.dynamodb.DynamoDbStore;
import java.util.List;
import java.util.Map;
import org.junit.jupiter.api.Test;

public class DynamoDbStoreBatchTest {

  private DynamoDbStore storeWithTable() {
    DynamoDbStore store = new DynamoDbStore();
    store.createTable("T", "id", "S", null, null, List.of());
    return store;
  }

  @Test
  public void batchWriteItems_putsItems_storesAll() {
    // Arrange
    DynamoDbStore store = storeWithTable();
    Map<String, Object> item1 = Map.of("id", Map.of("S", "i1"), "val", Map.of("S", "one"));
    Map<String, Object> item2 = Map.of("id", Map.of("S", "i2"), "val", Map.of("S", "two"));
    Map<String, Object> key1 = Map.of("id", Map.of("S", "i1"));
    Map<String, Object> key2 = Map.of("id", Map.of("S", "i2"));

    // Act
    store.batchWriteItems("T", List.of(item1, item2), List.of());
    Map<String, Object> actualItem1 = store.getItem("T", key1);
    Map<String, Object> actualItem2 = store.getItem("T", key2);

    // Assert
    assertNotNull(actualItem1, "Expected actualItem1 to not be null");
    assertNotNull(actualItem2, "Expected actualItem2 to not be null");
  }

  @Test
  public void batchGetItems_existingItems_returnsBoth() {
    // Arrange
    DynamoDbStore store = storeWithTable();
    Map<String, Object> item1 = Map.of("id", Map.of("S", "i1"), "val", Map.of("S", "one"));
    Map<String, Object> item2 = Map.of("id", Map.of("S", "i2"), "val", Map.of("S", "two"));
    store.putItem("T", item1);
    store.putItem("T", item2);
    List<Map<String, Object>> keys =
        List.of(Map.of("id", Map.of("S", "i1")), Map.of("id", Map.of("S", "i2")));
    int expectedSize = 2;

    // Act
    List<Map<String, Object>> actualItems = store.batchGetItems("T", keys);

    // Assert
    assertEquals(
        expectedSize, actualItems.size(), "Expected actualItems.size() to match expectedSize");
  }

  @Test
  public void batchGetItems_missingKeys_returnsEmpty() {
    // Arrange
    DynamoDbStore store = storeWithTable();
    List<Map<String, Object>> keys =
        List.of(Map.of("id", Map.of("S", "ghost1")), Map.of("id", Map.of("S", "ghost2")));

    // Act
    List<Map<String, Object>> actualItems = store.batchGetItems("T", keys);

    // Assert
    assertTrue(actualItems.isEmpty(), "Expected actualItems to be empty");
  }
}
