package io.localwebservices.lws.providers.opensearch;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpHandler;
import io.localwebservices.lws.ServerState;
import io.localwebservices.lws.middleware.ChaosMiddleware;
import io.localwebservices.lws.middleware.IamMiddleware;
import java.io.*;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

/**
 * OpenSearch wire-protocol HTTP handler (REST-JSON, AWS SDK v2 OpenSearch REST protocol).
 *
 * <p>The AWS SDK v2 OpenSearch client uses REST API paths like:
 *
 * <ul>
 *   <li>POST /2021-01-01/opensearch/domain → CreateDomain
 *   <li>DELETE /2021-01-01/opensearch/domain/{name} → DeleteDomain
 *   <li>GET /2021-01-01/opensearch/domain/{name} → DescribeDomain
 *   <li>GET /2021-01-01/opensearch/domain → ListDomainNames
 *   <li>POST /2021-01-01/tags → AddTags
 *   <li>GET /2021-01-01/tags → ListTags
 *   <li>DELETE /2021-01-01/tags → RemoveTags
 *   <li>POST /2021-01-01/opensearch/domain/{name}/config → UpdateDomainConfig
 * </ul>
 */
public class OpenSearchHandler implements HttpHandler {

  private static final ObjectMapper MAPPER = new ObjectMapper();
  private static final String ACCOUNT = "000000000000";
  private static final String REGION = "us-east-1";

  private final ServerState state;
  private final Map<String, Map<String, Object>> domains = new ConcurrentHashMap<>();
  private final Map<String, List<Map<String, String>>> domainTags = new ConcurrentHashMap<>();

  public OpenSearchHandler(ServerState state) {
    this.state = state;
    state.resetCallbacks.add(this::reset);
  }

  private void reset() {
    domains.clear();
    domainTags.clear();
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

    // Derive a logical operation name for IAM/chaos middleware
    String operation = deriveOperation(method, path);

    try {
      if (IamMiddleware.applyIamAuth(state, "opensearch", operation, exchange, false)) return;
      if (ChaosMiddleware.applyChaos(state, "opensearch", operation, exchange, false)) return;

      handleOperation(method, path, body, exchange);
    } catch (InterruptedException e) {
      Thread.currentThread().interrupt();
      sendJson(exchange, 500, Map.of("__type", "InternalFailure", "message", "Interrupted"));
    } catch (Exception e) {
      sendJson(
          exchange,
          400,
          Map.of(
              "__type",
              "ResourceNotFoundException",
              "message",
              e.getMessage() != null ? e.getMessage() : "Error"));
    }
  }

  private String deriveOperation(String method, String path) {
    // Arrange: map method + path pattern to a logical operation name
    if ("POST".equals(method) && path.equals("/2021-01-01/opensearch/domain")) {
      return "CreateDomain";
    }
    if ("DELETE".equals(method) && path.startsWith("/2021-01-01/opensearch/domain/")) {
      return "DeleteDomain";
    }
    if ("GET".equals(method)
        && path.startsWith("/2021-01-01/opensearch/domain/")
        && !path.endsWith("/config")) {
      return "DescribeDomain";
    }
    if ("GET".equals(method) && path.equals("/2021-01-01/opensearch/domain")) {
      return "ListDomainNames";
    }
    if ("POST".equals(method) && path.equals("/2021-01-01/tags")) {
      return "AddTags";
    }
    if ("GET".equals(method) && path.equals("/2021-01-01/tags")) {
      return "ListTags";
    }
    if ("DELETE".equals(method) && path.equals("/2021-01-01/tags")) {
      return "RemoveTags";
    }
    if ("POST".equals(method) && path.endsWith("/config")) {
      return "UpdateDomainConfig";
    }
    return method + " " + path;
  }

