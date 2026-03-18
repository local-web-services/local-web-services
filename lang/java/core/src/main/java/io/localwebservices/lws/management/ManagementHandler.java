package io.localwebservices.lws.management;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpHandler;
import io.localwebservices.lws.ServerState;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.*;

/** Management HTTP handler for /_ldk/* endpoints. */
public class ManagementHandler implements HttpHandler {

  private static final ObjectMapper MAPPER = new ObjectMapper();

  private static final List<String> ALL_SERVICES =
      Arrays.asList(
          "dynamodb",
          "sqs",
          "s3",
          "sns",
          "stepfunctions",
          "events",
          "cognito-idp",
          "ssm",
          "secretsmanager");

  private final ServerState state;

  public ManagementHandler(ServerState state) {
    this.state = state;
  }

  @Override
  public void handle(HttpExchange exchange) throws IOException {
    String path = exchange.getRequestURI().getPath();
    String method = exchange.getRequestMethod();

    try {
      switch (path) {
        case "/_ldk/status":
          handleStatus(exchange);
          break;
        case "/_ldk/reset":
          handleReset(exchange);
          break;
        case "/_ldk/chaos":
          if ("GET".equalsIgnoreCase(method)) handleGetChaos(exchange);
          else handlePostChaos(exchange);
          break;
        case "/_ldk/iam-auth":
          if ("GET".equalsIgnoreCase(method)) handleGetIam(exchange);
          else handlePostIam(exchange);
          break;
        case "/_ldk/logs":
          handleGetLogs(exchange);
          break;
        case "/_ldk/aws-fake":
          if ("GET".equalsIgnoreCase(method)) sendJson(exchange, 200, state.fakeRules);
          else handlePostFake(exchange);
          break;
        case "/_ldk/lifecycle":
          sendJson(exchange, 200, Map.of("status", "ok"));
          break;
        case "/_ldk/resources":
          sendJson(exchange, 200, Map.of("resources", Map.of()));
          break;
        case "/_ldk/shutdown":
          sendJson(exchange, 200, Map.of("status", "shutting down"));
          break;
        default:
          sendJson(exchange, 404, Map.of("error", "not found"));
      }
    } catch (Exception e) {
      try {
        sendJson(exchange, 500, Map.of("error", e.getMessage()));
      } catch (Exception ignored) { // error sending 500 response; swallowed
      }
    }
  }

  private void handleStatus(HttpExchange exchange) throws IOException {
    sendJson(exchange, 200, Map.of("running", true, "providers", List.of()));
  }

  private void handleReset(HttpExchange exchange) throws IOException {
    state.reset();
    sendJson(exchange, 200, Map.of("status", "ok"));
  }

  private void handleGetChaos(HttpExchange exchange) throws IOException {
    Map<String, Object> result = new LinkedHashMap<>();
    for (String service : ALL_SERVICES) {
      Map<String, Map<String, Object>> serviceRules = state.chaosRules.get(service);
      Map<String, Object> rule =
          serviceRules != null ? serviceRules.getOrDefault("*", Map.of()) : Map.of();
      Map<String, Object> entry = new LinkedHashMap<>();
      entry.put("enabled", serviceRules != null);
      entry.put("error_rate", rule.getOrDefault("error_rate", 0.0));
      Object latMin = rule.get("latency_min_ms");
      if (latMin == null) latMin = rule.getOrDefault("latency_ms", 0);
      entry.put("latency_min_ms", latMin);
      Object latMax = rule.get("latency_max_ms");
      if (latMax == null) latMax = rule.getOrDefault("latency_ms", 0);
      entry.put("latency_max_ms", latMax);
      result.put(service, entry);
    }
    sendJson(exchange, 200, result);
  }

