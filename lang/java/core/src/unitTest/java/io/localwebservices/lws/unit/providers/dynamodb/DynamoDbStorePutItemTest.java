package io.localwebservices.lws.unit.providers.dynamodb;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;

import io.localwebservices.lws.providers.dynamodb.DynamoDbStore;
import java.util.List;
import java.util.Map;
import org.junit.jupiter.api.Test;

public class DynamoDbStorePutItemTest {

  private DynamoDbStore storeWithTable() {
    DynamoDbStore store = new DynamoDbStore();
    store.createTable("T", "id", "S", null, null, List.of());
    return store;
  }

  @Test
  public void putItem_newItem_storedSuccessfully() {
    // Arrange
    DynamoDbStore store = storeWithTable();
    Map<String, Object> item = Map.of("id", Map.of("S", "v1"), "name", Map.of("S", "Alice"));
    Map<String, Object> keyAttr = Map.of("id", Map.of("S", "v1"));

    // Act
    store.putItem("T", item);
    Map<String, Object> actualItem = store.getItem("T", keyAttr);

    // Assert
    assertNotNull(actualItem, "Expected actualItem to not be null");
  }

  @Test
  public void putItem_overwritesExistingItem() {
    // Arrange
    DynamoDbStore store = storeWithTable();
    Map<String, Object> originalItem =
        Map.of("id", Map.of("S", "v1"), "name", Map.of("S", "Alice"));
    Map<String, Object> updatedItem = Map.of("id", Map.of("S", "v1"), "name", Map.of("S", "Bob"));
    Map<String, Object> keyAttr = Map.of("id", Map.of("S", "v1"));
    Map<String, Object> expectedName = Map.of("S", "Bob");

    // Act
    store.putItem("T", originalItem);
    store.putItem("T", updatedItem);
    Map<String, Object> actualItem = store.getItem("T", keyAttr);

    // Assert
    assertNotNull(actualItem, "Expected actualItem to not be null");
    assertEquals(expectedName, actualItem.get("name"), "Expected name to match");
  }

  @Test
  public void getItem_nonExistentKey_returnsNull() {
    // Arrange
    DynamoDbStore store = storeWithTable();
    Map<String, Object> keyAttr = Map.of("id", Map.of("S", "missing"));

    // Act
    Map<String, Object> actualItem = store.getItem("T", keyAttr);

    // Assert
    assertNull(actualItem, "Expected actualItem to be null");
  }

  @Test
  public void putItem_withSortKey_roundtrip() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();
    store.createTable("Composite", "pk", "S", "sk", "S", List.of());
    Map<String, Object> item =
        Map.of("pk", Map.of("S", "p1"), "sk", Map.of("S", "s1"), "data", Map.of("S", "hello"));
    Map<String, Object> keyAttr = Map.of("pk", Map.of("S", "p1"), "sk", Map.of("S", "s1"));

    // Act
    store.putItem("Composite", item);
    Map<String, Object> actualItem = store.getItem("Composite", keyAttr);

    // Assert
    assertNotNull(actualItem, "Expected actualItem to not be null");
  }
}
