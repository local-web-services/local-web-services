package io.localwebservices.lws.unit.providers.dynamodb;

import static org.junit.jupiter.api.Assertions.assertEquals;

import io.localwebservices.lws.providers.dynamodb.DynamoDbStore;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import org.junit.jupiter.api.Test;

public class DynamoDbStoreEvaluateFilterBranchTest {

  private static Map<String, Object> strAttr(String value) {
    Map<String, Object> m = new LinkedHashMap<>();
    m.put("S", value);
    return m;
  }

  @Test
  public void evaluateFilter_attributeExists_attrPresent_returnsTrue() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();
    Map<String, Object> item = new LinkedHashMap<>();
    item.put("status", strAttr("active"));
    boolean expectedResult = true;

    // Act
    boolean actualResult = store.evaluateFilter(item, "attribute_exists(status)", null, null);

    // Assert
    assertEquals(expectedResult, actualResult, "Expected actualResult to equal expectedResult");
  }

  @Test
  public void evaluateFilter_attributeExists_attrMissing_returnsFalse() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();
    Map<String, Object> item = new LinkedHashMap<>();
    item.put("pk", strAttr("a"));
    boolean expectedResult = false;

    // Act
    boolean actualResult = store.evaluateFilter(item, "attribute_exists(status)", null, null);

    // Assert
    assertEquals(expectedResult, actualResult, "Expected actualResult to equal expectedResult");
  }

  @Test
  public void evaluateFilter_attributeNotExists_attrMissing_returnsTrue() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();
    Map<String, Object> item = new LinkedHashMap<>();
    item.put("pk", strAttr("a"));
    boolean expectedResult = true;

    // Act
    boolean actualResult = store.evaluateFilter(item, "attribute_not_exists(deleted)", null, null);

    // Assert
    assertEquals(expectedResult, actualResult, "Expected actualResult to equal expectedResult");
  }

  @Test
  public void evaluateFilter_attributeNotExists_attrPresent_returnsFalse() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();
    Map<String, Object> item = new LinkedHashMap<>();
    item.put("deleted", strAttr("true"));
    boolean expectedResult = false;

    // Act
    boolean actualResult = store.evaluateFilter(item, "attribute_not_exists(deleted)", null, null);

    // Assert
    assertEquals(expectedResult, actualResult, "Expected actualResult to equal expectedResult");
  }

  @Test
  public void evaluateFilter_andExpression_bothTrue_returnsTrue() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();
    Map<String, Object> item = new LinkedHashMap<>();
    item.put("color", "blue");
    item.put("size", "large");
    boolean expectedResult = true;

    // Act
    boolean actualResult = store.evaluateFilter(item, "color = blue AND size = large", null, null);

    // Assert
    assertEquals(expectedResult, actualResult, "Expected actualResult to equal expectedResult");
  }

  @Test
  public void evaluateFilter_andExpression_firstFalse_returnsFalse() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();
    Map<String, Object> item = new LinkedHashMap<>();
    item.put("color", "red");
    item.put("size", "large");
    boolean expectedResult = false;

    // Act
    boolean actualResult = store.evaluateFilter(item, "color = blue AND size = large", null, null);

    // Assert
    assertEquals(expectedResult, actualResult, "Expected actualResult to equal expectedResult");
  }

  @Test
  public void evaluateFilter_orExpression_firstTrue_returnsTrue() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();
    Map<String, Object> item = new LinkedHashMap<>();
    item.put("color", "blue");
    item.put("size", "small");
    boolean expectedResult = true;

    // Act
    boolean actualResult = store.evaluateFilter(item, "color = blue OR size = large", null, null);

    // Assert
    assertEquals(expectedResult, actualResult, "Expected actualResult to equal expectedResult");
  }

  @Test
  public void evaluateFilter_orExpression_noneMatch_returnsFalse() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();
    Map<String, Object> item = new LinkedHashMap<>();
    item.put("color", "red");
    item.put("size", "small");
    boolean expectedResult = false;

    // Act
    boolean actualResult = store.evaluateFilter(item, "color = blue OR size = large", null, null);

    // Assert
    assertEquals(expectedResult, actualResult, "Expected actualResult to equal expectedResult");
  }

  @Test
  public void query_beginsWith_matchingPrefix_returnsMatchingItems() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();
    store.createTable("T", "pk", "S", "sk", "S", List.of());
    Map<String, Object> item = new LinkedHashMap<>();
    item.put("pk", strAttr("user1"));
    item.put("sk", strAttr("order#001"));
    store.putItem("T", item);
    int expectedCount = 1;

    // Act
    List<Map<String, Object>> actualItems =
        store.query(
            "T",
            "pk = :pk AND begins_with(sk, :prefix)",
            null,
            Map.of(":pk", strAttr("user1"), ":prefix", strAttr("order#")),
            null,
            null,
            true,
            null,
            null);

    // Assert
    assertEquals(expectedCount, actualItems.size(), "Expected actualItems.size() to match expectedCount");
  }

  @Test
  public void query_beginsWith_nonMatchingPrefix_returnsEmpty() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();
    store.createTable("T2", "pk", "S", "sk", "S", List.of());
    Map<String, Object> item = new LinkedHashMap<>();
    item.put("pk", strAttr("user1"));
    item.put("sk", strAttr("invoice#001"));
    store.putItem("T2", item);
    int expectedCount = 0;

    // Act
    List<Map<String, Object>> actualItems =
        store.query(
            "T2",
            "pk = :pk AND begins_with(sk, :prefix)",
            null,
            Map.of(":pk", strAttr("user1"), ":prefix", strAttr("order#")),
            null,
            null,
            true,
            null,
            null);

    // Assert
    assertEquals(expectedCount, actualItems.size(), "Expected actualItems.size() to match expectedCount");
  }

  @Test
  public void query_beginsWith_nullItemVal_returnsEmpty() {
    // Arrange
    DynamoDbStore store = new DynamoDbStore();
    store.createTable("T3", "pk", "S", "sk", "S", List.of());
    Map<String, Object> item = new LinkedHashMap<>();
    item.put("pk", strAttr("user1"));
    // sk attribute intentionally absent so resolveScalarFromItem returns null
    store.putItem("T3", item);
    int expectedCount = 0;

    // Act
    List<Map<String, Object>> actualItems =
        store.query(
            "T3",
            "pk = :pk AND begins_with(sk, :prefix)",
            null,
            Map.of(":pk", strAttr("user1"), ":prefix", strAttr("order#")),
            null,
            null,
            true,
            null,
            null);

    // Assert
    assertEquals(expectedCount, actualItems.size(), "Expected actualItems.size() to match expectedCount");
  }
}
