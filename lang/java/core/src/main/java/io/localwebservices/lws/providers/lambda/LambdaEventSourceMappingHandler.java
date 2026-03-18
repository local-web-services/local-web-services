package io.localwebservices.lws.providers.lambda;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sun.net.httpserver.HttpExchange;
import java.io.IOException;
import java.io.OutputStream;
import java.util.*;

/** Handles Lambda event source mapping operations. */
class LambdaEventSourceMappingHandler {

  private static final ObjectMapper MAPPER = new ObjectMapper();

  private final LambdaStore store;

  LambdaEventSourceMappingHandler(LambdaStore store) {
    this.store = store;
  }

  void handleCreate(Map<String, Object> body, HttpExchange exchange) throws IOException {
    String uuid = UUID.randomUUID().toString();
    Map<String, Object> mapping = new LinkedHashMap<>();
    mapping.put("UUID", uuid);
    mapping.put("EventSourceArn", body.getOrDefault("EventSourceArn", ""));
    mapping.put("FunctionArn", body.getOrDefault("FunctionArn", ""));
    mapping.put("State", "Enabled");
    mapping.put("BatchSize", body.getOrDefault("BatchSize", 10));
    mapping.put("StartingPosition", body.getOrDefault("StartingPosition", "TRIM_HORIZON"));
    mapping.put("LastModified", System.currentTimeMillis() / 1000.0);
    mapping.put("StateTransitionReason", "User action");
    store.eventSourceMappings.put(uuid, mapping);
    sendJson(exchange, 202, mapping);
  }

  void handleList(String functionName, HttpExchange exchange) throws IOException {
    List<Map<String, Object>> result = new ArrayList<>();
    for (Map<String, Object> m : store.eventSourceMappings.values()) {
      if (functionName == null) {
        result.add(m);
      } else {
        String fnArn = (String) m.getOrDefault("FunctionArn", "");
        if (fnArn.contains(functionName) || fnArn.endsWith(":function:" + functionName)) {
          result.add(m);
        }
      }
    }
    sendJson(exchange, 200, Map.of("EventSourceMappings", result));
  }

  void handleGet(String uuid, HttpExchange exchange) throws IOException {
    Map<String, Object> mapping = store.eventSourceMappings.get(uuid);
    if (mapping == null) {
      sendJson(
          exchange,
          404,
          Map.of(
              "__type",
              "ResourceNotFoundException",
              "message",
              "Event source mapping " + uuid + " not found"));
      return;
    }
    sendJson(exchange, 200, mapping);
  }

  void handleDelete(String uuid, HttpExchange exchange) throws IOException {
    Map<String, Object> mapping = store.eventSourceMappings.remove(uuid);
    if (mapping == null) {
      sendJson(
          exchange,
          404,
          Map.of(
              "__type",
              "ResourceNotFoundException",
              "message",
              "Event source mapping " + uuid + " not found"));
      return;
    }
    sendJson(exchange, 202, mapping);
  }

  void handleUpdate(String uuid, Map<String, Object> body, HttpExchange exchange)
      throws IOException {
    Map<String, Object> mapping = store.eventSourceMappings.get(uuid);
    if (mapping == null) {
      sendJson(
          exchange,
          404,
          Map.of(
              "__type",
              "ResourceNotFoundException",
              "message",
              "Event source mapping " + uuid + " not found"));
      return;
    }
    if (body.containsKey("Enabled")) {
      mapping.put("State", Boolean.TRUE.equals(body.get("Enabled")) ? "Enabled" : "Disabled");
    }
    mapping.put("LastModified", System.currentTimeMillis() / 1000.0);
    sendJson(exchange, 200, mapping);
  }

  private static void sendJson(HttpExchange exchange, int status, Object payload)
      throws IOException {
    byte[] bytes = MAPPER.writeValueAsBytes(payload);
    exchange.getResponseHeaders().set("Content-Type", "application/json");
    exchange.sendResponseHeaders(status, bytes.length);
    try (OutputStream os = exchange.getResponseBody()) {
      os.write(bytes);
    }
  }
}
