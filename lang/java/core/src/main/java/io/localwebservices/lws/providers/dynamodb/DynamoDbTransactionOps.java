package io.localwebservices.lws.providers.dynamodb;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * Handles DynamoDB transactional operations: TransactGetItems and TransactWriteItems. Delegates
 * storage reads/writes to DynamoDbStore.
 */
class DynamoDbTransactionOps {

  private final DynamoDbStore store;

  DynamoDbTransactionOps(DynamoDbStore store) {
    this.store = store;
  }

  /** Executes TransactGetItems and returns the response map. */
  @SuppressWarnings("unchecked")
  Map<String, Object> transactGetItems(List<Map<String, Object>> txItems) {
    List<Object> responses = new ArrayList<>();
    for (Map<String, Object> txItem : txItems) {
      Map<String, Object> get = (Map<String, Object>) txItem.get("Get");
      if (get != null) {
        String tableName = (String) get.get("TableName");
        Map<String, Object> key = (Map<String, Object>) get.get("Key");
        Map<String, Object> item = store.getItem(tableName, key);
        responses.add(item != null ? Map.of("Item", item) : Map.of());
      }
    }
    return Map.of("Responses", responses);
  }

  /**
   * Executes TransactWriteItems. Returns a result map with either "cancelled" true + reasons, or
   * "ok" true.
   */
  @SuppressWarnings("unchecked")
  Map<String, Object> transactWriteItems(List<Map<String, Object>> txItems) {
    // First pass: evaluate condition checks
    List<Map<String, Object>> cancellationReasons = new ArrayList<>();
    boolean transactionCancelled = false;
    for (Map<String, Object> txItem : txItems) {
      if (txItem.containsKey("ConditionCheck")) {
        Map<String, Object> cc = (Map<String, Object>) txItem.get("ConditionCheck");
        String condExpr = (String) cc.get("ConditionExpression");
        if (condExpr != null) {
          Map<String, Object> existingItem =
              store.getItem((String) cc.get("TableName"), (Map<String, Object>) cc.get("Key"));
          Map<String, String> exprNames = (Map<String, String>) cc.get("ExpressionAttributeNames");
          Map<String, Object> exprValues =
              (Map<String, Object>) cc.get("ExpressionAttributeValues");
          boolean condMet =
              store.evaluateFilter(
                  existingItem != null ? existingItem : Map.of(), condExpr, exprNames, exprValues);
          if (!condMet) {
            transactionCancelled = true;
            cancellationReasons.add(Map.of("Code", "ConditionalCheckFailed"));
          } else {
            cancellationReasons.add(Map.of());
          }
        } else {
          cancellationReasons.add(Map.of());
        }
      } else {
        cancellationReasons.add(Map.of());
      }
    }
    if (transactionCancelled) {
      Map<String, Object> result = new LinkedHashMap<>();
      result.put("cancelled", true);
      result.put("reasons", cancellationReasons);
      return result;
    }
    // Second pass: apply writes
    for (Map<String, Object> txItem : txItems) {
      if (txItem.containsKey("Put")) {
        Map<String, Object> put = (Map<String, Object>) txItem.get("Put");
        store.putItem((String) put.get("TableName"), (Map<String, Object>) put.get("Item"));
      } else if (txItem.containsKey("Delete")) {
        Map<String, Object> del = (Map<String, Object>) txItem.get("Delete");
        store.deleteItem((String) del.get("TableName"), (Map<String, Object>) del.get("Key"));
      } else if (txItem.containsKey("Update")) {
        Map<String, Object> upd = (Map<String, Object>) txItem.get("Update");
        store.updateItem(
            (String) upd.get("TableName"),
            (Map<String, Object>) upd.get("Key"),
            (String) upd.get("UpdateExpression"),
            (Map<String, String>) upd.get("ExpressionAttributeNames"),
            (Map<String, Object>) upd.get("ExpressionAttributeValues"));
      }
    }
    return Map.of("ok", true);
  }
}