  @SuppressWarnings("unchecked")
  private void handleOperation(
      String method, String path, Map<String, Object> body, HttpExchange exchange)
      throws IOException {
    // Arrange: route by HTTP method and path
    // POST /2021-01-01/opensearch/domain → CreateDomain
    if ("POST".equals(method) && path.equals("/2021-01-01/opensearch/domain")) {
      String name = (String) body.get("DomainName");
      Map<String, Object> domain = buildDomain(name);
      domains.put(name, domain);
      sendJson(exchange, 200, Map.of("DomainStatus", domain));
      return;
    }
    // DELETE /2021-01-01/opensearch/domain/{name} → DeleteDomain
    if ("DELETE".equals(method) && path.startsWith("/2021-01-01/opensearch/domain/")) {
      String name = extractDomainName(path);
      Map<String, Object> domain = domains.remove(name);
      if (domain == null) {
        sendJson(
            exchange,
            400,
            Map.of("__type", "ResourceNotFoundException", "message", "Domain not found: " + name));
        return;
      }
      sendJson(exchange, 200, Map.of("DomainStatus", domain));
      return;
    }
    // GET /2021-01-01/opensearch/domain/{name} → DescribeDomain
    if ("GET".equals(method)
        && path.startsWith("/2021-01-01/opensearch/domain/")
        && !path.endsWith("/config")) {
      String name = extractDomainName(path);
      Map<String, Object> domain = domains.get(name);
      if (domain == null) {
        sendJson(
            exchange,
            400,
            Map.of("__type", "ResourceNotFoundException", "message", "Domain not found: " + name));
        return;
      }
      sendJson(exchange, 200, Map.of("DomainStatus", domain));
      return;
    }
    // GET /2021-01-01/opensearch/domain → ListDomainNames
    if ("GET".equals(method) && path.equals("/2021-01-01/opensearch/domain")) {
      List<Map<String, Object>> list = new ArrayList<>();
      for (String name : domains.keySet()) {
        list.add(Map.of("DomainName", name));
      }
      sendJson(exchange, 200, Map.of("DomainNames", list));
      return;
    }
    // POST /2021-01-01/tags → AddTags
    if ("POST".equals(method) && path.equals("/2021-01-01/tags")) {
      String arn = (String) body.get("ARN");
      String domainName = arnToDomainName(arn);
      List<Map<String, Object>> newTags =
          (List<Map<String, Object>>) body.getOrDefault("TagList", List.of());
      List<Map<String, String>> existing =
          domainTags.computeIfAbsent(domainName, k -> new ArrayList<>());
      for (Map<String, Object> tag : newTags) {
        existing.add(Map.of("Key", (String) tag.get("Key"), "Value", (String) tag.get("Value")));
      }
      sendJson(exchange, 200, Map.of());
      return;
    }
    // GET /2021-01-01/tags?ARN=... → ListTags
    if ("GET".equals(method) && path.equals("/2021-01-01/tags")) {
      String query = exchange.getRequestURI().getQuery();
      String arn = extractQueryParam(query, "ARN");
      String domainName = arnToDomainName(arn);
      List<Map<String, String>> tags = domainTags.getOrDefault(domainName, List.of());
      sendJson(exchange, 200, Map.of("TagList", tags));
      return;
    }
    // DELETE /2021-01-01/tags → RemoveTags
    if ("DELETE".equals(method) && path.equals("/2021-01-01/tags")) {
      String query = exchange.getRequestURI().getQuery();
      String arn = extractQueryParam(query, "ARN");
      String domainName = arnToDomainName(arn);
      List<String> tagKeys = (List<String>) body.getOrDefault("TagKeys", List.of());
      List<Map<String, String>> existing = domainTags.getOrDefault(domainName, new ArrayList<>());
      existing.removeIf(t -> tagKeys.contains(t.get("Key")));
      sendJson(exchange, 200, Map.of());
      return;
    }
    // POST /2021-01-01/opensearch/domain/{name}/config → UpdateDomainConfig
    if ("POST".equals(method) && path.endsWith("/config")) {
      String name = extractDomainName(path.replace("/config", ""));
      Map<String, Object> domain = domains.get(name);
      if (domain == null) {
        sendJson(
            exchange,
            400,
            Map.of("__type", "ResourceNotFoundException", "message", "Domain not found: " + name));
        return;
      }
      sendJson(exchange, 200, Map.of("DomainConfig", buildDomainConfig(domain)));
      return;
    }
    // Unknown operation
    sendJson(
        exchange,
        400,
        Map.of("__type", "UnknownOperationException", "message", "Not implemented: " + path));
  }

  private Map<String, Object> buildDomain(String name) {
    Map<String, Object> domain = new LinkedHashMap<>();
    domain.put("DomainId", ACCOUNT + "/" + name);
    domain.put("DomainName", name);
    domain.put("ARN", "arn:aws:opensearch:" + REGION + ":" + ACCOUNT + ":domain/" + name);
    domain.put("Created", true);
    domain.put("Deleted", false);
    domain.put("Processing", false);
    domain.put("Endpoint", "http://localhost:9200");
    domain.put("EngineType", "OpenSearch");
    domain.put("EBSOptions", Map.of("EBSEnabled", false));
    return domain;
  }

  private String extractDomainName(String path) {
    // path is like /2021-01-01/opensearch/domain/{name}
    String prefix = "/2021-01-01/opensearch/domain/";
    if (path.startsWith(prefix)) {
      String rest = path.substring(prefix.length());
      int slash = rest.indexOf('/');
      return slash >= 0 ? rest.substring(0, slash) : rest;
    }
    return path;
  }

  private String extractQueryParam(String query, String key) {
    if (query == null) return null;
    for (String pair : query.split("&")) {
      String[] kv = pair.split("=", 2);
      if (kv.length == 2 && kv[0].equals(key)) {
        try {
          return java.net.URLDecoder.decode(kv[1], java.nio.charset.StandardCharsets.UTF_8);
        } catch (Exception e) {
          return kv[1];
        }
      }
    }
    return null;
  }

  private Map<String, Object> buildDomainConfig(Map<String, Object> domain) {
    Map<String, Object> config = new LinkedHashMap<>();
    config.put(
        "ClusterConfig",
        Map.of(
            "Options",
            domain.getOrDefault("ClusterConfig", Map.of("InstanceType", "m5.large.search"))));
    config.put(
        "EBSOptions",
        Map.of("Options", domain.getOrDefault("EBSOptions", Map.of("EBSEnabled", false))));
    return config;
  }

  private String arnToDomainName(String arn) {
    if (arn == null) return "";
    String[] parts = arn.split("/");
    return parts.length > 1 ? parts[parts.length - 1] : arn;
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
