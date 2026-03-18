package io.localwebservices.lws.unit.providers.dynamodb;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import io.localwebservices.lws.providers.dynamodb.DynamoDbStore;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class DynamoDbStoreQueryAdvancedTest {

  private DynamoDbStore store;

  @BeforeEach
  void setUp() {
    store = new DynamoDbStore();
  }

  @Test
  void query_withFilterExpr_filtersResults() {
    // Arrange
    store.createTable("colors", "pk", "S", null, null, List.of());
    Map<String, Object> item1 = new LinkedHashMap<>();
    item1.put("pk", Map.of("S", "p1"));
    item1.put("color", Map.of("S", "blue"));
    Map<String, Object> item2 = new LinkedHashMap<>();
    item2.put("pk", Map.of("S", "p2"));
    item2.put("color", Map.of("S", "red"));
    Map<String, Object> item3 = new LinkedHashMap<>();
    item3.put("pk", Map.of("S", "p3"));
    item3.put("color", Map.of("S", "blue"));
    store.putItem("colors", item1);
    store.putItem("colors", item2);
    store.putItem("colors", item3);

    Map<String, Object> exprValues = new LinkedHashMap<>();
    exprValues.put(":c", Map.of("S", "blue"));

    int expectedCount = 2;

    // Act
    List<Map<String, Object>> actualItems =
        store.query("colors", null, null, exprValues, null, "color = :c", true, null, null);

    // Assert
    assertEquals(expectedCount, actualItems.size());
  }

  @Test
  void query_scanIndexForwardFalse_reversesList() {
    // Arrange
    store.createTable("ordered", "pk", "S", "sk", "S", List.of());
    Map<String, Object> itemA = new LinkedHashMap<>();
    itemA.put("pk", Map.of("S", "user1"));
    itemA.put("sk", Map.of("S", "a"));
    Map<String, Object> itemB = new LinkedHashMap<>();
    itemB.put("pk", Map.of("S", "user1"));
    itemB.put("sk", Map.of("S", "b"));
    Map<String, Object> itemC = new LinkedHashMap<>();
    itemC.put("pk", Map.of("S", "user1"));
    itemC.put("sk", Map.of("S", "c"));
    store.putItem("ordered", itemA);
    store.putItem("ordered", itemB);
    store.putItem("ordered", itemC);

    Map<String, Object> exprValues = new LinkedHashMap<>();
    exprValues.put(":pk", Map.of("S", "user1"));

    String expectedFirstSk = "c";
    String expectedLastSk = "a";

    // Act
    List<Map<String, Object>> actualItems =
        store.query("ordered", "pk = :pk", null, exprValues, null, null, false, null, null);

    // Assert
    assertEquals(3, actualItems.size());
    assertEquals(expectedFirstSk, ((Map<?, ?>) actualItems.get(0).get("sk")).get("S"));
    assertEquals(expectedLastSk, ((Map<?, ?>) actualItems.get(2).get("sk")).get("S"));
  }

  @Test
  void query_withExclusiveStartKey_returnsItemsAfterKey() {
    // Arrange
    store.createTable("paged", "pk", "S", "sk", "S", List.of());
    Map<String, Object> itemA = new LinkedHashMap<>();
    itemA.put("pk", Map.of("S", "user1"));
    itemA.put("sk", Map.of("S", "a"));
    Map<String, Object> itemB = new LinkedHashMap<>();
    itemB.put("pk", Map.of("S", "user1"));
    itemB.put("sk", Map.of("S", "b"));
    Map<String, Object> itemC = new LinkedHashMap<>();
    itemC.put("pk", Map.of("S", "user1"));
    itemC.put("sk", Map.of("S", "c"));
    store.putItem("paged", itemA);
    store.putItem("paged", itemB);
    store.putItem("paged", itemC);

    Map<String, Object> exprValues = new LinkedHashMap<>();
    exprValues.put(":pk", Map.of("S", "user1"));

    Map<String, Object> exclusiveStartKey = new LinkedHashMap<>();
    exclusiveStartKey.put("pk", Map.of("S", "user1"));
    exclusiveStartKey.put("sk", Map.of("S", "b"));

    int expectedCount = 1;
    String expectedSk = "c";

    // Act
    List<Map<String, Object>> actualItems =
        store.query(
            "paged", "pk = :pk", null, exprValues, null, null, true, null, exclusiveStartKey);

    // Assert
    assertEquals(expectedCount, actualItems.size());
    assertEquals(expectedSk, ((Map<?, ?>) actualItems.get(0).get("sk")).get("S"));
  }

  @Test
  void query_withExclusiveStartKeyNotFound_returnsAllItems() {
    // Arrange
    store.createTable("paged2", "pk", "S", "sk", "S", List.of());
    Map<String, Object> itemA = new LinkedHashMap<>();
    itemA.put("pk", Map.of("S", "user1"));
    itemA.put("sk", Map.of("S", "a"));
    Map<String, Object> itemB = new LinkedHashMap<>();
    itemB.put("pk", Map.of("S", "user1"));
    itemB.put("sk", Map.of("S", "b"));
    store.putItem("paged2", itemA);
    store.putItem("paged2", itemB);

    Map<String, Object> exprValues = new LinkedHashMap<>();
    exprValues.put(":pk", Map.of("S", "user1"));

    Map<String, Object> exclusiveStartKey = new LinkedHashMap<>();
    exclusiveStartKey.put("pk", Map.of("S", "user1"));
    exclusiveStartKey.put("sk", Map.of("S", "z"));

    int expectedCount = 2;

    // Act
    List<Map<String, Object>> actualItems =
        store.query(
            "paged2", "pk = :pk", null, exprValues, null, null, true, null, exclusiveStartKey);

    // Assert
    assertEquals(expectedCount, actualItems.size());
  }

  @Test
  void query_withLimit_limitsResults() {
    // Arrange
    store.createTable("limited", "pk", "S", "sk", "S", List.of());
    for (int i = 1; i <= 5; i++) {
      Map<String, Object> item = new LinkedHashMap<>();
      item.put("pk", Map.of("S", "user1"));
      item.put("sk", Map.of("S", "item" + i));
      store.putItem("limited", item);
    }

    Map<String, Object> exprValues = new LinkedHashMap<>();
    exprValues.put(":pk", Map.of("S", "user1"));

    int expectedCount = 2;

    // Act
    List<Map<String, Object>> actualItems =
        store.query("limited", "pk = :pk", null, exprValues, null, null, true, 2, null);

    // Assert
    assertEquals(expectedCount, actualItems.size());
  }

  @Test
  void scan_withExclusiveStartKey_returnsItemsAfterKey() {
    // Arrange
    store.createTable("scanpaged", "pk", "S", null, null, List.of());
    Map<String, Object> itemA = new LinkedHashMap<>();
    itemA.put("pk", Map.of("S", "a"));
    Map<String, Object> itemB = new LinkedHashMap<>();
    itemB.put("pk", Map.of("S", "b"));
    Map<String, Object> itemC = new LinkedHashMap<>();
    itemC.put("pk", Map.of("S", "c"));
    store.putItem("scanpaged", itemA);
    store.putItem("scanpaged", itemB);
    store.putItem("scanpaged", itemC);

    Map<String, Object> exclusiveStartKey = new LinkedHashMap<>();
    exclusiveStartKey.put("pk", Map.of("S", "b"));

    int expectedCount = 1;
    String expectedPk = "c";

    // Act
    List<Map<String, Object>> actualItems =
        store.scan("scanpaged", null, null, null, null, exclusiveStartKey);

    // Assert
    assertEquals(expectedCount, actualItems.size());
    assertEquals(expectedPk, ((Map<?, ?>) actualItems.get(0).get("pk")).get("S"));
  }

  @Test
  void scan_withExclusiveStartKeyNotFound_returnsAll() {
    // Arrange
    store.createTable("scanpaged2", "pk", "S", null, null, List.of());
    Map<String, Object> itemA = new LinkedHashMap<>();
    itemA.put("pk", Map.of("S", "a"));
    Map<String, Object> itemB = new LinkedHashMap<>();
    itemB.put("pk", Map.of("S", "b"));
    store.putItem("scanpaged2", itemA);
    store.putItem("scanpaged2", itemB);

    Map<String, Object> exclusiveStartKey = new LinkedHashMap<>();
    exclusiveStartKey.put("pk", Map.of("S", "z"));

    int expectedCount = 2;

    // Act
    List<Map<String, Object>> actualItems =
        store.scan("scanpaged2", null, null, null, null, exclusiveStartKey);

    // Assert
    assertEquals(expectedCount, actualItems.size());
  }

  @Test
  void updateItem_onNewKey_createsItem() {
    // Arrange
    store.createTable("newitems", "pk", "S", null, null, List.of());
    Map<String, Object> key = new LinkedHashMap<>();
    key.put("pk", Map.of("S", "brand-new"));

    Map<String, Object> exprValues = new LinkedHashMap<>();
    exprValues.put(":n", Map.of("S", "Alice"));

    String expectedName = "Alice";

    // Act
    Map<String, Object> actualItem =
        store.updateItem("newitems", key, "SET #name = :n", Map.of("#name", "name"), exprValues);

    // Assert
    assertNotNull(actualItem);
    assertEquals(expectedName, ((Map<?, ?>) actualItem.get("name")).get("S"));
  }
}
