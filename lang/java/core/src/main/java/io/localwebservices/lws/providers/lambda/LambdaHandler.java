package io.localwebservices.lws.providers.lambda;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpHandler;
import io.localwebservices.lws.ServerState;
import io.localwebservices.lws.middleware.ChaosMiddleware;
import io.localwebservices.lws.middleware.IamMiddleware;
import java.io.*;
import java.nio.charset.StandardCharsets;
import java.util.*;

/**
 * Lambda REST wire-protocol HTTP handler.
 *
 * <p>Routes: POST/GET/DELETE /2015-03-31/functions[/:name[/...]] POST
 * /2015-03-31/functions/:name/invocations POST/GET/DELETE/PUT
 * /2015-03-31/event-source-mappings[/:uuid] POST/GET /2015-03-31/functions/:name/policy
 * PUT/DELETE/GET /2017-10-31/functions/:name/concurrency POST/DELETE /2017-03-31/tags/:arn
 */
public class LambdaHandler implements HttpHandler {

  private static final ObjectMapper MAPPER = new ObjectMapper();
  private static final String REGION = "us-east-1";
  private static final String ACCOUNT = "000000000000";

  private final ServerState state;
  private final LambdaStore store = new LambdaStore();
  private final LambdaEventSourceMappingHandler esmHandler =
      new LambdaEventSourceMappingHandler(store);

  /** Constructs a new LambdaHandler. */
  public LambdaHandler(ServerState state) {
    this.state = state;
    state.resetCallbacks.add(store::reset);
  }

  @Override
  public void handle(HttpExchange exchange) throws IOException {
    String method = exchange.getRequestMethod();
    String path = exchange.getRequestURI().getPath();

    byte[] bodyBytes;
    try (InputStream is = exchange.getRequestBody()) {
      bodyBytes = is.readAllBytes();
    }
    @SuppressWarnings("unchecked")
    Map<String, Object> body =
        bodyBytes.length > 0 ? MAPPER.readValue(bodyBytes, Map.class) : new LinkedHashMap<>();

    try {
      route(method, path, body, exchange);
    } catch (InterruptedException e) {
      Thread.currentThread().interrupt();
      sendJson(exchange, 500, Map.of("__type", "ServiceException", "message", "Interrupted"));
    } catch (Exception e) {
      String msg = e.getMessage() != null ? e.getMessage() : "Internal error";
      sendJson(exchange, 500, Map.of("__type", "ServiceException", "message", msg));
    }
  }

