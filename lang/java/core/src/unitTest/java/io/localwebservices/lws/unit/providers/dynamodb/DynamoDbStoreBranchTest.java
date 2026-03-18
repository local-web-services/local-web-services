package io.localwebservices.lws.unit.providers.dynamodb;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.localwebservices.lws.providers.dynamodb.DynamoDbStore;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import org.junit.jupiter.api.Test;

public class DynamoDbStoreBranchTest {

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

  private static Map<String, Object> boolAttr(boolean value) {
    Map<String, Object> m = new LinkedHashMap<>();
    m.put("BOOL", value);
    return m;
  }

  @Test
  public void putItem_numericPkType_storesAndRetrievesCorrectly() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();
    String tableName = "num-pk-table";
    store.createTable(tableName, "id", "N", null, null, List.of());
    Map<String, Object> item = new LinkedHashMap<>();
    item.put("id", numAttr("42"));
    item.put("name", strAttr("widget"));

    // Act
    store.putItem(tableName, item);
    Map<String, Object> actualItem = store.getItem(tableName, Map.of("id", numAttr("42")));

    // Assert
    assertNotNull(actualItem);
    assertEquals(strAttr("widget"), actualItem.get("name"));
  }

  @Test
  public void query_withNumericEquality_returnsMatch() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();
    String tableName = "num-query-table";
    store.createTable(tableName, "pk", "S", "score", "N", List.of());
    Map<String, Object> item1 = new LinkedHashMap<>();
    item1.put("pk", strAttr("user"));
    item1.put("score", numAttr("100"));
    Map<String, Object> item2 = new LinkedHashMap<>();
    item2.put("pk", strAttr("user"));
    item2.put("score", numAttr("200"));
    store.putItem(tableName, item1);
    store.putItem(tableName, item2);
    int expectedCount = 1;

    // Act
    List<Map<String, Object>> actualItems =
        store.query(tableName, "pk = :pk AND score = :score", null,
            Map.of(":pk", strAttr("user"), ":score", numAttr("100")),
            null, null, true, null, null);

    // Assert
    assertEquals(expectedCount, actualItems.size());
  }

  @Test
  public void scan_withNumericEqualityFilter_returnsMatchingItems() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();
    String tableName = "num-scan-table";
    store.createTable(tableName, "pk", "S", null, null, List.of());
    Map<String, Object> item1 = new LinkedHashMap<>();
    item1.put("pk", strAttr("a"));
    item1.put("score", numAttr("100"));
    Map<String, Object> item2 = new LinkedHashMap<>();
    item2.put("pk", strAttr("b"));
    item2.put("score", numAttr("200"));
    store.putItem(tableName, item1);
    store.putItem(tableName, item2);
    int expectedCount = 1;

    // Act
    List<Map<String, Object>> actualItems =
        store.scan(tableName, "score = :val", null,
            Map.of(":val", numAttr("100")), null, null);

    // Assert
    assertEquals(expectedCount, actualItems.size());
  }

  @Test
  public void scan_filterWithBoolAttribute_returnsMatchingItems() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();
    String tableName = "bool-filter-table";
    store.createTable(tableName, "pk", "S", null, null, List.of());
    Map<String, Object> item1 = new LinkedHashMap<>();
    item1.put("pk", strAttr("a"));
    item1.put("active", boolAttr(true));
    Map<String, Object> item2 = new LinkedHashMap<>();
    item2.put("pk", strAttr("b"));
    item2.put("active", boolAttr(false));
    store.putItem(tableName, item1);
    store.putItem(tableName, item2);
    int expectedCount = 1;

    // Act
    List<Map<String, Object>> actualItems =
        store.scan(tableName, "active = :val", null,
            Map.of(":val", boolAttr(true)), null, null);

    // Assert
    assertEquals(expectedCount, actualItems.size());
  }

  @Test
  public void updateItem_addExpression_nonNumericValue_setsAttribute() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();
    String tableName = "add-nonnumeric-table";
    store.createTable(tableName, "pk", "S", null, null, List.of());
    Map<String, Object> item = new LinkedHashMap<>();
    item.put("pk", strAttr("r1"));
    store.putItem(tableName, item);

    // Act — ADD with a string value (not a N-typed map) falls to the generic put
    store.updateItem(tableName,
        Map.of("pk", strAttr("r1")),
        "ADD label :lbl",
        null,
        Map.of(":lbl", strAttr("new-label")));

    // Assert
    Map<String, Object> actualItem = store.getItem(tableName, Map.of("pk", strAttr("r1")));
    assertEquals(strAttr("new-label"), actualItem.get("label"));
  }

  @Test
  public void scan_withExclusiveStartKeyAndLimit_paginatesCorrectly() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();
    String tableName = "page-limit-table";
    store.createTable(tableName, "pk", "S", null, null, List.of());
    store.putItem(tableName, new LinkedHashMap<>(Map.of("pk", strAttr("a"))));
    store.putItem(tableName, new LinkedHashMap<>(Map.of("pk", strAttr("b"))));
    store.putItem(tableName, new LinkedHashMap<>(Map.of("pk", strAttr("c"))));
    store.putItem(tableName, new LinkedHashMap<>(Map.of("pk", strAttr("d"))));

    // Act — first page, then second page with limit
    List<Map<String, Object>> firstPage = store.scan(tableName, null, null, null, 2, null);
    Map<String, Object> lastOfFirst = firstPage.get(firstPage.size() - 1);
    List<Map<String, Object>> actualSecondPage = store.scan(tableName, null, null, null, 1, lastOfFirst);

    // Assert
    assertEquals(1, actualSecondPage.size());
  }

  @Test
  public void query_beginsWithOnNullItem_returnsFalse() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();
    String tableName = "null-begins-table";
    store.createTable(tableName, "pk", "S", "sk", "S", List.of());
    Map<String, Object> item = new LinkedHashMap<>();
    item.put("pk", strAttr("user"));
    // sk intentionally omitted so resolveScalarFromItem returns null
    store.putItem(tableName, item);
    int expectedCount = 0;

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
  public void query_betweenOnNullAttribute_returnsFalse() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();
    String tableName = "null-between-table";
    store.createTable(tableName, "pk", "S", "sk", "S", List.of());
    Map<String, Object> item = new LinkedHashMap<>();
    item.put("pk", strAttr("user"));
    // sk intentionally omitted so itemVal is null in between check
    store.putItem(tableName, item);
    int expectedCount = 0;

    // Act
    List<Map<String, Object>> actualItems =
        store.query(tableName,
            "pk = :pk AND sk BETWEEN :lo AND :hi",
            null,
            Map.of(":pk", strAttr("user"), ":lo", strAttr("a"), ":hi", strAttr("z")),
            null, null, true, null, null);

    // Assert
    assertEquals(expectedCount, actualItems.size());
  }

  @Test
  public void getItem_withPlainStringKey_resolvedCorrectly() {
    // Arrange — use raw scalar (not DynamoDB typed map) as key value
    DynamoDbStore store = new DynamoDbStore();
    String tableName = "plain-key-table";
    store.createTable(tableName, "pk", "S", null, null, List.of());
    Map<String, Object> item = new LinkedHashMap<>();
    item.put("pk", "plain-key");
    item.put("data", "value");
    store.putItem(tableName, item);

    // Act
    Map<String, Object> actualItem = store.getItem(tableName, Map.of("pk", "plain-key"));

    // Assert
    assertNotNull(actualItem);
    assertEquals("value", actualItem.get("data"));
  }

  @Test
  public void scan_filterWithUnresolvableExprValue_treatsAsLiteral() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();
    String tableName = "literal-filter-table";
    store.createTable(tableName, "pk", "S", null, null, List.of());
    Map<String, Object> item = new LinkedHashMap<>();
    item.put("pk", strAttr("x"));
    item.put("status", strAttr("active"));
    store.putItem(tableName, item);
    int expectedCount = 1;

    // Act — exprValues is null, so literal "active" is used as the comparison value
    List<Map<String, Object>> actualItems =
        store.scan(tableName, "status = active", null, null, null, null);

    // Assert
    assertEquals(expectedCount, actualItems.size());
  }
}
