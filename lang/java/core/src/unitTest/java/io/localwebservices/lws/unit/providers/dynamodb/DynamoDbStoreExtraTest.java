package io.localwebservices.lws.unit.providers.dynamodb;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNull;

import io.localwebservices.lws.providers.dynamodb.DynamoDbStore;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import org.junit.jupiter.api.Test;

public class DynamoDbStoreExtraTest {

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
  public void updateItem_nullExpression_doesNotModifyItem() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();
    String tableName = "null-expr-table";
    store.createTable(tableName, "pk", "S", null, null, List.of());
    Map<String, Object> item = new LinkedHashMap<>();
    item.put("pk", strAttr("k1"));
    item.put("val", strAttr("original"));
    store.putItem(tableName, item);

    // Act
    store.updateItem(tableName, Map.of("pk", strAttr("k1")), null, null, null);

    // Assert
    Map<String, Object> actualItem = store.getItem(tableName, Map.of("pk", strAttr("k1")));
    assertEquals(strAttr("original"), actualItem.get("val"), "Expected actualItem.get("val") to equal strAttr("original")");
  }

  @Test
  public void updateItem_emptyExpression_doesNotModifyItem() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();
    String tableName = "empty-expr-table";
    store.createTable(tableName, "pk", "S", null, null, List.of());
    Map<String, Object> item = new LinkedHashMap<>();
    item.put("pk", strAttr("k2"));
    item.put("val", strAttr("original"));
    store.putItem(tableName, item);

    // Act
    store.updateItem(tableName, Map.of("pk", strAttr("k2")), "", null, null);

    // Assert
    Map<String, Object> actualItem = store.getItem(tableName, Map.of("pk", strAttr("k2")));
    assertEquals(strAttr("original"), actualItem.get("val"), "Expected actualItem.get("val") to equal strAttr("original")");
  }

  @Test
  public void updateItem_setWithLiteralAttrAndValue_updatesItem() {
    // Arrange — no # or : prefixes (exprNames/exprValues are null)
    DynamoDbStore store = new DynamoDbStore();
    String tableName = "literal-set-table";
    store.createTable(tableName, "pk", "S", null, null, List.of());
    Map<String, Object> item = new LinkedHashMap<>();
    item.put("pk", strAttr("k3"));
    store.putItem(tableName, item);
    String expectedValue = "direct-value";

    // Act
    store.updateItem(
        tableName, Map.of("pk", strAttr("k3")), "SET status = " + expectedValue, null, null);

    // Assert
    Map<String, Object> actualItem = store.getItem(tableName, Map.of("pk", strAttr("k3")));
    assertEquals(expectedValue, actualItem.get("status"), "Expected actualItem.get("status") to equal expectedValue");
  }

  @Test
  public void scan_withNullExclusiveStartKey_returnsAllItems() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();
    String tableName = "null-start-table";
    store.createTable(tableName, "pk", "S", null, null, List.of());
    store.putItem(tableName, new LinkedHashMap<>(Map.of("pk", strAttr("a"))));
    store.putItem(tableName, new LinkedHashMap<>(Map.of("pk", strAttr("b"))));
    int expectedCount = 2;

    // Act — null exclusiveStartKey should return all items
    List<Map<String, Object>> actualItems = store.scan(tableName, null, null, null, null, null);

    // Assert
    assertEquals(expectedCount, actualItems.size(), "Expected actualItems.size() to match expectedCount");
  }

  @Test
  public void scan_withEmptyExclusiveStartKey_returnsAllItems() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();
    String tableName = "empty-start-table";
    store.createTable(tableName, "pk", "S", null, null, List.of());
    store.putItem(tableName, new LinkedHashMap<>(Map.of("pk", strAttr("a"))));
    store.putItem(tableName, new LinkedHashMap<>(Map.of("pk", strAttr("b"))));
    int expectedCount = 2;

    // Act — empty map as exclusiveStartKey — should behave as no start key
    List<Map<String, Object>> actualItems = store.scan(tableName, null, null, null, null, Map.of());

    // Assert
    assertEquals(expectedCount, actualItems.size(), "Expected actualItems.size() to match expectedCount");
  }

  @Test
  public void query_withNullKeyCondition_returnsAllItems() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();
    String tableName = "no-cond-table";
    store.createTable(tableName, "pk", "S", null, null, List.of());
    store.putItem(tableName, new LinkedHashMap<>(Map.of("pk", strAttr("a"))));
    store.putItem(tableName, new LinkedHashMap<>(Map.of("pk", strAttr("b"))));
    int expectedCount = 2;

    // Act — null keyConditionExpr skips filtering
    List<Map<String, Object>> actualItems =
        store.query(tableName, null, null, null, null, null, true, null, null);

    // Assert
    assertEquals(expectedCount, actualItems.size(), "Expected actualItems.size() to match expectedCount");
  }

  @Test
  public void updateItem_addExpressionLiteralAttrLiteralValue_setsAttribute() {
    // Arrange — ADD with no # or : prefix (both null maps)
    DynamoDbStore store = new DynamoDbStore();
    String tableName = "add-literal-table";
    store.createTable(tableName, "pk", "S", null, null, List.of());
    Map<String, Object> item = new LinkedHashMap<>();
    item.put("pk", strAttr("k4"));
    store.putItem(tableName, item);

    // Act
    store.updateItem(tableName, Map.of("pk", strAttr("k4")), "ADD count 5", null, null);

    // Assert
    Map<String, Object> actualItem = store.getItem(tableName, Map.of("pk", strAttr("k4")));
    assertEquals("5", actualItem.get("count"), "Expected actualItem.get("count") to match "5"");
  }

  @Test
  public void updateItem_removeExpressionLiteralAttr_removesAttribute() {
    // Arrange — REMOVE with no # prefix
    DynamoDbStore store = new DynamoDbStore();
    String tableName = "remove-literal-table";
    store.createTable(tableName, "pk", "S", null, null, List.of());
    Map<String, Object> item = new LinkedHashMap<>();
    item.put("pk", strAttr("k5"));
    item.put("temp", strAttr("delete-me"));
    store.putItem(tableName, item);

    // Act
    store.updateItem(tableName, Map.of("pk", strAttr("k5")), "REMOVE temp", null, null);

    // Assert
    Map<String, Object> actualItem = store.getItem(tableName, Map.of("pk", strAttr("k5")));
    assertNull(actualItem.get("temp"), "Expected actualItem.get("temp") to be null");
  }

  @Test
  public void updateItem_expressionWithUnknownPrefix_doesNotModifyItem() {
    // Arrange — exercises L182 false branch: expression starts with neither SET, REMOVE, nor ADD
    DynamoDbStore store = new DynamoDbStore();
    String tableName = "unknown-prefix-table";
    store.createTable(tableName, "pk", "S", null, null, List.of());
    Map<String, Object> item = new LinkedHashMap<>();
    item.put("pk", strAttr("k6"));
    item.put("val", strAttr("unchanged"));
    store.putItem(tableName, item);

    // Act — expression starting with DELETE (not supported) takes no action
    store.updateItem(tableName, Map.of("pk", strAttr("k6")), "DELETE unknown_attr", null, null);

    // Assert — val is unchanged
    Map<String, Object> actualItem = store.getItem(tableName, Map.of("pk", strAttr("k6")));
    assertEquals(strAttr("unchanged"), actualItem.get("val"), "Expected actualItem.get("val") to equal strAttr("unchanged")");
  }

  @Test
  public void updateItem_setExpressionWithHashAttrAndNullExprNames_usesHashLiteral() {
    // Arrange — exercises L160 false branch: exprNames is null, attrExpr starts with #
    DynamoDbStore store = new DynamoDbStore();
    String tableName = "hash-null-names-table";
    store.createTable(tableName, "pk", "S", null, null, List.of());
    Map<String, Object> item = new LinkedHashMap<>();
    item.put("pk", strAttr("k7"));
    store.putItem(tableName, item);

    // Act — exprNames is null, so #attr is used as literal attribute name
    store.updateItem(
        tableName,
        Map.of("pk", strAttr("k7")),
        "SET #attr = :val",
        null,
        Map.of(":val", strAttr("myValue")));

    // Assert — #attr literally becomes the key
    Map<String, Object> actualItem = store.getItem(tableName, Map.of("pk", strAttr("k7")));
    assertEquals(strAttr("myValue"), actualItem.get("#attr"), "Expected actualItem.get("#attr") to equal strAttr("myValue")");
  }

  @Test
  public void updateItem_setExpressionLiteralAttrAndNullExprValues_usesLiteralValue() {
    // Arrange — exercises L165 false branch: exprValues is null, valExpr starts with :
    DynamoDbStore store = new DynamoDbStore();
    String tableName = "colon-null-values-table";
    store.createTable(tableName, "pk", "S", null, null, List.of());
    Map<String, Object> item = new LinkedHashMap<>();
    item.put("pk", strAttr("k8"));
    store.putItem(tableName, item);

    // Act — exprValues is null, so :val is used as literal value string
    store.updateItem(tableName, Map.of("pk", strAttr("k8")), "SET myAttr = :val", null, null);

    // Assert — :val literally becomes the value
    Map<String, Object> actualItem = store.getItem(tableName, Map.of("pk", strAttr("k8")));
    assertEquals(":val", actualItem.get("myAttr"), "Expected actualItem.get("myAttr") to equal ":val"");
  }

  @Test
  public void updateItem_addExpressionWithHashAndColonAndNoExprMaps_setsDirectly() {
    // Arrange — exercises L191 false+null, L195 false+null branches in ADD
    DynamoDbStore store = new DynamoDbStore();
    String tableName = "add-no-maps-table";
    store.createTable(tableName, "pk", "S", null, null, List.of());
    Map<String, Object> item = new LinkedHashMap<>();
    item.put("pk", strAttr("k9"));
    store.putItem(tableName, item);

    // Act — both exprNames and exprValues are null with # and : prefixes
    store.updateItem(tableName, Map.of("pk", strAttr("k9")), "ADD #myAttr :delta", null, null);

    // Assert — #myAttr is used literally, :delta is the value
    Map<String, Object> actualItem = store.getItem(tableName, Map.of("pk", strAttr("k9")));
    assertEquals(":delta", actualItem.get("#myAttr"), "Expected actualItem.get("#myAttr") to equal ":delta"");
  }

  @Test
  public void updateItem_addExpression_existingMapDeltaMapNoN_setsDirectly() {
    // Arrange — exercises L200 false branch: maps but without "N" key
    DynamoDbStore store = new DynamoDbStore();
    String tableName = "add-map-non-n-table";
    store.createTable(tableName, "pk", "S", null, null, List.of());
    Map<String, Object> item = new LinkedHashMap<>();
    item.put("pk", strAttr("k10"));
    item.put("category", strAttr("food")); // S-typed, not N
    store.putItem(tableName, item);

    // Act — ADD where both existing and delta are maps but neither has "N" → generic put
    store.updateItem(
        tableName,
        Map.of("pk", strAttr("k10")),
        "ADD category :delta",
        null,
        Map.of(":delta", strAttr("drinks")));

    // Assert — value is replaced with the delta
    Map<String, Object> actualItem = store.getItem(tableName, Map.of("pk", strAttr("k10")));
    assertEquals(strAttr("drinks"), actualItem.get("category"), "Expected actualItem.get("category") to equal strAttr("drinks")");
  }

  @Test
  public void updateItem_removeExpressionWithHashAndNullExprNames_usesHashLiteral() {
    // Arrange — exercises L177 false branch: exprNames null, attrExpr starts with #
    DynamoDbStore store = new DynamoDbStore();
    String tableName = "remove-hash-null-table";
    store.createTable(tableName, "pk", "S", null, null, List.of());
    Map<String, Object> item = new LinkedHashMap<>();
    item.put("pk", strAttr("k11"));
    item.put("#extra", strAttr("literal-hash-key"));
    store.putItem(tableName, item);

    // Act — exprNames is null, so #extra is used as literal key
    store.updateItem(tableName, Map.of("pk", strAttr("k11")), "REMOVE #extra", null, null);

    // Assert — #extra literally removed
    Map<String, Object> actualItem = store.getItem(tableName, Map.of("pk", strAttr("k11")));
    assertNull(actualItem.get("#extra"), "Expected actualItem.get("#extra") to be null");
  }
}