  @SuppressWarnings("unchecked")
  private void handlePostChaos(HttpExchange exchange) throws IOException {
    Map<String, Object> body = readJson(exchange);
    for (Map.Entry<String, Object> entry : body.entrySet()) {
      String service = entry.getKey();
      Map<String, Object> config = (Map<String, Object>) entry.getValue();
      boolean enabled = !Boolean.FALSE.equals(config.get("enabled"));

      if (!enabled) {
        state.chaosRules.remove(service);
        continue;
      }

      long nonEnabledKeys = config.keySet().stream().filter(k -> !k.equals("enabled")).count();
      if (nonEnabledKeys == 0) {
        state.chaosRules.computeIfAbsent(
            service, k -> Collections.synchronizedMap(new LinkedHashMap<>()));
        continue;
      }

      Map<String, Map<String, Object>> serviceRules =
          state.chaosRules.computeIfAbsent(
              service, k -> Collections.synchronizedMap(new LinkedHashMap<>()));
      Map<String, Object> rule = new LinkedHashMap<>();

      if (config.containsKey("error_rate")) {
        Number errorRate = (Number) config.get("error_rate");
        if (errorRate.doubleValue() > 0) rule.put("error_rate", errorRate.doubleValue());
      }
      if (config.containsKey("latency_min_ms")) {
        Number v = (Number) config.get("latency_min_ms");
        if (v.intValue() > 0) {
          rule.put("latency_min_ms", v.intValue());
          rule.put("latency_ms", v.intValue());
        }
      }
      if (config.containsKey("latency_max_ms")) {
        Number v = (Number) config.get("latency_max_ms");
        if (v.intValue() > 0) rule.put("latency_max_ms", v.intValue());
      }
      if (config.containsKey("error_code")) {
        rule.put("error_code", config.get("error_code"));
      }

      serviceRules.put("*", rule);
    }
    sendJson(exchange, 200, Map.of("status", "ok"));
  }

  private void handleGetIam(HttpExchange exchange) throws IOException {
    Map<String, Object> result = new LinkedHashMap<>();
    result.put("mode", state.iamEnforce ? "enforce" : "disabled");
    result.put("default_identity", state.iamDefaultIdentity);
    result.put("identities", state.iamIdentities);
    result.put("resource_policies", state.iamResourcePolicies);
    sendJson(exchange, 200, result);
  }

  @SuppressWarnings("unchecked")
  private void handlePostIam(HttpExchange exchange) throws IOException {
    Map<String, Object> body = readJson(exchange);

    if (body.containsKey("mode")) {
      String mode = (String) body.get("mode");
      state.iamEnforce = "enforce".equals(mode);
    }
    if (body.containsKey("enforce")) {
      state.iamEnforce = Boolean.TRUE.equals(body.get("enforce"));
    }
    if (body.containsKey("default_identity") && body.get("default_identity") != null) {
      state.iamDefaultIdentity = (String) body.get("default_identity");
    }
    if (body.containsKey("identities")) {
      Map<String, Object> identities = (Map<String, Object>) body.get("identities");
      for (Map.Entry<String, Object> entry : identities.entrySet()) {
        Map<String, Object> identity = (Map<String, Object>) entry.getValue();
        Map<String, Object> stored = new LinkedHashMap<>();
        if (identity.containsKey("inline_policies")) {
          stored.put("inline_policies", identity.get("inline_policies"));
        }
        Object boundary =
            identity.getOrDefault("boundary_policy", identity.get("permission_boundary"));
        if (boundary != null) stored.put("permission_boundary", boundary);
        state.iamIdentities.put(entry.getKey(), stored);
      }
    }
    if (body.containsKey("resource_policies")) {
      state.iamResourcePolicies.clear();
      state.iamResourcePolicies.putAll((Map<String, Object>) body.get("resource_policies"));
    }

    sendJson(exchange, 200, Map.of("status", "ok"));
  }

  private void handleGetLogs(HttpExchange exchange) throws IOException {
    sendJson(exchange, 200, Map.of("logs", state.logBuffer));
  }

  @SuppressWarnings("unchecked")
  private void handlePostFake(HttpExchange exchange) throws IOException {
    Map<String, Object> body = readJson(exchange);
    for (Map.Entry<String, Object> entry : body.entrySet()) {
      String service = entry.getKey();
      Map<String, Object> config = (Map<String, Object>) entry.getValue();
      boolean enabled = !Boolean.FALSE.equals(config.get("enabled"));
      if (!enabled) {
        state.fakeRules.remove(service);
      } else {
        state.fakeRules.put(service, config);
      }
    }
    sendJson(exchange, 200, Map.of("status", "ok"));
  }

  private Map<String, Object> readJson(HttpExchange exchange) throws IOException {
    try (InputStream is = exchange.getRequestBody()) {
      byte[] bytes = is.readAllBytes();
      if (bytes.length == 0) return Map.of();
      return MAPPER.readValue(bytes, Map.class);
    }
  }

  private void sendJson(HttpExchange exchange, int status, Object body) throws IOException {
    byte[] bytes = MAPPER.writeValueAsBytes(body);
    exchange.getResponseHeaders().set("Content-Type", "application/json");
    exchange.sendResponseHeaders(status, bytes.length);
    try (OutputStream os = exchange.getResponseBody()) {
      os.write(bytes);
    }
  }
}
