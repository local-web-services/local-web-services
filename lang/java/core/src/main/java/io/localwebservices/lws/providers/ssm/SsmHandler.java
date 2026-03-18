package io.localwebservices.lws.providers.ssm;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpHandler;
import io.localwebservices.lws.ServerState;
import io.localwebservices.lws.middleware.ChaosMiddleware;
import io.localwebservices.lws.middleware.IamMiddleware;
import java.io.*;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

/** SSM wire-protocol HTTP handler. */
public class SsmHandler implements HttpHandler {

  private static final ObjectMapper MAPPER = new ObjectMapper();
  private static final String TARGET_PREFIX = "AmazonSSM.";

  private final ServerState state;
  private final Map<String, Map<String, Object>> parameters = new ConcurrentHashMap<>();
  private final Map<String, List<Map<String, String>>> resourceTags = new ConcurrentHashMap<>();

  public SsmHandler(ServerState state) {
    this.state = state;
    state.resetCallbacks.add(this::reset);
  }

  private void reset() {
    parameters.clear();
    resourceTags.clear();
  }

  @Override
  public void handle(HttpExchange exchange) throws IOException {
    String target = exchange.getRequestHeaders().getFirst("X-Amz-Target");
    if (target == null) target = "";
    String operation =
        target.startsWith(TARGET_PREFIX) ? target.substring(TARGET_PREFIX.length()) : target;

    byte[] bodyBytes;
    try (InputStream is = exchange.getRequestBody()) {
      bodyBytes = is.readAllBytes();
    }
    @SuppressWarnings("unchecked")
    Map<String, Object> body =
        bodyBytes.length > 0 ? MAPPER.readValue(bodyBytes, Map.class) : new LinkedHashMap<>();

    try {
      if (IamMiddleware.applyIamAuth(state, "ssm", operation, exchange, false)) return;
      if (ChaosMiddleware.applyChaos(state, "ssm", operation, exchange, false)) return;

      handleOperation(operation, body, exchange);
    } catch (InterruptedException e) {
      Thread.currentThread().interrupt();
      sendJson(exchange, 500, Map.of("__type", "InternalFailure", "message", "Interrupted"));
    } catch (Exception e) {
      sendJson(
          exchange,
          400,
          Map.of(
              "__type",
              "ParameterNotFound",
              "message",
              e.getMessage() != null ? e.getMessage() : "Error"));
    }
  }