  private void route(String method, String path, Map<String, Object> body, HttpExchange exchange)
      throws IOException, InterruptedException {
    // POST /2015-03-31/functions
    if ("POST".equals(method) && "/2015-03-31/functions".equals(path)) {
      if (IamMiddleware.applyIamAuth(state, "lambda", "CreateFunction", exchange, false)) return;
      if (ChaosMiddleware.applyChaos(state, "lambda", "CreateFunction", exchange, false)) return;
      handleCreateFunction(body, exchange);
      return;
    }

    // GET /2015-03-31/functions
    if ("GET".equals(method) && "/2015-03-31/functions".equals(path)) {
      handleListFunctions(exchange);
      return;
    }

    // GET /2015-03-31/functions/:name
    if ("GET".equals(method) && path.matches("/2015-03-31/functions/[^/]+$")) {
      String name = lastName(path);
      handleGetFunction(name, exchange);
      return;
    }

    // DELETE /2015-03-31/functions/:name
    if ("DELETE".equals(method) && path.matches("/2015-03-31/functions/[^/]+$")) {
      String name = lastName(path);
      handleDeleteFunction(name, exchange);
      return;
    }

    // PUT /2015-03-31/functions/:name/code
    if ("PUT".equals(method) && path.matches("/2015-03-31/functions/[^/]+/code$")) {
      String name = path.split("/")[4];
      handleUpdateFunctionCode(name, exchange);
      return;
    }

    // PUT /2015-03-31/functions/:name/configuration
    if ("PUT".equals(method) && path.matches("/2015-03-31/functions/[^/]+/configuration$")) {
      String name = path.split("/")[4];
      handleUpdateFunctionConfig(name, body, exchange);
      return;
    }

    // GET /2015-03-31/functions/:name/configuration
    if ("GET".equals(method) && path.matches("/2015-03-31/functions/[^/]+/configuration$")) {
      String name = path.split("/")[4];
      handleGetFunctionConfig(name, exchange);
      return;
    }

    // POST /2015-03-31/functions/:name/invocations
    if ("POST".equals(method) && path.matches("/2015-03-31/functions/[^/]+/invocations$")) {
      String name = path.split("/")[4];
      if (IamMiddleware.applyIamAuth(state, "lambda", "Invoke", exchange, false)) return;
      if (ChaosMiddleware.applyChaos(state, "lambda", "Invoke", exchange, false)) return;
      if (state.getCapacityConfig("lambda").isExhausted()) {
        sendJson(
            exchange,
            429,
            Map.of("__type", "TooManyRequestsException", "message", "Rate Exceeded."));
        return;
      }
      handleInvoke(name, exchange);
      return;
    }

    // POST /2015-03-31/functions/:name/policy
    if ("POST".equals(method) && path.matches("/2015-03-31/functions/[^/]+/policy$")) {
      String name = path.split("/")[4];
      handleAddPermission(name, body, exchange);
      return;
    }

    // GET /2015-03-31/functions/:name/policy
    if ("GET".equals(method) && path.matches("/2015-03-31/functions/[^/]+/policy$")) {
      String name = path.split("/")[4];
      handleGetPolicy(name, exchange);
      return;
    }

    // POST /2015-03-31/event-source-mappings
    if ("POST".equals(method) && "/2015-03-31/event-source-mappings".equals(path)) {
      esmHandler.handleCreate(body, exchange);
      return;
    }

    // GET /2015-03-31/event-source-mappings
    if ("GET".equals(method)
        && path.startsWith("/2015-03-31/event-source-mappings")
        && !path.matches("/2015-03-31/event-source-mappings/[^/]+$")) {
      String functionName = queryParam(exchange, "FunctionName");
      esmHandler.handleList(functionName, exchange);
      return;
    }

    // GET /2015-03-31/event-source-mappings/:uuid
    if ("GET".equals(method) && path.matches("/2015-03-31/event-source-mappings/[^/]+$")) {
      String uuid = lastName(path);
      esmHandler.handleGet(uuid, exchange);
      return;
    }

    // DELETE /2015-03-31/event-source-mappings/:uuid
    if ("DELETE".equals(method) && path.matches("/2015-03-31/event-source-mappings/[^/]+$")) {
      String uuid = lastName(path);
      esmHandler.handleDelete(uuid, exchange);
      return;
    }

    // PUT /2015-03-31/event-source-mappings/:uuid
    if ("PUT".equals(method) && path.matches("/2015-03-31/event-source-mappings/[^/]+$")) {
      String uuid = lastName(path);
      esmHandler.handleUpdate(uuid, body, exchange);
      return;
    }

    // Concurrency endpoints
    if (path.matches("/2017-10-31/functions/[^/]+/concurrency$")) {
      if ("PUT".equals(method)) {
        int reserved =
            body.containsKey("ReservedConcurrentExecutions")
                ? ((Number) body.get("ReservedConcurrentExecutions")).intValue()
                : 0;
        sendJson(exchange, 200, Map.of("ReservedConcurrentExecutions", reserved));
      } else if ("DELETE".equals(method)) {
        sendEmpty(exchange, 204);
      } else {
        sendJson(exchange, 200, Map.of("ReservedConcurrentExecutions", 0));
      }
      return;
    }

    // Tags endpoints
    if (path.matches("/2017-03-31/tags/.*")) {
      sendEmpty(exchange, 204);
      return;
    }

    sendJson(
        exchange,
        404,
        Map.of("__type", "ResourceNotFoundException", "message", "Not found: " + path));
  }

  // ── Function CRUD ──────────────────────────────────────────────────────────

