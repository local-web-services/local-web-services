package io.localwebservices.lws.unit.providers.dynamodb;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.localwebservices.lws.providers.dynamodb.DynamoDbStore;
import io.localwebservices.lws.providers.dynamodb.TableDef;
import java.util.List;
import java.util.Map;
import org.junit.jupiter.api.Test;

public class DynamoDbStoreCreateTableTest {

  @Test
  public void createTable_hashOnly_storesTable() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();
    String expectedTableName = "Users";

    // Act
    store.createTable(expectedTableName, "id", "S", null, null, List.of());

    // Assert
    assertTrue(
        store.tableExists(expectedTableName),
        "Expected condition to be true: store.tableExists(expectedTableName)");
  }

  @Test
  public void createTable_hashAndSort_storesTable() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();
    String expectedTableName = "Orders";

    // Act
    store.createTable(expectedTableName, "pk", "S", "sk", "S", List.of());

    // Assert
    assertTrue(
        store.tableExists(expectedTableName),
        "Expected condition to be true: store.tableExists(expectedTableName)");
  }

  @Test
  public void tableExists_unknownTable_returnsFalse() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();
    String tableName = "NonExistent";

    // Act
    boolean actualResult = store.tableExists(tableName);

    // Assert
    assertFalse(actualResult, "Expected condition to be false: actualResult");
  }

  @Test
  public void getTable_existingTable_returnsTableDef() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();
    String tableName = "Users";
    store.createTable(tableName, "id", "S", null, null, List.of());

    // Act
    TableDef actualTable = store.getTable(tableName);

    // Assert
    assertNotNull(actualTable, "Expected actualTable to not be null");
  }

  @Test
  public void getTable_unknownTable_throwsRuntimeException() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();

    // Act & Assert
    assertThrows(RuntimeException.class, () -> store.getTable("missing"));
  }

  @Test
  public void deleteTable_existingTable_removesIt() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();
    String tableName = "Users";
    store.createTable(tableName, "id", "S", null, null, List.of());

    // Act
    store.deleteTable(tableName);

    // Assert
    assertFalse(
        store.tableExists(tableName),
        "Expected condition to be false: store.tableExists(tableName)");
  }

  @Test
  public void deleteTable_unknownTable_throwsRuntimeException() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();

    // Act & Assert
    assertThrows(RuntimeException.class, () -> store.deleteTable("missing"));
  }

  @Test
  public void listTables_twoTables_returnsBothNames() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();
    store.createTable("Alpha", "id", "S", null, null, List.of());
    store.createTable("Beta", "id", "S", null, null, List.of());
    int expectedCount = 2;

    // Act
    List<String> actualNames = store.listTables();

    // Assert
    assertEquals(
        expectedCount, actualNames.size(), "Expected actualNames.size() to match expectedCount");
    assertTrue(actualNames.contains("Alpha"), "Expected value to contain expected substring");
    assertTrue(actualNames.contains("Beta"), "Expected value to contain expected substring");
  }

  @Test
  public void describeTable_returnsTableName() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();
    String expectedTableName = "Users";
    store.createTable(expectedTableName, "id", "S", null, null, List.of());

    // Act
    Map<String, Object> actualDesc = store.describeTable(expectedTableName);

    // Assert
    assertEquals(expectedTableName, actualDesc.get("TableName"), "Expected tableName to match");
  }

  @Test
  public void reset_clearsAllTables() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();
    String tableName = "Users";
    store.createTable(tableName, "id", "S", null, null, List.of());

    // Act
    store.reset();

    // Assert
    assertFalse(
        store.tableExists(tableName),
        "Expected condition to be false: store.tableExists(tableName)");
  }
}
