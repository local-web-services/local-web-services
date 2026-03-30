package io.localwebservices.lws.providers.dynamodb;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sun.net.httpserver.HttpExchange;
import java.io.IOException;
import java.io.OutputStream;
import java.util.*;

/** Handles DynamoDB table DDL operations (CreateTable, DeleteTable, DescribeTable, etc.). */
class DynamoDbTableOps {

  private static final ObjectMapper MAPPER = new ObjectMapper();

  private final DynamoDbStore store;

  DynamoDbTableOps(DynamoDbStore store) {
    this.store = store;
  }

  @SuppressWarnings("unchecked")
  void handle(String operation, Map<String, Object> body, HttpExchange exchange)
      throws IOException {
    switch (operation) {
      case "CreateTable":
        handleCreateTable(body, exchange);
        break;
      case "DeleteTable":
        handleDeleteTable(body, exchange);
        break;
      case "DescribeTable":
        handleDescribeTable(body, exchange);
        break;
      case "ListTables":
        sendJson(exchange, 200, Map.of("TableNames", store.listTables()));
        break;
      case "UpdateTable":
        handleUpdateTable(body, exchange);
        break;
      default:
        break;
    }
  }

  @SuppressWarnings("unchecked")
  private void handleCreateTable(Map<String, Object> body, HttpExchange exchange)
      throws IOException {
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
      return;
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
      gsiDef.put("Projection", gsi.getOrDefault("Projection", Map.of("ProjectionType", "ALL")));
      gsiDef.put("IndexStatus", "ACTIVE");
      gsiDefs.add(gsiDef);
    }
    TableDef newTable = store.createTable(tableName, pkName, pkType, skName, skType, gsiDefs);
    @SuppressWarnings("unchecked")
    Map<String, Object> streamSpec = (Map<String, Object>) body.get("StreamSpecification");
    if (streamSpec != null) {
      Object streamEnabledVal = streamSpec.get("StreamEnabled");
      if (Boolean.TRUE.equals(streamEnabledVal)) {
        String viewType =
            streamSpec.get("StreamViewType") != null
                ? (String) streamSpec.get("StreamViewType")
                : "NEW_AND_OLD_IMAGES";
        newTable.streamEnabled = true;
        newTable.streamViewType = viewType;
        newTable.latestStreamArn =
            "arn:aws:dynamodb:us-east-1:000000000000:table/"
                + tableName
                + "/stream/"
                + java.time.Instant.now().toString();
      }
    }
    sendJson(exchange, 200, Map.of("TableDescription", store.describeTable(tableName)));
  }

  private void handleDeleteTable(Map<String, Object> body, HttpExchange exchange)
      throws IOException {
    String tableName = (String) body.get("TableName");
    store.deleteTable(tableName);
    sendJson(
        exchange,
        200,
        Map.of("TableDescription", Map.of("TableName", tableName, "TableStatus", "DELETING")));
  }

  private void handleDescribeTable(Map<String, Object> body, HttpExchange exchange)
      throws IOException {
    String tableName = (String) body.get("TableName");
    Map<String, Object> desc = store.describeTable(tableName);
    sendJson(exchange, 200, Map.of("Table", desc));
  }

  @SuppressWarnings("unchecked")
  private void handleUpdateTable(Map<String, Object> body, HttpExchange exchange)
      throws IOException {
    String tableName = (String) body.get("TableName");
    Map<String, Object> updateStreamSpec = (Map<String, Object>) body.get("StreamSpecification");
    if (updateStreamSpec != null) {
      TableDef existingTable = store.getTable(tableName);
      Object streamEnabledVal = updateStreamSpec.get("StreamEnabled");
      if (Boolean.TRUE.equals(streamEnabledVal)) {
        String viewType =
            updateStreamSpec.get("StreamViewType") != null
                ? (String) updateStreamSpec.get("StreamViewType")
                : "NEW_AND_OLD_IMAGES";
        existingTable.streamEnabled = true;
        existingTable.streamViewType = viewType;
        existingTable.latestStreamArn =
            "arn:aws:dynamodb:us-east-1:000000000000:table/"
                + tableName
                + "/stream/"
                + java.time.Instant.now().toString();
      } else if (Boolean.FALSE.equals(streamEnabledVal)) {
        existingTable.streamEnabled = false;
        existingTable.streamViewType = null;
        existingTable.latestStreamArn = null;
      }
    }
    Map<String, Object> desc = store.describeTable(tableName);
    sendJson(exchange, 200, Map.of("TableDescription", desc));
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
