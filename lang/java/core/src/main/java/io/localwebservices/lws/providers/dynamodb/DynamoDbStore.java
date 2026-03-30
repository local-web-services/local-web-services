package io.localwebservices.lws.providers.dynamodb;

import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import java.util.stream.Collectors;

/** In-memory DynamoDB storage. */
public class DynamoDbStore {

  private final Map<String, TableDef> tables = new ConcurrentHashMap<>();

  public void reset() {
    tables.clear();
  }

  public TableDef createTable(
      String name,
      String pkName,
      String pkType,
      String skName,
      String skType,
      List<Map<String, Object>> gsis) {
    TableDef table = new TableDef(name, pkName, pkType, skName, skType, gsis);
    tables.put(name, table);
    return table;
  }

  public TableDef getTable(String name) {
    TableDef t = tables.get(name);
    if (t == null)
      throw new RuntimeException("ResourceNotFoundException: Table not found: " + name);
    return t;
  }

  public boolean tableExists(String name) {
    return tables.containsKey(name);
  }

  public TableDef deleteTable(String name) {
    TableDef t = tables.remove(name);
    if (t == null)
      throw new RuntimeException("ResourceNotFoundException: Table not found: " + name);
    return t;
  }

  public List<String> listTables() {
    return new ArrayList<>(tables.keySet());
  }

  public Map<String, Object> describeTable(String name) {
    TableDef t = getTable(name);
    Map<String, Object> desc = new LinkedHashMap<>();
    List<Map<String, Object>> keySchema = new ArrayList<>();
    keySchema.add(Map.of("AttributeName", t.pkName, "KeyType", "HASH"));
    if (t.skName != null) {
      keySchema.add(Map.of("AttributeName", t.skName, "KeyType", "RANGE"));
    }
    List<Map<String, Object>> attrDefs = new ArrayList<>();
    attrDefs.add(Map.of("AttributeName", t.pkName, "AttributeType", t.pkType));
    if (t.skName != null) {
      attrDefs.add(Map.of("AttributeName", t.skName, "AttributeType", t.skType));
    }
    desc.put("TableName", t.name);
    desc.put("TableStatus", "ACTIVE");
    desc.put("KeySchema", keySchema);
    desc.put("AttributeDefinitions", attrDefs);
    desc.put("CreationDateTime", t.createdAt / 1000.0);
    desc.put("TableArn", "arn:aws:dynamodb:us-east-1:000000000000:table/" + t.name);
    desc.put("ItemCount", t.items.size());
    desc.put("BillingModeSummary", Map.of("BillingMode", "PAY_PER_REQUEST"));
    if (!t.gsis.isEmpty()) {
      desc.put("GlobalSecondaryIndexes", t.gsis);
    }
    if (t.streamEnabled) {
      desc.put(
          "StreamSpecification",
          Map.of("StreamEnabled", true, "StreamViewType", t.streamViewType));
      desc.put("LatestStreamArn", t.latestStreamArn);
    }
    return desc;
  }

  private String itemKey(TableDef t, Map<String, Object> item) {
    Object pk = extractScalar(item.get(t.pkName));
    String key = String.valueOf(pk);
    if (t.skName != null) {
      Object sk = extractScalar(item.get(t.skName));
      key += "#" + String.valueOf(sk);
    }
    return key;
  }

  @SuppressWarnings("unchecked")
  private Object extractScalar(Object attrVal) {
    if (attrVal instanceof Map) {
      Map<String, Object> m = (Map<String, Object>) attrVal;
      if (m.containsKey("S")) return m.get("S");
      if (m.containsKey("N")) return m.get("N");
      if (m.containsKey("B")) return m.get("B");
    }
    return attrVal;
  }

  public void putItem(String tableName, Map<String, Object> item) {
    TableDef t = getTable(tableName);
    String key = itemKey(t, item);
    synchronized (t.items) {
      t.items.put(key, item);
    }
  }

  @SuppressWarnings("unchecked")
  public Map<String, Object> getItem(String tableName, Map<String, Object> keyAttr) {
    TableDef t = getTable(tableName);
    String key = itemKey(t, keyAttr);
    synchronized (t.items) {
      return t.items.get(key);
    }
  }

  public void deleteItem(String tableName, Map<String, Object> keyAttr) {
    if (!tableExists(tableName)) return;
    TableDef t = getTable(tableName);
    String key = itemKey(t, keyAttr);
    synchronized (t.items) {
      t.items.remove(key);
    }
  }

