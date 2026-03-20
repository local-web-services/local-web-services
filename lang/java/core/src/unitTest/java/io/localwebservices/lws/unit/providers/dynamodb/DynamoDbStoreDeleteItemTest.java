package io.localwebservices.lws.unit.providers.dynamodb;

import static org.junit.jupiter.api.Assertions.assertNull;

import io.localwebservices.lws.providers.dynamodb.DynamoDbStore;
import java.util.List;
import java.util.Map;
import org.junit.jupiter.api.Test;

public class DynamoDbStoreDeleteItemTest {

  @Test
  public void deleteItem_existingItem_removesIt() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();
    store.createTable("T", "id", "S", null, null, List.of());
    Map<String, Object> item = Map.of("id", Map.of("S", "v1"), "data", Map.of("S", "hello"));
    store.putItem("T", item);
    Map<String, Object> keyAttr = Map.of("id", Map.of("S", "v1"));

    // Act
    store.deleteItem("T", keyAttr);
    Map<String, Object> actualItem = store.getItem("T", keyAttr);

    // Assert
    assertNull(actualItem, "Expected actualItem to be null");
  }

  @Test
  public void deleteItem_nonExistentItem_noOp() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();
    store.createTable("T", "id", "S", null, null, List.of());
    Map<String, Object> keyAttr = Map.of("id", Map.of("S", "does-not-exist"));

    // Act — no exception expected
    store.deleteItem("T", keyAttr);

    // Assert
    assertNull(store.getItem("T", keyAttr), "Expected store.getItem("T", keyAttr) to be null");
  }
}
