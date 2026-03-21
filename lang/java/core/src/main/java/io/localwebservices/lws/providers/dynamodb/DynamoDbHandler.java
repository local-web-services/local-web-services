package io.localwebservices.lws.providers.dynamodb;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpHandler;
import io.localwebservices.lws.ServerState;
import io.localwebservices.lws.middleware.ChaosMiddleware;
import io.localwebservices.lws.middleware.IamMiddleware;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.*;

/** DynamoDB wire-protocol HTTP handler. */
public class DynamoDbHandler implements HttpHandler {

  private static final ObjectMapper MAPPER = new ObjectMapper();
  private static final String TARGET_PREFIX = "DynamoDB_20120810.";

  private final ServerState state;
  private final DynamoDbStore store;

  public DynamoDbHandler(ServerState state) {
    this.state = state;
    this.store = new DynamoDbStore();
    state.resetCallbacks.add(store::reset);
  }

  /**
   * Puts an item into a DynamoDB table programmatically (used by StepFunctions service task
   * bridges). The body map must contain "TableName" and "Item" keys.
   */
  @SuppressWarnings("unchecked")
  public Map<String, Object> executePutItem(Map<String, Object> params) {
    String tableName = (String) params.get("TableName");
    Map<String, Object> item = (Map<String, Object>) params.get("Item");
    store.putItem(tableName, item);
    return new LinkedHashMap<>();
  }

  /**
   * Gets an item from a DynamoDB table programmatically (used by StepFunctions service task
   * bridges). The body map must contain "TableName" and "Key" keys.
   */
  @SuppressWarnings("unchecked")
  public Map<String, Object> executeGetItem(Map<String, Object> params) {
    String tableName = (String) params.get("TableName");
    Map<String, Object> key = (Map<String, Object>) params.get("Key");
    Map<String, Object> item = store.getItem(tableName, key);
    if (item != null) {
      return new LinkedHashMap<>(Map.of("Item", item));
    }
    return new LinkedHashMap<>();
  }

  @Override
  public void handle(HttpExchange exchange) throws IOException {
    String target = exchange.getRequestHeaders().getFirst("X-Amz-Target");
    if (target == null || !target.startsWith(TARGET_PREFIX)) {
      sendJson(
          exchange,
          400,
          Map.of("__type", "ValidationException", "message", "Unknown target: " + target));
      return;
    }
    String operation = target.substring(TARGET_PREFIX.length());

    long startMs = System.currentTimeMillis();
    int[] statusHolder = {200};
    try {
      if (IamMiddleware.applyIamAuth(state, "dynamodb", operation, exchange, false)) {
        statusHolder[0] = 403;
        return;
      }
      if (ChaosMiddleware.applyChaos(state, "dynamodb", operation, exchange, false)) {
        statusHolder[0] = 500;
        return;
      }

      byte[] bodyBytes;
      try (InputStream is = exchange.getRequestBody()) {
        bodyBytes = is.readAllBytes();
      }
      @SuppressWarnings("unchecked")
      Map<String, Object> body =
          bodyBytes.length > 0 ? MAPPER.readValue(bodyBytes, Map.class) : Map.of();

      handleOperation(operation, body, exchange);
    } catch (InterruptedException e) {
      Thread.currentThread().interrupt();
      statusHolder[0] = 500;
      sendJson(exchange, 500, Map.of("__type", "InternalFailure", "message", "Interrupted"));
    } catch (Exception e) {
      statusHolder[0] = 400;
      String msg = e.getMessage() != null ? e.getMessage() : e.toString();
      if (msg.contains("ResourceNotFoundException")) {
        sendJson(exchange, 400, Map.of("__type", "ResourceNotFoundException", "message", msg));
      } else {
        sendJson(exchange, 400, Map.of("__type", "ValidationException", "message", msg));
      }
    } finally {
      double durationMs = System.currentTimeMillis() - startMs;
      Map<String, Object> logEntry = new LinkedHashMap<>();
      logEntry.put("service", "dynamodb");
      logEntry.put("handler", operation);
      logEntry.put("level", statusHolder[0] >= 500 ? "ERROR" : "INFO");
      logEntry.put("status_code", statusHolder[0]);
      logEntry.put("duration_ms", durationMs);
      logEntry.put("timestamp", java.time.Instant.now().toString());
      state.addLog(logEntry);
    }
  }