  @SuppressWarnings("unchecked")
  public Map<String, Object> updateItem(
      String tableName,
      Map<String, Object> keyAttr,
      String updateExpression,
      Map<String, String> exprNames,
      Map<String, Object> exprValues) {
    TableDef t = getTable(tableName);
    String key = itemKey(t, keyAttr);
    synchronized (t.items) {
      Map<String, Object> item = t.items.computeIfAbsent(key, k -> new LinkedHashMap<>(keyAttr));
      if (updateExpression != null && !updateExpression.isEmpty()) {
        applyUpdateExpression(item, updateExpression, exprNames, exprValues);
      }
      return item;
    }
  }

  @SuppressWarnings("unchecked")
  private void applyUpdateExpression(
      Map<String, Object> item,
      String expr,
      Map<String, String> exprNames,
      Map<String, Object> exprValues) {
    // Simple SET expression parsing: "SET #a = :a, #b = :b"
    String e = expr.trim();
    if (e.toUpperCase().startsWith("SET ")) {
      String rest = e.substring(4);
      String[] parts = rest.split(",");
      for (String part : parts) {
        String[] kv = part.trim().split("=", 2);
        if (kv.length == 2) {
          String attrExpr = kv[0].trim();
          String valExpr = kv[1].trim();
          // Resolve attribute name
          String attrName = attrExpr;
          if (exprNames != null && attrExpr.startsWith("#")) {
            attrName = exprNames.getOrDefault(attrExpr, attrExpr);
          }
          // Resolve value
          Object value = valExpr;
          if (exprValues != null && valExpr.startsWith(":")) {
            value = exprValues.get(valExpr);
          }
          item.put(attrName, value);
        }
      }
    } else if (e.toUpperCase().startsWith("REMOVE ")) {
      String rest = e.substring(7);
      String[] parts = rest.split(",");
      for (String part : parts) {
        String attrExpr = part.trim();
        String attrName = attrExpr;
        if (exprNames != null && attrExpr.startsWith("#")) {
          attrName = exprNames.getOrDefault(attrExpr, attrExpr);
        }
        item.remove(attrName);
      }
    } else if (e.toUpperCase().startsWith("ADD ")) {
      String rest = e.substring(4);
      String[] parts = rest.split(",");
      for (String part : parts) {
        String[] kv = part.trim().split("\\s+", 2);
        if (kv.length == 2) {
          String attrExpr = kv[0].trim();
          String valExpr = kv[1].trim();
          String attrName =
              exprNames != null && attrExpr.startsWith("#")
                  ? exprNames.getOrDefault(attrExpr, attrExpr)
                  : attrExpr;
          Object delta =
              exprValues != null && valExpr.startsWith(":") ? exprValues.get(valExpr) : valExpr;
          Object existing = item.get(attrName);
          if (existing instanceof Map && delta instanceof Map) {
            Map<String, Object> existMap = (Map<String, Object>) existing;
            Map<String, Object> deltaMap = (Map<String, Object>) delta;
            if (existMap.containsKey("N") && deltaMap.containsKey("N")) {
              double existNum = Double.parseDouble((String) existMap.get("N"));
              double deltaNum = Double.parseDouble((String) deltaMap.get("N"));
              Map<String, Object> result = new LinkedHashMap<>(existMap);
              result.put("N", String.valueOf(existNum + deltaNum));
              item.put(attrName, result);
              continue;
            }
          }
          item.put(attrName, delta);
        }
      }
    }
  }

  public List<Map<String, Object>> scan(
      String tableName,
      String filterExpr,
      Map<String, String> exprNames,
      Map<String, Object> exprValues,
      Integer limit,
      Map<String, Object> exclusiveStartKey) {
    TableDef t = getTable(tableName);
    List<Map<String, Object>> items;
    synchronized (t.items) {
      items = new ArrayList<>(t.items.values());
    }
    if (exclusiveStartKey != null && !exclusiveStartKey.isEmpty()) {
      String startKey = itemKey(t, exclusiveStartKey);
      int idx = -1;
      for (int i = 0; i < items.size(); i++) {
        if (itemKey(t, items.get(i)).equals(startKey)) {
          idx = i;
          break;
        }
      }
      if (idx >= 0) items = items.subList(idx + 1, items.size());
    }
    if (filterExpr != null && !filterExpr.isEmpty()) {
      String fe = filterExpr;
      Map<String, String> en = exprNames;
      Map<String, Object> ev = exprValues;
      items =
          items.stream()
              .filter(item -> evaluateFilter(item, fe, en, ev))
              .collect(Collectors.toList());
    }
    if (limit != null && items.size() > limit) {
      items = items.subList(0, limit);
    }
    return items;
  }

