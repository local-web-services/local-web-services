package io.localwebservices.lws.unit.providers.dynamodb;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.localwebservices.lws.providers.dynamodb.DynamoDbStore;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import org.junit.jupiter.api.Test;

public class DynamoDbStoreQueryTest {

  private static Map<String, Object> strAttr(String value) {
    Map<String, Object> m = new LinkedHashMap<>();
    m.put("S", value);
    return m;
  }

  private static Map<String, Object> numAttr(String value) {
    Map<String, Object> m = new LinkedHashMap<>();
    m.put("N", value);
    return m;
  }

  private static Map<String, Object> mutableItem(String pkValue) {
    Map<String, Object> item = new LinkedHashMap<>();
    item.put("pk", strAttr(pkValue));
    return item;
  }

  @Test
  public void scan_noFilter_returnsAllItems() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();
    String tableName = "scan-table";
    store.createTable(tableName, "pk", "S", null, null, List.of());
    store.putItem(tableName, mutableItem("a"));
    store.putItem(tableName, mutableItem("b"));
    int expectedCount = 2;

    // Act
    List<Map<String, Object>> actualItems = store.scan(tableName, null, null, null, null, null);

    // Assert
    assertEquals(expectedCount, actualItems.size());
  }

  @Test
  public void scan_withLimit_returnsLimitedItems() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();
    String tableName = "limit-table";
    store.createTable(tableName, "pk", "S", null, null, List.of());
    store.putItem(tableName, mutableItem("a"));
    store.putItem(tableName, mutableItem("b"));
    store.putItem(tableName, mutableItem("c"));
    int expectedCount = 2;

    // Act
    List<Map<String, Object>> actualItems = store.scan(tableName, null, null, null, 2, null);

    // Assert
    assertEquals(expectedCount, actualItems.size());
  }

  @Test
  public void scan_withAttributeExistsFilter_returnsMatchingItems() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();
    String tableName = "filter-table";
    store.createTable(tableName, "pk", "S", null, null, List.of());
    Map<String, Object> itemWithFlag = mutableItem("a");
    itemWithFlag.put("flag", strAttr("yes"));
    store.putItem(tableName, itemWithFlag);
    store.putItem(tableName, mutableItem("b"));
    int expectedCount = 1;

    // Act
    List<Map<String, Object>> actualItems =
        store.scan(tableName, "attribute_exists(#f)", Map.of("#f", "flag"), null, null, null);

    // Assert
    assertEquals(expectedCount, actualItems.size());
  }

  @Test
  public void scan_withAttributeNotExistsFilter_returnsMatchingItems() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();
    String tableName = "not-exists-table";
    store.createTable(tableName, "pk", "S", null, null, List.of());
    Map<String, Object> itemWithFlag = mutableItem("a");
    itemWithFlag.put("flag", strAttr("yes"));
    store.putItem(tableName, itemWithFlag);
    store.putItem(tableName, mutableItem("b"));
    int expectedCount = 1;

    // Act
    List<Map<String, Object>> actualItems =
        store.scan(tableName, "attribute_not_exists(#f)", Map.of("#f", "flag"), null, null, null);

    // Assert
    assertEquals(expectedCount, actualItems.size());
  }

  @Test
  public void query_withPkEquals_returnsMatchingItems() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();
    String tableName = "query-table";
    store.createTable(tableName, "pk", "S", null, null, List.of());
    Map<String, Object> itemA = mutableItem("user-1");
    itemA.put("val", strAttr("a"));
    Map<String, Object> itemB = mutableItem("user-2");
    itemB.put("val", strAttr("b"));
    store.putItem(tableName, itemA);
    store.putItem(tableName, itemB);
    int expectedCount = 1;

    // Act
    List<Map<String, Object>> actualItems =
        store.query(tableName, "pk = :pk", null, Map.of(":pk", strAttr("user-1")),
            null, null, true, null, null);

    // Assert
    assertEquals(expectedCount, actualItems.size());
  }

  @Test
  public void query_scanIndexForwardFalse_reversesList() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();
    String tableName = "reverse-table";
    store.createTable(tableName, "pk", "S", "sk", "S", List.of());
    Map<String, Object> item1 = new LinkedHashMap<>();
    item1.put("pk", strAttr("p"));
    item1.put("sk", strAttr("1"));
    item1.put("v", strAttr("first"));
    Map<String, Object> item2 = new LinkedHashMap<>();
    item2.put("pk", strAttr("p"));
    item2.put("sk", strAttr("2"));
    item2.put("v", strAttr("second"));
    store.putItem(tableName, item1);
    store.putItem(tableName, item2);

    // Act
    List<Map<String, Object>> actualForward =
        store.query(tableName, "pk = :pk", null, Map.of(":pk", strAttr("p")),
            null, null, true, null, null);
    List<Map<String, Object>> actualReversed =
        store.query(tableName, "pk = :pk", null, Map.of(":pk", strAttr("p")),
            null, null, false, null, null);

    // Assert
    assertEquals(2, actualForward.size());
    assertEquals(2, actualReversed.size());
    assertFalse(actualForward.get(0).equals(actualReversed.get(0)));
  }

  @Test
  public void updateItem_setExpression_updatesAttribute() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();
    String tableName = "update-table";
    store.createTable(tableName, "pk", "S", null, null, List.of());
    Map<String, Object> item = mutableItem("row-1");
    item.put("status", strAttr("pending"));
    store.putItem(tableName, item);

    // Act
    store.updateItem(tableName,
        Map.of("pk", strAttr("row-1")),
        "SET #s = :s",
        Map.of("#s", "status"),
        Map.of(":s", strAttr("done")));

    // Assert
    Map<String, Object> actualItem = store.getItem(tableName, Map.of("pk", strAttr("row-1")));
    assertEquals(strAttr("done"), actualItem.get("status"));
  }

  @Test
  public void updateItem_removeExpression_removesAttribute() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();
    String tableName = "remove-table";
    store.createTable(tableName, "pk", "S", null, null, List.of());
    Map<String, Object> item = mutableItem("row-1");
    item.put("extra", strAttr("toRemove"));
    store.putItem(tableName, item);

    // Act
    store.updateItem(tableName,
        Map.of("pk", strAttr("row-1")),
        "REMOVE #e",
        Map.of("#e", "extra"),
        null);

    // Assert
    Map<String, Object> actualItem = store.getItem(tableName, Map.of("pk", strAttr("row-1")));
    assertFalse(actualItem.containsKey("extra"));
  }

  @Test
  public void updateItem_addExpression_incrementsNumericAttribute() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();
    String tableName = "add-table";
    store.createTable(tableName, "pk", "S", null, null, List.of());
    Map<String, Object> item = mutableItem("row-1");
    item.put("count", numAttr("5"));
    store.putItem(tableName, item);
    String expectedCount = "8.0";

    // Act
    store.updateItem(tableName,
        Map.of("pk", strAttr("row-1")),
        "ADD #c :delta",
        Map.of("#c", "count"),
        Map.of(":delta", numAttr("3")));

    // Assert
    Map<String, Object> actualItem = store.getItem(tableName, Map.of("pk", strAttr("row-1")));
    Map<?, ?> actualCount = (Map<?, ?>) actualItem.get("count");
    assertEquals(expectedCount, actualCount.get("N"));
  }

  @Test
  public void batchGetItems_returnsFoundItems() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();
    String tableName = "batch-get-table";
    store.createTable(tableName, "pk", "S", null, null, List.of());
    store.putItem(tableName, mutableItem("a"));
    store.putItem(tableName, mutableItem("b"));
    int expectedCount = 2;

    // Act
    List<Map<String, Object>> actualItems = store.batchGetItems(tableName,
        List.of(Map.of("pk", strAttr("a")), Map.of("pk", strAttr("b")), Map.of("pk", strAttr("c"))));

    // Assert
    assertEquals(expectedCount, actualItems.size());
  }

  @Test
  public void batchWriteItems_putsAndDeletesItems() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();
    String tableName = "batch-write-table";
    store.createTable(tableName, "pk", "S", null, null, List.of());
    store.putItem(tableName, mutableItem("to-delete"));

    // Act
    store.batchWriteItems(tableName,
        List.of(mutableItem("new-item")),
        List.of(Map.of("pk", strAttr("to-delete"))));

    // Assert
    assertNotNull(store.getItem(tableName, Map.of("pk", strAttr("new-item"))));
    assertEquals(null, store.getItem(tableName, Map.of("pk", strAttr("to-delete"))));
  }

  @Test
  public void scan_withOrFilter_returnsUnionOfMatches() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();
    String tableName = "or-filter-table";
    store.createTable(tableName, "pk", "S", null, null, List.of());
    Map<String, Object> itemA = mutableItem("a");
    itemA.put("status", strAttr("active"));
    Map<String, Object> itemB = mutableItem("b");
    itemB.put("status", strAttr("inactive"));
    Map<String, Object> itemC = mutableItem("c");
    itemC.put("status", strAttr("pending"));
    store.putItem(tableName, itemA);
    store.putItem(tableName, itemB);
    store.putItem(tableName, itemC);
    int expectedCount = 2;

    // Act
    List<Map<String, Object>> actualItems =
        store.scan(tableName, "#s = :active OR #s = :pending",
            Map.of("#s", "status"),
            Map.of(":active", strAttr("active"), ":pending", strAttr("pending")),
            null, null);

    // Assert
    assertEquals(expectedCount, actualItems.size());
  }

  @Test
  public void scan_withAndFilter_returnsIntersection() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();
    String tableName = "and-filter-table";
    store.createTable(tableName, "pk", "S", null, null, List.of());
    Map<String, Object> itemA = mutableItem("a");
    itemA.put("status", strAttr("active"));
    itemA.put("flag", strAttr("yes"));
    Map<String, Object> itemB = mutableItem("b");
    itemB.put("status", strAttr("active"));
    store.putItem(tableName, itemA);
    store.putItem(tableName, itemB);
    int expectedCount = 1;

    // Act
    List<Map<String, Object>> actualItems =
        store.scan(tableName, "#s = :active AND attribute_exists(#f)",
            Map.of("#s", "status", "#f", "flag"),
            Map.of(":active", strAttr("active")),
            null, null);

    // Assert
    assertEquals(expectedCount, actualItems.size());
  }

  @Test
  public void query_withBeginsWithCondition_returnsMatchingItems() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();
    String tableName = "begins-table";
    store.createTable(tableName, "pk", "S", "sk", "S", List.of());
    Map<String, Object> o1 = new LinkedHashMap<>();
    o1.put("pk", strAttr("user"));
    o1.put("sk", strAttr("order#001"));
    Map<String, Object> o2 = new LinkedHashMap<>();
    o2.put("pk", strAttr("user"));
    o2.put("sk", strAttr("order#002"));
    Map<String, Object> c1 = new LinkedHashMap<>();
    c1.put("pk", strAttr("user"));
    c1.put("sk", strAttr("cart#001"));
    store.putItem(tableName, o1);
    store.putItem(tableName, o2);
    store.putItem(tableName, c1);
    int expectedCount = 2;

    // Act
    List<Map<String, Object>> actualItems =
        store.query(tableName,
            "pk = :pk AND begins_with(sk, :prefix)",
            null,
            Map.of(":pk", strAttr("user"), ":prefix", strAttr("order")),
            null, null, true, null, null);

    // Assert
    assertEquals(expectedCount, actualItems.size());
  }

  @Test
  public void scan_withExclusiveStartKey_resumesPagination() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();
    String tableName = "page-table";
    store.createTable(tableName, "pk", "S", null, null, List.of());
    store.putItem(tableName, mutableItem("a"));
    store.putItem(tableName, mutableItem("b"));
    store.putItem(tableName, mutableItem("c"));

    // Act — first page of 2
    List<Map<String, Object>> firstPage = store.scan(tableName, null, null, null, 2, null);
    Map<String, Object> lastKey = firstPage.get(firstPage.size() - 1);
    List<Map<String, Object>> actualSecondPage = store.scan(tableName, null, null, null, null, lastKey);

    // Assert
    assertTrue(actualSecondPage.size() >= 1);
  }

  @Test
  public void describeTable_withGsi_includesGsiInDescription() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();
    String tableName = "gsi-table";
    List<Map<String, Object>> gsis = List.of(Map.of("IndexName", "gsi-status"));
    store.createTable(tableName, "pk", "S", null, null, gsis);

    // Act
    Map<String, Object> actualDesc = store.describeTable(tableName);

    // Assert
    assertTrue(actualDesc.containsKey("GlobalSecondaryIndexes"));
  }

  @Test
  public void query_withFilterExpression_furtherFiltersResults() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();
    String tableName = "filter-query-table";
    store.createTable(tableName, "pk", "S", null, null, List.of());
    Map<String, Object> item1 = mutableItem("user-1");
    item1.put("active", strAttr("true"));
    Map<String, Object> item2 = mutableItem("user-1-inactive");
    item2.put("active", strAttr("false"));
    store.putItem(tableName, item1);
    store.putItem(tableName, item2);
    int expectedCount = 1;

    // Act
    List<Map<String, Object>> actualItems =
        store.query(tableName, "pk = :pk", null,
            Map.of(":pk", strAttr("user-1"), ":active", strAttr("true")),
            null, "active = :active",
            true, null, null);

    // Assert
    assertEquals(expectedCount, actualItems.size());
  }

  @Test
  public void scan_withEmptyFilterExpr_returnsAllItems() {
    // Arrange — exercises L238 false branch: filterExpr != null but isEmpty()
    DynamoDbStore store = new DynamoDbStore();
    String tableName = "empty-filter-table";
    store.createTable(tableName, "pk", "S", null, null, List.of());
    Map<String, Object> itemA = new LinkedHashMap<>(Map.of("pk", strAttr("a")));
    Map<String, Object> itemB = new LinkedHashMap<>(Map.of("pk", strAttr("b")));
    store.putItem(tableName, itemA);
    store.putItem(tableName, itemB);
    int expectedCount = 2;

    // Act — empty string filterExpr should skip filtering
    List<Map<String, Object>> actualItems = store.scan(tableName, "", null, null, null, null);

    // Assert
    assertEquals(expectedCount, actualItems.size());
  }

  @Test
  public void query_withEmptyFilterExpr_returnsAllMatchingKeyItems() {
    // Arrange — exercises L280 false branch: filterExpr != null but isEmpty()
    DynamoDbStore store = new DynamoDbStore();
    String tableName = "empty-query-filter-table";
    store.createTable(tableName, "pk", "S", null, null, List.of());
    Map<String, Object> item = new LinkedHashMap<>(Map.of("pk", strAttr("user-1")));
    store.putItem(tableName, item);
    int expectedCount = 1;

    // Act — empty filterExpr on query
    List<Map<String, Object>> actualItems =
        store.query(tableName, "pk = :pk", null,
            Map.of(":pk", strAttr("user-1")),
            null, "", true, null, null);

    // Assert
    assertEquals(expectedCount, actualItems.size());
  }

  @Test
  public void query_withEmptyKeyCondition_returnsAllItems() {
    // Arrange — exercises L271 false branch: keyConditionExpr != null but isEmpty()
    DynamoDbStore store = new DynamoDbStore();
    String tableName = "empty-keycond-table";
    store.createTable(tableName, "pk", "S", null, null, List.of());
    Map<String, Object> itemA = new LinkedHashMap<>(Map.of("pk", strAttr("a")));
    Map<String, Object> itemB = new LinkedHashMap<>(Map.of("pk", strAttr("b")));
    store.putItem(tableName, itemA);
    store.putItem(tableName, itemB);
    int expectedCount = 2;

    // Act — empty keyConditionExpr skips key filtering
    List<Map<String, Object>> actualItems =
        store.query(tableName, "", null, null, null, null, true, null, null);

    // Assert
    assertEquals(expectedCount, actualItems.size());
  }

  @Test
  public void scan_limitNotExceeded_returnsAllItems() {
    // Arrange — exercises L247 false branch: limit != null but items.size() <= limit
    DynamoDbStore store = new DynamoDbStore();
    String tableName = "under-limit-table";
    store.createTable(tableName, "pk", "S", null, null, List.of());
    Map<String, Object> itemA = new LinkedHashMap<>(Map.of("pk", strAttr("a")));
    store.putItem(tableName, itemA);
    int expectedCount = 1;

    // Act — limit is larger than item count
    List<Map<String, Object>> actualItems = store.scan(tableName, null, null, null, 100, null);

    // Assert
    assertEquals(expectedCount, actualItems.size());
  }

  @Test
  public void query_withEmptyExclusiveStartKey_returnsAllItems() {
    // Arrange — exercises L294 false branch: exclusiveStartKey != null but isEmpty()
    DynamoDbStore store = new DynamoDbStore();
    String tableName = "empty-esk-table";
    store.createTable(tableName, "pk", "S", null, null, List.of());
    Map<String, Object> itemA = new LinkedHashMap<>(Map.of("pk", strAttr("a")));
    Map<String, Object> itemB = new LinkedHashMap<>(Map.of("pk", strAttr("b")));
    store.putItem(tableName, itemA);
    store.putItem(tableName, itemB);
    int expectedCount = 2;

    // Act — empty exclusiveStartKey should not paginate
    List<Map<String, Object>> actualItems =
        store.query(tableName, null, null, null, null, null, true, null, Map.of());

    // Assert
    assertEquals(expectedCount, actualItems.size());
  }

  @Test
  public void query_exclusiveStartKeyNotFoundInResults_returnsAll() {
    // Arrange — exercises L297/L303: for loop runs but key not found, idx stays -1
    DynamoDbStore store = new DynamoDbStore();
    String tableName = "esk-miss-table";
    store.createTable(tableName, "pk", "S", null, null, List.of());
    Map<String, Object> itemA = new LinkedHashMap<>(Map.of("pk", strAttr("a")));
    Map<String, Object> itemB = new LinkedHashMap<>(Map.of("pk", strAttr("b")));
    store.putItem(tableName, itemA);
    store.putItem(tableName, itemB);
    int expectedCount = 2;

    // Act — exclusiveStartKey references an item not in results → idx=-1 → no subList
    List<Map<String, Object>> actualItems =
        store.query(tableName, null, null, null, null, null, true, null,
            Map.of("pk", strAttr("nonexistent")));

    // Assert — all items returned (idx stays -1)
    assertEquals(expectedCount, actualItems.size());
  }

}
