package io.localwebservices.lws.providers.ssm;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpHandler;
import io.localwebservices.lws.ServerState;
import io.localwebservices.lws.middleware.ChaosMiddleware;
import io.localwebservices.lws.middleware.IamMiddleware;
import java.io.*;
import java.util.*;

/** SSM wire-protocol HTTP handler. */
public class SsmHandler implements HttpHandler {

  private static final ObjectMapper MAPPER = new ObjectMapper();
  private static final String TARGET_PREFIX = "AmazonSSM.";

  private final ServerState state;
  private final SsmStore store;

  public SsmHandler(ServerState state) {
    this.state = state;
    this.store = new SsmStore();
    state.resetCallbacks.add(store::reset);
  }

  /**
   * Gets a parameter programmatically (used by StepFunctions service task bridges). The params map
   * must contain "Name". Returns a map with "Parameter".
   */
  public Map<String, Object> executeGetParameter(Map<String, Object> params) {
    String name = (String) params.get("Name");
    Map<String, Object> param = store.getParameter(name);
    if (param == null) {
      throw new RuntimeException("ParameterNotFound: Parameter " + name + " not found");
    }
    Map<String, Object> result = new LinkedHashMap<>();
    result.put(
        "Parameter",
        Map.of(
            "Name", param.get("Name"),
            "Value", param.get("Value"),
            "Type", param.get("Type"),
            "Version", param.get("Version")));
    return result;
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
          if (!overwrite && store.containsParameter(name)) {
            sendJson(
                exchange,
                400,
                Map.of("__type", "ParameterAlreadyExists", "message", "Parameter already exists"));
            break;
          }
          if (overwrite && !store.containsParameter(name)) {
            sendJson(
                exchange,
                400,
                Map.of(
                    "__type", "ParameterNotFound", "message", "Parameter " + name + " not found"));
            break;
          }
          Map<String, Object> param =
              store.putParameter(
                  name, (String) body.get("Value"), (String) body.get("Type"), overwrite);
          sendJson(exchange, 200, Map.of("Version", param.get("Version"), "Tier", "Standard"));
          break;
        }
      case "GetParameter":
        {
          String name = (String) body.get("Name");
          Map<String, Object> param = store.getParameter(name);
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
          List<Map<String, Object>> found = store.getParameters(names);
          List<String> invalid = store.getInvalidParameters(names);
          sendJson(exchange, 200, Map.of("Parameters", found, "InvalidParameters", invalid));
          break;
        }
      case "GetParametersByPath":
        {
          String path = (String) body.get("Path");
          List<Map<String, Object>> found = store.getParametersByPath(path);
          sendJson(exchange, 200, Map.of("Parameters", found));
          break;
        }
      case "DeleteParameter":
        {
          String name = (String) body.get("Name");
          if (!store.deleteParameter(name)) {
            sendJson(
                exchange,
                400,
                Map.of(
                    "__type", "ParameterNotFound", "message", "Parameter " + name + " not found"));
            break;
          }
          sendJson(exchange, 200, Map.of());
          break;
        }
      case "DeleteParameters":
        {
          List<String> names = (List<String>) body.getOrDefault("Names", List.of());
          List<String> deleted = store.deleteParameters(names);
          List<String> invalid = new ArrayList<>(names);
          invalid.removeAll(deleted);
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
          List<Map<String, Object>> params = store.describeParameters();
          sendJson(exchange, 200, Map.of("Parameters", params));
          break;
        }
      case "AddTagsToResource":
        {
          String resourceId = (String) body.get("ResourceId");
          if (!store.containsParameter(resourceId)) {
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
          store.addTags(resourceId, newTags);
          sendJson(exchange, 200, Map.of());
          break;
        }
      case "RemoveTagsFromResource":
        {
          String resourceId = (String) body.get("ResourceId");
          if (!store.containsParameter(resourceId)) {
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
          if (!store.hasTagAssociated(resourceId, tagKeys)) {
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
          store.removeTags(resourceId, tagKeys);
          sendJson(exchange, 200, Map.of());
          break;
        }
      case "ListTagsForResource":
        {
          String resourceId = (String) body.get("ResourceId");
          if (!store.containsParameter(resourceId)) {
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
          List<Map<String, String>> tags = store.listTags(resourceId);
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
