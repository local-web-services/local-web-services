package io.localwebservices.lws.unit.providers.dynamodb;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.localwebservices.lws.providers.dynamodb.DynamoDbStore;
import java.util.List;
import java.util.Map;
import org.junit.jupiter.api.Test;

public class DynamoDbStoreCrudTest {

  @Test
  public void createTable_newName_storesTable() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();
    String expectedName = "my-table";

    // Act
    store.createTable(expectedName, "pk", "S", null, null, List.of());

    // Assert
    assertTrue(
        store.tableExists(expectedName),
        "Expected condition to be true: store.tableExists(expectedName)");
  }

  @Test
  public void tableExists_missingTable_returnsFalse() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();

    // Act
    boolean actualResult = store.tableExists("nonexistent");

    // Assert
    assertFalse(actualResult, "Expected condition to be false: actualResult");
  }

  @Test
  public void getTable_missingTable_throwsException() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();

    // Act & Assert
    assertThrows(RuntimeException.class, () -> store.getTable("nonexistent"));
  }

  @Test
  public void deleteTable_existingTable_removesTable() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();
    String tableName = "delete-me";
    store.createTable(tableName, "pk", "S", null, null, List.of());

    // Act
    store.deleteTable(tableName);

    // Assert
    assertFalse(
        store.tableExists(tableName),
        "Expected condition to be false: store.tableExists(tableName)");
  }

  @Test
  public void deleteTable_missingTable_throwsException() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();

    // Act & Assert
    assertThrows(RuntimeException.class, () -> store.deleteTable("nonexistent"));
  }

  @Test
  public void listTables_twoTables_returnsBothNames() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();
    store.createTable("table-a", "pk", "S", null, null, List.of());
    store.createTable("table-b", "pk", "S", null, null, List.of());
    int expectedCount = 2;

    // Act
    List<String> actualNames = store.listTables();

    // Assert
    assertEquals(
        expectedCount, actualNames.size(), "Expected actualNames.size() to match expectedCount");
    assertTrue(actualNames.contains("table-a"), "Expected value to contain expected substring");
    assertTrue(actualNames.contains("table-b"), "Expected value to contain expected substring");
  }

  @Test
  public void reset_clearsAllTables() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();
    store.createTable("reset-table", "pk", "S", null, null, List.of());

    // Act
    store.reset();

    // Assert
    assertFalse(store.tableExists("reset-table"), "Expected values to match");
  }

  @Test
  public void putItem_andGetItem_roundTrip() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();
    String tableName = "items-table";
    store.createTable(tableName, "pk", "S", null, null, List.of());
    Map<String, Object> expectedItem =
        Map.of("pk", Map.of("S", "key-1"), "value", Map.of("S", "hello"));

    // Act
    store.putItem(tableName, expectedItem);
    Map<String, Object> actualItem = store.getItem(tableName, Map.of("pk", Map.of("S", "key-1")));

    // Assert
    assertNotNull(actualItem, "Expected actualItem to not be null");
    assertEquals(expectedItem.get("value"), actualItem.get("value"), "Expected values to match");
  }

  @Test
  public void getItem_missingKey_returnsNull() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();
    String tableName = "empty-table";
    store.createTable(tableName, "pk", "S", null, null, List.of());

    // Act
    Map<String, Object> actualItem = store.getItem(tableName, Map.of("pk", Map.of("S", "missing")));

    // Assert
    assertNull(actualItem, "Expected actualItem to be null");
  }

  @Test
  public void deleteItem_existingKey_removesItem() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();
    String tableName = "del-item-table";
    store.createTable(tableName, "pk", "S", null, null, List.of());
    Map<String, Object> item = Map.of("pk", Map.of("S", "to-delete"));
    store.putItem(tableName, item);

    // Act
    store.deleteItem(tableName, Map.of("pk", Map.of("S", "to-delete")));

    // Assert
    assertNull(
        store.getItem(tableName, Map.of("pk", Map.of("S", "to-delete"))),
        "Expected values to match");
  }

  @Test
  public void deleteItem_missingTable_doesNotThrow() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();

    // Act & Assert — no exception thrown
    store.deleteItem("ghost-table", Map.of("pk", Map.of("S", "any")));
  }

  @Test
  public void describeTable_returnsTableMetadata() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();
    String expectedName = "describe-table";
    store.createTable(expectedName, "pk", "S", "sk", "N", List.of());

    // Act
    Map<String, Object> actualDesc = store.describeTable(expectedName);

    // Assert
    assertEquals(expectedName, actualDesc.get("TableName"), "Expected name to match");
    assertEquals("ACTIVE", actualDesc.get("TableStatus"), "Expected values to match");
    assertNotNull(actualDesc.get("KeySchema"), "Expected values to match");
  }

  @Test
  public void putItem_withSortKey_storesToDistinctSlots() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();
    String tableName = "sk-table";
    store.createTable(tableName, "pk", "S", "sk", "S", List.of());

    // Act
    store.putItem(
        tableName,
        Map.of("pk", Map.of("S", "p1"), "sk", Map.of("S", "s1"), "data", Map.of("S", "v1")));
    store.putItem(
        tableName,
        Map.of("pk", Map.of("S", "p1"), "sk", Map.of("S", "s2"), "data", Map.of("S", "v2")));

    // Assert
    assertEquals(
        2,
        store.listTables().size() > 0
            ? store.scan(tableName, null, null, null, null, null).size()
            : 0);
    Map<String, Object> actualItem1 =
        store.getItem(tableName, Map.of("pk", Map.of("S", "p1"), "sk", Map.of("S", "s1")));
    Map<String, Object> actualItem2 =
        store.getItem(tableName, Map.of("pk", Map.of("S", "p1"), "sk", Map.of("S", "s2")));
    assertNotNull(actualItem1, "Expected actualItem1 to not be null");
    assertNotNull(actualItem2, "Expected actualItem2 to not be null");
  }
}