  @SuppressWarnings("unchecked")
  public List<Map<String, Object>> query(
      String tableName,
      String keyConditionExpr,
      Map<String, String> exprNames,
      Map<String, Object> exprValues,
      String indexName,
      String filterExpr,
      boolean scanIndexForward,
      Integer limit,
      Map<String, Object> exclusiveStartKey) {
    TableDef t = getTable(tableName);
    List<Map<String, Object>> items;
    synchronized (t.items) {
      items = new ArrayList<>(t.items.values());
    }

    // Apply key condition
    if (keyConditionExpr != null && !keyConditionExpr.isEmpty()) {
      String kce = keyConditionExpr;
      items =
          items.stream()
              .filter(item -> evaluateKeyCondition(item, kce, exprNames, exprValues))
              .collect(Collectors.toList());
    }

    // Apply filter expression
    if (filterExpr != null && !filterExpr.isEmpty()) {
      String fe = filterExpr;
      Map<String, String> en = exprNames;
      Map<String, Object> ev = exprValues;
      items =
          items.stream()
              .filter(item -> evaluateFilter(item, fe, en, ev))
              .collect(Collectors.toList());
    }

    if (!scanIndexForward) {
      Collections.reverse(items);
    }

    if (exclusiveStartKey != null && !exclusiveStartKey.isEmpty()) {
      String startKey = itemKey(t, exclusiveStartKey);
      int idx = -1;
      for (int i = 0; i < items.size(); i++) {
        if (itemKey(t, items.get(i)).equals(startKey)) {
          idx = i;
          break;
        }
      }
      if (idx >= 0) items = items.subList(idx + 1, items.size());
    }

    if (limit != null && items.size() > limit) {
      items = items.subList(0, limit);
    }
    return items;
  }

  @SuppressWarnings("unchecked")
  private boolean evaluateKeyCondition(
      Map<String, Object> item,
      String expr,
      Map<String, String> exprNames,
      Map<String, Object> exprValues) {
    // Simple support for: pk = :pk and pk = :pk AND sk = :sk and begins_with
    String e = expr.trim();
    // Split on AND
    String[] parts = e.split("(?i)\\s+AND\\s+");
    for (String part : parts) {
      part = part.trim();
      if (!evaluateSingleCondition(item, part, exprNames, exprValues)) return false;
    }
    return true;
  }

  @SuppressWarnings("unchecked")
  private boolean evaluateSingleCondition(
      Map<String, Object> item,
      String expr,
      Map<String, String> exprNames,
      Map<String, Object> exprValues) {
    String trimmedExpr = expr.trim();
    // begins_with(attr, :val)
    if (trimmedExpr.toLowerCase().startsWith("begins_with")) {
      String inner =
          trimmedExpr.substring(trimmedExpr.indexOf('(') + 1, trimmedExpr.lastIndexOf(')'));
      String[] args = inner.split(",", 2);
      if (args.length == 2) {
        String attrExpr = args[0].trim();
        String valExpr = args[1].trim();
        String attrName = resolveAttrName(attrExpr, exprNames);
        String prefix = resolveScalarValue(valExpr, exprValues);
        Object itemVal = resolveScalarFromItem(item, attrName);
        return itemVal != null && String.valueOf(itemVal).startsWith(prefix);
      }
      return false;
    }
    // between
    if (trimmedExpr.toLowerCase().contains(" between ")) {
      String[] parts = trimmedExpr.split("(?i)\\s+between\\s+");
      if (parts.length == 2) {
        String attrExpr = parts[0].trim();
        String[] range = parts[1].split("(?i)\\s+and\\s+", 2);
        if (range.length == 2) {
          String attrName = resolveAttrName(attrExpr, exprNames);
          String low = resolveScalarValue(range[0].trim(), exprValues);
          String high = resolveScalarValue(range[1].trim(), exprValues);
          Object itemVal = resolveScalarFromItem(item, attrName);
          if (itemVal == null) return false;
          String sv = String.valueOf(itemVal);
          return sv.compareTo(low) >= 0 && sv.compareTo(high) <= 0;
        }
      }
      return false;
    }
    // = comparison
    if (trimmedExpr.contains("=")) {
      String[] kv = trimmedExpr.split("=", 2);
      String attrExpr = kv[0].trim();
      String valExpr = kv[1].trim();
      String attrName = resolveAttrName(attrExpr, exprNames);
      String expected = resolveScalarValue(valExpr, exprValues);
      Object itemVal = resolveScalarFromItem(item, attrName);
      return expected != null && expected.equals(String.valueOf(itemVal));
    }
    return true;
  }