  private void handleCreateFunction(Map<String, Object> body, HttpExchange exchange)
      throws IOException {
    String name = (String) body.get("FunctionName");
    if (name == null || name.isEmpty()) {
      sendJson(
          exchange,
          400,
          Map.of(
              "__type", "InvalidParameterValueException", "message", "FunctionName is required"));
      return;
    }
    @SuppressWarnings("unchecked")
    Map<String, Object> envMap =
        body.containsKey("Environment") ? (Map<String, Object>) body.get("Environment") : Map.of();
    @SuppressWarnings("unchecked")
    Map<String, String> envVars =
        envMap.containsKey("Variables") ? (Map<String, String>) envMap.get("Variables") : Map.of();

    Map<String, Object> fn = new LinkedHashMap<>();
    fn.put("FunctionName", name);
    fn.put("FunctionArn", "arn:aws:lambda:" + REGION + ":" + ACCOUNT + ":function:" + name);
    fn.put("Runtime", body.getOrDefault("Runtime", "python3.9"));
    fn.put("Role", body.getOrDefault("Role", ""));
    fn.put("Handler", body.getOrDefault("Handler", "handler.handler"));
    fn.put("Description", body.getOrDefault("Description", ""));
    fn.put("Timeout", body.getOrDefault("Timeout", 30));
    fn.put("MemorySize", body.getOrDefault("MemorySize", 128));
    fn.put("State", "Active");
    fn.put("CodeSize", 1024);
    fn.put("CodeSha256", Base64.getEncoder().encodeToString(name.getBytes(StandardCharsets.UTF_8)));
    fn.put("Version", "$LATEST");
    fn.put("LastModified", java.time.Instant.now().toString());
    fn.put("RevisionId", UUID.randomUUID().toString());
    fn.put("PackageType", body.getOrDefault("PackageType", "Zip"));
    fn.put("Environment", Map.of("Variables", envVars));
    fn.put("Architectures", List.of("x86_64"));
    fn.put("_tags", body.getOrDefault("Tags", new LinkedHashMap<>()));
    store.functions.put(name, fn);
    sendJson(exchange, 201, functionToConfig(fn));
  }

  private void handleListFunctions(HttpExchange exchange) throws IOException {
    List<Map<String, Object>> configs = new ArrayList<>();
    for (Map<String, Object> fn : store.functions.values()) {
      configs.add(functionToConfig(fn));
    }
    sendJson(exchange, 200, Map.of("Functions", configs));
  }

  private void handleGetFunction(String name, HttpExchange exchange) throws IOException {
    Map<String, Object> fn = store.functions.get(name);
    if (fn == null) {
      sendJson(
          exchange,
          404,
          Map.of(
              "__type", "ResourceNotFoundException", "message", "Function " + name + " not found"));
      return;
    }
    @SuppressWarnings("unchecked")
    Map<String, String> tags =
        fn.containsKey("_tags") ? (Map<String, String>) fn.get("_tags") : Map.of();
    sendJson(
        exchange,
        200,
        Map.of(
            "Configuration", functionToConfig(fn),
            "Code",
                Map.of(
                    "RepositoryType",
                    "S3",
                    "Location",
                    "https://s3.amazonaws.com/lws-lambda/" + name + ".zip"),
            "Tags", tags));
  }

  private void handleDeleteFunction(String name, HttpExchange exchange) throws IOException {
    if (!store.functions.containsKey(name)) {
      sendJson(
          exchange,
          404,
          Map.of(
              "__type", "ResourceNotFoundException", "message", "Function " + name + " not found"));
      return;
    }
    store.functions.remove(name);
    sendEmpty(exchange, 204);
  }

  private void handleUpdateFunctionCode(String name, HttpExchange exchange) throws IOException {
    Map<String, Object> fn = store.functions.get(name);
    if (fn == null) {
      sendJson(
          exchange,
          404,
          Map.of(
              "__type", "ResourceNotFoundException", "message", "Function " + name + " not found"));
      return;
    }
    fn.put("LastModified", java.time.Instant.now().toString());
    fn.put("RevisionId", UUID.randomUUID().toString());
    sendJson(exchange, 200, functionToConfig(fn));
  }