  @SuppressWarnings("unchecked")
  private void handleOperation(String operation, Map<String, Object> body, HttpExchange exchange)
      throws IOException {
    switch (operation) {
      case "PutParameter":
        {
          String name = (String) body.get("Name");
          boolean overwrite = Boolean.TRUE.equals(body.get("Overwrite"));
          if (!overwrite && parameters.containsKey(name)) {
            sendJson(
                exchange,
                400,
                Map.of("__type", "ParameterAlreadyExists", "message", "Parameter already exists"));
            break;
          }
          if (overwrite && !parameters.containsKey(name)) {
            sendJson(
                exchange,
                400,
                Map.of(
                    "__type", "ParameterNotFound", "message", "Parameter " + name + " not found"));
            break;
          }
          Map<String, Object> param = new LinkedHashMap<>();
          param.put("Name", name);
          param.put("Value", body.get("Value"));
          param.put("Type", body.getOrDefault("Type", "String"));
          param.put("Version", 1);
          param.put("LastModifiedDate", System.currentTimeMillis() / 1000.0);
          parameters.put(name, param);
          sendJson(exchange, 200, Map.of("Version", 1, "Tier", "Standard"));
          break;
        }
      case "GetParameter":
        {
          String name = (String) body.get("Name");
          Map<String, Object> param = parameters.get(name);
          if (param == null) {
            sendJson(
                exchange,
                400,
                Map.of(
                    "__type", "ParameterNotFound", "message", "Parameter " + name + " not found"));
            return;
          }
          sendJson(
              exchange,
              200,
              Map.of(
                  "Parameter",
                  Map.of(
                      "Name", param.get("Name"),
                      "Value", param.get("Value"),
                      "Type", param.get("Type"),
                      "Version", param.get("Version"))));
          break;
        }
      case "GetParameters":
        {
          List<String> names = (List<String>) body.getOrDefault("Names", List.of());
          List<Map<String, Object>> found = new ArrayList<>();
          List<String> invalid = new ArrayList<>();
          for (String name : names) {
            Map<String, Object> param = parameters.get(name);
            if (param != null) {
              found.add(
                  Map.of(
                      "Name",
                      param.get("Name"),
                      "Value",
                      param.get("Value"),
                      "Type",
                      param.get("Type"),
                      "Version",
                      param.get("Version")));
            } else {
              invalid.add(name);
            }
          }
          sendJson(exchange, 200, Map.of("Parameters", found, "InvalidParameters", invalid));
          break;
        }
      case "GetParametersByPath":
        {
          String path = (String) body.get("Path");
          List<Map<String, Object>> found = new ArrayList<>();
          for (Map.Entry<String, Map<String, Object>> entry : parameters.entrySet()) {
            if (entry.getKey().startsWith(path)) {
              Map<String, Object> param = entry.getValue();
              found.add(
                  Map.of(
                      "Name",
                      param.get("Name"),
                      "Value",
                      param.get("Value"),
                      "Type",
                      param.get("Type"),
                      "Version",
                      param.get("Version")));
            }
          }
          sendJson(exchange, 200, Map.of("Parameters", found));
          break;
        }
      case "DeleteParameter":
        {
          String name = (String) body.get("Name");
          if (!parameters.containsKey(name)) {
            sendJson(
                exchange,
                400,
                Map.of(
                    "__type", "ParameterNotFound", "message", "Parameter " + name + " not found"));
            break;
          }
          parameters.remove(name);
          sendJson(exchange, 200, Map.of());
          break;
        }
      case "DeleteParameters":
        {
          List<String> names = (List<String>) body.getOrDefault("Names", List.of());
          List<String> deleted = new ArrayList<>();
          List<String> invalid = new ArrayList<>();
          for (String name : names) {
            if (parameters.remove(name) != null) deleted.add(name);
            else invalid.add(name);
          }
          if (!invalid.isEmpty()) {
            sendJson(
                exchange,
                400,
                Map.of(
                    "__type",
                    "ParameterNotFound",
                    "message",
                    "Parameters not found: " + invalid,
                    "DeletedParameters",
                    deleted,
                    "InvalidParameters",
                    invalid));
            break;
          }
          sendJson(
              exchange, 200, Map.of("DeletedParameters", deleted, "InvalidParameters", invalid));
          break;
        }
      case "DescribeParameters":
        {
          List<Map<String, Object>> params = new ArrayList<>();
          for (Map<String, Object> p : parameters.values()) {
            params.add(Map.of("Name", p.get("Name"), "Type", p.get("Type")));
          }
          sendJson(exchange, 200, Map.of("Parameters", params));
          break;
        }
      case "AddTagsToResource":
        {
          String resourceId = (String) body.get("ResourceId");
          if (!parameters.containsKey(resourceId)) {
            sendJson(
                exchange,
                400,
                Map.of(
                    "__type",
                    "InvalidResourceId",
                    "message",
                    "Invalid resource id: " + resourceId));
            break;
          }
          List<Map<String, Object>> newTags =
              (List<Map<String, Object>>) body.getOrDefault("Tags", List.of());
          List<Map<String, String>> existing =
              resourceTags.computeIfAbsent(resourceId, k -> new ArrayList<>());
          for (Map<String, Object> tag : newTags) {
            existing.add(
                Map.of("Key", (String) tag.get("Key"), "Value", (String) tag.get("Value")));
          }
          sendJson(exchange, 200, Map.of());
          break;
        }
      case "RemoveTagsFromResource":
        {
          String resourceId = (String) body.get("ResourceId");
          if (!parameters.containsKey(resourceId)) {
            sendJson(
                exchange,
                400,
                Map.of(
                    "__type",
                    "InvalidResourceId",
                    "message",
                    "Invalid resource id: " + resourceId));
            break;
          }
          List<String> tagKeys = (List<String>) body.getOrDefault("TagKeys", List.of());
          List<Map<String, String>> existing =
              resourceTags.getOrDefault(resourceId, new ArrayList<>());
          if (existing.stream().noneMatch(t -> tagKeys.contains(t.get("Key")))) {
            sendJson(
                exchange,
                400,
                Map.of(
                    "__type",
                    "InvalidResourceId",
                    "message",
                    "Tag not associated with resource: " + resourceId));
            break;
          }
          existing.removeIf(t -> tagKeys.contains(t.get("Key")));
          sendJson(exchange, 200, Map.of());
          break;
        }
      case "ListTagsForResource":
        {
          String resourceId = (String) body.get("ResourceId");
          if (!parameters.containsKey(resourceId)) {
            sendJson(
                exchange,
                400,
                Map.of(
                    "__type",
                    "InvalidResourceId",
                    "message",
                    "Invalid resource id: " + resourceId));
            break;
          }
          List<Map<String, String>> tags = resourceTags.getOrDefault(resourceId, List.of());
          sendJson(exchange, 200, Map.of("TagList", tags));
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
                  "Not implemented: " + operation));
        }
    }
  }

  private void sendJson(HttpExchange exchange, int status, Object body) throws IOException {
    byte[] bytes = MAPPER.writeValueAsBytes(body);
    exchange.getResponseHeaders().set("Content-Type", "application/x-amz-json-1.1");
    exchange.sendResponseHeaders(status, bytes.length);
    try (OutputStream os = exchange.getResponseBody()) {
      os.write(bytes);
    }
  }
}
