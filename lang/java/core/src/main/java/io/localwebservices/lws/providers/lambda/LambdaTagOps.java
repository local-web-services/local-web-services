package io.localwebservices.lws.providers.lambda;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sun.net.httpserver.HttpExchange;
import java.io.IOException;
import java.io.OutputStream;
import java.util.*;

/** Handles Lambda tagging operations. */
class LambdaTagOps {

  private static final ObjectMapper MAPPER = new ObjectMapper();

  private final LambdaStore store;

  LambdaTagOps(LambdaStore store) {
    this.store = store;
  }

  @SuppressWarnings("unchecked")
  void handleTagResource(String arn, Map<String, Object> body, HttpExchange exchange)
      throws IOException {
    String name = arnToFunctionName(arn);
    Map<String, Object> fn = store.functions.get(name);
    if (fn == null) {
      sendJson(
          exchange,
          404,
          Map.of(
              "__type", "ResourceNotFoundException", "message", "Function " + name + " not found"));
      return;
    }
    Map<String, Object> tags =
        (Map<String, Object>) fn.computeIfAbsent("_tags", k -> new LinkedHashMap<String, Object>());
    if (body.containsKey("Tags")) {
      Map<String, Object> newTags = (Map<String, Object>) body.get("Tags");
      tags.putAll(newTags);
    }
    sendEmpty(exchange, 204);
  }

  @SuppressWarnings("unchecked")
  void handleListTags(String arn, HttpExchange exchange) throws IOException {
    String name = arnToFunctionName(arn);
    Map<String, Object> fn = store.functions.get(name);
    if (fn == null) {
      sendJson(
          exchange,
          404,
          Map.of(
              "__type", "ResourceNotFoundException", "message", "Function " + name + " not found"));
      return;
    }
    Map<String, Object> tags =
        fn.containsKey("_tags") ? (Map<String, Object>) fn.get("_tags") : Map.of();
    sendJson(exchange, 200, Map.of("Tags", tags));
  }

  @SuppressWarnings("unchecked")
  void handleUntagResource(String arn, HttpExchange exchange) throws IOException {
    String name = arnToFunctionName(arn);
    Map<String, Object> fn = store.functions.get(name);
    if (fn == null) {
      sendJson(
          exchange,
          404,
          Map.of(
              "__type", "ResourceNotFoundException", "message", "Function " + name + " not found"));
      return;
    }
    String query = exchange.getRequestURI().getQuery();
    List<String> tagKeys = new ArrayList<>();
    if (query != null) {
      for (String part : query.split("&")) {
        String[] kv = part.split("=", 2);
        if (kv.length == 2 && "tagKeys".equals(kv[0])) {
          tagKeys.add(kv[1]);
        }
      }
    }
    if (!tagKeys.isEmpty()) {
      Map<String, Object> tags =
          fn.containsKey("_tags") ? (Map<String, Object>) fn.get("_tags") : new LinkedHashMap<>();
      for (String key : tagKeys) {
        tags.remove(key);
      }
    }
    sendEmpty(exchange, 204);
  }

  private static String arnToFunctionName(String arn) {
    // arn:aws:lambda:us-east-1:000000000000:function:{name}
    String[] parts = arn.split(":");
    if (parts.length >= 7 && "function".equals(parts[5])) {
      return parts[6];
    }
    return arn;
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