  private void handleUpdateFunctionConfig(
      String name, Map<String, Object> body, HttpExchange exchange) throws IOException {
    Map<String, Object> fn = store.functions.get(name);
    if (fn == null) {
      sendJson(
          exchange,
          404,
          Map.of(
              "__type", "ResourceNotFoundException", "message", "Function " + name + " not found"));
      return;
    }
    if (body.containsKey("Timeout")) fn.put("Timeout", body.get("Timeout"));
    if (body.containsKey("MemorySize")) fn.put("MemorySize", body.get("MemorySize"));
    if (body.containsKey("Description")) fn.put("Description", body.get("Description"));
    if (body.containsKey("Runtime")) fn.put("Runtime", body.get("Runtime"));
    if (body.containsKey("Handler")) fn.put("Handler", body.get("Handler"));
    if (body.containsKey("Role")) fn.put("Role", body.get("Role"));
    fn.put("LastModified", java.time.Instant.now().toString());
    fn.put("RevisionId", UUID.randomUUID().toString());
    sendJson(exchange, 200, functionToConfig(fn));
  }

  private void handleGetFunctionConfig(String name, HttpExchange exchange) throws IOException {
    Map<String, Object> fn = store.functions.get(name);
    if (fn == null) {
      sendJson(
          exchange,
          404,
          Map.of(
              "__type", "ResourceNotFoundException", "message", "Function " + name + " not found"));
      return;
    }
    sendJson(exchange, 200, functionToConfig(fn));
  }

  // ── Invocations ────────────────────────────────────────────────────────────

  private void handleInvoke(String name, HttpExchange exchange) throws IOException {
    if (!store.functions.containsKey(name)) {
      sendJson(
          exchange,
          404,
          Map.of(
              "__type", "ResourceNotFoundException", "message", "Function " + name + " not found"));
      return;
    }
    String invType = exchange.getRequestHeaders().getFirst("X-Amz-Invocation-Type");
    if ("Event".equals(invType)) {
      sendEmpty(exchange, 202);
    } else {
      byte[] payload =
          "{\"statusCode\":200,\"body\":\"lws-mock-response\"}".getBytes(StandardCharsets.UTF_8);
      String encoded = Base64.getEncoder().encodeToString(payload);
      exchange.getResponseHeaders().set("Content-Type", "application/json");
      byte[] resp = encoded.getBytes(StandardCharsets.UTF_8);
      exchange.sendResponseHeaders(200, resp.length);
      try (OutputStream os = exchange.getResponseBody()) {
        os.write(resp);
      }
    }
  }

  // ── Permissions ────────────────────────────────────────────────────────────

  private void handleAddPermission(String name, Map<String, Object> body, HttpExchange exchange)
      throws IOException {
    List<Map<String, Object>> perms =
        store.permissions.computeIfAbsent(name, k -> new ArrayList<>());
    perms.add(body);
    sendJson(exchange, 201, Map.of("Statement", MAPPER.writeValueAsString(body)));
  }

  private void handleGetPolicy(String name, HttpExchange exchange) throws IOException {
    List<Map<String, Object>> perms = store.permissions.getOrDefault(name, List.of());
    String policy = MAPPER.writeValueAsString(Map.of("Version", "2012-10-17", "Statement", perms));
    sendJson(exchange, 200, Map.of("Policy", policy, "RevisionId", UUID.randomUUID().toString()));
  }

  // ── Event source mappings ──────────────────────────────────────────────────

  // ── Helpers ───────────────────────────────────────────────────────────────

  private static Map<String, Object> functionToConfig(Map<String, Object> fn) {
    Map<String, Object> cfg = new LinkedHashMap<>(fn);
    cfg.remove("_tags");
    return cfg;
  }

  private static String lastName(String path) {
    String[] parts = path.split("/");
    return parts[parts.length - 1];
  }

  private static String queryParam(HttpExchange exchange, String key) {
    String query = exchange.getRequestURI().getQuery();
    if (query == null) return null;
    for (String part : query.split("&")) {
      String[] kv = part.split("=", 2);
      if (kv.length == 2 && key.equals(kv[0])) return kv[1];
    }
    return null;
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