  @SuppressWarnings("unchecked")
  private void handleOperation(String operation, Map<String, Object> body, HttpExchange exchange)
      throws IOException {
    switch (operation) {
      case "CreateTable":
        {
          String tableName = (String) body.get("TableName");
          if (store.tableExists(tableName)) {
            sendJson(
                exchange,
                400,
                Map.of(
                    "__type",
                    "com.amazonaws.dynamodb.v20120810#ResourceInUseException",
                    "message",
                    "Table already exists: " + tableName));
            break;
          }
          Map<String, String> attrTypes = new LinkedHashMap<>();
          List<Map<String, Object>> attrDefs =
              (List<Map<String, Object>>) body.getOrDefault("AttributeDefinitions", List.of());
          for (Map<String, Object> ad : attrDefs) {
            attrTypes.put(
                (String) ad.get("AttributeName"), (String) ad.getOrDefault("AttributeType", "S"));
          }
          String pkName = "pk", pkType = "S", skName = null, skType = null;
          List<Map<String, Object>> keySchema =
              (List<Map<String, Object>>) body.getOrDefault("KeySchema", List.of());
          for (Map<String, Object> ks : keySchema) {
            String attrName = (String) ks.get("AttributeName");
            String keyType = (String) ks.get("KeyType");
            if ("HASH".equals(keyType)) {
              pkName = attrName;
              pkType = attrTypes.getOrDefault(attrName, "S");
            } else {
              skName = attrName;
              skType = attrTypes.getOrDefault(attrName, "S");
            }
          }
          List<Map<String, Object>> gsiDefs = new ArrayList<>();
          List<Map<String, Object>> rawGsis =
              (List<Map<String, Object>>) body.getOrDefault("GlobalSecondaryIndexes", List.of());
          for (Map<String, Object> gsi : rawGsis) {
            Map<String, Object> gsiDef = new LinkedHashMap<>();
            gsiDef.put("IndexName", gsi.get("IndexName"));
            gsiDef.put("KeySchema", gsi.get("KeySchema"));
            gsiDef.put(
                "Projection", gsi.getOrDefault("Projection", Map.of("ProjectionType", "ALL")));
            gsiDef.put("IndexStatus", "ACTIVE");
            gsiDefs.add(gsiDef);
          }
          store.createTable(tableName, pkName, pkType, skName, skType, gsiDefs);
          sendJson(exchange, 200, Map.of("TableDescription", store.describeTable(tableName)));
          break;
        }
      case "DeleteTable":
        {
          String tableName = (String) body.get("TableName");
          store.deleteTable(tableName);
          sendJson(
              exchange,
              200,
              Map.of(
                  "TableDescription", Map.of("TableName", tableName, "TableStatus", "DELETING")));
          break;
        }
      case "DescribeTable":
        {
          String tableName = (String) body.get("TableName");
          Map<String, Object> desc = store.describeTable(tableName);
          sendJson(exchange, 200, Map.of("Table", desc));
          break;
        }
      case "ListTables":
        {
          sendJson(exchange, 200, Map.of("TableNames", store.listTables()));
          break;
        }
      case "UpdateTable":
        {
          String tableName = (String) body.get("TableName");
          Map<String, Object> desc = store.describeTable(tableName);
          sendJson(exchange, 200, Map.of("TableDescription", desc));
          break;
        }
      case "PutItem":
        {
          if (state.getCapacityConfig("dynamodb").isExhausted()) {
            sendJson(
                exchange,
                400,
                Map.of(
                    "__type",
                    "ProvisionedThroughputExceededException",
                    "message",
                    "The level of configured provisioned throughput for the table was exceeded."));
            break;
          }
          String tableName = (String) body.get("TableName");
          Map<String, Object> item = (Map<String, Object>) body.get("Item");
          store.putItem(tableName, item);
          sendJson(exchange, 200, Map.of());
          break;
        }
      case "GetItem":
        {
          String tableName = (String) body.get("TableName");
          Map<String, Object> key = (Map<String, Object>) body.get("Key");
          Map<String, Object> item = store.getItem(tableName, key);
          if (item != null) {
            sendJson(exchange, 200, Map.of("Item", item));
          } else {
            sendJson(exchange, 200, Map.of());
          }
          break;
        }
      case "DeleteItem":
        {
          String tableName = (String) body.get("TableName");
          Map<String, Object> key = (Map<String, Object>) body.get("Key");
          Map<String, Object> existingForDelete = store.getItem(tableName, key);
          if (existingForDelete == null) {
            sendJson(
                exchange,
                400,
                Map.of(
                    "__type",
                    "com.amazonaws.dynamodb.v20120810#ConditionalCheckFailedException",
                    "message",
                    "The conditional request failed"));
            break;
          }
          store.deleteItem(tableName, key);
          sendJson(exchange, 200, Map.of());
          break;
        }
      case "UpdateItem":
        {
          String tableName = (String) body.get("TableName");
          Map<String, Object> key = (Map<String, Object>) body.get("Key");
          Map<String, Object> existingForUpdate = store.getItem(tableName, key);
          if (existingForUpdate == null) {
            sendJson(
                exchange,
                400,
                Map.of(
                    "__type",
                    "com.amazonaws.dynamodb.v20120810#ConditionalCheckFailedException",
                    "message",
                    "The conditional request failed"));
            break;
          }
          String updateExpr = (String) body.get("UpdateExpression");
          Map<String, String> exprNames =
              (Map<String, String>) body.get("ExpressionAttributeNames");
          Map<String, Object> exprValues =
              (Map<String, Object>) body.get("ExpressionAttributeValues");
          Map<String, Object> updated =
              store.updateItem(tableName, key, updateExpr, exprNames, exprValues);
          sendJson(exchange, 200, Map.of("Attributes", updated));
          break;
        }
      case "Query":
        {
          String tableName = (String) body.get("TableName");
          String kce = (String) body.get("KeyConditionExpression");
          Map<String, String> exprNames =
              (Map<String, String>) body.get("ExpressionAttributeNames");
          Map<String, Object> exprValues =
              (Map<String, Object>) body.get("ExpressionAttributeValues");
          String indexName = (String) body.get("IndexName");
          String filterExpr = (String) body.get("FilterExpression");
          boolean forward = !Boolean.FALSE.equals(body.get("ScanIndexForward"));
          Integer limit =
              body.get("Limit") != null ? ((Number) body.get("Limit")).intValue() : null;
          Map<String, Object> startKey = (Map<String, Object>) body.get("ExclusiveStartKey");
          List<Map<String, Object>> items =
              store.query(
                  tableName,
                  kce,
                  exprNames,
                  exprValues,
                  indexName,
                  filterExpr,
                  forward,
                  limit,
                  startKey);
          Map<String, Object> result = new LinkedHashMap<>();
          result.put("Items", items);
          result.put("Count", items.size());
          sendJson(exchange, 200, result);
          break;
        }
      case "Scan":
        {
          String tableName = (String) body.get("TableName");
          String filterExpr = (String) body.get("FilterExpression");
          Map<String, String> exprNames =
              (Map<String, String>) body.get("ExpressionAttributeNames");
          Map<String, Object> exprValues =
              (Map<String, Object>) body.get("ExpressionAttributeValues");
          Integer limit =
              body.get("Limit") != null ? ((Number) body.get("Limit")).intValue() : null;
          Map<String, Object> startKey = (Map<String, Object>) body.get("ExclusiveStartKey");
          List<Map<String, Object>> items =
              store.scan(tableName, filterExpr, exprNames, exprValues, limit, startKey);
          Map<String, Object> result = new LinkedHashMap<>();
          result.put("Items", items);
          result.put("Count", items.size());
          sendJson(exchange, 200, result);
          break;
        }
      case "BatchGetItem":
        {
          Map<String, Object> requestItems =
              (Map<String, Object>) body.getOrDefault("RequestItems", Map.of());
          Map<String, Object> responses = new LinkedHashMap<>();
          for (Map.Entry<String, Object> entry : requestItems.entrySet()) {
            String tableName = entry.getKey();
            Map<String, Object> tableReq = (Map<String, Object>) entry.getValue();
            List<Map<String, Object>> keys =
                (List<Map<String, Object>>) tableReq.getOrDefault("Keys", List.of());
            responses.put(tableName, store.batchGetItems(tableName, keys));
          }
          sendJson(exchange, 200, Map.of("Responses", responses));
          break;
        }
      case "BatchWriteItem":
        {
          Map<String, Object> requestItems =
              (Map<String, Object>) body.getOrDefault("RequestItems", Map.of());
          for (Map.Entry<String, Object> entry : requestItems.entrySet()) {
            String tableName = entry.getKey();
            List<Map<String, Object>> requests = (List<Map<String, Object>>) entry.getValue();
            List<Map<String, Object>> puts = new ArrayList<>();
            List<Map<String, Object>> deletes = new ArrayList<>();
            for (Map<String, Object> req : requests) {
              if (req.containsKey("PutRequest")) {
                puts.add(
                    (Map<String, Object>)
                        ((Map<String, Object>) req.get("PutRequest")).get("Item"));
              } else if (req.containsKey("DeleteRequest")) {
                deletes.add(
                    (Map<String, Object>)
                        ((Map<String, Object>) req.get("DeleteRequest")).get("Key"));
              }
            }
            store.batchWriteItems(tableName, puts, deletes);
          }
          sendJson(exchange, 200, Map.of());
          break;
        }
      case "TransactGetItems":
        {
          List<Map<String, Object>> txItems =
              (List<Map<String, Object>>) body.getOrDefault("TransactItems", List.of());
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
          sendJson(exchange, 200, Map.of("Responses", responses));
          break;
        }
      case "TransactWriteItems":
        {
          List<Map<String, Object>> txItems =
              (List<Map<String, Object>>) body.getOrDefault("TransactItems", List.of());
          // First pass: evaluate condition checks
          List<Map<String, Object>> cancellationReasons = new ArrayList<>();
          boolean transactionCancelled = false;
          for (Map<String, Object> txItem : txItems) {
            if (txItem.containsKey("ConditionCheck")) {
              Map<String, Object> cc = (Map<String, Object>) txItem.get("ConditionCheck");
              String condExpr = (String) cc.get("ConditionExpression");
              if (condExpr != null) {
                Map<String, Object> existingItem =
                    store.getItem(
                        (String) cc.get("TableName"), (Map<String, Object>) cc.get("Key"));
                Map<String, String> exprNames =
                    (Map<String, String>) cc.get("ExpressionAttributeNames");
                Map<String, Object> exprValues =
                    (Map<String, Object>) cc.get("ExpressionAttributeValues");
                boolean condMet =
                    store.evaluateFilter(
                        existingItem != null ? existingItem : Map.of(),
                        condExpr,
                        exprNames,
                        exprValues);
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
            sendJson(
                exchange,
                400,
                Map.of(
                    "__type", "TransactionCanceledException",
                    "message", "Transaction cancelled",
                    "CancellationReasons", cancellationReasons));
            break;
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
          sendJson(exchange, 200, Map.of());
          break;
        }
      case "DescribeTimeToLive":
        {
          sendJson(
              exchange,
              200,
              Map.of(
                  "TimeToLiveDescription",
                  Map.of(
                      "TimeToLiveStatus",
                      "DISABLED",
                      "TableName",
                      body.getOrDefault("TableName", ""))));
          break;
        }
      case "UpdateTimeToLive":
        {
          sendJson(
              exchange,
              200,
              Map.of(
                  "TimeToLiveSpecification",
                  body.getOrDefault("TimeToLiveSpecification", Map.of())));
          break;
        }
      case "DescribeContinuousBackups":
        {
          sendJson(
              exchange,
              200,
              Map.of(
                  "ContinuousBackupsDescription",
                  Map.of(
                      "ContinuousBackupsStatus",
                      "DISABLED",
                      "PointInTimeRecoveryDescription",
                      Map.of("PointInTimeRecoveryStatus", "DISABLED"))));
          break;
        }
      case "ListTagsOfResource":
        {
          sendJson(exchange, 200, Map.of("Tags", List.of()));
          break;
        }
      case "TagResource":
      case "UntagResource":
        {
          sendJson(exchange, 200, Map.of());
          break;
        }
      default:
        {
          sendJson(
              exchange,
              400,
              Map.of(
                  "__type",
                  "UnknownOperationException",
                  "message",
                  "lws: DynamoDB operation '" + operation + "' is not yet implemented"));
        }
    }
  }

  private void sendJson(HttpExchange exchange, int status, Object body) throws IOException {
    byte[] bytes = MAPPER.writeValueAsBytes(body);
    exchange.getResponseHeaders().set("Content-Type", "application/x-amz-json-1.0");
    exchange.sendResponseHeaders(status, bytes.length);
    try (OutputStream os = exchange.getResponseBody()) {
      os.write(bytes);
    }
  }
}