  @SuppressWarnings("unchecked")
  public boolean evaluateFilter(
      Map<String, Object> item,
      String expr,
      Map<String, String> exprNames,
      Map<String, Object> exprValues) {
    if (expr == null || expr.isEmpty()) return true;
    String trimmedExpr = expr.trim();

    // Handle attribute_exists
    if (trimmedExpr.toLowerCase().startsWith("attribute_exists")) {
      String inner =
          trimmedExpr.substring(trimmedExpr.indexOf('(') + 1, trimmedExpr.lastIndexOf(')'));
      String attrName = resolveAttrName(inner.trim(), exprNames);
      return item.containsKey(attrName);
    }
    if (trimmedExpr.toLowerCase().startsWith("attribute_not_exists")) {
      String inner =
          trimmedExpr.substring(trimmedExpr.indexOf('(') + 1, trimmedExpr.lastIndexOf(')'));
      String attrName = resolveAttrName(inner.trim(), exprNames);
      return !item.containsKey(attrName);
    }

    // Handle AND/OR
    // Simple AND splitting
    if (trimmedExpr.toUpperCase().contains(" AND ")) {
      String[] parts = trimmedExpr.split("(?i)\\s+AND\\s+");
      for (String part : parts) {
        if (!evaluateFilter(item, part.trim(), exprNames, exprValues)) return false;
      }
      return true;
    }
    if (trimmedExpr.toUpperCase().contains(" OR ")) {
      String[] parts = trimmedExpr.split("(?i)\\s+OR\\s+");
      for (String part : parts) {
        if (evaluateFilter(item, part.trim(), exprNames, exprValues)) return true;
      }
      return false;
    }

    return evaluateSingleCondition(item, trimmedExpr, exprNames, exprValues);
  }

  private String resolveAttrName(String expr, Map<String, String> exprNames) {
    if (exprNames != null && expr.startsWith("#")) {
      return exprNames.getOrDefault(expr, expr);
    }
    return expr;
  }

  @SuppressWarnings("unchecked")
  private String resolveScalarValue(String expr, Map<String, Object> exprValues) {
    if (exprValues != null && expr.startsWith(":")) {
      Object val = exprValues.get(expr);
      if (val instanceof Map) {
        Map<String, Object> m = (Map<String, Object>) val;
        if (m.containsKey("S")) return (String) m.get("S");
        if (m.containsKey("N")) return (String) m.get("N");
        if (m.containsKey("BOOL")) return String.valueOf(m.get("BOOL"));
      }
      return val != null ? String.valueOf(val) : null;
    }
    return expr;
  }

  @SuppressWarnings("unchecked")
  private Object resolveScalarFromItem(Map<String, Object> item, String attrName) {
    Object val = item.get(attrName);
    if (val instanceof Map) {
      Map<String, Object> m = (Map<String, Object>) val;
      if (m.containsKey("S")) return m.get("S");
      if (m.containsKey("N")) return m.get("N");
      if (m.containsKey("BOOL")) return m.get("BOOL");
    }
    return val;
  }

  public List<Map<String, Object>> batchGetItems(String tableName, List<Map<String, Object>> keys) {
    List<Map<String, Object>> result = new ArrayList<>();
    for (Map<String, Object> key : keys) {
      Map<String, Object> item = getItem(tableName, key);
      if (item != null) result.add(item);
    }
    return result;
  }

  public void batchWriteItems(
      String tableName, List<Map<String, Object>> puts, List<Map<String, Object>> deletes) {
    for (Map<String, Object> item : puts) {
      putItem(tableName, item);
    }
    for (Map<String, Object> key : deletes) {
      deleteItem(tableName, key);
    }
  }
}
