package io.localwebservices.lws.unit.providers.dynamodb;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.localwebservices.lws.providers.dynamodb.DynamoDbStore;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import org.junit.jupiter.api.Test;

public class DynamoDbStoreScanQueryBranchTest {

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

  @Test
  public void scan_emptyFilterExpr_returnsAllItems() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();
    String tableName = "scan-empty-filter-table";
    store.createTable(tableName, "pk", "S", null, null, List.of());
    store.putItem(tableName, new LinkedHashMap<>(Map.of("pk", strAttr("a"))));
    store.putItem(tableName, new LinkedHashMap<>(Map.of("pk", strAttr("b"))));
    int expectedCount = 2;

    // Act
    List<Map<String, Object>> actualItems = store.scan(tableName, "", null, null, null, null);

    // Assert
    assertEquals(
        expectedCount, actualItems.size(), "Expected actualItems.size() to match expectedCount");
  }

  @Test
  public void scan_limitSetButNotTriggered_returnsAllItems() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();
    String tableName = "scan-limit-not-triggered-table";
    store.createTable(tableName, "pk", "S", null, null, List.of());
    store.putItem(tableName, new LinkedHashMap<>(Map.of("pk", strAttr("a"))));
    store.putItem(tableName, new LinkedHashMap<>(Map.of("pk", strAttr("b"))));
    int expectedCount = 2;

    // Act — limit=10, but only 2 items exist, so size <= limit and limit is not applied
    List<Map<String, Object>> actualItems = store.scan(tableName, null, null, null, 10, null);

    // Assert
    assertEquals(
        expectedCount, actualItems.size(), "Expected actualItems.size() to match expectedCount");
  }

  @Test
  public void query_emptyKeyConditionExpr_returnsAllItems() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();
    String tableName = "query-empty-kce-table";
    store.createTable(tableName, "pk", "S", null, null, List.of());
    store.putItem(tableName, new LinkedHashMap<>(Map.of("pk", strAttr("a"))));
    store.putItem(tableName, new LinkedHashMap<>(Map.of("pk", strAttr("b"))));
    int expectedCount = 2;

    // Act — keyConditionExpr is empty string, so no key filtering is applied
    List<Map<String, Object>> actualItems =
        store.query(tableName, "", null, null, null, null, true, null, null);

    // Assert
    assertEquals(
        expectedCount, actualItems.size(), "Expected actualItems.size() to match expectedCount");
  }

  @Test
  public void query_emptyFilterExpr_returnsAllItems() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();
    String tableName = "query-empty-filter-table";
    store.createTable(tableName, "pk", "S", null, null, List.of());
    store.putItem(tableName, new LinkedHashMap<>(Map.of("pk", strAttr("a"))));
    store.putItem(tableName, new LinkedHashMap<>(Map.of("pk", strAttr("b"))));
    int expectedCount = 2;

    // Act — filterExpr is empty string, so no filter is applied
    List<Map<String, Object>> actualItems =
        store.query(tableName, null, null, null, null, "", true, null, null);

    // Assert
    assertEquals(
        expectedCount, actualItems.size(), "Expected actualItems.size() to match expectedCount");
  }

  @Test
  public void query_emptyExclusiveStartKey_returnsAllItems() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();
    String tableName = "query-empty-esk-table";
    store.createTable(tableName, "pk", "S", null, null, List.of());
    store.putItem(tableName, new LinkedHashMap<>(Map.of("pk", strAttr("a"))));
    store.putItem(tableName, new LinkedHashMap<>(Map.of("pk", strAttr("b"))));
    int expectedCount = 2;

    // Act — exclusiveStartKey is not null but is an empty map, so no pagination is applied
    List<Map<String, Object>> actualItems =
        store.query(tableName, null, null, null, null, null, true, null, new LinkedHashMap<>());

    // Assert
    assertEquals(
        expectedCount, actualItems.size(), "Expected actualItems.size() to match expectedCount");
  }

  @Test
  public void extractScalar_viaNumericPk_returnsNumber() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();
    String tableName = "numeric-pk-table";
    store.createTable(tableName, "pk", "N", null, null, List.of());
    Map<String, Object> item = new LinkedHashMap<>();
    item.put("pk", numAttr("42"));
    item.put("name", strAttr("widget"));
    store.putItem(tableName, item);

    // Act — getItem calls extractScalar({N: "42"}), hitting the containsKey("N") true branch
    Map<String, Object> actualItem = store.getItem(tableName, Map.of("pk", numAttr("42")));

    // Assert
    assertNotNull(actualItem, "Expected actualItem to not be null");
  }

  @Test
  public void extractScalar_viaUnknownTypeAttrInPk_doesNotThrow() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();
    String tableName = "unknown-pk-type-table";
    store.createTable(tableName, "pk", "S", null, null, List.of());
    // pk value is a Map with key "M" — not S, N, or B — so extractScalar falls through
    Map<String, Object> nestedVal = new LinkedHashMap<>();
    nestedVal.put("nested", "val");
    Map<String, Object> mTypedAttr = new LinkedHashMap<>();
    mTypedAttr.put("M", nestedVal);
    Map<String, Object> item = new LinkedHashMap<>();
    item.put("pk", mTypedAttr);

    // Act — putItem calls extractScalar({M: {nested: val}}), hitting the "B" false branch
    store.putItem(tableName, item);
    Map<String, Object> actualItem = store.getItem(tableName, item);

    // Assert
    assertNotNull(actualItem, "Expected actualItem to not be null");
  }

  @Test
  public void describeTable_withGsis_includesGsiInDescription() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();
    String tableName = "gsi-table";
    List<Map<String, Object>> gsis =
        List.of(
            Map.of(
                "IndexName",
                "myGsi",
                "KeySchema",
                List.of(Map.of("AttributeName", "sk", "KeyType", "HASH"))));
    store.createTable(tableName, "pk", "S", null, null, gsis);
    String expectedKey = "GlobalSecondaryIndexes";

    // Act
    Map<String, Object> actualDescription = store.describeTable(tableName);

    // Assert
    assertTrue(
        actualDescription.containsKey(expectedKey), "Expected map to contain the expected key");
  }

  @Test
  public void batchWriteItems_withDeletes_deletesItems() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();
    String tableName = "batch-delete-table";
    store.createTable(tableName, "pk", "S", null, null, List.of());
    Map<String, Object> itemA = new LinkedHashMap<>();
    itemA.put("pk", strAttr("a"));
    Map<String, Object> itemB = new LinkedHashMap<>();
    itemB.put("pk", strAttr("b"));
    store.putItem(tableName, itemA);
    store.putItem(tableName, itemB);

    // Act — non-empty deletes list exercises the deletes for-each loop body
    Map<String, Object> deleteKeyA = new LinkedHashMap<>();
    deleteKeyA.put("pk", strAttr("a"));
    store.batchWriteItems(tableName, List.of(), List.of(deleteKeyA));

    // Assert
    Map<String, Object> actualDeletedItem = store.getItem(tableName, Map.of("pk", strAttr("a")));
    Map<String, Object> actualSurvivingItem = store.getItem(tableName, Map.of("pk", strAttr("b")));
    assertNull(actualDeletedItem, "Expected actualDeletedItem to be null");
    assertNotNull(actualSurvivingItem, "Expected actualSurvivingItem to not be null");
  }
}
