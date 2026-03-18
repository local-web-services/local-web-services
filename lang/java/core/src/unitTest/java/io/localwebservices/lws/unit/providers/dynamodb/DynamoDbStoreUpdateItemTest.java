package io.localwebservices.lws.unit.providers.dynamodb;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import io.localwebservices.lws.providers.dynamodb.DynamoDbStore;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import org.junit.jupiter.api.Test;

public class DynamoDbStoreUpdateItemTest {

  @Test
  public void updateItem_setNewAttribute_updatesItem() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();
    store.createTable("T", "id", "S", null, null, List.of());
    Map<String, Object> originalItem = new LinkedHashMap<>();
    originalItem.put("id", Map.of("S", "v1"));
    originalItem.put("name", Map.of("S", "Alice"));
    store.putItem("T", originalItem);
    Map<String, Object> keyAttr = Map.of("id", Map.of("S", "v1"));
    String updateExpression = "SET #n = :n";
    Map<String, String> exprNames = Map.of("#n", "name");
    Map<String, Object> exprValues = Map.of(":n", Map.of("S", "Bob"));
    Map<String, Object> expectedName = Map.of("S", "Bob");

    // Act
    store.updateItem("T", keyAttr, updateExpression, exprNames, exprValues);
    Map<String, Object> actualItem = store.getItem("T", keyAttr);

    // Assert
    assertNotNull(actualItem);
    assertEquals(expectedName, actualItem.get("name"));
  }
}
