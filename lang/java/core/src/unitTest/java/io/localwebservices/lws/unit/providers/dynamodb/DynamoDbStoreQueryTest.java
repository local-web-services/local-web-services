package io.localwebservices.lws.unit.providers.dynamodb;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.localwebservices.lws.providers.dynamodb.DynamoDbStore;
import java.util.List;
import java.util.Map;
import org.junit.jupiter.api.Test;

public class DynamoDbStoreQueryTest {

  private DynamoDbStore storeWithOrdersTable() {
    DynamoDbStore store = new DynamoDbStore();
    store.createTable("Orders", "pk", "S", "sk", "S", List.of());
    return store;
  }

  @Test
  public void query_byPk_returnsMatchingItems() {
    // Arrange
    DynamoDbStore store = storeWithOrdersTable();
    store.putItem("Orders", Map.of("pk", Map.of("S", "user1"), "sk", Map.of("S", "order1")));
    store.putItem("Orders", Map.of("pk", Map.of("S", "user1"), "sk", Map.of("S", "order2")));
    store.putItem("Orders", Map.of("pk", Map.of("S", "user2"), "sk", Map.of("S", "order3")));
    String keyConditionExpr = "#pk = :pk";
    Map<String, String> expectedExprNames = Map.of("#pk", "pk");
    Map<String, Object> expectedExprValues = Map.of(":pk", Map.of("S", "user1"));
    int expectedSize = 2;

    // Act
    List<Map<String, Object>> actualItems =
        store.query(
            "Orders",
            keyConditionExpr,
            expectedExprNames,
            expectedExprValues,
            null,
            null,
            true,
            null,
            null);

    // Assert
    assertEquals(expectedSize, actualItems.size());
  }

  @Test
  public void query_noMatchingPk_returnsEmptyList() {
    // Arrange
    DynamoDbStore store = storeWithOrdersTable();
    store.putItem("Orders", Map.of("pk", Map.of("S", "user1"), "sk", Map.of("S", "order1")));
    String keyConditionExpr = "#pk = :pk";
    Map<String, String> exprNames = Map.of("#pk", "pk");
    Map<String, Object> exprValues = Map.of(":pk", Map.of("S", "unknown"));

    // Act
    List<Map<String, Object>> actualItems =
        store.query(
            "Orders", keyConditionExpr, exprNames, exprValues, null, null, true, null, null);

    // Assert
    assertTrue(actualItems.isEmpty());
  }

  @Test
  public void query_emptyTable_returnsEmptyList() {
    // Arrange
    DynamoDbStore store = storeWithOrdersTable();
    String keyConditionExpr = "#pk = :pk";
    Map<String, String> exprNames = Map.of("#pk", "pk");
    Map<String, Object> exprValues = Map.of(":pk", Map.of("S", "user1"));

    // Act
    List<Map<String, Object>> actualItems =
        store.query(
            "Orders", keyConditionExpr, exprNames, exprValues, null, null, true, null, null);

    // Assert
    assertTrue(actualItems.isEmpty());
  }
}
