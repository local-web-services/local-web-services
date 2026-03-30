package io.localwebservices.lws.providers.lambda;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sun.net.httpserver.HttpExchange;
import java.io.IOException;
import java.io.OutputStream;
import java.util.*;

/** Handles Lambda resource-based permission (policy) operations. */
class LambdaPermissionOps {

  private static final ObjectMapper MAPPER = new ObjectMapper();

  private final LambdaStore store;

  LambdaPermissionOps(LambdaStore store) {
    this.store = store;
  }

  void handleAddPermission(String name, Map<String, Object> body, HttpExchange exchange)
      throws IOException {
    List<Map<String, Object>> perms =
        store.permissions.computeIfAbsent(name, k -> new ArrayList<>());
    perms.add(body);
    sendJson(exchange, 201, Map.of("Statement", MAPPER.writeValueAsString(body)));
  }

  void handleGetPolicy(String name, HttpExchange exchange) throws IOException {
    List<Map<String, Object>> perms = store.permissions.getOrDefault(name, List.of());
    String policy = MAPPER.writeValueAsString(Map.of("Version", "2012-10-17", "Statement", perms));
    sendJson(exchange, 200, Map.of("Policy", policy, "RevisionId", UUID.randomUUID().toString()));
  }

  void handleRemovePermission(String name, String statementId, HttpExchange exchange)
      throws IOException {
    if (!store.functions.containsKey(name)) {
      sendJson(
          exchange,
          404,
          Map.of(
              "__type", "ResourceNotFoundException", "message", "Function " + name + " not found"));
      return;
    }
    List<Map<String, Object>> perms = store.permissions.getOrDefault(name, List.of());
    if (perms.isEmpty()) {
      sendJson(
          exchange,
          404,
          Map.of(
              "__type",
              "ResourceNotFoundException",
              "message",
              "Function " + name + " has no resource policy"));
      return;
    }
    List<Map<String, Object>> updated = new ArrayList<>();
    boolean found = false;
    for (Map<String, Object> p : perms) {
      String sid = (String) p.get("StatementId");
      if (statementId.equals(sid)) {
        found = true;
      } else {
        updated.add(p);
      }
    }
    if (!found) {
      sendJson(
          exchange,
          404,
          Map.of(
              "__type",
              "ResourceNotFoundException",
              "message",
              "Statement " + statementId + " not found in resource policy"));
      return;
    }
    store.permissions.put(name, updated);
    sendEmpty(exchange, 204);
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

  private static void sendEmpty(HttpExchange exchange, int status) throws IOException {
    exchange.sendResponseHeaders(status, -1);
    exchange.getResponseBody().close();
  }
}
