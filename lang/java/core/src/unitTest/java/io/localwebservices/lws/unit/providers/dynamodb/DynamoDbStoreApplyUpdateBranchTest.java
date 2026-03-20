package io.localwebservices.lws.unit.providers.dynamodb;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNull;

import io.localwebservices.lws.providers.dynamodb.DynamoDbStore;
import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.Map;
import org.junit.jupiter.api.Test;

class DynamoDbStoreApplyUpdateBranchTest {

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

  // L177: REMOVE section — exprNames != null but attrExpr does NOT start with "#"
  @Test
  void removeItem_withExprNamesButLiteralAttr_removesDirectly() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();
    store.createTable("tbl", "pk", "S", null, null, Collections.emptyList());
    Map<String, Object> initialItem = new LinkedHashMap<>();
    initialItem.put("pk", strAttr("k"));
    initialItem.put("extra", strAttr("x"));
    store.putItem("tbl", initialItem);
    Map<String, String> exprNames = Map.of("#other", "something");

    // Act
    store.updateItem("tbl", Map.of("pk", strAttr("k")), "REMOVE extra", exprNames, null);

    // Assert
    Map<String, Object> actualItem = store.getItem("tbl", Map.of("pk", strAttr("k")));
    Object actualExtra = actualItem.get("extra");
    assertNull(actualExtra, "Expected actualExtra to be null");
  }

  // L191: ADD section — exprNames != null but attrExpr does NOT start with "#"
  @Test
  void addItem_withExprNamesButLiteralAttr_usesLiteralAttrName() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();
    store.createTable("tbl", "pk", "S", null, null, Collections.emptyList());
    Map<String, Object> initialItem1 = new LinkedHashMap<>();
    initialItem1.put("pk", strAttr("k"));
    store.putItem("tbl", initialItem1);
    Map<String, String> exprNames = Map.of("#other", "something");
    Map<String, Object> exprValues = Map.of(":val", numAttr("5"));
    Map<String, Object> expectedMyAttr = numAttr("5");

    // Act
    store.updateItem("tbl", Map.of("pk", strAttr("k")), "ADD myAttr :val", exprNames, exprValues);

    // Assert
    Map<String, Object> actualItem = store.getItem("tbl", Map.of("pk", strAttr("k")));
    Object actualMyAttr = actualItem.get("myAttr");
    assertEquals(expectedMyAttr, actualMyAttr, "Expected actualMyAttr to equal expectedMyAttr");
  }

  // L195: ADD section — exprValues != null but valExpr does NOT start with ":"
  @Test
  void addItem_withExprValuesButLiteralValue_usesLiteralValue() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();
    store.createTable("tbl", "pk", "S", null, null, Collections.emptyList());
    Map<String, Object> initialItem2 = new LinkedHashMap<>();
    initialItem2.put("pk", strAttr("k"));
    store.putItem("tbl", initialItem2);
    Map<String, Object> exprValues = Map.of(":other", numAttr("99"));
    String expectedMyAttr = "literalDelta";

    // Act
    store.updateItem(
        "tbl", Map.of("pk", strAttr("k")), "ADD myAttr literalDelta", null, exprValues);

    // Assert
    Map<String, Object> actualItem = store.getItem("tbl", Map.of("pk", strAttr("k")));
    Object actualMyAttr = actualItem.get("myAttr");
    assertEquals(expectedMyAttr, actualMyAttr, "Expected actualMyAttr to equal expectedMyAttr");
  }

  // L197: existing instanceof Map TRUE, delta instanceof Map FALSE
  @Test
  void addItem_existingIsMapDeltaIsNotMap_setsDirectly() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();
    store.createTable("tbl", "pk", "S", null, null, Collections.emptyList());
    Map<String, Object> initialItem = new LinkedHashMap<>();
    initialItem.put("pk", strAttr("k"));
    initialItem.put("tag", strAttr("hello"));
    store.putItem("tbl", initialItem);
    String expectedTag = "literalReplacement";

    // Act
    store.updateItem("tbl", Map.of("pk", strAttr("k")), "ADD tag literalReplacement", null, null);

    // Assert
    Map<String, Object> actualItem = store.getItem("tbl", Map.of("pk", strAttr("k")));
    Object actualTag = actualItem.get("tag");
    assertEquals(expectedTag, actualTag, "Expected actualTag to equal expectedTag");
  }

  // L200-L206: numeric ADD — both existMap and deltaMap have "N" key
  @Test
  void addItem_numericAdd_bothHaveN_addsNumbers() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();
    store.createTable("tbl", "pk", "S", null, null, Collections.emptyList());
    Map<String, Object> initialItem = new LinkedHashMap<>();
    initialItem.put("pk", strAttr("k"));
    initialItem.put("count", numAttr("10"));
    store.putItem("tbl", initialItem);
    Map<String, Object> exprValues = Map.of(":delta", numAttr("5"));
    String expectedN = "15.0";

    // Act
    store.updateItem("tbl", Map.of("pk", strAttr("k")), "ADD count :delta", null, exprValues);

    // Assert
    Map<String, Object> actualItem = store.getItem("tbl", Map.of("pk", strAttr("k")));
    @SuppressWarnings("unchecked")
    Map<String, Object> actualCount = (Map<String, Object>) actualItem.get("count");
    Object actualN = actualCount.get("N");
    assertEquals(expectedN, actualN, "Expected actualN to equal expectedN");
  }

  // L200 false branch: existMap has "N" but deltaMap does NOT have "N"
  @Test
  void addItem_existingHasN_deltaLacksN_setsDirectly() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();
    store.createTable("tbl", "pk", "S", null, null, Collections.emptyList());
    Map<String, Object> initialItem = new LinkedHashMap<>();
    initialItem.put("pk", strAttr("k"));
    initialItem.put("count", numAttr("10"));
    store.putItem("tbl", initialItem);
    Map<String, Object> exprValues = Map.of(":delta", strAttr("hello"));
    Map<String, Object> expectedCount = strAttr("hello");

    // Act
    store.updateItem("tbl", Map.of("pk", strAttr("k")), "ADD count :delta", null, exprValues);

    // Assert
    Map<String, Object> actualItem = store.getItem("tbl", Map.of("pk", strAttr("k")));
    Object actualCount = actualItem.get("count");
    assertEquals(expectedCount, actualCount, "Expected actualCount to match expectedCount");
  }
}
